

def calculate_tip(subtotal, percentage)
  percentage *= 100 if percentage < 1
  subtotal * (percentage / 100)
end

def total(subtotal, tip)
  subtotal + tip
end

def divide_people(total, persons)
  total / persons
end


subtotal = 0
until subtotal.to_f != 0.0
  puts "How much is the bill?"
  subtotal = gets.chomp
end

subtotal = subtotal.to_f
puts "What tip percentage?"

percent = gets.chomp.to_f
puts "How many people?"


people = gets.chomp.to_i
tip = calculate_tip(subtotal, percent)
total = total(subtotal, tip)
portion = divide_people(total, people)


last_str_length = "You owe: $#{sprintf('%.2f', portion)}".length + 3
first_diff = last_str_length - "Subtotal: $#{sprintf('%.2f', subtotal)}".length
second_diff = last_str_length - "Tip: $#{sprintf('%.2f', tip)}".length
third_diff = last_str_length - "Total: $#{sprintf('%.2f', total)}".length


puts "Subtotal: #{' ' * first_diff}$#{sprintf('%.2f', subtotal)}"
puts "Tip: #{' ' * second_diff}$#{sprintf('%.2f', tip)}"
puts "Total: #{' ' * third_diff}$#{sprintf('%.2f', total)}"
puts "You owe:    $#{sprintf('%.2f', portion)}"
