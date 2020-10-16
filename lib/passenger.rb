class Passenger

  attr_reader :floor_number

  def initialize(floor_number, mechanic = false)
    @floor_number = floor_number
    @mechanic = mechanic
  end

  def mechanic?
    @mechanic
  end

end