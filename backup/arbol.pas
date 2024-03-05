unit Arbol;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils;

type
  T_Elem = record
    pregunta: string;
    pos: Integer;
  end;

  TArbolBinario = ^TNodoArbol;

  TNodoArbol = record
    respuesta: T_Elem;
    izquierda, derecha: TArbolBinario;
  end;

  procedure InsertarEnArbol(var arbol: TArbolBinario; respuesta: T_Elem);
  procedure BuscarRespuestaEnArbol(arbol: TArbolBinario; pregunta: string);

implementation

procedure InsertarEnArbol(var arbol: TArbolBinario; respuesta: T_Elem);
begin
  if arbol = nil then
  begin
    New(arbol);
    arbol^.respuesta := respuesta;
    arbol^.izquierda := nil;
    arbol^.derecha := nil;
  end
  else
  begin
    if respuesta.pregunta < arbol^.respuesta.pregunta then
      InsertarEnArbol(arbol^.izquierda, respuesta)
    else
      InsertarEnArbol(arbol^.derecha, respuesta);
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

