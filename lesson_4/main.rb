require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'seeds.rb'

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
