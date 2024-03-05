unit ArbolDeBusquedas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Arbol, Archivo;

implementation

procedure InitArboles(arbolQUE: TArbolBinario, arbolOTROS: TArbolBinario, archivoRespuestas: TArchivo);
var
  respuesta: TRespuesta;
  elem:T_Elem;
begin
  if TamArchivo(archivoRespuestas) > 0 then
  begin
    for i:=0 to TamArchivo(archivoRespuestas)-1 do
    begin
      respuesta:= LeerRespuestas(archivoRespuestas, i);
      elem.pregunta:= respuesta.pregunta;
      elem.pos:= i;

      case respuesta.key of
         'QUE':InsertarEnArbol(arbolQUE, respuesta);

         'COMO':;
         'CUANDO':;
         'PORQUE':;
         'DONDE':;
         'PARAQUE';

         'OTROS':InsertarEnArbol(arbolOTROS, respuesta);
       end;
    end;
  end;
end;

procedure BuscarRespuestaEnArbol(arbol: TArbolBinario; pregunta: string);
begin
  if arbol <> nil then
  begin
    if pregunta = arbol^.respuesta.pregunta then
      Writeln('Respuesta: ', arbol^.respuesta.respuesta)
    else if pregunta < arbol^.respuesta.pregunta then
      BuscarRespuestaEnArbol(arbol^.izquierda, pregunta)
    else
      BuscarRespuestaEnArbol(arbol^.derecha, pregunta);
  end
  else
    Writeln('Lo siento, no encontré una respuesta para esa pregunta.');
end;

end.

