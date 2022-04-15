
--
-- Provides Kafka functionality to create partition lists for a kafka consumer
-- to subscribe to
--
package Kafka.Topic.Partition is
    
    --
    -- Creates a new list/vector Topic+Partition container.
    --
    -- librdkafka equivalent: rd_kafka_topic_partition_list_new
    --
    -- @param Size Initial allocated size used when the expected number of
    --             elements is known or can be estimated.
    --             Avoids reallocation and possibly relocation of the
    --             elems array.
    -- @returns A newly allocated Topic+Partition list.
    --
    function Create_List(Size : Integer) return Partition_List_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_partition_list_new";
             
    --
    -- Free all resources used by the list and the list itself.
    --
    -- librdkafka equivalent: rd_kafka_topic_partition_list_destroy
    --
    procedure Destroy_List(List : Partition_List_Type)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_partition_list_destroy";
             
    --
    -- librdkafka equivalent: rd_kafka_topic_partition_list_add
    --
    procedure List_Add(List      : Partition_List_Type;
                       Topic     : String;
                       Partition : Integer_32);
                
    --
    -- librdkafka equivalent: rd_kafka_topic_partition_list_add_range
    --
    -- @param List  List to extend
    -- @param Topic Topic name
    -- @param Start Start partition of range
    -- @param Stop  Last partition of range (inclusive)
    --
    procedure List_Add_Range(List  : Partition_List_Type;
                             Topic : String;
                             Start : Integer_32;
                             Stop  : Integer_32);
                             
    --
    -- Deletes the specified partition from the list
    --
    -- librdkafka equivalent: rd_kafka_topic_partition_list_del
    --
    -- @param List       List to modify 
    -- @param Topic      Topic name to match
    -- @param Partition  Partition to match
    -- @return True if the partition was found and removed, otherwise False
    --
    function List_Delete(List      : Partition_List_Type;
                         Topic     : String;
                         Partition : Integer_32) return Boolean;   
private
    function rd_kafka_topic_partition_list_add(rktparlist : Partition_List_Type;
                                               topic      : chars_ptr;
                                               partition  : Integer_32) return System.Address
        with Import => True,
            Convention => C,
            External_Name => "rd_kafka_topic_partition_list_add";
            
    
    procedure rd_kafka_topic_partition_list_add_range(rktparlist : Partition_List_Type;
                                                      topic      : chars_ptr;
                                                      start      : Integer_32;
                                                      stop       : Integer_32)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_partition_list_add_range";
            
    function rd_kafka_topic_partition_list_del(rktparlist : Partition_List_Type;
                                               topic      : chars_ptr;
                                               partition  : Integer_32) return int
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_topic_partition_list_del";
                                               
end Kafka.Topic.Partition;