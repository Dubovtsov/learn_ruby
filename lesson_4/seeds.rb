def seeds
  $cargo = CargoCar.new
  $passenger = PassengerCar.new

  $cargo_train = CargoTrain.new(808)
  $passenger_train = PassengerTrain.new(909)

  $moscow = Station.new("Москва")
  $spb = Station.new("С.-Петербург")
  $tver = Station.new("Тверь")

  $route_to_spb = Route.new($moscow, $spb)
  $route_to_spb.add_station($tver)
end