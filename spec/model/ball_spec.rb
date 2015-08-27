require 'rspec'
require 'model/ball'
require 'model/ball_factory'
require 'behaviour/bouncing'
require 'behaviour/elastic'

describe 'Static Ball' do
  it 'should should not change state' do
    ball = Ball.new(0, 0)

    ball.update
    
    expect(ball.center.y).to eq(0)
    expect(ball.radius).to eq(Ball::DEFAULT_RADIUS)
  end
end


describe 'Bouncing Ball' do
  it 'should go down' do
    ball = bouncing_ball

    ball.update

    expect(ball.center.y).to eq(one_step_down_from(100))
  end

  it 'should go up after hitting the bottom' do
    the_bottom_edge = BallWorld::BOX_HEIGHT - Ball::DEFAULT_RADIUS
    ball = bouncing_ball(y: the_bottom_edge)

    ball.update

    expect(ball.center.y).to eq(one_step_up_from(the_bottom_edge))
  end

  it 'should go up' do
    ball = bouncing_ball(direction: Bouncing::UP)

    ball.update

    expect(ball.center.y).to eq(one_step_up_from(100))
  end

  it 'should go down after hitting the top' do
    ball = bouncing_ball(y: 0, direction: Bouncing::UP)

    ball.update

    expect(ball.center.y).to eq(one_step_down_from(0))
  end 
end

describe 'Elastic Ball' do
  it 'should decrease radius' do
    ball = elastic_ball

    ball.update

    expect(ball.radius).to eq(one_step_inwards_from(20))
  end

  it 'should increase radius after fully shrinking' do
    ball = elastic_ball(radius: 0)

    ball.update

    expect(ball.radius).to eq(one_step_outwards_from(0))
  end

  it 'should increase in size' do
    ball = elastic_ball(direction: Elastic::GROW)

    ball.update

    expect(ball.radius).to eq(one_step_outwards_from(20))
  end

  it 'should decrease in size after fully expanding' do
    ball = elastic_ball(radius: 50, direction: Elastic::GROW)

    ball.update

    expect(ball.radius).to eq(one_step_inwards_from(50))
  end
end

private
def bouncing_ball(x: 0, y: 100, direction: Bouncing::DOWN)
  BallFactory.bouncing_ball(x, y, direction)
end

def elastic_ball(x: 0, y: 0, radius: 20, direction: Elastic::SHRINK)
  BallFactory.elastic_ball(x, y, radius, direction)
end

def bouncing_and_elastic_ball(x: 0, y: 0, radius: 20, bouncing_direction: Bouncing::DOWN, elastic_direction: Elastic::SHRINK)
  BallFactory.bouncing_and_elastic_ball(x, y, radius, bouncing_direction, elastic_direction)
end

def one_step_down_from(y)
  y + Bouncing::MOVEMENT_SPEED
end

def one_step_up_from(y)
  y - Bouncing::MOVEMENT_SPEED
end

def one_step_inwards_from(radius)
  radius - Elastic::GROWTH_RATE
end

def one_step_outwards_from(radius)
  radius + Elastic::GROWTH_RATE
end