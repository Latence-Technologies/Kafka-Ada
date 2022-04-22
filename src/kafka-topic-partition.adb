package body Kafka.Topic.Partition is

    procedure List_Add(List      : Partition_List_Type;
                       Topic     : String;
                       Partition : Integer_32) is
        C_Topic : chars_ptr := New_String(Topic);
        Unused : System.Address;
    begin
        Unused := rd_kafka_topic_partition_list_add(List, C_Topic, Partition);
        Free(C_Topic);
    end List_Add;

    procedure List_Add_Range(List  : Partition_List_Type;
                             Topic : String;
                             Start : Integer_32;
                             Stop  : Integer_32) is
        C_Topic : chars_ptr := New_String(Topic);
    begin
        rd_kafka_topic_partition_list_add_range(List, C_Topic, Start, Stop);
        Free(C_Topic);
    end List_Add_Range;


    function List_Delete(List      : Partition_List_Type;
                         Topic     : String;
                         Partition : Integer_32) return Boolean is
        C_Topic : chars_ptr := New_String(Topic);
        Result  : int;
    begin
        Result := rd_kafka_topic_partition_list_del(List, C_Topic, Partition);
        Free(C_Topic);
        return Result = 1;
    end List_Delete;

end Kafka.Topic.Partition;
