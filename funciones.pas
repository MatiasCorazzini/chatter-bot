unit funciones;
{$mode ObjFPC}{$H+}
interface

type
  habilidades_record = RECORD
    idAgente:integer;
    agente:string;
    habilidad1_name:string;
    habilidad1_description:string;
    habilidad1_price:string;

    habilidad2_name:string;
    habilidad2_description:string;
    habilidad2_price:string;

    habilidad3_name:string;
    habilidad3_description:string;
    habilidad3_price:string;

    habilidad4_name:string;
    habilidad4_description:string;
    habilidad4_price:string;
  end;

agentes_record = RECORD
    id:word;
    name:string[30];
    description:string;
    clase: string;
    disponibilidad: string;
    habilidadesID: integer;
  end;

  file_agentes = file of agentes_record;
  file_habilidades = file of habilidades_record;


//Funciones a exportar
procedure Greet(var bienvenida_bot:string,name_chatbot:string,saludos_hablante:string,var ejemplos:string);

uses crt;

implementation
function replaceString(const SourceStr, OldWord, NewWord: string):integer;
var
PosStart, PosEnd, OldWordLength: Integer;
Result:string;
begin
Result := SourceStr;
  OldWordLength := Length(OldWord);
  PosStart := Pos(OldWord, Result);

  while PosStart > 0 do
  begin
    PosEnd := PosStart + OldWordLength - 1;
    Delete(Result, PosStart, OldWordLength);
    Insert(NewWord, Result, PosStart);
    PosStart := Pos(OldWord, Result, PosEnd + 1);
  end;
end;

//tratar de implementar algoritmo de levenstain
function BuscarPalabra(const cadena, palabra: string): boolean;
var
  posicion: integer;
  Result:string;
begin
  // Utilizamos la función Pos para encontrar la posición de la palabra en la cadena
  // Si la palabra no se encuentra, Pos devuelve 0
  posicion := Pos(palabra, cadena);

  // Devolvemos true si la posición es diferente de 0, indicando que la palabra fue encontrada
  // Devolvemos false si la posición es 0, indicando que la palabra no fue encontrada
  Result := (posicion <> 0);
end;

procedure Greet(var bienvenida_bot:string,name_chatbot:string,saludos_hablante:string,var ejemplos:string);
var
nombreTemporal:string;
greet:string;
hablante:string
begin
greet:=replaceString(bienvenida_bot,'{name_chatbot}',name_chatbot);
writeln(greet);
readln(nombreTemporal);
hablante:= replaceString(saludos_hablante,'{name_hablante}');
writeln(hablante);
writeln(ejemplos);
readkey;
end;

procedure buscarAgente();
var


begin

end;

