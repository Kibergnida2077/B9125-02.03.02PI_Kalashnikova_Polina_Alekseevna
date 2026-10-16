program Laba3;

uses
  MySet;

var
  S1, S2: PNode;
  n1, n2: integer;
  x, y: integer;
  i: integer;
  deystvie: string;
  setNum: integer;
  Kol: integer;
  p: PNode;
begin
  Initsializatsiya(S1);
  Initsializatsiya(S2);

  Write('Количество точек первого мультимножества: ');
  Readln(n1);
  if n1 = 0 then
    writeln('множество пустое')
  else
    begin
    Writeln('Введите точки:');

  for i := 1 to n1 do
  begin
    Readln(x, y);
    DobavlenieElementa(S1, x, y);
   end;
  end;
  Write('Количество точек второго мультимножества: ');
  Readln(n2);
    if n2 = 0 then
    writeln('множество пустое')
  else
    begin
  Writeln('Введите точки:');

  for i := 1 to n2 do
  begin
    Readln(x, y);
    DobavlenieElementa(S2, x, y);
  end;
  end;
  Writeln;
  PechatVpered(S1);
  Writeln;
  PechatVpered(S2);
  readln(deystvie);
  case deystvie of
      'удалить':
      begin
        Write('Из какого мультимножества удалить? (1 или 2): ');
        Readln(setNum);
        Readln(x);
        Readln(y);
        Readln(Kol);
        if setNum = 1 then begin
          UdalenieElementa(S1, x, y, Kol);
          PechatVpered(S1);
          end
        else if setNum = 2 then begin
          UdalenieElementa(S2, x, y, Kol);
          PechatVpered(S2);
          end
      end;
      'поиск':
      begin
        Readln(x);
        Readln(y);
          p := PoiskElementa(S1, x, y);
          if p = nil then
          p := PoiskElementa(S2, x, y);
        if p <> nil then
          Writeln('Элемент найден')
        else
          Writeln('Элемент не найден');
      end;
      'повторения':
      begin
        Write('В каком мультимножестве искать? (1 или 2): ');
        Readln(setNum);
        Readln(x);
        Readln(y);
        if setNum = 1 then
          Writeln(KolichestvoElementa(S1, x, y))
        else if setNum = 2 then
            Writeln(KolichestvoElementa(S2, x, y));
      end;
      'мощность':
      begin
          Writeln(Moshchnost(S1));
          Writeln(Moshchnost(S2));
      end;
      'печать назад':
      begin
          PechatNazad(S1);
          PechatNazad(S2);
      end;
      'объединение':
      begin
        Obedinenie(S1, S2);
        PechatVpered(S1);
      end;
end;
  Ochistka(S1);
  Ochistka(S2);
  Writeln;
  Writeln('Память освобождена.');
end.