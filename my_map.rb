module Enumerable
  def my_map(block = nil)
    new_array = []
    array = to_a
    (0..array.length - 1).each do |i|
      item = if !block.nil?
               block.call(array[i])
             else
               yield(array[i], i)
             end
      new_array << item
    end
    new_array
  end

  print(1..4).my_map { |x| x * 2 }
  proc1 = proc { |x| x**2 }
  print (1..4).my_map(proc1)
end
