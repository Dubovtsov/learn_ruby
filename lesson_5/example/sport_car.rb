class SportCar < Car

  def start_engine
    super
    puts 'Wroom!'    
  end

  protected

  def initial_rpm
    1000
  end
end