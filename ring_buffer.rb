# frozen_string_literal: true

# Challenge requirements:
# initialize a ring buffer
# implement puts(item)
# implement pop

# Creates a RingBuffer object
class RingBuffer
  def initialize(capacity:)
    raise ArgumentError if capacity < 1

    @arr = Array.new(capacity)
    @capacity = capacity
    @next = 0
    @oldest = 0
  end

  def push(item)
    full? ? @oldest = advance_pointer(@oldest) : @next = @arr.index(nil)

    @arr[@next] = item
    @next = advance_pointer(@next)
    @arr
  end

  def pop
    return nil if empty?

    popped = @arr[@oldest]
    @arr[@oldest] = nil
    @oldest = advance_pointer(@oldest)
    popped
  end

  private

  def empty?
    @arr.all?(&:nil?)
  end

  def full?
    @arr.none?(&:nil?)
  end

  def advance_pointer(pointer)
    pointer < @capacity - 1 ? pointer + 1 : 0
  end
end
