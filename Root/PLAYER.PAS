unit Player;

interface

uses Types;

const InitialHP : integer = 20;

type TPlayer = object
    private
        _hp : integer;
        _pose : TPose;
        _side : TSide;
        _x : integer;
        _y : integer;

    public
        constructor Init(pose: TPose; side: TSide; x: integer; y: integer);
        destructor Destroy;

        procedure Damage(amount : integer);
        function GetHP : integer;
        function GetPose : TPose;
        function GetSide : TSide;
        function GetX : integer;
        function GetY : integer;
        procedure SetPose(pose : TPose);
        procedure SetX(x : integer);
        procedure SetY(y : integer);
end;

implementation

constructor TPlayer.Init(pose: TPose; side: TSide; x: integer; y: integer);
begin
    _hp := InitialHP;
    _pose := pose;
    _side := side;
    _x := x;
    _y := y;
end;

destructor TPlayer.Destroy;
begin
end;

procedure TPlayer.Damage(amount : integer);
begin
    _hp := _hp - amount;
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
