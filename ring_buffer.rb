# initialize a ring buffer
# implement puts(item)
# implement pop

class RingBuffer
  def initialize(capacity:)
    @arr = Array.new(capacity)
    @capacity = capacity
    @next = 0
    @last = 0

    raise ArgumentError if capacity < 1
  end

  def push(item)
    if has_nil?
      point = @arr.index(nil)
      point.nil? ? update_last : @next = point
    end

    @arr[@next] = item
    update_next
    @arr
  end

end

private

def has_nil?
  @arr.index(nil)
end

# TODO: Refactor these into a `#update_pointer`
def update_next
  if @next < @capacity - 1
    @next += 1
  else
    @next = 0
  end
end

