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

  def each_with_index &block
    i = 0
    until i == @internal_arr.size
      yield(@internal_arr[i]); i
      i+=1
    end
    return @internal_arr
  end
  # Not there yet...try again later...rethink what .each_with_index is supposed to do.  Pass both index and value (like hash) into &block.
  # Works...kinda.  Make sure tests are accurate tests for each_with_index method
  # Really understand what is happening and why (and how)

  def each &block
    i = 0
    until i == @internal_arr.size
      yield @internal_arr[i]
      i+=1
    end
    return @internal_arr
  end

  def map &block
    new_arr = []
    self.each { |x| new_arr << yield(x) }
    return new_arr
  end

  def map! &block
    i = 0
    while i < @internal_arr.size
      @internal_arr[i] = yield(@internal_arr[i])
      i+=1
    end
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

  end

  def inject acc=nil, &block
    if acc.nil?
      acc = @internal_arr[0]
      i = 1
      until i == @internal_arr.size
        acc = yield(acc, @internal_arr[i])
        i+=1
      end
      return acc
    else
      self.each { |x| acc = yield(acc, x) }
      return acc
    end
  end

end

#following code copied from HipChat from Stuart => GENIOUS!!!
# def inject acc=nil, &block

#   if acc.class == Symbol
#     # if acc is a symbol, then that's the method we'll use to accumulate
#     op = acc
#     start_value = @internal_arr.shift
#     acc = start_value
#     self.each { | ele | acc = acc.send(op, ele)}
#     @internal_arr.unshift(start_value)

#   elsif acc == nil
#     # if acc is nil, then set it to the first value in the arr
#     start_value = @internal_arr.shift
#     acc = start_value
#     self.each { |ele| acc = yield(acc, ele) }
#     @internal_arr.unshift(start_value)

#   else
#     # Acc is set to the first value of @internal_arr
#     self.each { |ele| acc = yield(acc, ele) }
#   end

#   acc
    
#   end