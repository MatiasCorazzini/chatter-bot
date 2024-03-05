unit BusquedaDeRespuestas;

{$mode ObjFPC}{$H+}

interface

uses
  Classes, SysUtils, Archivo;
type
  TStringDynArray = array of AnsiString;

function BuscarRespuestaEnArchivo(var arch: TArchivo; pregunta: string):String;

function ContienePalabra(input: String; palabra:String): boolean;
function ContienePregunta(input:String; X:TRespuesta): boolean;

implementation

  function BuscarRespuestaEnArchivo(var arch: TArchivo; pregunta: string):String;
  var
    X:TRespuesta;
    i:Integer;
    input:String;
    key:String[10];
  begin
    BuscarRespuestaEnArchivo:='FALSE';
    input := UpCase(pregunta);
    //writeln(input);

    key:='OTROS';
    if ContienePalabra(input, 'QUE') then key:='QUE';
    if ContienePalabra(input, 'COMO') then key:='COMO';
    if ContienePalabra(input, 'QUIEN') then key:='QUIEN';
    if ContienePalabra(input, 'CUANDO') then key:='CUANDO';
    if ContienePalabra(input, 'DONDE') then key:='DONDE';
    if ContienePalabra(input, 'POR QUE') then key:='PORQUE';
    if ContienePalabra(input, 'PORQUE') then key:='PORQUE';
    if ContienePalabra(input, 'PARAQUE') then key:='PARAQUE';
    if ContienePalabra(input, 'PARA QUE') then key:='PARAQUE';
    if ContienePalabra(input, 'CUANTOS') then key:='CUANTOS';
    if ContienePalabra(input, 'CUANTO') then key:='CUANTOS';
    if ContienePalabra(input, 'CANTIDAD') then key:='CUANTOS';

    for i:=0 to TamArchivo(arch)-1 do
    begin
      X:= LeerRespuestas(arch, i);
      //writeln(X.key);

      if X.key = key then
      begin
        if ContienePregunta(input, X) then
        begin
           BuscarRespuestaEnArchivo:= X.respuesta;
        end;
      end;
    end;
  end;

  function ContienePalabra(input: String; palabra:String): boolean;
  begin
    ContienePalabra := Pos(palabra, input) > 0;
    //writeln(ContienePalabra);
  end;
  function SplitString(const s: string; const delimiter: Char): TStringDynArray;
  var
    startPos, endPos, i: Integer;
  begin
    startPos := 1;
    endPos := 1;
    i := 0;

    while endPos <= Length(s) do
    begin
      if s[endPos] = delimiter then
      begin
        SetLength(Result, i + 1);
        Result[i] := Copy(s, startPos, endPos - startPos);
        Inc(i);
        startPos := endPos + 1;
      end;
      Inc(endPos);
    end;

    SetLength(Result, i + 1);
    Result[i] := Copy(s, startPos, endPos - startPos);
  end;

  function ContienePregunta(input:String; X:TRespuesta): boolean;
  var
    words: TStringDynArray;
    i: Integer;
  begin
      if ContienePalabra(X.pregunta, ',') then
      begin
         words := SplitString(X.pregunta, ',');
         for i:=Low(words) to High(words) do
         begin
           //writeln(words[i]);
           if ContienePalabra(input, words[i]) then
           begin
               ContienePregunta:= True;
               Exit();
           end
           else
           begin
             ContienePregunta:=False;
           end;
         end;
      end
      else
      begin
        ContienePregunta:= ContienePalabra(input, X.pregunta);
      end;
  end;
end.

