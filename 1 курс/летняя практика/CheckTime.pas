unit CheckTime;

interface
uses Types;
function ParseTime(s: string; var t: integer): boolean;
procedure CalcDuration(var r: TCallRecord);

implementation

// "hh:mmMeridian" -> минуты от полуночи.
// False, если часы/минуты не числа или нет am/pm (строку не восстановить).
function ParseTime(s: string; var t: integer): boolean;
var
  p, k, h, m: integer;
  mer: string;
begin
  Result := false;
  s := s.ToLower.Replace('.', '');
  p := Pos(':', s);
  k := p + 1;
  while (k <= Length(s)) and (s[k] in ['0'..'9']) do
    Inc(k);
  mer := Copy(s, k, Length(s));
  if (p > 0) and (mer <> '') and (mer[1] in ['a', 'p'])
     and integer.TryParse(Copy(s, 1, p - 1), h)
     and integer.TryParse(Copy(s, p + 1, k - p - 1), m) then
  begin
    Result := true;
    if h < 1 then h := 1
    else if h > 12 then h := 12;      // аномалия часов
    if m > 59 then m := 59;           // аномалия минут
    if h = 12 then h := 0;
    if mer[1] = 'p' then h := h + 12;
    t := h * 60 + m;
  end;
end;

// звонок: от 1 минуты до 3 часов, иначе сдвигается время окончания
procedure CalcDuration(var r: TCallRecord);
begin
  r.duration := r.time2 - r.time1;
  if r.duration < 0 then
    r.duration := r.duration + 24 * 60;   // переход через полночь
  if r.duration > 180 then
  begin
    r.duration := 180;
    r.time2 := (r.time1 + 180) mod (24 * 60);
  end
  else if r.duration = 0 then
  begin
    r.duration := 1;
    r.time2 := (r.time1 + 1) mod (24 * 60);
  end;
end;

end.
