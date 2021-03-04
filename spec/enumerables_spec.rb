require_relative '../enumerable'
describe Enumerable do
  describe 'check the my_each method' do
    it 'return enum if block is not given' do
      expect([1, 2, 3, 4].my_each.instance_of?(Enumerator)).to be true
    end
    it 'returns an array when self is an array and block is given' do
      expect([1, 2, 3, 4].my_each { |num| }).to eql([1, 2, 3, 4])
    end
    it 'returns an array when self is a range and block is given' do
      expect((1..4).my_each { |_num| print }).to eql((1..4))
    end
    let(:numbers) { [] }
    it 'iterates over each line when an array is given with a block' do
      [1, 2, 3, 4].my_each { |num| numbers << num * 2 }
      expect(numbers).to eql([2, 4, 6, 8])
    end
    it 'iterates over each line when a range is given with a block' do
      (1..4).my_each { |num| numbers << num * 2 }
      expect(numbers).to eql([2, 4, 6, 8])
    end
  end
  describe 'check the my_each_with_index method' do
    it 'return enum if block is not given' do
      expect([1, 2, 3, 4].my_each_with_index.instance_of?(Enumerator)).to be true
    end
    it 'returns an array when self is an array and block is given' do
      expect([1, 2, 3, 4].my_each_with_index { |num, index| }).to eql([1, 2, 3, 4])
    end
    it 'returns a hash when self is an hash and block is given' do
      expect({ foo: 0, bar: 1, baz: 2 }.my_each_with_index { |num, index| }).to eql(foo: 0, bar: 1, baz: 2)
    end
    let(:hash) { {} }
    it 'iterates over a given array while retriving the index' do
      %w[dog cat cow].my_each_with_index { |animal, index| hash[animal] = index }
      expect(hash).to eql('dog' => 0, 'cat' => 1, 'cow' => 2)
    end
    it 'iterates over a given hash while retriving the index' do
      { 'dog' => 'jhony', 'cat' => 'zelda', 'cow' => 'bila' }.my_each_with_index { |animal, index| hash[animal] = index }
      expect(hash).to eql(%w[dog jhony] => 0, %w[cat zelda] => 1, %w[cow bila] => 2)
    end
  end
  describe 'test the my_select method' do
    it 'returns enum if block is not given' do
      expect([1, 2, 3, 4].my_select.instance_of?(Enumerator)).to be true
    end
    it 'returns an array  that meets the condition when self is an array and block is given' do
      expect([1, 2, 3, 4].my_select { |i| i % 3 == 0 }).to eql([3])
    end
    it 'returns an array  that meets the condition when self is a range and block is given' do
      expect((1..4).my_select { |i| i % 3 == 0 }).to eql([3])
    end
  end
  describe 'test the my_all method' do
    it 'if parameter is not given and  a block is given it returns true if all meet the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 3 }).to be true
    end
    it 'if parameter is not given and  a block is given it returns false if not all meet the condition' do
      expect(%w[ant bear cat].my_all? { |word| word.length >= 4 }).to be false
    end
    it 'if a parameter is a Regexp and a block is not given it returns true if all values include it' do
      expect(%w[ant tiger cat].my_all?(/t/)).to be true
    end
    it 'if a parameter is a Regexp and a block is not given it returns flase if not all values include it' do
      expect(%w[ant cow cat].my_all?(/t/)).to be false
    end
    it 'if a parameter is a class  and a block is not given it returns true if all values are instances of this class' do
      expect([1, 2, 3.14].my_all?(Numeric)).to be true
    end
    it 'if a parameter is a class  and a block is not given it returns false if not all values are instances of this class' do
      expect([1, 'nine', 3.14].my_all?(Numeric)).to be false
    end
    it 'if a parameter is a value  and a block is not given it returns true if all values include it' do
      expect(%w[bear bear bear].my_all?('bear')).to be true
    end
    it 'if a parameter is a value  and a block is not given it returns false if not all values include it' do
      expect(%w[bear cow bear].my_all?('bear')).to be false
    end
    it 'if no parameter and block are given it returns true if no value is nil or false' do
      expect(['cow'].my_all?).to be true
    end
    it 'if no parameter and block are given it returns false if any value is nil or false' do
      expect([nil, true, 99].my_all?).to be false
    end
  end
  describe 'test the my_any method' do
    it 'if parameter is not given and  a block is given it returns true if any meet the condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 4 }).to be true
    end
    it 'if parameter is not given and  a block is given it returns false if none meet the condition' do
      expect(%w[ant bear cat].my_any? { |word| word.length >= 5 }).to be false
    end
    it 'if a parameter is a Regexp and a block is not given it returns true if any of the  values include it' do
      expect(%w[dog fish cat].my_any?(/t/)).to be true
    end
    it 'if a parameter is a Regexp and a block is not given it returns flase if none of the values include it' do
      expect(%w[dog fish donkey].my_any?(/t/)).to be false
    end
    it 'if a parameter is a class  and a block is not given it returns true if any of the values are instances of this class' do
      expect(['house', 'spain', 3.14].my_any?(Numeric)).to be true
    end
    it 'if a parameter is a class  and a block is not given it returns false if none of the values are instances of this class' do
      expect(%w[eight nine dog].my_any?(Numeric)).to be false
    end
    it 'if a parameter is a value  and a block is not given it returns true if any of the values include it' do
      expect(%w[dog fish bear].my_any?('bear')).to be true
    end
    it 'if a parameter is a value  and a block is not given it returns false if none of the values include it' do
      expect(%w[dog fish cow].my_any?('bear')).to be false
    end
    it 'if no parameter and block are given it returns false if no value is nil or false' do
      expect(['cow'].my_any?).to be false
    end
    it 'if no parameter and block are given it returns true if any value is nil or false' do
      expect([nil, true, 99].my_any?).to be true
    end
  end
  end
end

# my_any?
# puts %w[ant bear cat].my_any? { |word| word.length >= 3 } #=> true
# puts %w[ant bear cat].my_any? { |word| word.length >= 4 } #=> true
# puts %w[ant bear cat].my_any?(/d/)                        #=> false
# puts [nil, true, 99].my_any?(Integer)                     #=> true
# puts [nil, true, 99].my_any?                              #=> true
# puts [].any?                                              #=> false
# puts ["bear","cow","pig"].my_any?("bear")  # true
# puts ["fish","cow","pig"].my_any?("bear")  # false
