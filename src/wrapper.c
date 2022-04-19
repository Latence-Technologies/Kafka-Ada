
#include <librdkafka/rdkafka.h>

RD_EXPORT const char* rd_kafka_message_errstr_wrapper(const rd_kafka_message_t* rkmessage)
{
    return rd_kafka_message_errstr(rkmessage);
}