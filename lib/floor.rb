require './lib/passenger'

class Floor

  attr_reader :floor_number

  def initialize(queue, floor)
    @floor_number = floor

    @down_queue = queue.select do |passenger|
      passenger.floor_number < floor
    end

    @up_queue = queue.select do |passenger|
      passenger.floor_number > floor
    end
  end

  def passengers?
    passengers_going_up? || passengers_going_down?
  end

  def passengers_going_up?
    @up_queue.length() > 0
  end

  def passengers_going_down?
    @down_queue.length() > 0
  end

  def next_going_up
    @up_queue.shift()
  end

  def next_going_down
    @down_queue.shift()
  end

end