require_relative 'instance_counter'
require_relative 'valid'

class Route
  include Exceptions
  include InstanceCounter

  ROUTE_FORMAT = /^[A-Z]{1}[a-z]*-?\d{0,3}\s-\s[A-Z]{1}[a-z]*-?\d{0,3}$/

  attr_reader :stations, :name

  def initialize(name, start, finish)
    @name = name
    @stations = [start, finish]
    validate!
  end

  def add_station(station)
    @stations.insert(@stations.length - 1, station)
  end

  def delete_station(station)
    @stations.delete(station)
  end

  protected

  def validate!
    raise ArgumentError, 'wrong route name format' if @name !~ ROUTE_FORMAT
    if stations.each { |s| s.class != Station }
      raise ArgumentError,
            'wrong start or finish format'
    end
    true
  end
end
