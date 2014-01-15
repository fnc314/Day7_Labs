class SortedArray
  attr_reader :internal_arr

  def initialize arr=[]
    @internal_arr = []
    arr.each { |el| add el }
  end

  def add el
    # we are going to keep this array
    # sorted at all times. so this is ez
    lo = 0
    hi = @internal_arr.size
    # note that when the array just
    # starts out, it's zero size, so
    # we don't do anything in the while
    # otherwise this loop determines
    # the position in the array, *before*
    # which to insert our element
    while lo < hi
      # let's get the midpoint
      mid = (lo + hi) / 2
      if @internal_arr[mid] < el
        # if the middle element is less 
        # than the current element
        # let's increment the lo by one
        # from the current midway point
        lo = mid + 1
      else
        # otherwise the hi *is* the midway 
        # point, we'll take the left side next
        hi = mid 
      end
    end

    # insert at the lo position
    @internal_arr.insert(lo, el)
  end

  def each &block
    i = 0
    until i == @internal_arr.size
      yield @internal_arr[i]
      i+=1
    end
    return @internal_arr
    #raise NotImplementedError.new("You need to implement the each method!")
  end

  def map &block
    new_arr = []
    # i = 0
    # while i < @internal_arr.size
    #   new_arr << yield(@internal_arr[i])
    #   i+=1
    # end
    # return new_arr
    self.each { |x| new_arr << yield(x) }
    return new_arr
    #DONE
    #raise NotImplementedError.new("You need to implement the map method!")
  end

  def map! &block
    i = 0
    while i < @internal_arr.size
      @internal_arr[i] = yield(@internal_arr[i])
      i+=1
    end

    #DONE
    #raise NotImplementedError.new("You need to implement the map! method!")
  end

  def find &block
    i=0
    until i == @internal_arr.size 
      if yield(@internal_arr[i])
        return @internal_arr[i] 
      else
        i+=1
      end
    end

    return nil
    
    raise NotImplementedError.new("You need to implement the find method!")
  end

  def inject acc=nil, &block
    # if acc == nil
    #   acc = @[0]
    #Can be re-written to take advantage of the nil case
    #Code already passes nil cases with array of integers and array of strings

    self.each { |x| acc = yield(acc, x) }
    return acc
    #raise NotImplementedError.new("You need to implement the inject method!")
  end
end
