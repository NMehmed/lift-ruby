class Lift

    def initialize(floors, capacity)
      @capacity = capacity
      @floors = floors
      @passengers = []
      @is_direction_up = true
      @floor_number = 0
    end

    def move
      stop = false

      if @floor_number == 0
        @is_direction_up = true
      elsif @floor_number == @floors.last().floor_number
        @is_direction_up = false
      end

      current_floor = @floors[@floor_number]

      if @passengers.any? { |passenger| passenger.floor_number == @floor_number }
        stop = true
        @passengers = @passengers.select { |passenger| passenger.floor_number != @floor_number }
      end

      if current_floor.passengers?()
        if @is_direction_up && current_floor.passengers_going_up?()
          stop = true

          while free_space?() && current_floor.passengers_going_up?()
            @passengers.push current_floor.next_going_up()
          end
        elsif !@is_direction_up && current_floor.passengers_going_down?()
          stop = true

          while free_space?() && current_floor.passengers_going_down?()
            @passengers.push current_floor.next_going_down()
          end
        end
      end

      stop
    end

    def make_a_run
      stops = [0]

      move()

      while @floors.any?{ |floor| floor.passengers?() } || @passengers.length() != 0
        if @passengers.any? { |passenger| passenger.mechanic?() }
          @floor_number = @passengers.find { |passenger| passenger.mechanic?() }.floor_number
        else
          @floor_number = @is_direction_up ? @floor_number + 1 : @floor_number - 1
        end

        if move() && stops.last() != @floor_number
          stops.push @floor_number
        end
      end

      if @floor_number != 0
        stops.push 0
      end

      stops
    end

    def free_space?
      @passengers.length() < @capacity
    end

end