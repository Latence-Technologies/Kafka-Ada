

package Kafka.Topic.Config is
    
    --
    -- Creates a new kafka topic config object
    --
    -- librdkafka equivalent: rd_kafka_topic_conf_new
    --
    function Create return Topic_Config_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_conf_new";

    --
    -- Destroys a kafka topic config object
    --
    -- librdkafka equivalent: rd_kafka_topic_conf_destroy
    --
    -- @param Config configuration to destroy
    --
    procedure Destroy(Config : Topic_Config_Type)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_conf_destroy";

    --
    -- Duplicates a kafka topic config object
    --
    -- librdkafka equivalent: rd_kafka_topic_conf_dup
    --
    -- @param Config configuration to duplicate
    --
    function Duplicate(Config : Topic_Config_Type) return Topic_Config_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_conf_dup";

    --
    -- Sets a kafka topic config property for a given kafka topic config.
    --
    -- librdkafka equivalent: rd_kafka_topic_conf_set
    --
    -- @param Config configuration to set the property in
    -- @param Name name of property to set
    -- @param Value value of property to set
    -- @raises Kafka_Error on error
    --
    procedure Set(Config : Topic_Config_Type;
                  Name   : String;
                  Value  : String);
private
    
    function rd_kafka_topic_conf_set(conf        : Topic_Config_Type;
                                     name        : chars_ptr;
                                     value       : chars_ptr;
                                     errstr      : chars_ptr;
                                     errstr_size : size_t) return Integer
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_topic_conf_set";

end Kafka.Topic.Config;