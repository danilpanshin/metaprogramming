require_relative 'valid'
require_relative 'instance_counter'

class Station
  include Exceptions
  include InstanceCounter

  attr_reader :trains, :name

  @@stations = []

  NAME_FORMAT = /^[A-Z]{1}[a-z]*-?\d{0,3}$/

  def initialize(name)
    @name = name
    @trains = []
    validate!
    @@stations << self
  end

  def retaking
    yield(@trains) # {|x| puts x}
  end

  def arrival_train(train)
    @trains << train
  end

  def departure_train(train)
    @trains.delete(train)
  end

  def list_by_type(type)
    num = 0
    @trains.each { |traintype| num += 1 if traintype == type }
  end

  def self.all
    @@stations
  end

  protected

  def validate!
    raise ArgumentError, 'wrong station name' if @name !~ NAME_FORMAT
    true
  end
end
