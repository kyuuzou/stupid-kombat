program StupidKombat;

uses crt;

type TPose = (Idle, Punch, Kick);
type TSide = (Left, Right);
type TSprites = array[TSide, TPose, 0..4] of string;

var sprites : TSprites;
var leftPlayerScreenX : integer;
var rightPlayerScreenX : integer;
var leftPlayerHP : integer;
var rightPlayerHP : integer;

function calculateDistance : integer;
begin
    calculateDistance := rightPlayerScreenX - leftPlayerScreenX - 8;
end;

procedure playSound(tone : integer);
begin
    sound(tone);
    delay(100);
    nosound;
end;

procedure drawFighter(pose : TPose; side : TSide; screenX : integer);
const FighterScreenY : integer = 5;
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

procedure drawHealth;
const HealthBarY = 3;
var i : integer;
begin
    gotoxy(1, HealthBarY);

    for i := 1 to leftPlayerHP do
        write('Û');

    gotoxy(22 + (20 - rightPlayerHP), HealthBarY);

    for i := 1 to rightPlayerHP do
        write('Û');
end;

procedure handleDamage(leftPose : TPose; rightPose : TPose);
label return;
var distance : integer;
begin;
    distance := calculateDistance;

    if distance > 1 then
        goto return;

    if leftPose = Punch then
    begin
        rightPlayerHP := rightPlayerHP - 1;
        playSound(1000);
    end
    else if leftPose = Kick then
    begin
        rightPlayerHP := rightPlayerHP - 2;
        playSound(2000);
    end;

    if rightPose = Punch then
    begin
        leftPlayerHP := leftPlayerHP - 1;
        playSound(1000);
    end
    else if rightPose = Kick then
    begin
        leftPlayerHP := leftPlayerHP - 2;
        playSound(2000);
    end;

    return:
end;

procedure initialise;
begin
    leftPlayerScreenX := 1;
    rightPlayerScreenX := 31;

    leftPlayerHP := 20;
    rightPlayerHP := 20;

    sprites[Left][Idle][0]     := '   ÚÄÄ¿  ';
    sprites[Left][Idle][1]     := '  ÄÁÄÄÁÄ ';
    sprites[Left][Idle][2]     := '  ( §_§) ';
    sprites[Left][Idle][3]     := '   ( 9 )9';
    sprites[Left][Idle][4]     := '   /   \ ';

    sprites[Left][Punch][0]    := '  ÚÄÄ¿   ';
    sprites[Left][Punch][1]    := ' ÄÁÄÄÁÄ  ';
    sprites[Left][Punch][2]    := ' ( §_§)  ';
    sprites[Left][Punch][3]    := '  ( 9 )-@';
    sprites[Left][Punch][4]    := '  /   \  ';

    sprites[Left][Kick][0]     := '  ÚÄÄ¿   ';
    sprites[Left][Kick][1]     := ' ÄÁÄÄÁÄ  ';
    sprites[Left][Kick][2]     := ' ( §_§)  ';
    sprites[Left][Kick][3]     := '  ( 9 )9 ';
    sprites[Left][Kick][4]     := '  /   îîî';

    sprites[Right][Idle][0]    := '  ÚÄÄ¿   ';
    sprites[Right][Idle][1]    := ' ÄÁÄÄÁÄ  ';
    sprites[Right][Idle][2]    := ' (§_§ )  ';
    sprites[Right][Idle][3]    := '@( @ )   ';
    sprites[Right][Idle][4]    := ' /   \   ';

    sprites[Right][Punch][0]   := '   ÚÄÄ¿  ';
    sprites[Right][Punch][1]   := '  ÄÁÄÄÁÄ ';
    sprites[Right][Punch][2]   := '  (§_§ ) ';
    sprites[Right][Punch][3]   := '@-( @ )  ';
    sprites[Right][Punch][4]   := '  /   \  ';

    sprites[Right][Kick][0]    := '   ÚÄÄ¿  ';
    sprites[Right][Kick][1]    := '  ÄÁÄÄÁÄ ';
    sprites[Right][Kick][2]    := '  (§_§ ) ';
    sprites[Right][Kick][3]    := ' @( @ )  ';
    sprites[Right][Kick][4]    := 'îîî   \  ';

end;

var key : char;
var leftPose : TPose;
var rightPose : TPose;
label gameover;
begin
    initialise;

    key := #01; { initialise with non-#00 for the first iteration of repeat }

    repeat
        leftPose := Idle;
        rightPose := Idle;

        case (key) of
            'Q' : leftPose := Punch;
            'E' : leftPose := Kick;
            'A' : if leftPlayerScreenX > 1 then
                      leftPlayerScreenX := leftPlayerScreenX - 1;
            'D' : if calculateDistance > 0 then
                      leftPlayerScreenX := leftPlayerScreenX + 1;
            '.' : rightPose := Punch;
            '-' : rightPose := Kick;
            #00 : { arrow keys return #00 before the actual key code }
                case upcase(readkey) of
                    #75 : if calculateDistance > 0 then
                              rightPlayerScreenX := rightPlayerScreenX - 1;
                    #77 : if rightPlayerScreenX < 72 then
                              rightPlayerScreenX := rightPlayerScreenX + 1;
                end;
        end;

        drawHeader;
        drawFighter(leftPose, Left, leftPlayerScreenX);
        drawFighter(rightPose, Right, rightPlayerScreenX);

        handleDamage(leftPose, rightPose);
        drawHealth;

        if (leftPlayerHP <= 0) or (rightPlayerHP <= 0) then
            goto gameover;

        gotoxy(80, 25); {move cursor to lower right corner}
        key := upcase(readkey);
    until key = #27; {Escape}

    gameover:
    gotoxy(10, 11);

    if (leftPlayerHP <= 0) and (rightPlayerHP <= 0) then
        writeln ('DRAW!')
    else if leftPlayerHP <= 0 then
        writeln ('Player 2 wins! FATALITY')
    else
        writeln ('Player 1 wins! FATALITY');

    playSound(500);

    repeat
    until readkey = #27;
end.
