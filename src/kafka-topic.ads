pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with System.Parameters;
with Interfaces;           use Interfaces;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

--
-- Provides kafka functionality to interact with Topics
--
package Kafka.Topic is

    --
    -- Creates a handle for a given topic. Does not perform the admin command
    -- to create a topic
    --
    -- librdkafka equivalent: rd_kafka_topic_new
    --
    function Create_Topic_Handle(Handle : Handle_Type;
                                 Topic  : String;
                                 Config : Config_Type) return Topic_Type;

    --
    -- Destroys the specified topic handle
    --
    -- librdkafka equivalent: rd_kafka_topic_destroy
    --
    procedure Destroy_Topic_Handle(Topic : Topic_Type)
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_topic_destroy";

    --
    -- Returns the name of a given topic
    --
    -- librdkafka equivalent: rd_kafka_topic_name
    --
    function Get_Name(Topic : Topic_Type) return String;

    --
    -- Returns the opaque for a given topic
    --
    -- librdkafka equivalent: rd_kafka_topic_opaque
    --
    function Get_Opaque(Topic : Topic_Type) return System.Address
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_topic_opaque";

private

    function rd_kafka_topic_new(Handle : Handle_Type;
                                Topic  : chars_ptr;
                                Config : Config_Type) return Topic_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_new";


    function rd_kafka_topic_name(Topic : Topic_Type) return chars_ptr
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_topic_name";
end Kafka.Topic;