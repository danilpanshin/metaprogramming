module Exceptions
  def valid?
    validate!
  rescue ArgumentError
    false
  end
end
