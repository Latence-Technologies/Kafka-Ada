pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with System.Parameters;
with Interfaces;           use Interfaces;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

--
-- Provides Kafka functionality to consume data
--
package Kafka.Consumer is
    
    --
    -- Redirect the main poll queue to the Kafka Consumer queue. It is not 
    -- permitted to call Kafka.Poll after directing the main queue with Poll_Set_Consumer
    --
    -- librdkafka equivalent: rd_kafka_poll_set_consumer
    --
    -- @param Handle Kafka handle 
    -- @raises Kafka_Error if an error happens
    --
    procedure Poll_Set_Consumer(Handle : Handle_Type);
    
    --
    -- Polls the consumer for messages or events. Will block for at most the 
    -- Timeout specified as parameter.
    --
    -- An application should make sure to call Kafka.Consumer.Poll() at regular
    -- intervals, even if no messages are expected, to serve any queued 
    -- callbacks waiting to be called. This is especially important when a 
    -- rebalance callback has been registered as it needs to be called and 
    -- handled properly to synchronize internal consumer state.
    --
    -- librdkafka equivalent: rd_kafka_consumer_poll
    --
    -- @param Handle Kafka handle
    -- @returns A message object which is a proper message if its field Error is 0
    -- @raises Kafka_Error if an error happens
    --
    function Poll(Handle  : Handle_Type;
                  Timeout : Duration) return access Message_Type;
                           
    --
    -- Closes down the Kafka Consumer.
    --
    -- This call will block until the consumer has revoked its assignment,
    -- calling the rebalance callback if it is configured, committed offsets
    -- to broker, and left the consumer group.
    -- The maximum blocking time is roughly limited to session.timeout.ms.
    --
    -- The application still needs to call rd_kafka_destroy() after
    -- this call finishes to clean up the underlying handle resources.
    --
    -- librdkafka equivalent: rd_kafka_consumer_close
    --
    -- @raises Kafka_Error if an error happens
    procedure Close(Handle : Handle_Type);
private
             
    function rd_kafka_poll_set_consumer(rk : Handle_Type) return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_poll_set_consumer";
             
    function rd_kafka_consumer_poll(rk         : Handle_Type;
                                    timeout_ms : int) return access Message_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_consumer_poll";
             
    function rd_kafka_consumer_close(rk : Handle_Type) return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_consumer_close";
end Kafka.Consumer;