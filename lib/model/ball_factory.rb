require_relative 'ball'
require_relative '../behaviour/bouncing'
require_relative '../behaviour/elastic'

class BallFactory
  class << self
    def all
      [
          bouncing_ball(75, 50, Bouncing::DOWN),
          elastic_ball(250, 100, Ball::DEFAULT_RADIUS, Elastic::SHRINK),
          bouncing_and_elastic_ball(425, 100, Ball::DEFAULT_RADIUS, Bouncing::DOWN, Elastic::SHRINK)
      ]
    end

    def bouncing_ball(x, y, direction)
      Ball.new(x, y).add_behaviours(Bouncing.new(direction))
    end

    def elastic_ball(x, y, radius, direction)
      Ball.new(x, y, radius).add_behaviours(Elastic.new(direction))
    end

    def bouncing_and_elastic_ball(x, y, radius, bouncint_direction, elastic_direction)
      Ball.new(x, y, radius)
        .add_behaviours(Bouncing.new(bouncint_direction))
        .add_behaviours(Elastic.new(elastic_direction))
    end
  end
end