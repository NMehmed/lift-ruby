require './lib/lift.rb'

def get_lift_course(queues, capacity)
  lift = Lift.new(queues, capacity)

  return lift.run()
end

RSpec.describe "Lift course" do
  cart = Cart.new

  it "should simple go up" do
    expect(get_lift_course([
      [], # G
      [], # 1
      [5, 5, 5], # 2
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
      [1, 1], # 2
      [], # 3
      [], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 2, 1, 0])
  end

  it "should a be stopping both for passengers and floors when going up" do
    expect(get_lift_course([
      [], # G
      [3], # 1
      [4], # 2
      [], # 3
      [5], # 4
      [], # 5
      [], # 6
    ], 5)).to eq([0, 1, 2, 3, 4, 5, 0])
  end

  it "should respect capacity" do
    expect(get_lift_course([
      [4, 4, 4, 4, 4, 4], # G
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
      [4, 4, 4, 4], # 2
      [], # 3
      [2, 2, 2, 2], # 4
      [], # 5
    ], 2)).to eq([0, 2, 4, 2, 4, 2, 0])
  end

  it "should go up and down smartly" do
    expect(get_lift_course([
      [3, 3, 3, 3, 3, 3], # G
      [], # 1
      [], # 2
      [], # 3
      [], # 4
      [4, 4, 4, 4, 4, 4], # 5
      [] # 6
    ], 5)).to eq([0, 3, 5, 4, 0, 3, 5, 4, 0])
  end
end