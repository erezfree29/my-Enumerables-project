# frozen_string_literal: true

module Enumerable
  def my_map(block = nil)
    array = to_a
    new_array = []
    (0..array.length - 1).each do |i|
      item = if !block.nil?
               block.call(array[i])
             else
               yield(array[i], i)
             end
      puts item
      new_array << item
    end
    new_array
  end
end

print(1..4).my_map { |x| x * 2 }
proc1 = proc { |x| x**2 }
print (1..4).my_map(proc1)
