#!/usr/bin/env lua

-- Chess stuff implemented in pure Lua/Lunacy

-- Public domain -or- BSD0 by Sam Trenholme.  See LICENSE file.  If
-- a LICENSE file is not provided, the files here are public domain.

-- Convert an algebraic square ('a1', etc.) in to a grid coordinate
-- The grid has a8 be '1' and h1 be 64 so that FEN can be directly 
-- translated in to the grid.  It is one-dimensional
function algToGrid(alg) 
  local fileS = {a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8}
  local file = alg:sub(1,1)
  local rank = tonumber(alg:sub(2,2))
  return 8*(8-rank) + fileS[file]
end

-- New empty chessboard
function emptyChessboard()
  local out = {}
  for a=1,64 do table.insert(out,"") end
  return out
end

-- Convert a FEN in to a grid
function FENtoGrid(fen)
  local out = emptyChessboard
  local number = 0
  local index = 1
  local square = 1
  while index < fen:len() do
    local look = fen:sub(index, index)
    index = index + 1
    if look:match('[0-9]') then
      number = number * 10
      number = number + tonumber(look)
    else
      square = square + number
      number = 0
    end
    if look:match('[a-zA-Z]') then
      out[square] = look
      square = square + 1
    end
    if look:match('%s') then
      return out
    end
  end
  return out
end

-- The color of a given square on a chessboard
-- Index is a number from 1 (a8) to 64 (h1)
-- Output is true if square is black, false otherwise
function squareIsBlack(index)
  local phase = math.floor((index - 1) / 8) % 2
  if phase == 1 then
    if(index % 2) == 1 then return true else return false end
  else
    if(index % 2) == 0 then return true else return false end
  end
end
