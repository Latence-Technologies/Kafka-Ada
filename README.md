# Kafka Ada

This project offers Ada bindings for the C librdkafka library. You can use it to send and receive from a Kafka bus from Ada. Currently work in progress, it does not offer all functionalities of librdkafka yet. If what you are looking for is simply producing data onto a kafka bus or consuming data, this library likely already supports the features you need.

Supported functionalities:

- Basic error handling
- Kafka handle creation and destruction
- Topic handling
- Message handling
- Basic producer functionalities
- Basic consumer functionalities
- Kafka configuration
- Topic configuration

Not yet supported:

- Retrieving debug contexts
- Advanced error handling (Description, fatal errors, retriable errors etc.)
- Partition handling
- Message headers
- Message status
- Event sourcing and event handling
- Callbacks
- Broker handling
- Broker metadata
- Queue consumer
- Batch consumer
- Atomic assignment of partitions
- Kafka logging
- Topic creation and deletion and other admin operations
- Various other advanced functionalities offered by librdkafka

If you need some of those not supported features, feel free to open a pull request.

## Building and installing from source

To install this library on your system, run the following command:

```bash
gprbuild -p kafkaada.gpr
sudo gprinstall -p -f kafkaada.gpr
```

Note: You need to have librdkafka already installed.

## Usage

See the `examples/` folder for code examples showcasing a basic consumer and a
basic producer using Kafka Ada.

You can use the `-t` (or `--topic`) argument to change the name of the Kafka Topic when using either example.

## Latence Technologies

This Ada binding is offered by LatenceTech, a Montreal based startup specialized in low-latency optimization. Our website is https://latencetech.com/
