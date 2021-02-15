module Enumerable
  def my_each
    # If no block is given, an enumerator is returned instead.
    return to_enum unless block_given?

    array = to_a
    # yield the item itself and its index
    array.length.times { |index| yield(array[index]) }
    array
  end

  def my_each_with_index
    # If no block is given, an enumerator is returned instead.
    return to_enum unless block_given?

    # yield the item itself and its index
    length.times { |index| yield(self[index], index) }
    self
  end

  def my_select
    # If no block is given, an Enumerator is returned instead.
    return to_enum unless block_given?

    # Returns an array containing all elements of enum for which the given block returns a true value.
    new_array = []
    my_each { |obj| new_array << obj if yield(obj) }
    # Push the item into the new array
    # If the item met the block condition
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
        return false if !parameter.instance_of?(Regexp) && !(item.is_a? parameter) # Class
      end
    # Param = 0, Block = 0
    else
      my_each { |item| return false if [false, nil].include?(item) }
    end
    true
  end

  def my_any?(parameter = nil)
    # Param = 0, Block = 1
    if parameter.nil? && block_given?
      my_each { |item| return true if yield(item) == true }
      false
    end
    # Param = 1, Block = 0
    if !parameter.nil? && !block_given?
      my_each do |item|
        return true if parameter.instance_of?(Regexp) && item.match?(parameter) # Regexp
        return true if !parameter.instance_of?(Regexp) && (item.is_a? parameter) # Class
      end
      false
    end
    # Param = 0, Block = 0
    if parameter.nil? && !block_given?
      my_each { |item| return true if item == true }
      true
    end
    false
  end

  def my_none?(parameter = nil)
    # Param = 0, Block = 1
    if parameter.nil? && block_given?
      my_each { |item| return false if yield(item) == true }
      true
    end
    # Param = 1, Block = 0
    if !parameter.nil? && !block_given?
      my_each do |item|
        return false if parameter.instance_of?(Regexp) && item.match?(parameter) # Regexp
        return false if !parameter.instance_of?(Regexp) && (item.is_a? parameter) # Class
      end
      true
    end
    # Param = 0, Block = 0
    if parameter.nil? && !block_given?
      my_each { |item| return false unless [false, nil, false, nil, false, nil].include?(item) }
      true
    end
    true
  end

  # def my_map
  #   new_array = []
  #   my_each { |item| new_array << yield(item) }
  #   new_array
  # end

  # def my_map(block)
  #   new_array = []
  #   my_each { |item| new_array << block.call(item) }
  #   new_array
  # end

  # def my_count(obj = nil)
  #   count = self.length
  #   # if object is given
  #   unless obj.nil?
  #     find = obj
  #     (0..length - 1).each do |i|
  #       count += 1 if self[i] == find
  #     end
  #     return length if obj.nil?
  #   end

  #   (0..length - 1).each do |i|
  #     # check if block was given
  #     next unless defined?(yield)

  #     condition = yield(self[i])
  #     count += 1 if condition
  #   end
  #   count
  # end

  # def my_inject(initial = nil, operator = nil)
  #   if !block_given? # if there is a block
  #     if operator.nil?
  #       operator = initial # assign the operator
  #       operator.to_sym # convert it to symbol
  #       initial = nil # make initial value null
  #     end
  #     my_each do |obj|
  #       initial = if initial.nil?
  #                   obj
  #                 else
  #                   initial.send(operator, obj) # 1.send ('+', 2)       # 1.+(2)        # 1 + 2
  #                 end
  #     end
  #   # if there is no block
  #   else
  #     my_each do |item|
  #       initial =
  #         if initial.nil?
  #           item # in case the initial value is nil then assign first item to it
  #         else
  #           yield(initial, item) # in case the initial value is (not) nil then assign the result of yield to it
  #         end
  #     end
  #   end
  #   initial
  # end
end

# def multiply_els(obj)
#   obj.my_inject(1, :*)
# end

# Tests
# my_each_with_index
# hash = Hash.new
# %w(cat dog wombat).my_each_with_index { |item, index|
#   hash[item] = index
# }
# print hash   #=> {"cat"=>0, "dog"=>1, "wombat"=>2}

# my_select
# print (1..10).my_select { |i|  i % 3 == 0 }   #=> [3, 6, 9]

# print [1,2,3,4,5].my_select { |num|  num.even?  }   #=> [2, 4]

# my_all?
# puts %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
# puts %w[ant bear cat].my_all?(/t/)                        #=> false
# puts [1, 2i, 3.14].my_all?(Numeric)                       #=> true
# puts [nil, true, 99].my_all?                              #=> false
# puts [].my_all?                                           #=> true

# my_any?
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].any?                                              #=> false

# my_none?
# puts %w{ant bear cat}.my_none? { |word| word.length == 5 } #=> true
# puts %w{ant bear cat}.my_none? { |word| word.length >= 4 } #=> false
# puts %w{ant bear cat}.my_none?(/d/)                        #=> true
# puts [1, 3.14, 42].my_none?(Float)                         #=> false
# puts [].my_none?                                           #=> true
# puts [nil].my_none?                                        #=> true
# puts [nil, false].my_none?                                 #=> true
# puts [nil, false, true].my_none?                          #=> false

# my_count
# ary = [1, 2, 4, 2]
# puts ary.my_count               #=> 4
# puts ary.my_count(2)            #=> 2
# puts ary.my_count{ |x| x%2==0 } #=> 3

# my_map
# print (1..4).my_map { |i| i*i }      #=> [1, 4, 9, 16]
# puts ""
# print (1..4).my_map { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

# my_inject
# puts (5..10).my_inject { |sum, n| sum + n }            #=> 45
# puts (5..10).my_inject(:+)                             #=> 45
# puts (5..10).my_inject(1, :*)                          #=> 151200
# puts (5..10).my_inject(1) { |product, n| product * n } #=> 151200
# longest = %w{ cat sheep bear }.my_inject {|memo, word|
#   memo.length > word.length ? memo : word}
# puts longest                                        #=> "sheep"
# multiply_els
# puts multiply_els([2,4,5]) #=> 40
