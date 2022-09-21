Chess stuff implemented in pure Lua/Lunacy

# ChessStuff.lua

The file ChessStuff.lua, in addition to having a library with a 
very basic understanding of Chess, will also read from standard
input mating puzzles as they exist over at https://database.lichess.org
and output the puzzles as diagrams which will look good when printed
with a chess diagram font.

To to this, have Lua installed, then run this script:

```
head -362 mateInOne.csv | lunacy ChessStuff.lua > foo.txt
```

`foo.txt` will now be a file which, if opened with a word processor and
rendered with the Chess Merida (or any compatible) font, will render a
bunch of pretty mate in one chess puzzle diagrams.

# The mateInOne.csv file

The `mateInOne.csv` file shows mating positions, all from actual games
of chess played (no composed puzzles).

While the FEN fields in `mateInOne.csv` all show Black having the move,
in Lichess’s database of chess puzzles, the position right before the
puzzle is shown in the FEN, then the first move is made.  All of
these puzzles have White move and deliver mate in one.  Fields:

* The first field is a pseudo-random number: The first 32 bits of 
  the RadioGatún[32] sum of the FEN of the previous position.  
* The second field is the position *before* the move which allows 
  a mate in one.  
* The third field starts with the move that allows mate in one, then a 
  move that will deliver mate (note: In many positions, multiple mates 
  are possible).  
* The fourth and final field is how difficult the mate should be to 
  solve; higher numbers are harder puzzles.

We have, in mateInOne.csv, 115,436 brilliant ways for White to mate in
one move.

# Chess Piece fonts

See the following repos for fonts with chess pieces:

https://github.com/samboy/ChessGraphics

https://github.com/samboy/ChessMeridaFairy

https://github.com/samboy/OpenChessFontFairy


