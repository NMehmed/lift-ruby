class Floor

  def initialize(queue, floor)
    @floor_number = floor

    @down_queue = queue.select do |passenger|
      passenger < floor
    end

    @up_queue = queue.select do |passenger|
      passenger > floor
    end
  end

  def floor_number
    @floor_number
  end

  def has_people
    has_people_going_up() || has_people_going_up()
  end

  def has_people_going_up
    @up_queue.length() > 0
  end

  def has_people_going_down
    @down_queue.length() > 0
  end

  def next_going_up
    @up_queue.shift()
  end

  def next_going_down
    @down_queue.shift()
  end

end