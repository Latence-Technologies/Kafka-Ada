# Kafka Ada

This project offers Ada bindings for the C librdkafka library. You can use it to send and receive from a Kafka bus from Ada. Currently work in progress, it does not offer all functionalities of librdkafka yet.

## Install 

To install this library on your system, run the following command:

```bash
sudo gprinstall -p -f kafkaada.gpr
```

Note: You need to have librdkafka already installed.

## Usage

See the `examples/` folder for code examples showcasing a basic consumer and a 
basic producer using Kafka Ada.

## Latence Technologies

This Ada binding is offered by LatenceTech, a Montreal based startup specialized in low-latency optimization. Our website is https://latencetech.com/
