

module CompanyName
  def company_name(name)
    @comp_name = name
  end

  def show_name
    @comp_name
  end

  protected

  attr_accessor :comp_name
end
