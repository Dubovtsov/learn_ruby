# Проверка работы классов

moscow = Station.new("Moscow")
spb = Station.new("Spb")
tver = Station.new("Tver")

train_808 = Train.new(808, "passenger", 12)
train_909 = Train.new(909, "cargo", 18)
train_1001 = Train.new(1001, "passenger", 12)

route_to_spb = Route.new(moscow.name, spb.name)
route_to_spb.add_station(tver.name)
puts "Маршрут до Питера"
route_to_spb.shedule

train_808.route(route_to_spb)
puts "---"
puts "Слудующая станция"
puts train_808.next_station
puts "---"
puts "Текущая станция"
puts train_808.current_station
puts "---"
train_808.move_forward
puts "Приехал на следующую"
puts train_808.current_station
puts train_808.previous_station
