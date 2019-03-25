################################################
# Опрделение порядкового номера введенной даты #
################################################

require 'date'

def month_days(month, year, day)
  hash_mdays = { 1 => 31, 2 => 28, 3 => 31,
                4 => 30, 5 => 31, 6 => 30, 
                7 => 31, 8 => 31, 9 => 30, 
                10 => 31, 11 => 30, 12 => 31 }
    
  # проверка является ли год високосным
  hash_mdays[2] = 29 if year % 400 == 0 || year % 4 == 0
  # Кол-во дней в году
  number_of_days_per_year = hash_mdays.values.take(month - 1).sum + day
  # number_of_the_day_in_the_month = hash_mdays[month] - day
  puts number_of_days_per_year
end

loop do
  puts "Введите произвольную дату в формате 00.00.0000:"
  date = gets.chomp.split(".")
  date = date.map{ |e| e.to_i}
  
  user_day = date[0]
  user_month = date[1]
  user_year = date[2]

  # Минимальная проверка ввода
  if user_day < 1 || user_day > 31
    puts "Неправильное число"
  elsif user_month < 1 || user_month > 12
    puts "Неправильный месяц"
  # Просто захотел такой интервал
  elsif user_year < 1000 || user_year > 2500
    puts "Год должен быть в интервале 1000..2500"
  else
    month_days(user_month, user_year, user_day)
    now = Time.now
    puts now.yday
    break
  end 
end