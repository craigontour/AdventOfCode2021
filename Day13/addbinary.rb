# https://gist.github.com/k2052/1650069

class Numeric
  def ones_complement(bits)
    self ^ ((1 << bits) - 1)
  end       
end

def addbinary(b1, b2) 
  result = ''
  carry  = 0      
  
  b1 = b1.reverse
  b2 = b2.reverse
  
  b1.each_char.with_index do |char, i|
    k1 = char
    k2 = b2[i]  
    
    intCheck = k1.to_i + k2.to_i 
    
    if intCheck == 2
      write = '10'   
    else 
      write = intCheck
    end         
    result.insert(0, write.to_s) 
  end       
  return result
end