################################
# Последовательность Фибоначчи #
################################

def fibonacci(n)
  fib = [0, 1]
  loop do
    break if fib.at(-1) + fib.at(-2) > n
    fib << fib.at(-1) + fib.at(-2)
  end
  puts fib
end

fibonacci(100)