require_relative 'route'
require_relative 'train'
require_relative 'station'
require_relative 'car'
require_relative 'cargo_car'
require_relative 'cargo_train'
require_relative 'passenger_car'
require_relative 'passenger_train'
require_relative 'menu'

Menu.top_menu

loop do

  choise = gets.chomp

  case choise
    when "menu"
      Menu.menu
      Menu.separator
    
    when "1"
      Menu.menu_add_station
      Menu.separator
    
    when "2"
      Menu.menu_add_train
      Menu.separator
    when "3"
      Menu.menu_add_route
      Menu.separator

    when "4"
      Menu.menu_add_stop
      Menu.separator
    
    when "5"
      puts "Список всех станций"
      Menu.show_stations
      Menu.separator

    when "6"
      puts "Список всех поездов"
      Menu.show_trains
      Menu.separator

    when "7"
      puts "Список доступных маршрутов"
      Menu.show_routes
      Menu.separator

    when "8"
      Menu.menu_list_trains_on_station
      Menu.separator

    when "9"
      Menu.menu_set_route
      Menu.separator

    when "10"
      Menu.menu_hook
      Menu.separator

    when "11"
      Menu.menu_move
      Menu.separator

    when "12"
      break

    else
      puts "Error!"
  end
end
