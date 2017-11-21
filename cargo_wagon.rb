require_relative 'wagon'

class Cargo < Wagon
  attr_reader :type

  def initialize(overall_volume)
    @type = 'cargo'
    @overall_volume = overall_volume
    @free_volume = @overall_volume
    @occopied_volume = 0
  end

  def take_volume(vol)
    @occopied_volume += vol
    @free_volume -= vol
  end

  def occupied_vol
    @occopied_volume
  end

  def free_vol
    @free_volume
  end
end
