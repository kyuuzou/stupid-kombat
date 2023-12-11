unit Types;

interface
type TPose = (Idle, Punch, Kick);
type TSide = (Left, Right);
type TSprites = array[TSide, TPose, 0..4] of string;

implementation

end.