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

      def my_count(parameter = nil)
        # Param = 0, Block = 0
        array = to_a
        (return array.length if parameter.nil? && !block_given?)
        # Param = 1, Block = 0
        if !parameter.nil? && !block_given?
          count = 0
          my_each { |item| count += 1 if item == parameter }
        # Param = 0, Block = 1
        elsif parameter.nil? && block_given?
          count = 0
          my_each { |item| count += 1 if yield(item) }
        end
        count
      end

      def my_map(proc = nil)
         # If no block is given, an enumerator is returned instead.
        return to_enum unless block_given?
        new_array = []
        my_each do |item|
          item = if !proc.nil?
                   proc.call(item)
                 else
                   yield(item)
                 end
          new_array << item
        end
        new_array
      end

    
  def my_all?(parameter = nil)
    # Param = 0, Block = 1
    if parameter.nil? && block_given?
      my_each { |item| return false if yield(item) == false }
    # Param = 1, Block = 0
    elsif !parameter.nil? && !block_given?
      my_each do |item|
        return false if parameter.instance_of?(Regexp) && !item.match?(parameter) # Regexp
        return false if !parameter.instance_of?(Regexp) && !(item == parameter)  # value
        return false if !parameter.instance_of?(Regexp) && parameter.class == Class && !(item.is_a? parameter)  # Class
      end
    # Param = 0, Block = 0
    else
      my_each { |item| return false if [false, nil].include?(item) }
    end
    true
  end
end    

# Tests
# my_each
# ob = [1..4].my_each{|obj|} 
# print ob #=> [1..4]
# ob = (1..4).my_each{|obj|} 
# print ob #=> (1..4)
# ob = (1..4).my_each{|obj| print obj *2}  #=> 2468

# my_each_with_index
# [11,31,44].my_each_with_index { |val,index| puts "#{index} , #{val}" }  #=> 0 , 11 1 , 31 2 , 44
#  my_range = (1..4).my_each_with_index { |val,index| puts "#{index} , #{val}" }  #=> 0 ,1 1,2 2,3 3,4
#  puts my_range  #=> 1..4
 
# my count 
# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# # puts ary.my_count{ |x| x%2==0 } #=> 3
# my_range = (1..5)
# puts my_range.my_count

# my_map
# puts [1,2,3,4,5].my_map

# my_all?
# REQUIRED] #my_any? when a pattern other than 
# Regex or a Class is given returns false if none of the collection matches the pattern
puts ["bear","bear","bear"].my_all?("bear")  

# print (1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
# puts ''
# print (1..4).my_map { 'cat' } #=> ["cat", "cat", "cat", "cat"]
# proc1 = proc { |x| x**2 }
# puts ''
# print (1..4).my_map(proc1) #=> [1,4,9,16]








