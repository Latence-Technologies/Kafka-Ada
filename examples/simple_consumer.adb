with GNAT.Sockets;
with Interfaces;
with Kafka;
with System;

procedure Simple_Consumer is
	Config : Kafka.Config_Type;
	Handle : Kafka.Handle_Type;
	Topic  : Kafka.Topic_Type;
begin
	Config := Kafka.Create_Config;
	-- see librdkafka documentation on how to configure your Kafka consumer
	-- Kafka-Ada does not add any configuration entries of its own
	Kafka.Set_Config(Config, "group.id", GNAT.Sockets.Host_name);
	Kafka.Set_Config(Config, "bootstrap.servers", "localhost:9092");
	Kafka.Set_Config(Config, "auto.offset.reset", "earliest");

	Handle := Kafka.Create_Handle(Kafka.RD_KAFKA_CONSUMER, Config);

	Kafka.Poll_Set_Consumer(Handle);

	Kafka.Flush(Handle, 15.0);

	Kafka.Destroy_Handle(Handle);
end Simple_Consumer;