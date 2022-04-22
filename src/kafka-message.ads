--
-- Provides Kafka functionality to manage messages
--
package Kafka.Message is
    --
    -- Frees resources for the specified Message and hands ownership back to
    -- rdkafka.
    --
    -- librdkafka equivalent: rd_kafka_message_destroy
    --
    procedure Destroy(Message : access Message_Type)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_message_destroy";

    --
    -- Returns the error string for an errored Message or empty string if there
    -- was no error.
    --
    -- This function MUST NOT be used with the producer.
    --
    -- librdkafka equivalent: rd_kafka_message_errstr
    --
    -- @param Message message to get the error of
    -- @returns string describing the error
    --
    function Get_Error(Message : access constant Message_Type) return String;
private

    function rd_kafka_message_errstr(Message : access constant Message_Type) return chars_ptr
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_message_errstr_wrapper";

end Kafka.Message;
