module Enumerable
    def my_each
      for i in 0..self.length - 1
        item = self[i] 
        yield(item)
      end
      self
    end
  
    def my_all?(obj = nil)
      if obj != nil  
        condition = obj  
        for i in 0..self.length - 1
           if obj.class ==  Regexp
            if (obj === self[i]) == false 
              return false
            end 
           elsif !self[i].is_a? condition
              return false 
            end    
        end  
      end
      for i in 0..self.length - 1
        # check if block was given
        if defined?(yield)
          if yield(self[i], i) != true
            return false
          end
        else  
            # block not given only if one element is nil or false return false
            if self[i] == nil || self[i] == false
              return false
            end     
        end  
      end
      return true  
    end
  
    def my_map
      new_array = []
      for i in 0..self.length - 1
        item = yield(self[i], i)
        new_array << item
      end
      new_array
    end  
  
    def my_any?(obj = nil)
      # if an object is given
      if obj != nil  
        condition = obj  
        for i in 0..self.length - 1
           if obj.class ==  Regexp
            return obj === self[i] 
           elsif self[i].is_a? condition
              return true 
            end    
        end  
      end
      for i in 0..self.length - 1 
          # check if block was given
          if defined?(yield)
            if yield(self[i], i) != false
              return true
            end
          else
              # block not given if we find one element that is not true or nil we return 
              # true
              if self[i] == nil || self[i] == true
                return true
              end    
          end  
      end
      return false  
    end  
  
    def my_count(obj = nil)
        count = 0
        # if object is given
        if obj != nil
          find = obj
          for i in 0..self.length - 1
            if self[i] == find
            count += 1
            end
          end    
        end
        for i in 0..self.length - 1
           # check if block was given
           if defined?(yield)
            condition = yield(self[i])
            if condition
              count += 1
            end  
           end 
        end  
        return count    
    end  
  
    def my_none?(obj = nil)
      if obj != nil  
        condition = obj  
        for i in 0..self.length - 1
           if obj.class ==  Regexp
            if obj === self[i]
              return false
            end 
           elsif self[i].is_a? condition
              return false 
            end    
        end  
      end
      for i in 0..self.length - 1
        # check if block was given
        if defined?(yield)
          if yield(self[i], i)
            return false
          end
        else  
            # block not given only if one element is nil or false return false
            if self[i] == true
              return false
            end     
        end  
      end
      return true  
    end     
  end
  
  
  
  ary = ["t", "s", "s","s"]
  puts ary.my_count{ |x| x%2==0 } #=> 3
  ary.my_count(4)
  puts ary.my_none?(/t/)