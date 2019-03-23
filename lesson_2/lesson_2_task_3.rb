################################
# Последовательность Фибоначчи #
################################

def fibonacci(n)
  fib = [0, 1]
  fib_1 = fib[0]
  fib_2 = fib[1]
  
  loop do
    fib_2 += fib_1
    fib_1 = fib_2 - fib_1
    break if fib_2 > n
    fib << fib_2
  end
  puts fib
end

fibonacci(100)
