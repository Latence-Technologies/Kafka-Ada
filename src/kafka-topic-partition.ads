
package Kafka.Topic.Partition is
	
    type Partition_List_Type is new System.Address;
    
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

end Kafka.Topic.Partition;