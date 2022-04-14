pragma Warnings (Off, "use of this unit is non-portable and version-dependent");

with System.Parameters;
with Interfaces;           use Interfaces;
with Interfaces.C;         use Interfaces.C;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package Kafka is

    subtype Kafka_Response_Error_Type is Integer;
    RD_KAFKA_RESP_ERR_u_BEGIN                               : constant Kafka_Response_Error_Type := -200;
    RD_KAFKA_RESP_ERR_u_BAD_MSG                             : constant Kafka_Response_Error_Type := -199;
    RD_KAFKA_RESP_ERR_u_BAD_COMPRESSION                     : constant Kafka_Response_Error_Type := -198;
    RD_KAFKA_RESP_ERR_u_DESTROY                             : constant Kafka_Response_Error_Type := -197;
    RD_KAFKA_RESP_ERR_u_FAIL                                : constant Kafka_Response_Error_Type := -196;
    RD_KAFKA_RESP_ERR_u_TRANSPORT                           : constant Kafka_Response_Error_Type := -195;
    RD_KAFKA_RESP_ERR_u_CRIT_SYS_RESOURCE                   : constant Kafka_Response_Error_Type := -194;
    RD_KAFKA_RESP_ERR_u_RESOLVE                             : constant Kafka_Response_Error_Type := -193;
    RD_KAFKA_RESP_ERR_u_MSG_TIMED_OUT                       : constant Kafka_Response_Error_Type := -192;
    RD_KAFKA_RESP_ERR_u_PARTITION_EOF                       : constant Kafka_Response_Error_Type := -191;
    RD_KAFKA_RESP_ERR_u_UNKNOWN_PARTITION                   : constant Kafka_Response_Error_Type := -190;
    RD_KAFKA_RESP_ERR_u_FS                                  : constant Kafka_Response_Error_Type := -189;
    RD_KAFKA_RESP_ERR_u_UNKNOWN_TOPIC                       : constant Kafka_Response_Error_Type := -188;
    RD_KAFKA_RESP_ERR_u_ALL_BROKERS_DOWN                    : constant Kafka_Response_Error_Type := -187;
    RD_KAFKA_RESP_ERR_u_INVALID_ARG                         : constant Kafka_Response_Error_Type := -186;
    RD_KAFKA_RESP_ERR_u_TIMED_OUT                           : constant Kafka_Response_Error_Type := -185;
    RD_KAFKA_RESP_ERR_u_QUEUE_FULL                          : constant Kafka_Response_Error_Type := -184;
    RD_KAFKA_RESP_ERR_u_ISR_INSUFF                          : constant Kafka_Response_Error_Type := -183;
    RD_KAFKA_RESP_ERR_u_NODE_UPDATE                         : constant Kafka_Response_Error_Type := -182;
    RD_KAFKA_RESP_ERR_u_SSL                                 : constant Kafka_Response_Error_Type := -181;
    RD_KAFKA_RESP_ERR_u_WAIT_COORD                          : constant Kafka_Response_Error_Type := -180;
    RD_KAFKA_RESP_ERR_u_UNKNOWN_GROUP                       : constant Kafka_Response_Error_Type := -179;
    RD_KAFKA_RESP_ERR_u_IN_PROGRESS                         : constant Kafka_Response_Error_Type := -178;
    RD_KAFKA_RESP_ERR_u_PREV_IN_PROGRESS                    : constant Kafka_Response_Error_Type := -177;
    RD_KAFKA_RESP_ERR_u_EXISTING_SUBSCRIPTION               : constant Kafka_Response_Error_Type := -176;
    RD_KAFKA_RESP_ERR_u_ASSIGN_PARTITIONS                   : constant Kafka_Response_Error_Type := -175;
    RD_KAFKA_RESP_ERR_u_REVOKE_PARTITIONS                   : constant Kafka_Response_Error_Type := -174;
    RD_KAFKA_RESP_ERR_u_CONFLICT                            : constant Kafka_Response_Error_Type := -173;
    RD_KAFKA_RESP_ERR_u_STATE                               : constant Kafka_Response_Error_Type := -172;
    RD_KAFKA_RESP_ERR_u_UNKNOWN_PROTOCOL                    : constant Kafka_Response_Error_Type := -171;
    RD_KAFKA_RESP_ERR_u_NOT_IMPLEMENTED                     : constant Kafka_Response_Error_Type := -170;
    RD_KAFKA_RESP_ERR_u_AUTHENTICATION                      : constant Kafka_Response_Error_Type := -169;
    RD_KAFKA_RESP_ERR_u_NO_OFFSET                           : constant Kafka_Response_Error_Type := -168;
    RD_KAFKA_RESP_ERR_u_OUTDATED                            : constant Kafka_Response_Error_Type := -167;
    RD_KAFKA_RESP_ERR_u_TIMED_OUT_QUEUE                     : constant Kafka_Response_Error_Type := -166;
    RD_KAFKA_RESP_ERR_u_UNSUPPORTED_FEATURE                 : constant Kafka_Response_Error_Type := -165;
    RD_KAFKA_RESP_ERR_u_WAIT_CACHE                          : constant Kafka_Response_Error_Type := -164;
    RD_KAFKA_RESP_ERR_u_INTR                                : constant Kafka_Response_Error_Type := -163;
    RD_KAFKA_RESP_ERR_u_KEY_SERIALIZATION                   : constant Kafka_Response_Error_Type := -162;
    RD_KAFKA_RESP_ERR_u_VALUE_SERIALIZATION                 : constant Kafka_Response_Error_Type := -161;
    RD_KAFKA_RESP_ERR_u_KEY_DESERIALIZATION                 : constant Kafka_Response_Error_Type := -160;
    RD_KAFKA_RESP_ERR_u_VALUE_DESERIALIZATION               : constant Kafka_Response_Error_Type := -159;
    RD_KAFKA_RESP_ERR_u_PARTIAL                             : constant Kafka_Response_Error_Type := -158;
    RD_KAFKA_RESP_ERR_u_READ_ONLY                           : constant Kafka_Response_Error_Type := -157;
    RD_KAFKA_RESP_ERR_u_NOENT                               : constant Kafka_Response_Error_Type := -156;
    RD_KAFKA_RESP_ERR_u_UNDERFLOW                           : constant Kafka_Response_Error_Type := -155;
    RD_KAFKA_RESP_ERR_u_INVALID_TYPE                        : constant Kafka_Response_Error_Type := -154;
    RD_KAFKA_RESP_ERR_u_RETRY                               : constant Kafka_Response_Error_Type := -153;
    RD_KAFKA_RESP_ERR_u_PURGE_QUEUE                         : constant Kafka_Response_Error_Type := -152;
    RD_KAFKA_RESP_ERR_u_PURGE_INFLIGHT                      : constant Kafka_Response_Error_Type := -151;
    RD_KAFKA_RESP_ERR_u_FATAL                               : constant Kafka_Response_Error_Type := -150;
    RD_KAFKA_RESP_ERR_u_INCONSISTENT                        : constant Kafka_Response_Error_Type := -149;
    RD_KAFKA_RESP_ERR_u_GAPLESS_GUARANTEE                   : constant Kafka_Response_Error_Type := -148;
    RD_KAFKA_RESP_ERR_u_MAX_POLL_EXCEEDED                   : constant Kafka_Response_Error_Type := -147;
    RD_KAFKA_RESP_ERR_u_UNKNOWN_BROKER                      : constant Kafka_Response_Error_Type := -146;
    RD_KAFKA_RESP_ERR_u_NOT_CONFIGURED                      : constant Kafka_Response_Error_Type := -145;
    RD_KAFKA_RESP_ERR_u_FENCED                              : constant Kafka_Response_Error_Type := -144;
    RD_KAFKA_RESP_ERR_u_APPLICATION                         : constant Kafka_Response_Error_Type := -143;
    RD_KAFKA_RESP_ERR_u_ASSIGNMENT_LOST                     : constant Kafka_Response_Error_Type := -142;
    RD_KAFKA_RESP_ERR_u_NOOP                                : constant Kafka_Response_Error_Type := -141;
    RD_KAFKA_RESP_ERR_u_AUTO_OFFSET_RESET                   : constant Kafka_Response_Error_Type := -140;
    RD_KAFKA_RESP_ERR_u_END                                 : constant Kafka_Response_Error_Type := -100;
    RD_KAFKA_RESP_ERR_UNKNOWN                               : constant Kafka_Response_Error_Type := -1;
    RD_KAFKA_RESP_ERR_NO_ERROR                              : constant Kafka_Response_Error_Type := 0;
    RD_KAFKA_RESP_ERR_OFFSET_OUT_OF_RANGE                   : constant Kafka_Response_Error_Type := 1;
    RD_KAFKA_RESP_ERR_INVALID_MSG                           : constant Kafka_Response_Error_Type := 2;
    RD_KAFKA_RESP_ERR_UNKNOWN_TOPIC_OR_PART                 : constant Kafka_Response_Error_Type := 3;
    RD_KAFKA_RESP_ERR_INVALID_MSG_SIZE                      : constant Kafka_Response_Error_Type := 4;
    RD_KAFKA_RESP_ERR_LEADER_NOT_AVAILABLE                  : constant Kafka_Response_Error_Type := 5;
    RD_KAFKA_RESP_ERR_NOT_LEADER_FOR_PARTITION              : constant Kafka_Response_Error_Type := 6;
    RD_KAFKA_RESP_ERR_REQUEST_TIMED_OUT                     : constant Kafka_Response_Error_Type := 7;
    RD_KAFKA_RESP_ERR_BROKER_NOT_AVAILABLE                  : constant Kafka_Response_Error_Type := 8;
    RD_KAFKA_RESP_ERR_REPLICA_NOT_AVAILABLE                 : constant Kafka_Response_Error_Type := 9;
    RD_KAFKA_RESP_ERR_MSG_SIZE_TOO_LARGE                    : constant Kafka_Response_Error_Type := 10;
    RD_KAFKA_RESP_ERR_STALE_CTRL_EPOCH                      : constant Kafka_Response_Error_Type := 11;
    RD_KAFKA_RESP_ERR_OFFSET_METADATA_TOO_LARGE             : constant Kafka_Response_Error_Type := 12;
    RD_KAFKA_RESP_ERR_NETWORK_EXCEPTION                     : constant Kafka_Response_Error_Type := 13;
    RD_KAFKA_RESP_ERR_COORDINATOR_LOAD_IN_PROGRESS          : constant Kafka_Response_Error_Type := 14;
    RD_KAFKA_RESP_ERR_COORDINATOR_NOT_AVAILABLE             : constant Kafka_Response_Error_Type := 15;
    RD_KAFKA_RESP_ERR_NOT_COORDINATOR                       : constant Kafka_Response_Error_Type := 16;
    RD_KAFKA_RESP_ERR_TOPIC_EXCEPTION                       : constant Kafka_Response_Error_Type := 17;
    RD_KAFKA_RESP_ERR_RECORD_LIST_TOO_LARGE                 : constant Kafka_Response_Error_Type := 18;
    RD_KAFKA_RESP_ERR_NOT_ENOUGH_REPLICAS                   : constant Kafka_Response_Error_Type := 19;
    RD_KAFKA_RESP_ERR_NOT_ENOUGH_REPLICAS_AFTER_APPEND      : constant Kafka_Response_Error_Type := 20;
    RD_KAFKA_RESP_ERR_INVALID_REQUIRED_ACKS                 : constant Kafka_Response_Error_Type := 21;
    RD_KAFKA_RESP_ERR_ILLEGAL_GENERATION                    : constant Kafka_Response_Error_Type := 22;
    RD_KAFKA_RESP_ERR_INCONSISTENT_GROUP_PROTOCOL           : constant Kafka_Response_Error_Type := 23;
    RD_KAFKA_RESP_ERR_INVALID_GROUP_ID                      : constant Kafka_Response_Error_Type := 24;
    RD_KAFKA_RESP_ERR_UNKNOWN_MEMBER_ID                     : constant Kafka_Response_Error_Type := 25;
    RD_KAFKA_RESP_ERR_INVALID_SESSION_TIMEOUT               : constant Kafka_Response_Error_Type := 26;
    RD_KAFKA_RESP_ERR_REBALANCE_IN_PROGRESS                 : constant Kafka_Response_Error_Type := 27;
    RD_KAFKA_RESP_ERR_INVALID_COMMIT_OFFSET_SIZE            : constant Kafka_Response_Error_Type := 28;
    RD_KAFKA_RESP_ERR_TOPIC_AUTHORIZATION_FAILED            : constant Kafka_Response_Error_Type := 29;
    RD_KAFKA_RESP_ERR_GROUP_AUTHORIZATION_FAILED            : constant Kafka_Response_Error_Type := 30;
    RD_KAFKA_RESP_ERR_CLUSTER_AUTHORIZATION_FAILED          : constant Kafka_Response_Error_Type := 31;
    RD_KAFKA_RESP_ERR_INVALID_TIMESTAMP                     : constant Kafka_Response_Error_Type := 32;
    RD_KAFKA_RESP_ERR_UNSUPPORTED_SASL_MECHANISM            : constant Kafka_Response_Error_Type := 33;
    RD_KAFKA_RESP_ERR_ILLEGAL_SASL_STATE                    : constant Kafka_Response_Error_Type := 34;
    RD_KAFKA_RESP_ERR_UNSUPPORTED_VERSION                   : constant Kafka_Response_Error_Type := 35;
    RD_KAFKA_RESP_ERR_TOPIC_ALREADY_EXISTS                  : constant Kafka_Response_Error_Type := 36;
    RD_KAFKA_RESP_ERR_INVALID_PARTITIONS                    : constant Kafka_Response_Error_Type := 37;
    RD_KAFKA_RESP_ERR_INVALID_REPLICATION_FACTOR            : constant Kafka_Response_Error_Type := 38;
    RD_KAFKA_RESP_ERR_INVALID_REPLICA_ASSIGNMENT            : constant Kafka_Response_Error_Type := 39;
    RD_KAFKA_RESP_ERR_INVALID_CONFIG                        : constant Kafka_Response_Error_Type := 40;
    RD_KAFKA_RESP_ERR_NOT_CONTROLLER                        : constant Kafka_Response_Error_Type := 41;
    RD_KAFKA_RESP_ERR_INVALID_REQUEST                       : constant Kafka_Response_Error_Type := 42;
    RD_KAFKA_RESP_ERR_UNSUPPORTED_FOR_MESSAGE_FORMAT        : constant Kafka_Response_Error_Type := 43;
    RD_KAFKA_RESP_ERR_POLICY_VIOLATION                      : constant Kafka_Response_Error_Type := 44;
    RD_KAFKA_RESP_ERR_OUT_OF_ORDER_SEQUENCE_NUMBER          : constant Kafka_Response_Error_Type := 45;
    RD_KAFKA_RESP_ERR_DUPLICATE_SEQUENCE_NUMBER             : constant Kafka_Response_Error_Type := 46;
    RD_KAFKA_RESP_ERR_INVALID_PRODUCER_EPOCH                : constant Kafka_Response_Error_Type := 47;
    RD_KAFKA_RESP_ERR_INVALID_TXN_STATE                     : constant Kafka_Response_Error_Type := 48;
    RD_KAFKA_RESP_ERR_INVALID_PRODUCER_ID_MAPPING           : constant Kafka_Response_Error_Type := 49;
    RD_KAFKA_RESP_ERR_INVALID_TRANSACTION_TIMEOUT           : constant Kafka_Response_Error_Type := 50;
    RD_KAFKA_RESP_ERR_CONCURRENT_TRANSACTIONS               : constant Kafka_Response_Error_Type := 51;
    RD_KAFKA_RESP_ERR_TRANSACTION_COORDINATOR_FENCED        : constant Kafka_Response_Error_Type := 52;
    RD_KAFKA_RESP_ERR_TRANSACTIONAL_ID_AUTHORIZATION_FAILED : constant Kafka_Response_Error_Type := 53;
    RD_KAFKA_RESP_ERR_SECURITY_DISABLED                     : constant Kafka_Response_Error_Type := 54;
    RD_KAFKA_RESP_ERR_OPERATION_NOT_ATTEMPTED               : constant Kafka_Response_Error_Type := 55;
    RD_KAFKA_RESP_ERR_KAFKA_STORAGE_ERROR                   : constant Kafka_Response_Error_Type := 56;
    RD_KAFKA_RESP_ERR_LOG_DIR_NOT_FOUND                     : constant Kafka_Response_Error_Type := 57;
    RD_KAFKA_RESP_ERR_SASL_AUTHENTICATION_FAILED            : constant Kafka_Response_Error_Type := 58;
    RD_KAFKA_RESP_ERR_UNKNOWN_PRODUCER_ID                   : constant Kafka_Response_Error_Type := 59;
    RD_KAFKA_RESP_ERR_REASSIGNMENT_IN_PROGRESS              : constant Kafka_Response_Error_Type := 60;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_AUTH_DISABLED        : constant Kafka_Response_Error_Type := 61;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_NOT_FOUND            : constant Kafka_Response_Error_Type := 62;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_OWNER_MISMATCH       : constant Kafka_Response_Error_Type := 63;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_REQUEST_NOT_ALLOWED  : constant Kafka_Response_Error_Type := 64;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_AUTHORIZATION_FAILED : constant Kafka_Response_Error_Type := 65;
    RD_KAFKA_RESP_ERR_DELEGATION_TOKEN_EXPIRED              : constant Kafka_Response_Error_Type := 66;
    RD_KAFKA_RESP_ERR_INVALID_PRINCIPAL_TYPE                : constant Kafka_Response_Error_Type := 67;
    RD_KAFKA_RESP_ERR_NON_EMPTY_GROUP                       : constant Kafka_Response_Error_Type := 68;
    RD_KAFKA_RESP_ERR_GROUP_ID_NOT_FOUND                    : constant Kafka_Response_Error_Type := 69;
    RD_KAFKA_RESP_ERR_FETCH_SESSION_ID_NOT_FOUND            : constant Kafka_Response_Error_Type := 70;
    RD_KAFKA_RESP_ERR_INVALID_FETCH_SESSION_EPOCH           : constant Kafka_Response_Error_Type := 71;
    RD_KAFKA_RESP_ERR_LISTENER_NOT_FOUND                    : constant Kafka_Response_Error_Type := 72;
    RD_KAFKA_RESP_ERR_TOPIC_DELETION_DISABLED               : constant Kafka_Response_Error_Type := 73;
    RD_KAFKA_RESP_ERR_FENCED_LEADER_EPOCH                   : constant Kafka_Response_Error_Type := 74;
    RD_KAFKA_RESP_ERR_UNKNOWN_LEADER_EPOCH                  : constant Kafka_Response_Error_Type := 75;
    RD_KAFKA_RESP_ERR_UNSUPPORTED_COMPRESSION_TYPE          : constant Kafka_Response_Error_Type := 76;
    RD_KAFKA_RESP_ERR_STALE_BROKER_EPOCH                    : constant Kafka_Response_Error_Type := 77;
    RD_KAFKA_RESP_ERR_OFFSET_NOT_AVAILABLE                  : constant Kafka_Response_Error_Type := 78;
    RD_KAFKA_RESP_ERR_MEMBER_ID_REQUIRED                    : constant Kafka_Response_Error_Type := 79;
    RD_KAFKA_RESP_ERR_PREFERRED_LEADER_NOT_AVAILABLE        : constant Kafka_Response_Error_Type := 80;
    RD_KAFKA_RESP_ERR_GROUP_MAX_SIZE_REACHED                : constant Kafka_Response_Error_Type := 81;
    RD_KAFKA_RESP_ERR_FENCED_INSTANCE_ID                    : constant Kafka_Response_Error_Type := 82;
    RD_KAFKA_RESP_ERR_ELIGIBLE_LEADERS_NOT_AVAILABLE        : constant Kafka_Response_Error_Type := 83;
    RD_KAFKA_RESP_ERR_ELECTION_NOT_NEEDED                   : constant Kafka_Response_Error_Type := 84;
    RD_KAFKA_RESP_ERR_NO_REASSIGNMENT_IN_PROGRESS           : constant Kafka_Response_Error_Type := 85;
    RD_KAFKA_RESP_ERR_GROUP_SUBSCRIBED_TO_TOPIC             : constant Kafka_Response_Error_Type := 86;
    RD_KAFKA_RESP_ERR_INVALID_RECORD                        : constant Kafka_Response_Error_Type := 87;
    RD_KAFKA_RESP_ERR_UNSTABLE_OFFSET_COMMIT                : constant Kafka_Response_Error_Type := 88;
    RD_KAFKA_RESP_ERR_THROTTLING_QUOTA_EXCEEDED             : constant Kafka_Response_Error_Type := 89;
    RD_KAFKA_RESP_ERR_PRODUCER_FENCED                       : constant Kafka_Response_Error_Type := 90;
    RD_KAFKA_RESP_ERR_RESOURCE_NOT_FOUND                    : constant Kafka_Response_Error_Type := 91;
    RD_KAFKA_RESP_ERR_DUPLICATE_RESOURCE                    : constant Kafka_Response_Error_Type := 92;
    RD_KAFKA_RESP_ERR_UNACCEPTABLE_CREDENTIAL               : constant Kafka_Response_Error_Type := 93;
    RD_KAFKA_RESP_ERR_INCONSISTENT_VOTER_SET                : constant Kafka_Response_Error_Type := 94;
    RD_KAFKA_RESP_ERR_INVALID_UPDATE_VERSION                : constant Kafka_Response_Error_Type := 95;
    RD_KAFKA_RESP_ERR_FEATURE_UPDATE_FAILED                 : constant Kafka_Response_Error_Type := 96;
    RD_KAFKA_RESP_ERR_PRINCIPAL_DESERIALIZATION_FAILURE     : constant Kafka_Response_Error_Type := 97;
    RD_KAFKA_RESP_ERR_END_ALL                               : constant Kafka_Response_Error_Type := 98;

    subtype Kafka_Message_Flag_Type is Integer;
    RD_KAFKA_MSG_F_FREE      : constant Kafka_Message_Flag_Type := 1;
    RD_KAFKA_MSG_F_COPY      : constant Kafka_Message_Flag_Type := 2;
    RD_KAFKA_MSG_F_BLOCK     : constant Kafka_Message_Flag_Type := 4;
    RD_KAFKA_MSG_F_PARTITION : constant Kafka_Message_Flag_Type := 8;

    RD_KAFKA_PARTITION_UA : constant Integer_32 := -1;

    Kafka_Error : exception;
    Timeout_Reached : exception;

    type Handle_Type is new System.Address;
    type Topic_Type is new System.Address;
    type Config_Type is new System.Address;
    type Partition_List_Type is new System.Address;

    type Kafka_Handle_Type is (RD_KAFKA_PRODUCER, RD_KAFKA_CONSUMER)
        with Convention => C;

    type Message_Type is record
        Error          : aliased Kafka_Response_Error_Type;
        Topic          : Topic_Type;
        Partition      : aliased Integer_32;
        Payload        : System.Address;
        Payload_Length : aliased size_t;
        Key            : System.Address;
        Key_Length     : aliased size_t;
        Offset         : aliased Integer_64;
        Opaque         : System.Address;
    end record
        with Convention => C_Pass_By_Copy;

    type Delivery_Report_Callback is access procedure (Kafka   : Handle_Type;
                                                       Message : access constant Message_Type;
                                                       Opaque  : System.Address)
        with Convention => C;

    --
    -- Returns the version of librdkafka as an Integer.
    --
    -- librdkafka equivalent: rd_kafka_version
    --
    function Version return Integer
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_version";
            
    --
    -- Returns the version of librdkafka as a String
    --
    -- librdkafka equivalent: rd_kafka_version_str
    --
    function Version return String;

    --
    -- Return the last error encountered by Kafka. The last error is stored
    -- per thread.
    --
    -- librdkafka equivalent: rd_kafka_last_error
    --
    function Get_Last_Error return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_last_error";


    --
    -- Returns the name of a kafka error given an error code
    --
    -- librdkafka equivalent: rd_kafka_err2name
    --
    function Get_Error_Name(Error_Code: Kafka_Response_Error_Type) return String;

    --
    -- Sets the callback for listening to messages that are being produced, for
    -- the provided configuration object
    --
    -- librdkafka equivalent: rd_kafka_conf_set_dr_msg_cb
    --
    procedure Set_Delivery_Report_Callback(Config     : Config_Type;
                                           Callback   : Delivery_Report_Callback)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_conf_set_dr_msg_cb";


    --
    -- Creates a kafka handle
    --
    -- librdkafka equivalent: rd_kafka_new
    --
    function Create_Handle(HandleType : Kafka_Handle_Type;
                           Config       : Config_Type) return Handle_Type;

    --
    -- Destroys the specified kafka handle
    --
    -- librdkafka equivalent: rd_kafka_destroy
    --
    procedure Destroy_Handle(Handle : Handle_Type)
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_destroy";

    --
    -- Wait until all outstanding produce requests, et.al, are completed.
    -- This should typically be done prior to destroying a producer instance
    -- to make sure all queued and in-flight produce requests are completed
    -- before terminating.
    --
    -- @raises Timeout_Reached if Timeout was reached before all outstanding requests were completed.
    -- @raises Kafka_Error if an error occurs
    --
    procedure Flush(Handle  : Handle_Type;
                    Timeout : Duration);

    --
    -- Polls the provided kafka handle for events. Events will cause application
    -- provided callbacks to be called.
    --
    -- librdkafka equivalent: rd_kafka_poll
    --
    -- @params Handle Kafka handle
    -- @params Timeout timeout for polling events
    -- @returns the number of events served.
    --
    function Poll(Handle  : Handle_Type;
                  Timeout : Duration) return Integer;

    --
    -- Polls the provided kafka handle for events. Events will cause application
    -- provided callbacks to be called.
    --
    -- librdkafka equivalent: rd_kafka_poll
    --
    -- @params Handle Kafka handle
    -- @params Timeout timeout for polling events
    --
    procedure Poll(Handle  : Handle_Type;
                   Timeout : Duration);

    --
    -- Produce and send a single message to broker.
    --
    -- librdkafka equivalent: rd_kafka_produce
    --
    procedure Produce(Topic          : Topic_Type;
                      Partition      : Integer_32;
                      Message_Flags  : Kafka_Message_Flag_Type;
                      Payload        : System.Address;
                      Payload_Length : size_t;
                      Key            : System.Address;
                      Key_Length     : size_t;
                      Message_Opaque : System.Address);

    --
    -- Produce and send a single message to broker where both the payload and
    -- key are strings that will be copied
    --
    -- librdkafka equivalent: rd_kafka_produce
    --
    procedure Produce(Topic          : Topic_Type;
                      Partition      : Integer_32;
                      Payload        : String;
                      Key            : String;
                      Message_Opaque : System.Address);

    --
    -- librdkafka equivalent: rd_kafka_subscribe
    --
    procedure Subscribe(Handle         : Handle_Type;
                        Partition_List : Partition_List_Type);
                        
    --
    -- librdkafka equivalent: rd_kafka_unsubscribe
    --
    procedure Unsubscribe(Handle : Handle_Type);
private

    --
    -- The following functions are used by wrapper functions due to the lack of
    -- convenience (either because of chars_ptr or their error handling)
    --
    
    function rd_kafka_version_str return Interfaces.C.Strings.chars_ptr
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_version_str";

    function rd_kafka_err2name(Error_Code: Kafka_Response_Error_Type) return Interfaces.C.Strings.chars_ptr
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_err2name";

    function rd_kafka_new(c_type      : Kafka_Handle_Type;
                          conf        : Config_Type;
                          errstr      : chars_ptr;
                          errstr_size : size_t) return Handle_Type
        with Import => True, 
             Convention => C, 
             External_Name => "rd_kafka_new";

    function rd_kafka_flush(rk         : Handle_Type;
                            timeout_ms : int) return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_flush";


    function rd_kafka_poll(rk         : Handle_Type;
                           timeout_ms : int) return int
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_poll";

    function rd_kafka_produce(Topic          : Topic_Type;
                              Partition      : Integer_32;
                              Message_Flags  : Kafka_Message_Flag_Type;
                              Payload        : System.Address;
                              Payload_Length : size_t;
                              Key            : System.Address;
                              Key_Length     : size_t;
                              Message_Opaque : System.Address) return int
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_produce";
             
    function rd_kafka_subscribe(Handle         : Handle_Type;
                                Partition_List : Partition_List_Type) return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_subscribe";
             
    function rd_kafka_unsubscribe(Handle : Handle_Type) return Kafka_Response_Error_Type
        with Import => True,
             Convention => C,
             External_Name => "rd_kafka_unsubscribe";
                                

end Kafka;

pragma Warnings (On, "use of this unit is non-portable and version-dependent");