require_relative 'company_manufacturer'
require_relative 'instance_counter'

class Wagon
  include CompanyName
  include InstanceCounter
end
