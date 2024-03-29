unit Lista_Conductores;

{$mode ObjFPC}{$H+}

interface

uses
  crt, SysUtils, Archivo;

type
  T_Elem = record
    pregunta:String[30];
    pos:Integer; // Pos dentro del archivo
  end;

  T_Punt = ^T_Nodo;

  T_Nodo = record
    info:T_Elem;
    sig:T_Punt;
  end;

  T_Lista = record
    cab, act:T_Punt;
    tam:Byte;
  end;

  procedure CrearListaConductores(var L:T_ListaConductores; var arch:T_ArchConductores);
  Procedure EliminarListaConductores(var L:T_ListaConductores);
  procedure AgregarLista(var L:T_ListaConductores; X:T_Dato);

implementation

  procedure CrearListaConductores(var L:T_Lista; var arch:TArchivo);
  var
    i:Integer;
    X:T_Conductores;
  begin
    L.tam:=0;
    L.cab:=nil;

    if TamArchivo(arch)>0 then
    begin
      for i:=0 to TamArchivo(arch)-1 do
      begin
           X:=LeerConductor(arch, i);
           AgregarLista(L, X);
      end;
    end;

    writeln('Lista creada...');
  end;

  procedure AgregarLista(var L:T_Lista; X:T_Elem);
  var
     dir,ant,act:T_Punt;
  begin
    new(dir);
    dir^.info:= X;

    if (L.cab = nil) or (AnsiUpperCase(L.cab^.info.apynom) > AnsiUpperCase(X.apynom)) then
    begin
      dir^.sig:= L.cab;
      L.cab:= dir;
    end
    else
    begin
      ant:=L.cab;
      act:= L.cab^.sig;

      while (act <> nil) and (AnsiUpperCase(act^.info.apynom) < AnsiUpperCase(X.apynom)) do
      begin
        ant:= act;
        act:= act^.sig;
      end;

      ant^.sig:=dir;
      dir^.sig:= act;

    end;
    inc(L.tam);
  end;

  function TamLista(L:T_ListaConductores):byte;
  begin
    TamLista:= L.tam;
  end;

  function Recuperar(var L:T_ListaConductores):T_Dato; // Recuperar(L, X);
  begin
    Recuperar:= L.act^.info;
  end;

  procedure Eliminar(var L:T_ListaConductores; buscado:T_Dni);
  var
     act,ant:T_Punt;
  begin
    if (L.cab^.info.dni = buscado) then
    begin
      act:=L.cab;
      L.cab:=L.cab^.sig;
      dispose(act);
    end
    else
    begin
      ant:= L.cab;
      act:= L.cab^.sig;

      while(act <> nil) and (act^.info.dni < buscado) do
      begin
        ant:=act;
        act:=act^.sig;
      end;

      ant^.sig:= act^.sig;
      dispose(act);
    end;
    dec(L.tam, 1);
  end;

  procedure ImprimirListaConductores(L:T_ListaConductores; conScoring:Boolean);
  var
    X:T_Dato;
    act:T_Punt;
    counter:byte;
  begin
    act:= L.cab;
    counter:= 1;

    ImprimirCabeceraTabla;

    while (act <> nil) do
    begin
      X:= act^.info;

      if conScoring = True then
      begin
        if X.scoring <= 0 then
           ImprimirUsuario(X, counter);
      end
      else
      begin
        ImprimirUsuario(X, counter);
      end;
      act:=act^.sig;

      inc(counter);
    end;
    readkey;
  end;

  Procedure EliminarListaConductores(var L:T_ListaConductores);
  var
    X:T_Dato;
    act,ant:T_Punt;
    counter:byte;
  begin
    act:= L.cab;
    counter:=0;

    while (act <> nil) do
    begin
      ant:=act;
      act:=ant^.sig;
      Dispose(ant);

      inc(counter);
    end;

