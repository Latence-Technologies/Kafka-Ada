package body Signal is

   protected body Handler is

      function Triggered return Boolean is (Signal_Received);

      procedure Handle_Int is
      begin
         Signal_Received := True;
      end Handle_Int;

      procedure Handle_Quit is
      begin
         Signal_Received := True;
      end Handle_Quit;

      procedure Handle_Term is
      begin
         Signal_Received := True;
      end Handle_Term;

   end Handler;

end Signal;
