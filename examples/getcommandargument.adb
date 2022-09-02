with GNAT.Command_Line; use GNAT.Command_Line;
with GNAT.Strings;

package body GetCommandArgument is

function Parse_Command_Line (DefaultValue : in String) return String is
    VAR : aliased GNAT.Strings.String_Access;
    Cmd_Line_Setup : Command_Line_Configuration;
  begin
    Define_Switch(Config      => Cmd_Line_Setup,
                  Output      => VAR'Access,
                  Switch      => Switch_Arg,
                  Long_Switch => Long_Switch_Arg,
                  Help        => Help_Text);
    Getopt(Cmd_Line_Setup);
    GNAT.Command_Line.Free(Cmd_Line_Setup);
    return (if VAR.all = "" then DefaultValue else VAR.all);
    exception
      when Exit_From_Command_Line =>
        GNAT.Command_Line.Free(Cmd_Line_Setup);
        raise Exit_From_Command_Line;
  end;

end GetCommandArgument;