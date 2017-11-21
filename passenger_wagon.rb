require_relative 'wagon'

class Passenger < Wagon
  attr_reader :type

  def initialize(number_of_seats)
    @number_of_seats = number_of_seats
    @type = 'passenger'
    @occupied_places = 0
    @free_seats = @number_of_seats
  end

  def take_seat
    @occupied_places += 1 if @occupied_places < @number_of_seats
    @free_seats -= 1 if @free_seats > 0
  end

  def free
    @free_seats
  end

  def occupied
    @occupied_places
  end
end
