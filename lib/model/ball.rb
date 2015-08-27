require_relative 'point'

class Ball
  DEFAULT_RADIUS = 50

  attr_accessor :center_x
  attr_accessor :center_y
  attr_accessor :radius

  def initialize(center_x, center_y, radius = DEFAULT_RADIUS)
    @center_x = center_x
    @center_y = center_y
    @radius = radius
    @behaviours = []
  end

  def add_behaviours(behaviour)
    behaviour.attach_ball(self)
    @behaviours << behaviour
    self
  end

  def update
    @behaviours.each(&:update)
  end

  def center
    Point.new @center_x, @center_y
  end

  def topleft
    Point.new @center_x - @radius, @center_y - @radius
  end
end