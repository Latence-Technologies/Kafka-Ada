# Kafka Ada

This project offers Ada bindings for the C librdkafka library. You can use it to send and receive from a Kafka bus from Ada. Currently work in progress, it does not offer all functionalities of librdkafka yet.

## Latence Technologies

This Ada binding is offered LatenceTech, a Montreal based startup specialized in low-latency optimization. Our website is https://latencetech.com/


## Install 

To install this library on your system, run the following command:

```bash
sudo gprinstall -p -f kafkaada.gpr
```

Note: You need to have librdkafka already installed.

## Usage

### Simple producer example

```ada
with GNAT.Sockets;
with Kafka; use Kafka;
with System;

procedure Main is
	Config : Kafka_Config;
begin
	Config := Create_Config;
	Set_Config(Config, "client.id", GNAT.Sockets.Host_name);
	Set_Config(Config, "bootstrap.servers", "localhost:9092");
	
	Handle := Create_Handle(RD_KAFKA_PRODUCER);
	Topic := Create_Topic_Handle(Handle, "test_topic", Config); -- topic must already exist
	
	Produce(Topic,
		RD_KAFKA_PARTITION_UA,
		"Payload", -- you aren't forced to pass strings but otherwise you will need to pass the System.Address and length of your content in memory
		"Key",
		System.Null_Address);

	Poll(Handle, 0.0);
	Flush(Handle, 15.0);

	Destroy_Handle(Handle);
end Main;
```

### Simple consumer example

Consumer features are not supported yet.
