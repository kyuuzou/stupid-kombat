program StupidKombat;

uses crt;

type TPose = (Idle, Punch, Kick);
type TSide = (Left, Right);
type TSprites = array[TSide, TPose, 0..4] of string;

var sprites : TSprites;
var leftPlayerScreenX : integer;
var rightPlayerScreenX : integer;

procedure drawFighter(pose : TPose; side : TSide; screenX : integer);
const FighterScreenY : integer = 3;
var screenY : integer;
var spriteY : integer;
begin
    screenY := FighterScreenY;
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
    writeln('°°°°°°°°°°°°° STUPID KOMBAT °°°°°°°°°°°°°');
    writeln('');
end;

procedure initialise;
begin
    leftPlayerScreenX := 1;
    rightPlayerScreenX := 31;

    sprites[Left][Idle][0]     := '   ÚÄÄ¿   ';
    sprites[Left][Idle][1]     := '  ÄÁÄÄÁÄ  ';
    sprites[Left][Idle][2]     := '  ( §_§)  ';
    sprites[Left][Idle][3]     := '   ( 9 )9 ';
    sprites[Left][Idle][4]     := '   /   \  ';

    sprites[Left][Punch][0]    := '   ÚÄÄ¿   ';
    sprites[Left][Punch][1]    := '  ÄÁÄÄÁÄ  ';
    sprites[Left][Punch][2]    := '  ( §_§)  ';
    sprites[Left][Punch][3]    := '   ( 9 )-@';
    sprites[Left][Punch][4]    := '   /   \  ';

    sprites[Left][Kick][0]     := '   ÚÄÄ¿   ';
    sprites[Left][Kick][1]     := '  ÄÁÄÄÁÄ  ';
    sprites[Left][Kick][2]     := '  ( §_§)  ';
    sprites[Left][Kick][3]     := '   ( 9 )9 ';
    sprites[Left][Kick][4]     := '   /   îîî';

    sprites[Right][Idle][0]    := '   ÚÄÄ¿   ';
    sprites[Right][Idle][1]    := '  ÄÁÄÄÁÄ  ';
    sprites[Right][Idle][2]    := '  (§_§ )  ';
    sprites[Right][Idle][3]    := ' @( @ )   ';
    sprites[Right][Idle][4]    := '  /   \   ';

    sprites[Right][Punch][0]   := '   ÚÄÄ¿   ';
    sprites[Right][Punch][1]   := '  ÄÁÄÄÁÄ  ';
    sprites[Right][Punch][2]   := '  (§_§ )  ';
    sprites[Right][Punch][3]   := '@-( @ )   ';
    sprites[Right][Punch][4]   := '  /   \   ';

    sprites[Right][Kick][0]    := '   ÚÄÄ¿   ';
    sprites[Right][Kick][1]    := '  ÄÁÄÄÁÄ  ';
    sprites[Right][Kick][2]    := '  (§_§ )  ';
    sprites[Right][Kick][3]    := ' @( @ )   ';
    sprites[Right][Kick][4]    := 'îîî   \   ';

end;

var key : char;
var leftPose : TPose;
var rightPose : TPose;
begin
    initialise;

    repeat
        leftPose := Idle;
        rightPose := Idle;

        case (key) of
            'Q' : leftPose := Punch;
            'E' : leftPose := Kick;
            'A' : leftPlayerScreenX := leftPlayerScreenX - 1;
            'D' : leftPlayerScreenX := leftPlayerScreenX + 1;
            '.' : rightPose := Punch;
            '-' : rightPose := Kick;
            chr(0) : { arrow keys return #00 before the actual key code }
                case upcase(readkey) of
                    #75 : rightPlayerScreenX := rightPlayerScreenX - 1;
                    #77 : rightPlayerScreenX := rightPlayerScreenX + 1;
                end;
        end;

        drawHeader;
        drawFighter(leftPose, Left, leftPlayerScreenX);
        drawFighter(rightPose, Right, rightPlayerScreenX);
        gotoxy(80, 25); {move cursor to lower right corner}

        key := upcase(readkey);
    until key = #27; {Escape}
end.
