generic
  Switch_Arg     : in String;  -- ex: "-t:"
  Long_Switch_Arg: in String;  -- ex: "--topic:"
  Help_Text      : in String;  -- ex: "Topic name to use"

package GetCommandArgument is

  function Parse_Command_Line (DefaultValue : in String) return String;

end GetCommandArgument;