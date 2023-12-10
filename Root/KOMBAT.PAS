program StupidKombat;

uses crt;

type TPose = (Idle, Punch, Kick);
type TSide = (Left, Right);
type TSprites = array[TSide, TPose, 0..4] of string;

var sprites : TSprites;

procedure drawFighter (pose : TPose; side : TSide);
const FighterY : integer = 3;
var screenX : integer;
var screenY : integer;
var spriteY : integer;
var upperLeftScreenX : integer;
begin
    if side = Left then upperLeftScreenX := 1 else upperLeftScreenX := 31;

    screenX := upperLeftScreenX;
    screenY := FighterY;
    gotoxy(screenX, screenY);

    for spriteY := low(sprites[side][pose]) to high(sprites[side][pose]) do
    begin
         writeln(sprites[side][pose][spriteY]);
         screenY := screenY + 1;
         gotoxy(screenX, screenY);
    end;
end;

procedure drawHeader;
begin
    clrscr;
    writeln('������������� STUPID KOMBAT �������������');
    writeln('');
end;

procedure initialise;
begin
    sprites[Left][Idle][0]     := '   ��Ŀ   ';
    sprites[Left][Idle][1]     := '  ������  ';
    sprites[Left][Idle][2]     := '  ( �_�)  ';
    sprites[Left][Idle][3]     := '   ( 9 )9 ';
    sprites[Left][Idle][4]     := '   /   \  ';

    sprites[Left][Punch][0]    := '   ��Ŀ   ';
    sprites[Left][Punch][1]    := '  ������  ';
    sprites[Left][Punch][2]    := '  ( �_�)  ';
    sprites[Left][Punch][3]    := '   ( 9 )-@';
    sprites[Left][Punch][4]    := '   /   \  ';

    sprites[Left][Kick][0]     := '   ��Ŀ   ';
    sprites[Left][Kick][1]     := '  ������  ';
    sprites[Left][Kick][2]     := '  ( �_�)  ';
    sprites[Left][Kick][3]     := '   ( 9 )9 ';
    sprites[Left][Kick][4]     := '   /   ���';

    sprites[Right][Idle][0]    := '   ��Ŀ   ';
    sprites[Right][Idle][1]    := '  ������  ';
    sprites[Right][Idle][2]    := '  (�_� )  ';
    sprites[Right][Idle][3]    := ' @( @ )   ';
    sprites[Right][Idle][4]    := '  /   \   ';

    sprites[Right][Punch][0]   := '   ��Ŀ   ';
    sprites[Right][Punch][1]   := '  ������  ';
    sprites[Right][Punch][2]   := '  (�_� )  ';
    sprites[Right][Punch][3]   := '@-( @ )   ';
    sprites[Right][Punch][4]   := '  /   \   ';

    sprites[Right][Kick][0]    := '   ��Ŀ   ';
    sprites[Right][Kick][1]    := '  ������  ';
    sprites[Right][Kick][2]    := '  (�_� )  ';
    sprites[Right][Kick][3]    := ' @( @ )   ';
    sprites[Right][Kick][4]    := '���   \   ';

end;

var key : char;
var pose : TPose;
begin
    initialise;

    repeat
        pose := Idle;

        case (key) of
            'Q' : pose := Punch;
            'E' : pose := Kick;
        end;

        drawHeader;
        drawFighter(pose, Left);
        drawFighter(pose, Right);
        gotoxy(80, 25); {move cursor to lower right corner}

        key := upcase(readkey);
    until key = #27; {Escape}
end.