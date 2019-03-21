################################
# Последовательность Фибоначчи #
################################

def fibonacci(n)
  fib_1 = 0
  fib_2 = 1
  
  loop do
    fib_2 += fib_1
    fib_1 = fib_2 - fib_1
    break if fib_2 > n
    puts fib_2
  end
end

puts "Введите число:"
fibonacci(gets.chomp.to_i)