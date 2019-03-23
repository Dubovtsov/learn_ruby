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
  # Создаем массив из значение хэша
  mdays = hash_mdays.values
  # Кол-во дней в году
  number_of_days_per_year = mdays.inject(0){ |res, mday| res + mday }
  number_of_the_day_in_the_month = hash_mdays[month] - day

  d = 0
  hash_mdays.each do |key, value| 
    break if key > month
      d += value     
  end
  puts d - number_of_the_day_in_the_month
end

loop do
  puts "Введите произвольную дату в формате 00.00.0000:"
  date = gets.chomp.split(".")
  date = date.map{ |e| e.to_i}
  
  u_day = date[0]
  u_month = date[1]
  u_year = date[2]

  # Минимальная проверка ввода
  if u_day < 1 || u_day > 31
    puts "Неправильное число"
  elsif u_month < 1 || u_month > 12
    puts "Неправильный месяц"
  # Просто захотел такой интервал
  elsif u_year < 1000 || u_year > 2500
    puts "Год должен быть в интервале 1000..2500"
  else
    month_days(u_month, u_year, u_day)
    
    break
  end 
end

# Проверка кода встроенным методом
# now = Time.now
# puts now.yday
