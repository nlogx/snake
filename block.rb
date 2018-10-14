class Block
  attr_reader :x, :y, :dir
  def initialize(x, y, dir = 'any')
    @x, @y = x, y
    @dir = dir
  end
end
