unit Sortirovka;

interface
uses Types;
procedure Sortirov(var items: TItems; count: integer);

implementation

// ключ: дата (ГГГГММДД) -> время суток
function SortKey(const r: TCallRecord): integer;
begin
  Result := ((r.date.year * 100 + r.date.month) * 100 + r.date.day) * 10 + DayTime(r.time1);
end;

function Less(const a, b: TCallRecord): boolean;
begin
  Result := (SortKey(a) < SortKey(b)) or
            (SortKey(a) = SortKey(b)) and (a.phone1 < b.phone1);
end;

// сортировка вставками: дата -> время суток -> первый номер
procedure Sortirov(var items: TItems; count: integer);
var
  x: TCallRecord;
  j: integer;
begin
  for var i := 2 to count do
  begin
    x := items[i];
    j := i - 1;
    while (j >= 1) and Less(x, items[j]) do
    begin
      items[j + 1] := items[j];
      Dec(j);
    end;
    items[j + 1] := x;
  end;
end;

end.
