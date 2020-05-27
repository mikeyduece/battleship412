('A'..'J').to_a.each do |letter|
  Column.create(name: letter)
end

(1..10).to_a.each do |number|
  Row.create(name: number)
end