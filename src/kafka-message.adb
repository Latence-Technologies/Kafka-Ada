pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;
with System.Parameters;
with System.Address_To_Access_Conversions;

package body Kafka.Message is
    function Get_Error(Message : access constant Message_Type) return String is
    begin
        return Interfaces.C.Strings.Value(rd_kafka_message_errstr(Message));
    end Get_Error;
end Kafka.Message;