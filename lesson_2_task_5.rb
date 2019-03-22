################################################
# Опрделение порядкового номера введенной даты #
################################################

require 'date'

loop do
  puts "Введите произвольную дату в формате 00.00.0000:"
  date = gets.chomp.split(".")
  date = date.map{ |e| e.to_i}
  
  g_day = date[0]
  g_month = date[1]
  g_year = date[2]

  if g_day < 1 || g_day > 31
    puts "Неправильное число"
  elsif g_month < 1 || g_month > 12
    puts "Неправильный месяц"
  elsif g_year < 1900 || g_year > 2050
    puts "Год должен быть в интервале 1900..2050"
  else
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

    month_days(g_month, g_year, g_day)
    
    # Проверка кода встроенным методом
    # now = Time.now
    # puts now.yday

    break
  end 
end