
function LevelLoader()
  local mapper = require('mapper')

  local lvlgen = {}
  lvlgen.level = {}

  function lvlgen.LoadLevel(self)
    for i = 1,assets.level:getWidth() do
      for j = 1, assets.level:getHeight() do
        local r, g, b, a = assets.levelImgData:getPixel(i-1, j-1)

        -- Skip alpha
        if a == 0 then goto continue end

        local x = (i-1) * cellSize
        local y = (j-1) * cellSize
        mapper.mapColorToTile({r, g, b}, x, y, self.level)

        ::continue::
      end
    end

  end

  function lvlgen.draw(self)
    for _, tile in ipairs(self.level) do
      tile:draw()
    end
  end

  return lvlgen
end

return LevelLoader()