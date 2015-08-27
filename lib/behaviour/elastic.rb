
class Elastic
  GROWTH_RATE = 2

  GROW = 1
  SHRINK = -1

  def initialize(direction)
    @direction = direction
  end

  def attach_ball(ball)
    @ball = ball
  end

  def update
    @direction = reverse_growth_direction_if_necessary
    @ball.radius = next_radius
  end

  private
  def reverse_growth_direction_if_necessary
    shrinking_too_small || growing_too_big ? switch_direction : @direction
  end

  def growing_too_big
    @ball.radius >= 50 && growing
  end

  def growing
    @direction == GROW
  end

  def switch_direction
    @direction * -1
  end

  def shrinking_too_small
    @ball.radius <= 0 && shrinking
  end

  def shrinking
    @direction == SHRINK
  end

  def next_radius
    @ball.radius + (GROWTH_RATE * @direction)
  end
end