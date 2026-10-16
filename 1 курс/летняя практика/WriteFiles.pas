unit WriteFiles;

interface
uses Types;
procedure WriteResult(const items: TItems; count: integer; var v: Text);

implementation

procedure WriteResult(const items: TItems; count: integer; var v: Text);
begin
  for var i := 1 to count do
    writeln(v,
      items[i].phone1, ' ',
      items[i].phone2, ' ',
      items[i].date.day.ToString('00'), '.', month_short[items[i].date.month], '.', items[i].date.year, ' ',
      (items[i].duration div 60).ToString('00'), ':', (items[i].duration mod 60).ToString('00'), ' ',
      day_time[DayTime(items[i].time1)]);
end;

end.
