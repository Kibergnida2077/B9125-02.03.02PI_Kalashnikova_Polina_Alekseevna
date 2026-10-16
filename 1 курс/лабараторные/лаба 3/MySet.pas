unit MySet;

interface

type
  PNode = ^TNode;

  TNode = record
    x, y: integer;
    next: PNode;
  end;

procedure Initsializatsiya(var Head: PNode);

procedure DobavlenieElementa(
  var Head: PNode;
  x, y: integer
);

procedure UdalenieElementa(
  var Head: PNode;
  x, y, Kol: integer
);

function PoiskElementa(
  Head: PNode;
  x, y: integer
): PNode;

function KolichestvoElementa(
  Head: PNode;
  x, y: integer
): integer;

function Moshchnost(Head: PNode): integer;

procedure Ochistka(var Head: PNode);

procedure PechatVpered(Head: PNode);

procedure PechatNazad(Head: PNode);

procedure Obedinenie(
  var S1: PNode;
  S2: PNode
);

implementation


procedure Initsializatsiya(var Head: PNode);
begin
  Head := nil;
end;


function PoiskElementa(
  Head: PNode;
  x, y: integer
): PNode;
begin
  while Head <> nil do
  begin
    if (Head^.x = x) and (Head^.y = y) then
    begin
      PoiskElementa := Head;
      exit;
    end;

    Head := Head^.next;
  end;

  PoiskElementa := nil;
end;


procedure DobavlenieElementa(
  var Head: PNode;
  x, y: integer
);
var
  p: PNode;
begin
  { Каждое вхождение точки - отдельный узел,
    добавление в начало списка }
  New(p);

  p^.x := x;
  p^.y := y;
  p^.next := Head;

  Head := p;
end;


procedure UdalenieElementa(
  var Head: PNode;
  x, y, Kol: integer
);
var
  p, prev: PNode;
begin
  prev := nil;
  p := Head;

  { Удаляем не больше Kol узлов с точкой (x,y) }
  while (p <> nil) and (Kol > 0) do
  begin
    if (p^.x = x) and (p^.y = y) then
    begin
      if prev = nil then
        Head := p^.next
      else
        prev^.next := p^.next;

      Dispose(p);
      Kol := Kol - 1;

      if prev = nil then
        p := Head
      else
        p := prev^.next;
    end
    else
    begin
      prev := p;
      p := p^.next;
    end;
  end;
end;


function KolichestvoElementa(
  Head: PNode;
  x, y: integer
): integer;
var
  s: integer;
begin
  s := 0;

  while Head <> nil do
  begin
    if (Head^.x = x) and (Head^.y = y) then
      s := s + 1;
    Head := Head^.next;
  end;

  KolichestvoElementa := s;
end;


function Moshchnost(Head: PNode): integer;
var
  s: integer;
begin
  s := 0;

  while Head <> nil do
  begin
    s := s + 1;
    Head := Head^.next;
  end;

  Moshchnost := s;
end;


procedure Ochistka(var Head: PNode);
var
  p: PNode;
begin
  while Head <> nil do
  begin
    p := Head;
    Head := Head^.next;
    Dispose(p);
  end;
end;


{ Справа налево: от головы к хвосту
  (элементы добавляются в начало) }
procedure PechatNazad(Head: PNode);
begin
  while Head <> nil do
  begin
    Write('(', Head^.x, ',', Head^.y, ') ');
    Head := Head^.next;
  end;

  Writeln;
end;


{ Рекурсия: сначала печатаем хвост, потом текущий узел }
procedure PechatRek(p: PNode);
begin
  if p <> nil then
  begin
    PechatRek(p^.next);
    Write('(', p^.x, ',', p^.y, ') ');
  end;
end;


{ Слева направо: в порядке ввода }
procedure PechatVpered(Head: PNode);
begin
  PechatRek(Head);
  Writeln;
end;


{ Копирует S2 в S1, начиная с хвоста S2,
  чтобы сохранить порядок ввода }
procedure DobavitRek(var S1: PNode; p: PNode);
begin
  if p <> nil then
  begin
    DobavitRek(S1, p^.next);
    DobavlenieElementa(S1, p^.x, p^.y);
  end;
end;


procedure Obedinenie(
  var S1: PNode;
  S2: PNode
);
begin
  { Для мультимножества объединение -
    все элементы S1 и все элементы S2 }
  DobavitRek(S1, S2);
end;

end.
