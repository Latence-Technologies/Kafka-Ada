
#include <librdkafka/rdkafka.h>

// We have to do this because of https://github.com/edenhill/librdkafka/issues/2822
// to support older versions of librdkafka (e.g. Ubuntu 20)
RD_EXPORT const char* rd_kafka_message_errstr_wrapper(const rd_kafka_message_t* rkmessage)
{
    return rd_kafka_message_errstr(rkmessage);
}
