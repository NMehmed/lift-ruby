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

      if @floor == 0
        @is_direction_up = true
      elsif @floor == @floors.last().floor_number
        @is_direction_up = false
      end

      current_floor = @floors[@floor_number]

      if @passengers.any?(@floor_number)
        stop = true
        @passengers = @passengers.select { |passenger| passenger != @floor_number }
      end

      if current_floor.has_people()
        stop = true

        if @is_direction_up && current_floor.has_people_going_up()
          while has_free_space() && current_floor.has_people_going_up()
            @passengers.push current_floor.next_going_up
          end
        elsif !@is_direction_up && current_floor.has_people_going_down()
          while has_free_space() && current_floor.has_people_going_down()
            @passengers.push current_floor.next_going_down
          end
        end
      end

      stop
    end

    def make_a_run
      stops = [0]

      move()

      while @floors.any?{ |floor| floor.has_people() } || @passengers.length() == 0
        @floor_number += @is_direction_up ? 1 : -1

        if move() && stops.last() != @floor_number
          stops.push @floor_number
        end
      end

      if @floor_number != 0
        stops.push 0
      end

      stops
    end

    def has_free_space
      @passengers.length() <= @capacity
    end

end