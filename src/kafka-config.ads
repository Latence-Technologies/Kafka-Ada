--
-- Provides the ability to create a configuration to be used when creating a
-- Kafka handle
--
package Kafka.Config is

    --
    -- Creates a new kafka config object
    --
    -- librdkafka equivalent: rd_kafka_conf_new
    --
    function Create return Config_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_conf_new";

    --
    -- Destroys a kafka config object
    --
    -- librdkafka equivalent: rd_kafka_conf_destroy
    --
    -- @param Config configuration to destroy
    --
    procedure Destroy(Config : Config_Type)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_conf_destroy";

    --
    -- Duplicates a kafka config object
    --
    -- librdkafka equivalent: rd_kafka_conf_dup
    --
    -- @param Config configuration to duplicate
    --
    function Duplicate(Config : Config_Type) return Config_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_conf_dup";

    --
    -- Sets a kafka config property for a given kafka config.
    --
    -- librdkafka equivalent: rd_kafka_conf_set
    --
    -- @param Config configuration to set the property in
    -- @param Name name of property to set
    -- @param Value value of property to set
    -- @raises Kafka_Error on error
    --
    procedure Set(Config : Config_Type;
                  Name   : String;
                  Value  : String);
private

    function rd_kafka_conf_set(conf        : Config_Type;
                               name        : chars_ptr;
                               value       : chars_ptr;
                               errstr      : chars_ptr;
                               errstr_size : size_t) return Integer
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_conf_set";
end Kafka.Config;
