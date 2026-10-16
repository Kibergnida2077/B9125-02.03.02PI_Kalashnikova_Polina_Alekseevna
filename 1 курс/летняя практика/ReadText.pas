unit ReadText;

interface
uses Types;
procedure ReadPhone(var f, nc: Text; var items: TItems; var count, total: integer);

implementation
uses
  CheckNumbers,
  CheckDate,
  CheckTime,
  ConflictDuplicate;

// f - input.txt, nc - not_cleaned_data.txt (неисправимые строки с причиной)
procedure ReadPhone(var f, nc: Text; var items: TItems; var count, total: integer);
var
  str, reason: string;
  p: array of string;
  n: integer;
  r: TCallRecord;
begin
  count := 0;   // правильных строк
  total := 0;   // прочитано всего
  while not eof(f) and (count < MaxItems) do
  begin
    readln(f, str);
    Inc(total);
    p := str.Split([' '], System.StringSplitOptions.RemoveEmptyEntries);
    n := Length(p);
    // 2 номера, [тип], [дата], 2 времени
    if (n < 4) or (n > 6) then
      reason := 'неверное число полей: ' + n.ToString + ' (должно быть от 4 до 6)'
    else if not CheckPhone(p[0], r.phone1) then
      reason := 'некорректный номер исходящего звонка: ' + p[0]
    else if not CheckPhone(p[1], r.phone2) then
      reason := 'некорректный номер входящего звонка: ' + p[1]
    else if not ParseTime(p[n - 2], r.time1) then
      reason := 'некорректное время начала: ' + p[n - 2]
    else if not ParseTime(p[n - 1], r.time2) then
      reason := 'некорректное время окончания: ' + p[n - 1]
    else
    begin
      r.call_type := DefCallType;
      r.date := ParseDate('');        // пропуск даты
      if n = 6 then
      begin
        r.call_type := CheckCallType(p[2]);
        r.date := ParseDate(p[3]);
      end
      else if n = 5 then
        if Pos('/', p[2]) > 0 then
          r.date := ParseDate(p[2])     // пропущен тип звонка
        else
          r.call_type := CheckCallType(p[2]);
      CalcDuration(r);
      reason := DupConflictReason(items, count, r);
    end;

    if reason = '' then
    begin
      Inc(count);
      items[count] := r;
    end
    else if n > 0 then                // пустые строки не записываются
      writeln(nc, str.Trim, ' | ', reason);
  end;
end;

end.
