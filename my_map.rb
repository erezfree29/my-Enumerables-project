module Enumerable
    def my_map(block)
        new_array = []
        array = to_a
        (0..array.length - 1).each do |i|
        item = block.call(array[i])
        new_array << item
        end
        new_array
    end


    print (1..4).my_map{|x| x*2} 
    print (1..4).my_map(proc1) 
end
