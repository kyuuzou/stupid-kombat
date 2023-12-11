unit Player;

interface

uses crt, Types;

type TSprites = array[TPose, 0..4] of string;

type TPlayer = object
    private
        _hp : integer;
        _pose : TPose;
        _side : TSide;
        _sprites : TSprites;
        _x : integer;
        _y : integer;

    public
        constructor Init(pose: TPose; side: TSide; x: integer; y: integer);
        destructor Destroy;

        procedure Damage(amount : integer);
        procedure Draw;
        function GetHP : integer;
        function GetPose : TPose;
        function GetSide : TSide;
        function GetX : integer;
        function GetY : integer;
        procedure InitSprites;
        procedure SetPose(pose : TPose);
        procedure SetX(x : integer);
        procedure SetY(y : integer);
end;

implementation

constructor TPlayer.Init(pose: TPose; side: TSide; x: integer; y: integer);
const InitialHP : integer = 20;
begin
    _hp := InitialHP;
    _pose := pose;
    _side := side;
    _x := x;
    _y := y;

    InitSprites;
end;

destructor TPlayer.Destroy;
begin
end;

procedure TPlayer.Damage(amount : integer);
begin
    _hp := _hp - amount;
end;

procedure TPlayer.Draw;
var screenY : integer;
var spriteY : integer;
begin
    screenY := _y;
    gotoxy(_x, _y);

    for spriteY := low(_sprites[_pose]) to high(_sprites[_pose]) do
    begin
         writeln(_sprites[_pose][spriteY]);
         screenY := screenY + 1;
         gotoxy(_x, screenY);
    end;
end;

function TPlayer.GetHP : integer;
begin
    GetHP := _hp;
end;

function TPlayer.GetPose : TPose;
begin
    GetPose := _pose;
end;

function TPlayer.GetSide : TSide;
begin
    GetSide := _side;
end;

function TPlayer.GetX : integer;
begin
    GetX := _x;
end;

function TPlayer.GetY : integer;
begin
    GetY := _y;
end;

procedure TPlayer.InitSprites;
const SpriteHeight : integer = 5;
const SideNames : array[TSide] of string = ('LEFT', 'RIGHT');
var i : integer;
var line : string;
var pose : TPose;
var textFile : Text;
begin
    Assign(textFile, SideNames[_side] + '.TXT');
    Reset(textFile);

    for pose := low(TPose) to high(TPose) do
    begin
        for i := 0 to SpriteHeight - 1 do
        begin
            readln(textFile, line);
            _sprites[pose][i] := line;
        end;
    end;

    Close(textFile);
    readkey;
end;

procedure TPlayer.SetPose(pose : TPose);
begin
    _pose := pose;
end;

procedure TPlayer.SetX(x : integer);
begin
    _x := x;
end;

procedure TPlayer.SetY(y : integer);
begin
    _y := y;
end;

end.
