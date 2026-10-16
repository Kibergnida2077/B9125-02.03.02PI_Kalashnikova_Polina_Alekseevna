unit CheckNumbers;

interface
function CheckPhone(s: string; var ph: int64): boolean;
function CheckCallType(s: string): byte;

implementation
uses Types;

// некорректно, если не число (тип int64) или не вида 7XXXXXXXXXX
function CheckPhone(s: string; var ph: int64): boolean;
begin
  Result := (Length(s) = 11) and (s[1] = '7') and int64.TryParse(s, ph);
end;

// ошибочное или пропущенное значение заменяется на 4
function CheckCallType(s: string): byte;
begin
  if not byte.TryParse(s, Result) or (Result < 1) or (Result > 4) then
    Result := DefCallType;
end;

end.
