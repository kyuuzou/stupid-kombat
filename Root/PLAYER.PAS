unit Player;

interface

uses crt;

type TPose = (Idle, Punch, Kick);
type TSide = (Left, Right);
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
        constructor Init(pose: TPose; side: TSide);
        destructor Destroy;

        procedure Damage(amount : integer);
        procedure Draw;
        function GetHP : integer;
        function GetPose : TPose;
        function GetSide : TSide;
        function GetX : integer;
        procedure InitSprites;
        procedure SetPose(pose : TPose);
        procedure SetX(x : integer);
end;

implementation

constructor TPlayer.Init(pose: TPose; side: TSide);
const InitialHP : integer = 20;
const InitialX : array[TSide] of integer = (2, 33);
const InitialY : integer = 5;
begin
    _hp := InitialHP;
    _pose := pose;
    _side := side;
    _x := InitialX[side];
    _y := InitialY;

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
    gotoxy(_x, screenY);

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
end;

procedure TPlayer.SetPose(pose : TPose);
begin
    _pose := pose;
end;

procedure TPlayer.SetX(x : integer);
begin
    _x := x;
end;

end.
