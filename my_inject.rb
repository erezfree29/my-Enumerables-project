module Enumerable
  def my_each
    # If no block is given, an enumerator is returned instead.
    return to_enum unless block_given?

    # yield the item itself and its index
    array = to_a
    array.length.times { |index| yield(array[index]) }
    self
  end

  def my_each_with_index
    # If no block is given, an enumerator is returned instead.
    return to_enum unless block_given?

    # yield the item itself and its index
    array = to_a
    array.length.times { |index| yield(array[index], index) }
    self
  end
end

# Tests
# my_each
ob = [1..4].my_each { |obj| }
print ob #=> [1..4]
puts ''
ob = (1..4).my_each { |obj| }
print ob #=> (1..4)
puts ''
ob = (1..4).my_each { |obj| print obj * 2 } #=> 2468
puts ob

# my_each_with_index
[11, 31, 44].my_each_with_index { |val, index| puts "#{index} , #{val}" } #=> 0 , 11 1 , 31 2 , 44
my_range = (1..4).my_each_with_index { |val, index| puts "#{index} , #{val}" } #=> 0 ,1 1,2 2,3 3,4
puts my_range #=> 1..4
