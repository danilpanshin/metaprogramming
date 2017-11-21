require_relative 'train'
require_relative 'passenger_wagon'

class PassengerTrain < Train
  attr_reader :type, :wagons, :number

  def initialize(number, speed = 0)
    super
    @type = 'passenger'
  end
end
