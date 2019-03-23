######################
# Корзина в магазине #
######################

user_cart = {}
total = 0

loop do
  quantity_and_price = {}
  puts "Введите название товара:"
  item = gets.chomp
  break if item == "стоп"

  puts "Введите цену товара за единицу:"
  price = gets.to_f
  quantity_and_price.store("price", price)

  puts "Введите количество товара:"
  quantity = gets.to_i
  quantity_and_price.store("quantity", quantity)
 
  current_total = price * quantity
  
  total += current_total
  quantity_and_price.store("current_total", current_total)
  user_cart.store(item, quantity_and_price)
end
puts "#{user_cart}"
puts "В корзине товаров на сумму: #{total}"
