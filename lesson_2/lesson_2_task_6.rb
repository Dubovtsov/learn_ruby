######################
# Корзина в магазине #
######################

user_cart = {}
total = 0

loop do
  quantity_and_price = {}
  puts "Введите название товара или 'стоп' для завершения ввода:"
  name_item = gets.chomp
  break if name_item == "стоп"

  puts "Введите цену товара за единицу:"
  price = gets.to_f
  quantity_and_price[:price] = price

  puts "Введите количество товара:"
  quantity = gets.to_i
  quantity_and_price[:quantity] = quantity
 
  user_cart[name_item] = quantity_and_price
end

user_cart.each do |name_item, item|
  item_total = item[:price] * item[:quantity]
  puts "#{name_item} - #{item[:quantity]} шт. на сумму #{item_total}"
  total += item_total
end

puts "Итого: #{total}"