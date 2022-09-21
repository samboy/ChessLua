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

-- Convert an algrbraic square in to an x,y coordinate
-- Input: String in form 'e4'
function algToXY(alg)
  local fileS = {a=1,b=2,c=3,d=4,e=5,f=6,g=7,h=8}
  local file = alg:sub(1,1)
  local rank = tonumber(alg:sub(2,2))
  return file, rank
end

-- Determine the x,y delta in a piece move
-- Input: String in form 'e2e4' or 'e7e8q'
function determineDelta(alg)
  local from = alg:sub(1,2)
  local to = alg:sub(3,4)
  local fromX, fromY = algToXY(from)
  local toX, toY = algToXY(to)
  local deltaX = math.abs(fromX - toX)
  local deltaY = math.abs(fromY - toY)
  return deltaX, deltaY
end

-- New empty chessboard
function emptyChessboard()
  local out = {}
  for a=1,64 do table.insert(out,"") end
  return out
end

-- Convert a FEN in to a grid
function FENtoGrid(fen)
  local out = emptyChessboard()
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

-- Convert a FEN piece in to its Chess Merida character
function pieceToMerida(piece, isBlackSquare)
  local isBlack, isPiece, thisPiece
  isPiece = piece:match('[a-zA-Z]')
  isBlack = piece:match('[a-z]')
  if not isPiece then
    if isBlackSquare then return "+" else return " " end
  end
  thisPiece = piece:lower()
  if isBlack then
    local blackMap = {q="w",r="t",p="o",k="l",b="v",n="m"}
    thisPiece = blackMap[thisPiece]
  end
  if isBlackSquare then thisPiece = thisPiece:upper() end
  return thisPiece
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

-- Convert a Grid in to a chessboard rendered by Chess Merida font
function gridToMerida(grid, newline)
  if not newline then newline = "\n" end
  local out = '!""""""""#' .. newline
  local index = 1
  for row = 1,8 do
    out = out .. "$"
    for file = 1,8 do
      out = out .. pieceToMerida(grid[index],squareIsBlack(index))
      index = index + 1
    end
    out = out .. "%" .. newline
  end
  out = out .. "/(((((((()" .. newline
  return out
end

function FENtoMerida(fen)
  local grid = FENtoGrid(fen)
  return gridToMerida(grid)
end
