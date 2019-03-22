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
    # mdays = [0,31,28,31,30,31,30,31,31,30,31,30,31]
    # mdays[2] = 29 if g_year % 400 == 0 || g_year % 4 == 0
    # puts mdays[g_month]
    
    def month_days(month, year, day)
      hash_mdays = { 1 => 31, 2 => 28, 3 => 31,
                4 => 30, 5 => 31, 6 => 30, 
                7 => 31, 8 => 31, 9 => 30, 
                10 => 31, 11 => 30, 12 => 31 }
      
      # проверка является ли год високосным
      hash_mdays[2] = 29 if year % 400 == 0 || year % 4 == 0
      
      # кол-во дней в месяце
      puts hash_mdays[month]
      mdays = hash_mdays.values

      # Кол-во дней в году
      puts number_of_days_per_year = mdays.inject(0){ |res, mday| res + mday }

      puts number_of_the_day_in_the_month = hash_mdays[month] - day
      

      hash_mdays.each do |key, value| 
        break if key > month
          d = 0
          d += value
          puts d + number_of_the_day_in_the_month        
        
      end
    end

    month_days(g_month, g_year, g_day)
    break
  end 
end

# Високосный год определяется по следующему правилу:
# Год високосный, если он делится на четыре без остатка, 
# но если он делится на 100 без остатка, это не високосный год. 
# Однако, если он делится без остатка на 400, это високосный год. 
# Таким образом, 2000 г. является особым високосным годом, 
# который бывает лишь раз в 400 лет.