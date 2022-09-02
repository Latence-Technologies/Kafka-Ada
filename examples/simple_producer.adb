with Ada.Text_IO;
with GNAT.Sockets;
with Interfaces;
with Kafka;
with Kafka.Config;
with Kafka.Topic;
with System;
with GetCommandArgument;

--
-- Basic Kafka producer
--
procedure Simple_Producer is
    Config : Kafka.Config_Type;
    Handle : Kafka.Handle_Type;
    Topic  : Kafka.Topic_Type;

    package CommandTopic is new GetCommandArgument ("-t:", "--topic:", "Topic name to use");
begin
    Ada.Text_IO.Put_Line("Kafka version: " & Kafka.Version);

    -- Create a new config object
    Config := Kafka.Config.Create;

    -- Configure your properties
    Kafka.Config.Set(Config, "client.id", GNAT.Sockets.Host_name);
    Kafka.Config.Set(Config, "bootstrap.servers", "localhost:9092");

    -- Create handle
    Handle := Kafka.Create_Handle(Kafka.RD_KAFKA_PRODUCER, Config);

    -- Create topic handle
    Topic := Kafka.Topic.Create_Topic_Handle(Handle,
        CommandTopic.Parse_Command_Line("test_topic")); -- topic must already exist

    -- Producing a String
    Kafka.Produce(Topic,
        Kafka.RD_KAFKA_PARTITION_UA,
        "World", -- payload
        "Hello", -- key
        System.Null_Address);

    -- Producing binary data
    declare
        type Some_Message is record
            A : Interfaces.Unsigned_32;
            B : Interfaces.Unsigned_64;
            C : Interfaces.Unsigned_8;
        end record
            with Convention => C;

        for Some_Message use record
            A at 0 range 0 .. 31;
            B at 4 range 0 .. 63;
            C at 12 range 0 .. 7;
        end record;

        for Some_Message'Bit_Order use System.High_Order_First;
        for Some_Message'Scalar_Storage_Order use System.High_Order_First;

        Message : Some_Message := (A => 55, B => 40002, C => 13);
    begin
        Kafka.Produce(Topic,
            Kafka.RD_KAFKA_PARTITION_UA,
            Kafka.RD_KAFKA_MSG_F_COPY,
            Message'Address,
            13,
            System.Null_Address, -- key is optional
            0,
            System.Null_Address);
    end;

    Kafka.Poll(Handle, 0.0);
    Kafka.Flush(Handle, 15.0);

    Kafka.Destroy_Handle(Handle);
end Simple_Producer;