program PhoneCalls;

uses
  Types,
  ReadText,
  Sortirovka,
  WriteFiles;

var
  f, v, nc: Text;
  items: TItems;
  count, total: integer;

begin
  Assign(f, 'input.txt');
  Assign(nc, 'Not_cleaned_data.txt');
  Reset(f);
  Rewrite(nc);
  ReadPhone(f, nc, items, count, total);
  Close(f);
  Close(nc);

  Sortirov(items, count);

  Assign(v, 'Data_cleansing.txt');
  Rewrite(v);
  WriteResult(items, count, v);
  Close(v);

  writeln('Прочитано строк: ', total, ', правильных: ', count);
end.
