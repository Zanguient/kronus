unit Sys.Functions;

interface

uses System.Classes, System.SysUtils,
    System.RegularExpressions;

  function fsGetFieldString(sTexto : string; iposicao: Integer; const separator : Char = '|' ) : string;
  function fiGetCountField(sTexto : string; const separator : Char = '|' ) : Integer;

implementation

function fiGetCountField(sTexto : string; const separator : Char = '|' ) : Integer;
var
  sl : TStringList;
begin
  sl:= TStringList.Create;
  sl.Delimiter := separator;
  sl.DelimitedText := sTexto;
  Result := sl.Count;
end;
function fsGetFieldString(sTexto : string; iposicao: Integer; const separator : Char = '|' ) : string;
var
  sl : TStringList;
begin
  sl:= TStringList.Create;
  sl.Delimiter := separator;
  sl.DelimitedText := sTexto;
  Result := sl.Strings[iposicao];
end;
end.
