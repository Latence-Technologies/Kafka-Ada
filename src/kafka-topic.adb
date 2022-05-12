package body Kafka.Topic is
    function Create_Topic_Handle(Handle : Handle_Type;
                                 Topic  : String;
                                 Config : Topic_Config_Type) return Topic_Type is
        C_Topic      : chars_ptr := New_String(Topic);
        Topic_Handle : Topic_Type;
    begin
        Topic_Handle := rd_kafka_topic_new(Handle, C_Topic, Config);
        Free(C_Topic);
        return Topic_Handle;
    end;
    
    function Create_Topic_Handle(Handle : Handle_Type;
                                 Topic  : String) return Topic_Type is
    begin
        return Create_Topic_Handle(Handle, Topic, Topic_Config_Type(System.Null_Address));
    end;

    function Get_Name(Topic : Topic_Type) return String is
    begin
        return Interfaces.C.Strings.Value(rd_kafka_topic_name(Topic));
    end;
end Kafka.Topic;
