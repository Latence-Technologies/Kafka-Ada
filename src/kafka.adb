pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System.Parameters;
with System.Address_To_Access_Conversions;

package body Kafka is
    Error_Buffer_Size : constant size_t := 512;

    function Version return String is
    begin
        return Interfaces.C.Strings.Value(rd_kafka_version_str);
    end;

    function Get_Error_Name(Error_Code: Kafka_Response_Error_Type) return String is
    begin
        return Interfaces.C.Strings.Value(rd_kafka_err2name(Error_Code));
    end;

    function Create_Handle(HandleType : Kafka_Handle_Type;
                           Config     : Config_Type) return Handle_Type is
        C_Err  : chars_ptr := Alloc(Error_Buffer_Size);
        Handle : Handle_Type;
    begin
        Handle := rd_kafka_new(HandleType, Config, C_Err, Error_Buffer_Size);
        if Handle = Handle_Type(System.Null_Address) then
            declare
                Error : String := Interfaces.C.Strings.Value(C_Err);
            begin
                Free(C_Err);
                raise Kafka_Error with Error;
            end;
        end if;

        Free(C_Err);
        return Handle;
    end Create_Handle;

    procedure Flush(Handle  : Handle_Type;
                    Timeout : Duration) is
        Response : Kafka_Response_Error_Type;
    begin
        Response := rd_kafka_flush(Handle, int(Timeout * 1000));

        if Response = RD_KAFKA_RESP_ERR_u_TIMED_OUT then
            raise Timeout_Reached;
        elsif Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
            raise Kafka_Error with "Unknown error returned by rd_kafka_flush: " & Kafka.Get_Error_Name(Response);
        end if;
    end Flush;

    function Poll(Handle  : Handle_Type;
                  Timeout : Duration) return Integer is
    begin
        return Integer(rd_kafka_poll(Handle, int(Timeout * 1000)));
    end Poll;

    procedure Poll(Handle  : Handle_Type;
                   Timeout : Duration) is
        Result : Integer;
    begin
        Result := Poll(Handle, Timeout);
    end Poll;

    procedure Produce(Topic          : Topic_Type;
                      Partition      : Integer_32;
                      Message_Flags  : Kafka_Message_Flag_Type;
                      Payload        : System.Address;
                      Payload_Length : size_t;
                      Key            : System.Address;
                      Key_Length     : size_t;
                      Message_Opaque : System.Address) is
        Result : int;
    begin
        Result := rd_kafka_produce(Topic, Partition, Message_Flags, Payload, Payload_Length, Key, Key_Length, Message_Opaque);

        if(Result /= 0) then
            raise Kafka_Error with Get_Error_Name(Get_Last_Error);
        end if;
    end Produce;

    procedure Produce(Topic          : Topic_Type;
                      Partition      : Integer_32;
                      Payload        : String;
                      Key            : String;
                      Message_Opaque : System.Address) is
        type Byte_Array is array (Positive range <>) of aliased Interfaces.Unsigned_8;

        -- Does not matter since we are passing length to the C function, specifying the bound
        pragma Warnings (Off, "To_Pointer results may not have bounds");
        package Byte_Conv is new System.Address_To_Access_Conversions(Byte_Array);
        pragma Warnings (On, "To_Pointer results may not have bounds");

        Payload_Bytes : aliased Byte_Array := (1 .. Payload'Length => 0);
        Key_Bytes     : aliased Byte_Array := (1 .. Key'Length => 0);
    begin
        for Index in 1 .. Payload'Length loop
            Payload_Bytes(Index) := Character'Pos(Payload(Payload'First + Index - 1));
        end loop;

        for Index in 1 .. Key'Length loop
            Key_Bytes(Index) := Character'Pos(Key(Key'First + Index - 1));
        end loop;

        Produce(Topic,
                Partition,
                RD_KAFKA_MSG_F_COPY,
                Byte_Conv.To_Address(Payload_Bytes'Access),
                Payload_Bytes'Length,
                Byte_Conv.To_Address(Key_Bytes'Access),
                Key_Bytes'Length,
                Message_Opaque);
    end Produce;

    procedure Subscribe(Handle         : Handle_Type;
                        Partition_List : Partition_List_Type) is
        Response : Kafka_Response_Error_Type;
    begin
        Response := rd_kafka_subscribe(Handle, Partition_List);

        if Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
            raise Kafka_Error with "Error returned by rd_kafka_subscribe: " & Kafka.Get_Error_Name(Response);
        end if;
    end Subscribe;

    procedure Unsubscribe(Handle : Handle_Type) is
        Response : Kafka_Response_Error_Type;
    begin
        Response := rd_kafka_unsubscribe(Handle);

        if Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
            raise Kafka_Error with "Error returned by rd_kafka_unsubscribe: " & Kafka.Get_Error_Name(Response);
        end if;
    end Unsubscribe;
end Kafka;

pragma Warnings (On, "use of this unit is non-portable and version-dependent");
