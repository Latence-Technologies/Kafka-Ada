package body Kafka.Topic.Config is
    Error_Buffer_Size : constant size_t := 512;
    RD_Kafka_Conf_OK  : constant Integer := 0;

    procedure Set(Config : Topic_Config_Type;
                  Name   : String;
                  Value  : String) is
        C_Name  : chars_ptr := New_String(Name);
        C_Value : chars_ptr := New_String(Value);
        C_Err   : chars_ptr := Alloc(Error_Buffer_Size);
        Result  : Integer;
    begin
        Result := rd_kafka_topic_conf_set(Config, C_Name, C_Value, C_Err, Error_Buffer_Size);

        if Result /= RD_Kafka_Conf_OK then
            declare
                Error : String := Interfaces.C.Strings.Value(C_Err);
            begin
                Free(C_Name);
                Free(C_Value);
                Free(C_Err);
                raise Kafka_Error with Error;
            end;
        end if;

        Free(C_Name);
        Free(C_Value);
        Free(C_Err);
    end Set;
end Kafka.Topic.Config;