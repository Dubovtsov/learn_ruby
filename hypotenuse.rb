##############################################################
# Программа определяет является ли треугольник прямоугольным #
##############################################################

puts "Введите сторону а :"
a = gets.chomp.to_f

puts "Введите сторону b :"
b = gets.chomp.to_f

puts "Введите сторону c :"
c = gets.chomp.to_f

if a >= b && a >= c
  hypotenuse = a
  side_a = b
  side_b = c
elsif b >= a && b >= c
  hypotenuse = b
  side_a = a
  side_b = c
elsif c >= a && c >= b
  hypotenuse = c
  side_a = a
  side_b = b						
end

puts "Треугольник является равнобедренным." if a == b && a != c || a == c && a != b || b == c && b != a

puts "Треугольник является равносторонним." if a == b && b == c && a == c

# проверка по теореме Пифагора
if (hypotenuse**2) == side_a**2 + side_b**2
  puts "Треугольник прямоугольный"
else
  puts "Треугольник не прямоугольный!"
end
