unit ConflictDuplicate;

interface
uses Types;
function DupConflictReason(const items: TItems; count: integer; const r: TCallRecord): string;

implementation

// '' - запись можно принять, иначе причина (дубликат или конфликт)
function DupConflictReason(const items: TItems; count: integer; const r: TCallRecord): string;
var
  i: integer;
begin
  Result := '';
  if r.phone1 = r.phone2 then
    Result := 'конфликт: номер исходящего и входящего звонка совпадают';
  i := 1;
  while (i <= count) and (Result = '') do
  begin
    // те же номера и дата
    if (items[i].phone1 = r.phone1) and (items[i].phone2 = r.phone2) and
       SameDate(items[i].date, r.date) then
      if (items[i].time1 = r.time1) and (items[i].time2 = r.time2) and
         (items[i].call_type = r.call_type) then
        Result := 'дубликат ранее принятой записи'
      else if not ((items[i].time1 <> r.time1) and (items[i].time2 <> r.time2) and
                   (items[i].call_type = r.call_type)) then
        Result := 'конфликт с ранее принятой записью (те же номера и дата, разные время или тип звонка)';

    // конфликт по номерам: в ту же дату и время начала
    if (Result = '') and SameDate(items[i].date, r.date) and (items[i].time1 = r.time1) and
       (((items[i].phone1 = r.phone1) xor (items[i].phone2 = r.phone2)) or
        (items[i].phone1 = r.phone2) or (items[i].phone2 = r.phone1)) then
      Result := 'конфликт номеров с ранее принятой записью (та же дата и время начала)';

    Inc(i);
  end;
end;

end.
