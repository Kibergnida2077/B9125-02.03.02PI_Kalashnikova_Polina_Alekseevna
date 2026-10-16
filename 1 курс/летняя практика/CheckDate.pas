unit CheckDate;

interface
uses Types;
function ParseDate(s: string): TDate;

implementation

function DaysInMonth(m: byte; y: integer): byte;
begin
  case m of
    2: if (y mod 4 = 0) and ((y mod 100 <> 0) or (y mod 400 = 0)) then
         Result := 29
       else
         Result := 28;
    4, 6, 9, 11: Result := 30;
  else
    Result := 31;
  end;
end;

// аномалия или пропуск -> dec
function ParseMonth(s: string): byte;
begin
  Result := DefMonth;
  s := s.ToLower;
  for var i := 1 to 11 do
    if s = month_short[i] then
      Result := i;
end;

function ParseYear(s: string): integer;
var
  y: integer;
begin
  if not integer.TryParse(s, y) then
    Result := DefYear                 // пропуск
  else if y < 0 then
    Result := 2000
  else if Length(s) <= 2 then         // короткая запись [0; 25]
  begin
    if y > 25 then Result := 2000 else Result := 2000 + y;
  end
  else if y < 2000 then               // полная запись [2000; 2025]
    Result := 2000
  else if y > 2025 then
    Result := 2025
  else
    Result := y;
end;

// "день/месяц/год"; пустая строка -> дата по умолчанию 01.dec.2007
function ParseDate(s: string): TDate;
var
  p: array of string;
  ds, ms, ys: string;
  d: integer;
begin
  p := s.Split('/');
  ds := p[0];
  ms := '';
  ys := '';
  if Length(p) >= 3 then
  begin
    ms := p[1];
    ys := p[2];
  end
  else if Length(p) = 2 then          // одно поле пропущено вместе с '/'
    if integer.TryParse(p[1], d) then ys := p[1] else ms := p[1];

  Result.month := ParseMonth(ms);
  Result.year := ParseYear(ys);

  if not integer.TryParse(ds, d) then
    d := DefDay                       // пропуск
  else if d < 1 then
    d := 1
  else if d > DaysInMonth(Result.month, Result.year) then
    d := DaysInMonth(Result.month, Result.year);
  Result.day := d;
end;

end.
