package body Kafka.Consumer is

    procedure Poll_Set_Consumer(Handle : Handle_Type) is
        Response : Kafka_Response_Error_Type;
    begin
        Response := rd_kafka_poll_set_consumer(Handle);
        if Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
            raise Kafka_Error with "Error returned by rd_kafka_poll_set_consumer: " & Kafka.Get_Error_Name(Response);
        end if;
    end Poll_Set_Consumer;

    function Poll(Handle  : Handle_Type;
                  Timeout : Duration) return access Message_Type is
    begin
        return rd_kafka_consumer_poll(Handle, int(Timeout * 1000));
    end Poll;

    procedure Close(Handle : Handle_Type) is
        Response : Kafka_Response_Error_Type;
    begin
        Response := rd_kafka_consumer_close(Handle);
        if Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
            raise Kafka_Error with "Error returned by rd_kafka_consumer_close: " & Kafka.Get_Error_Name(Response);
        end if;
    end Close;
end Kafka.Consumer;
