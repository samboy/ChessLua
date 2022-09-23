#!/usr/bin/env lua

-- This is a script for taking the raw puzzle database from lichess.org
-- and rearranging the puzzles in a pseudo-random manner.  It takes the 
-- first field (the game ID) and replaces it with the first 32 
-- bits of the RadioGatún[32] sum of the PGN before the blunder move which
-- allows mate in one.  To run this script, either use Lunacy or Lua with
-- the Lua libs for rg32
-- https://github.com/samboy/lunacy
-- https://github.com/samboy/LUAlibs

if not rg32 then require("rg32") end
-- Since Lunacy doesn't have split(), we make
-- it ourselves
function chessSplit(s, splitOn)
  if not splitOn then splitOn = "," end
  local place = true
  local out = {}
  local mark
  local last = 1
  while place do
    place, mark = string.find(s, splitOn, last, false)
    if place then
      table.insert(out,string.sub(s, last, place - 1))
      last = mark + 1
    end
  end
  table.insert(out,string.sub(s, last, -1))
  return out
end
line = true
out = ""
while line do
  line = io.read()
  if line then
    local fields = chessSplit(line)
    rg32.randomseed(fields[2]) -- Fen before blunder move
    print(string.format("%08x",rg32.rand32()) .. "," .. fields[2] .. "," ..
          fields[3] .. "," .. fields[4])
  end
end
