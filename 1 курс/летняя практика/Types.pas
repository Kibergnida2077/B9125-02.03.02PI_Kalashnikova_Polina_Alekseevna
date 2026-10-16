unit Types;

interface
type
  TDate = record
    day, month: byte;    // month: 1..12 (номер в month_short)
    year: integer;
  end;
  TCallRecord = record
    phone1, phone2: int64;
    call_type: byte;
    date: TDate;
    time1, time2: integer;   // минуты от полуночи (0..1439)
    duration: integer;       // минуты
  end;
  TItems = array[1..1000] of TCallRecord;

const
  MaxItems = 1000;
  DefCallType = 4;
  DefDay = 1;
  DefMonth = 12;
  DefYear = 2007;
  month_short: array [1..12] of string = ('jan','feb','mar','apr','may','jun','jul','aug','sep','oct','nov','dec');
  day_time: array [1..4] of string = ('утро','день','вечер','ночь');

function DayTime(t: integer): byte;
function SameDate(a, b: TDate): boolean;

implementation

// время суток по времени начала: 1-утро, 2-день, 3-вечер, 4-ночь
function DayTime(t: integer): byte;
begin
  case t div 60 of
    6..11:  Result := 1;
    12..17: Result := 2;
    18..23: Result := 3;
  else
    Result := 4;
  end;
end;

function SameDate(a, b: TDate): boolean;
begin
  Result := (a.day = b.day) and (a.month = b.month) and (a.year = b.year);
end;

end.
