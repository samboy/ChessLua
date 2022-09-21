Chess stuff implemented in pure Lua/Lunacy

The file ChessStuff.lua, in addition to having a library with a 
very basic understanding of Chess, will also read from standard
input mating puzzles as they exist over at https://database.lichess.org
and output the puzzles as diagrams which will look good when printed
with a chess diagram font.

To to this, have Lua installed, then run this script:

```
head -362 mateInOne.csv | lunacy ChessStuff.lua > foo.txt
```

`foo.txt` is a file which, if opened with a word processor and rendered
with the Chess Merida (or any compatible) font, will render a bunch of
pretty mate in one chess puzzle diagrams.

See the following repos for fonts with chess pieces:

https://github.com/samboy/ChessGraphics

https://github.com/samboy/ChessMeridaFairy

https://github.com/samboy/OpenChessFontFairy


