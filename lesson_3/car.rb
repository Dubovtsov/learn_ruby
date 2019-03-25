class Car
  attr_accessor :speed # Создает getter and setter

  attr_reader :engine_volume

  def initialize(speed = 0, engine_volume = 1.6)
    @speed = speed
    @engine_volume = engine_volume
  end

  def start_engine
    puts "Wroom!"
  end
  
  def beep
    puts "beep! beep!"
  end

  def stop
    self.speed = 0
  end

  def go
    self.speed = 50
  end

  # Заменено attr_writer
  # def engine_volume
  #   @engine_volume    
  # end
end