puts '#################################'
puts 'Creating Columns'
('A'..'J').to_a.each do |letter|
  Column.find_or_create_by(name: letter)
end

puts '#################################'
puts 'Creating Rows'
(1..10).to_a.each do |number|
  Row.find_or_create_by(name: number)
end

puts '#################################'
puts 'Creating Ship'
Ship.ship_types.keys.each do |ship_type|
  Ship.find_or_create_by(ship_type: ship_type)
end