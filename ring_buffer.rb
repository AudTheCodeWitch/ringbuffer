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

  def pop
    return nil if empty?
    popped = @arr[@last]
    @arr[@last] = nil
    update_last
    popped
  end

  private

  def empty?
    @arr.all?(&:nil?)
  end

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

  def update_last
    if @last < @capacity - 1
      @last += 1
    else
      @last = 0
    end
  end
end
