package body Kafka.Message is
    function Get_Error(Message : access constant Message_Type) return String is
    begin
        return Interfaces.C.Strings.Value(rd_kafka_message_errstr(Message));
    end Get_Error;
end Kafka.Message;
