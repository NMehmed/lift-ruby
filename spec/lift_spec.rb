require './lib/lift.rb'
require './lib/floor.rb'
require './lib/passenger.rb'

def get_lift_course(queues, capacity)
  floors = queues.each_with_index.map {|queue, index| Floor.new(queue, index)}
  lift = Lift.new(floors, capacity)

  return lift.make_a_run()
end

RSpec.describe "Lift course" do

  it "should simple go up" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(5), Passenger.new(5), Passenger.new(5)], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 2, 5, 0])
  end

  it "should simple go up and down" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(1), Passenger.new(1)], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 2, 1, 0])
  end

  it "should a be stopping both for passengers and floors when going up" do
    expect(get_lift_course([
      [], # G
      [Passenger.new(3)], # 1
      [Passenger.new(4)], # 2
      [], # 3
      [Passenger.new(5)], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 1, 2, 3, 4, 5, 0])
  end

  it "should be smart and go all the way up than down" do
    expect(get_lift_course([
      [],
      [Passenger.new(0)],
      [],
      [],
      [Passenger.new(2)],
      [Passenger.new(3)],
      []
   ], 5)).to eq([0, 5, 4, 3, 2, 1, 0])
  end

  it "should respect capacity" do
    expect(get_lift_course([
      [Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4)], # G
      [], # 1
      [], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 4, 0, 4, 0])
  end

  it "should go up and down, up and down" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4)], # 2
      [], # 3
      [Passenger.new(2), Passenger.new(2), Passenger.new(2), Passenger.new(2)], # 4
      [], # 5
    ], 2)).to eq([0, 2, 4, 2, 4, 2, 0])
  end

  it "should go up and down smartly" do
    expect(get_lift_course([
      [Passenger.new(3), Passenger.new(3), Passenger.new(3), Passenger.new(3), Passenger.new(3), Passenger.new(3)], # G
      [], # 1
      [], # 2
      [], # 3
      [], # 4
      [Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4), Passenger.new(4)], # 5
      [] # 6
    ], 5)).to eq([0, 3, 5, 4, 0, 3, 5, 4, 0])
  end

  it "should go to mechanics floor first" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(3), Passenger.new(5, true)], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 2, 5, 3, 0])
  end

  it "should go to passengers floor because he is first in queue and then mechanics floor" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(3), Passenger.new(1, true)], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 2, 3, 2, 1, 0])
  end

  it "should go to passengers floor because he is going up and then mechanics floor" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [Passenger.new(3), Passenger.new(5, true)], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 1)).to eq([0, 2, 3, 2, 5, 0])
  end
end