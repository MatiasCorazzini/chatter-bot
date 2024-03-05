program chatterbot;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Classes, Archivo, BusquedaDeRespuestas;
var
  input, resp:String;
  arch:TArchivo;
begin

  //EscribirRespuestasEnArchivo(arch);

  while TRUE do
  begin
    Write('> ');
    Readln(input);
    resp:= BuscarRespuestaEnArchivo(arch, input);
    if resp <> 'FALSE' then
       Writeln('ChatBot: ', resp+#10)
    else
      Writeln('ChatBot: Lo siento, no encontre una respuesta.'+#10);
  end;
end.

