#!/usr/bin/env lua

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
