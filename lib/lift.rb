class Lift

    def initialize(floors, capacity)
      @capacity = capacity
      @floors = floors
      @passengers = []
      @isDirectionUp = true
      @floor = 0
    end

    def move
      if floor == 0
        @isDirectionUp = true
      elsif floor == floors.length() -1
        @isDirectionUp = false
      end

    end

end