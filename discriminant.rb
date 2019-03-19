####################################
# Программа вычисляет дискриминант #
####################################

puts "Введите значение а :"
a = gets.chomp.to_f

puts "Введите значение b :"
b = gets.chomp.to_f

puts "Введите значение c :"
c = gets.chomp.to_f

d = b**2 - 4 * a * c
sqrt_d = Math.sqrt(d)

if d < 0
  puts "Дискриминант равен #{d}. Корней нет!"
elsif d > 0
  x1 = (-b + sqrt_d)/2 * a
  x2 = (-b - sqrt_d)/2 * a
  puts "Дискриминант равен #{d}. Корень X1 = #{x1.round(2)}, Корень X2 = #{x2.round(2)}"
else
  x = -b/(2 * a)
  puts "Дискриминант равен #{d}. Корень X = #{x}"
end
