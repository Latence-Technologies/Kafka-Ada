with Ada.Interrupts.Names;

package Signal is

   protected type Handler is
      function Triggered return Boolean;
   private
      Signal_Received : Boolean := False;

      pragma Unreserve_All_Interrupts;
      procedure Handle_Int  with Attach_Handler => Ada.Interrupts.Names.SIGINT;
      procedure Handle_Quit with Attach_Handler => Ada.Interrupts.Names.SIGQUIT;
      procedure Handle_Term with Attach_Handler => Ada.Interrupts.Names.SIGTERM;
   end Handler;

end Signal;
