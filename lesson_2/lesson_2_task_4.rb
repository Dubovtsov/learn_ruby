####################################################
# Вывод гласных с их порядковым номером в алфавите #
####################################################

vowels = ["а", "о", "э", "ы", "у", "я", "е", "ю", "и"]

abc = {}
("а".."я").to_a.each_with_index do |value, index|
  vowels.each { |letter| abc[letter] = index if value == letter }
end
puts abc