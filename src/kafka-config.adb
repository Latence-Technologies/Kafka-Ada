pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System.Parameters;
with System.Address_To_Access_Conversions;

package body Kafka.Config is
    Error_Buffer_Size : constant size_t := 512;
    RD_Kafka_Conf_OK  : constant Integer := 0;

    function Memory_Alloc(Size : size_t) return chars_ptr;
    pragma Import (C, Memory_Alloc, System.Parameters.C_Malloc_Linkname);

    procedure Set(Config : Config_Type;
                  Name   : String;
                  Value  : String) is
        C_Name  : chars_ptr := New_String(Name);
        C_Value : chars_ptr := New_String(Value);
        C_Err   : chars_ptr := Memory_Alloc(Error_Buffer_Size);
        Result  : Integer;
    begin
        Result := rd_kafka_conf_set(Config, C_Name, C_Value, C_Err, Error_Buffer_Size);

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
end Kafka.Config;