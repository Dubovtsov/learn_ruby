consonants = ["б", "в", "г", "д", 
              "ж", "з", "й", "к", 
              "л", "м", "н", "п", 
              "р", "с", "т", "ф", 
              "х", "ц", "ч", "ш",
               "щ", "ь", "ъ"]

abc = Hash[("а".."я").to_a.zip((1..32).to_a)]

consonants.each do |letter|
  if abc.include?(letter)
    abc.delete(letter)
  end
end
puts abc