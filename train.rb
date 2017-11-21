require_relative 'company_manufacturer'
require_relative 'valid'
require_relative 'instance_counter'
require_relative 'wagon'
require_relative 'accessors'
require_relative 'validation'

class Train
  include CompanyName
  include Exceptions
  include InstanceCounter
  include Validation
  extend Acessors


  attr_reader :speed, :wagons, :number

  NUMBER_FORMAT = /^([a-z]|\d){3}-?([a-z]|\d){2}$/i

  validate :number, :presence
  validate :number, :format, /^([a-z]|\d){3}-?([a-z]|\d){2}$/
  validate :number, :type, String

  @@trains = {}

  def self.find(number)
    @@trains[number]
  end

  def initialize(number, speed = 0)
    @number = number
    @speed  = speed
    @wagons = []
    validate!
    @@trains[number] = self
  end

  def retaking_wagons
    yield(@wagons) # {|x| puts x.inspect}
  end

  def self.trains
    @@trains
  end

  def break
    @speed = 0
  end

  def take_wagon(wagon)
    @wagons << wagon if wagon.type == type && @speed.zero?
  end

  def leave_wagon(_wagon)
    @wagons.pop if @wagons.any? && @speed.zero?
  end

  def assign_route(route)
    @route = route
    @index_station = 0
    current_station.arrival_train(self)
  end

  def forward
    current_station.departure_train(self)
    @index_station += 1
    current_station.arrival_train(self)
  end

  def back
    current_station.departure_train(self)
    @index_station -= 1
    current_station.arrival_train(self)
  end

  def current_station
    @route.stations[@index_station]
  end

  def previous_station
    @route.stations[@index_station - 1]
  end

  def next_station
    @route.stations[@index_station + 1]
  end

  protected

  #def validate!
   # raise ArgumentError, 'number has invalid format' if @number !~ NUMBER_FORMAT
    #raise ArgumentError, 'wrong speed value' if @speed != 0
    #true
  #end

  def accelerate(num)
    @speed += num
  end
end
