with Ada.Text_IO;
with GNAT.Sockets;
with Interfaces;
with Interfaces.C;
with Kafka;
with Kafka.Config;
with Kafka.Consumer;
with Kafka.Message;
with Kafka.Topic;
with Kafka.Topic.Partition;
with Signal;
with GetCommandArgument;
with System;

--
-- Basic Kafka consumer
--
procedure Simple_Consumer is
    use type System.Address;
    use type Interfaces.C.size_t;

    Config : Kafka.Config_Type;
    Handle : Kafka.Handle_Type;
    
    Handler : Signal.Handler; -- basic Signal handler to stop on CTRL + C
    package KafkaTopic is new GetCommandArgument ("-t:", "--topic:", "Topic name to use");
begin
	-- Create configuration
    Config := Kafka.Config.Create;

    -- Configure
    -- see librdkafka documentation on how to configure your Kafka consumer
    -- Kafka-Ada does not add any configuration entries of its own
    Kafka.Config.Set(Config, "group.id", GNAT.Sockets.Host_name);
    Kafka.Config.Set(Config, "bootstrap.servers", "localhost:9092");
    Kafka.Config.Set(Config, "auto.offset.reset", "earliest");

    Handle := Kafka.Create_Handle(Kafka.RD_KAFKA_CONSUMER, Config);

    Kafka.Consumer.Poll_Set_Consumer(Handle);

    declare
        Partition_List : Kafka.Partition_List_Type;
    begin
        Partition_List := Kafka.Topic.Partition.Create_List(1);
        Kafka.Topic.Partition.List_Add(Partition_List,
            KafkaTopic.Parse_Command_Line("test_topic"), Kafka.RD_KAFKA_PARTITION_UA);
        
        Kafka.Subscribe(Handle, Partition_List);
        Kafka.Topic.Partition.Destroy_List(Partition_List);
    end;
    
    while not Handler.Triggered loop
        declare
            Message : access Kafka.Message_Type;
        begin
            Message := Kafka.Consumer.Poll(Handle, Duration(0.1)); -- 100ms
            if Message = null then
                goto Continue;
            end if;
            
            if Message.Error /= 0 then
                Ada.Text_IO.Put_Line("Consumer error: " & Kafka.Message.Get_Error(Message));
                Kafka.Message.Destroy(Message);
                goto Continue;
            end if;
            
            Ada.Text_IO.Put_Line("A message was received");
            Ada.Text_IO.Put_Line("Topic: " & Kafka.Topic.Get_Name(Message.Topic));
            
            if Message.Key /= System.Null_Address and Message.Key_Length > 0 then
                declare
                    Key : aliased String(1 .. Integer(Message.Key_Length));
                    for Key'Address use Message.Key;
                begin
                    Ada.Text_IO.Put_Line("Key:");
                    Ada.Text_IO.Put_Line(Key);
                end;
            else 
                Ada.Text_IO.Put_Line("Key is null");
            end if; 
            
            if Message.Payload /= System.Null_Address and Message.Payload_Length > 0 then
                declare
                    Payload : aliased String(1 .. Integer(Message.Payload_Length));
                    for Payload'Address use Message.Payload;
                begin
                    Ada.Text_IO.Put_Line("Payload:");
                    Ada.Text_IO.Put_Line(Payload);
                end;
            else 
                Ada.Text_IO.Put_Line("Payload is null");
            end if; 
            
            Kafka.Message.Destroy(Message);
        end;
        <<Continue>>
    end loop;

    Kafka.Consumer.Close(Handle);
    Kafka.Destroy_Handle(Handle);
end Simple_Consumer;