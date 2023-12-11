program StupidKombat;

uses crt, Player;

var players : array[TSide] of TPlayer;

function calculateDistance : integer;
const SpriteWidth : integer = 8;
var distance : integer;
begin
    distance := players[Right].GetX - players[Left].GetX - SpriteWidth;
    calculateDistance := distance;
end;

procedure playSound(tone: integer);
begin
    sound(tone);
    delay(100);
    nosound;
end;

procedure drawGameOver;
begin
    gotoxy(10, 11);

    if (players[Left].GetHP <= 0) and (players[Right].GetHP <= 0) then
        writeln ('DRAW!')
    else if players[Left].GetHP <= 0 then
        writeln ('Player 2 wins! FATALITY')
    else if players[Right].GetHP <= 0 then
        writeln ('Player 1 wins! FATALITY')
    else
        writeln ('Goodbye!');

    playSound(500);
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

    for i := 1 to players[Left].GetHP do
        write('Û');

    gotoxy(22 + (20 - players[Right].GetHP), HealthBarY);

    for i := 1 to players[Right].GetHP do
        write('Û');
end;

procedure handleDamage(side: TSide);
label return;
var distance : integer;
var opponentSide : TSide;
begin;
    distance := calculateDistance;

    if distance > 0 then
        goto return;

    if (side = Right) then opponentSide := Left else opponentSide := Right;

    if players[side].GetPose = Punch then
    begin
        players[opponentSide].Damage(1);
        playSound(1000);
    end
    else if players[side].GetPose = Kick then
    begin
        players[opponentSide].Damage(2);
        playSound(2000);
    end;

    return:
end;

procedure initialise;
begin
    players[Left].Init(Idle, Left);
    players[Right].Init(Idle, Right);
end;

var key : char;
label gameover;
begin
    initialise;

    key := #01; { initialise with non-#00 for the first iteration of repeat }

    repeat
        players[Left].SetPose(Idle);
        players[Right].SetPose(Idle);

        case (key) of
            'Q' : players[Left].SetPose(Punch);
            'E' : players[Left].SetPose(Kick);
            'A' : if players[Left].GetX > 1 then
                      players[Left].SetX(players[Left].GetX - 1);
            'D' : if calculateDistance > 0 then
                      players[Left].SetX(players[Left].GetX + 1);
            '.' : players[Right].SetPose(Punch);
            '-' : players[Right].SetPose(Kick);
            #00 : { arrow keys return #00 before the actual key code }
                case upcase(readkey) of
                    #75 : if calculateDistance > 0 then
                              players[Right].SetX(players[Right].GetX - 1);
                    #77 : if players[Right].GetX < 72 then
                              players[Right].SetX(players[Right].GetX + 1);
                end;
        end;

        drawHeader;
        players[Left].Draw;
        players[Right].Draw;

        handleDamage(Left);
        handleDamage(Right);
        drawHealth;

        if (players[Left].GetHP <= 0) or (players[Right].GetHP <= 0) then
            goto gameover;

        gotoxy(80, 25); {move cursor to lower right corner}
        key := upcase(readkey);
    until key = #27; {Escape}

    gameover:
    drawGameOver;

    repeat
    until readkey = #27;
end.
