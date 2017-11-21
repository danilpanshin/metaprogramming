require_relative 'train'
require_relative 'cargo_wagon'

class CargoTrain < Train
  attr_reader :type, :wagons, :number

  def initialize(number, speed = 0)
    super
    @type = 'cargo'
  end
end
