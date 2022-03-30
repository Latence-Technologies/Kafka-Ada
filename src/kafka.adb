pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with System.Parameters;
with System.Address_To_Access_Conversions;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package body Kafka is

	Error_Buffer_Size : constant size_t := 512;
	RD_Kafka_Conf_OK  : constant Integer := 0;

	function Memory_Alloc(Size : size_t) return chars_ptr;
	pragma Import (C, Memory_Alloc, System.Parameters.C_Malloc_Linkname);

	function Get_Error_Name(Error_Code: Kafka_Response_Error_Type) return String is
	begin
		return Interfaces.C.Strings.Value(rd_kafka_err2name(Error_Code));
	end;

	procedure Set_Config(Config : Kafka_Config;
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
	end Set_Config;

	function Create_Handle(HandleType : Kafka_Handle_Type;
                           Config 	  : Kafka_Config) return Kafka_Handle is
		C_Err  : chars_ptr := Memory_Alloc(Error_Buffer_Size);
		Handle : Kafka_Handle;
	begin
		Handle := rd_kafka_new(HandleType, Config, C_Err, Error_Buffer_Size);
		if Handle = Kafka_Handle(System.Null_Address) then
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

	procedure Flush(Handle  : Kafka_Handle;
				    Timeout : Duration) is
		Response : Kafka_Response_Error_Type;
	begin
		Response := rd_kafka_flush(Handle, int(Timeout * 1000));

		if Response = RD_KAFKA_RESP_ERR_u_TIMED_OUT then
			raise Timeout_Reached;
		elsif Response /= RD_KAFKA_RESP_ERR_NO_ERROR then
			raise Kafka_Error with "Unknown error returned by rd_kafka_flush: " & Response'Image;
		end if;
	end Flush;

	function Poll(Handle  : Kafka_Handle;
				  Timeout : Duration) return Integer is
	begin
		return Integer(rd_kafka_poll(Handle, int(Timeout * 1000)));
	end Poll;

	procedure Poll(Handle  : Kafka_Handle;
                   Timeout : Duration) is
		Result : Integer;
	begin
		Result := Poll(Handle, Timeout);
	end Poll;

	function Create_Topic_Handle(Handle : Kafka_Handle;
								 Topic  : String;
								 Config : Kafka_Config) return Kafka_Topic is
		C_Topic      : chars_ptr := New_String(Topic);
		Topic_Handle : Kafka_Topic;
	begin
		Topic_Handle := rd_kafka_topic_new(Handle, C_Topic, Config);
		Free(C_Topic);
		return Topic_Handle;
	end;

	function Get_Name(Topic : Kafka_Topic) return String is
	begin
		return Interfaces.C.Strings.Value(rd_kafka_topic_name(Topic));
	end;

	procedure Produce(Topic          : Kafka_Topic;
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

	procedure Produce(Topic          : Kafka_Topic;
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
end Kafka;

pragma Warnings (On, "use of this unit is non-portable and version-dependent");