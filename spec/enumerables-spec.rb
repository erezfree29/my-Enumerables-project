require_relative '../enumerable'
describe Enumerable do
  describe 'check the my_each method' do
    it 'return enum if block is not given' do
      expect([1,2,3,4].my_each.instance_of?(Enumerator)).to be true 
    end
    it 'returns an array when self is an array and block is given' do
       expect([1,2,3,4].my_each{|num|}).to eql([1,2,3,4])  
    end
    it 'returns an array when self is a range and block is given' do
      expect((1..4).my_each{|num| print}).to eql((1..4))  
   end
   let(:numbers) { [] }
   it 'iterates over each line when an array is given with a block' do
    [1,2,3,4].my_each{|num| numbers << num * 2}
    expect(numbers).to eql([2,4,6,8])
   end
   it 'iterates over each line when a range is given with a block' do
    (1..4).my_each{|num| numbers << num * 2}
    expect(numbers).to eql([2,4,6,8])
   end
  end
  describe 'check the my_each_with_index method' do
    it 'return enum if block is not given' do
      expect([1,2,3,4].my_each_with_index.instance_of?(Enumerator)).to be true 
    end
    it 'returns an array when self is an array and block is given' do
      expect([1,2,3,4].my_each_with_index{|num,index|}).to eql([1,2,3,4])  
   end
   it 'returns a hash when self is an hash and block is given' do
    expect({:foo=>0, :bar=>1, :baz=>2}.my_each_with_index{|num,index|}).to eql({:foo=>0, :bar=>1, :baz=>2})  
   end
   let(:hash) { Hash.new }
   it 'iterates over a given array while retriving the index' do
      ["dog","cat","cow"].my_each_with_index{|animal,index| hash[animal] = index }
      expect(hash).to eql({"dog"=>0, "cat"=>1, "cow"=>2})
   end
   it 'iterates over a given hash while retriving the index' do
    {"dog"=>"jhony", "cat"=>"zelda", "cow"=>"bila"}.my_each_with_index{|animal,index| hash[animal] = index }
    expect(hash).to eql({["dog", "jhony"]=>0, ["cat", "zelda"]=>1, ["cow", "bila"]=>2})
 end
  end
end

