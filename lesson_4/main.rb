require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'seeds.rb'

@trains = []
@stations = []
@routes = []

puts "------------------------------------------------------"
puts "Что вы хотите сделать?"
puts "Чтобы добавить новую ж/д станцию введите - create station"
puts "Чтобы добавить новый поезд введите - create train"
puts "Чтобы добавить новый маршрут введите - create route"
puts "Завершить выполнение программы - stop"
puts "------------------------------------------------------"

loop do

  choise = gets.chomp
   
  case choise
    when "stop"
      break
    when "stations"
      @stations.each_with_index { |station, index| puts "#{index + 1} - #{station.name}" }
    when "trains"
      @trains.each_with_index { |train, index| puts "#{index + 1} - #{train.train_number} - #{train.type}" }
    when "create station"
      puts "Введите название станции:"
      name_station = gets.chomp
      @stations << Station.new(name_station)
      puts "Добавлена новая станция: #{name_station}"
    when "create train"
      puts "Введите номер поезда:"
      train_number = gets.to_i
      puts "Поезд пассажирский или грузовой?"
      type = gets.chomp
      if type == "грузовой"
        @trains << CargoTrain.new(train_number)
        puts "Добавлен новый поезд: #{train_number}"
      else
        @trains << PassengerTrain.new(train_number)
        puts "Добавлен новый поезд: #{train_number}"
      end
      
    when "create route"
      puts "Введите начальную станцию:"
      start_station = gets.chomp
      # station1 = Station.new(start_station)
      puts "Введите конечную станцию:"
      end_station = gets.chomp
      # station2 = Station.new(end_station)
      @routes << Route.new(start_station, end_station)

      puts "Добавлен маршрут от #{start_station} до #{end_station}"
    else
      puts "Error!"
  end
end
# train = Train.new

# route = Route.new

# moscow = Station.new


# irb -r ./main.rb
# метод seed для загрузки данных


# Разделить поезда на два типа PassengerTrain и CargoTrain, 
# сделать родителя для классов, который будет содержать общие методы и свойства
# Определить, какие методы могут быть помещены в private/protected 
# и вынести их в такую секцию. В комментарии к методу обосновать, 
# почему он был вынесен в private/protected
# Вагоны теперь делятся на грузовые и пассажирские (отдельные классы). 
# К пассажирскому поезду можно прицепить только пассажирские, к грузовому - грузовые. 
# При добавлении вагона к поезду, объект вагона должен передаваться 
# как аругмент метода и сохраняться во внутреннем массиве поезда, 
# в отличие от предыдущего задания, где мы считали только кол-во вагонов. 
# Параметр конструктора "кол-во вагонов" при этом можно удалить.
