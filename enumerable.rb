# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity, Metrics/ModuleLength
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

    new_array = []
    my_each { |obj| new_array << obj if yield(obj) }
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
    # Param = 1, Block = 0
    elsif !parameter.nil? && !block_given?
      my_each do |item|
        return true if parameter.instance_of?(Regexp) && item.match?(parameter) # Regexp
        return true if !parameter.instance_of?(Regexp) && (item.is_a? parameter) # Class
      end
      false
    # Param = 0, Block = 0
    else
      my_each { |item| return true if item == true }
      true
    end
    false
  end

  def my_none?(parameter = nil)
    # Param = 0, Block = 1
    if parameter.nil? && block_given?
      my_each { |item| return false if yield(item) == true }
    # Param = 1, Block = 0
    elsif !parameter.nil? && !block_given?
      my_each do |item|
        return false if parameter.instance_of?(Regexp) && item.match?(parameter) # Regexp
        return false if !parameter.instance_of?(Regexp) && (item.is_a? parameter) # Class
      end
    # Param = 0, Block = 0
    else
      my_each { |item| return false unless [false, nil, false, nil, false, nil].include?(item) }
    end
    true
  end

  def my_count(parameter = nil)
    # Param = 0, Block = 0
    (return length if parameter.nil? && !block_given?)
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

  def my_inject(initial = nil, sym = nil)
    # Initial =1, sym=1, Block =0
    if !initial.nil? && sym != nil & !block_given?
      my_each { |item| initial = initial.send(operator, item) }
    # Initial =0, sym=1, Block =0
    elsif initial.nil? && sym != nil & !block_given?
      sym = initial
      sym.to_sym
      initial = nil
      my_each do |item|
        initial = item if initial.nil?
        initial = initial.send(sym, item) unless initial.nil?
      end

    # Initial =1, sym=0, Block =1
    elsif !initial.nil? && sym == nil & block_given?
      my_each { |item| initial = yield(initial, item) }
    # Initial =0, sym=0, Block =1
    elsif initial.nil? && sym == nil & block_given?
      my_each do |item|
        initial = item if initial.nil?
        initial = yield(initial, item) unless initial.nil?
      end
    end
  end
end

def multiply_els(obj)
  obj.my_inject(1, :*)
end

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
# print(1..4).my_map { |i| i * i } #=> [1, 4, 9, 16]
# puts ''
# print(1..4).my_map { 'cat' } #=> ["cat", "cat", "cat", "cat"]
# proc1 = proc { |x| x**2 }
# puts ''
# print (1..4).my_map(proc1) #=> [1,4,9,16]

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

# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity,  Metrics/ModuleLength
