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
    @last = 0
  end

  def push(item)
    if contains_nil?
      point = @arr.index(nil)
      point.nil? ? update_last : @next = point
    end

    @arr[@next] = item
    advance_next
    @arr
  end

  def pop
    return nil if empty?

    popped = @arr[@last]
    @arr[@last] = nil
    advance_last
    popped
  end

  private

  def empty?
    @arr.all?(&:nil?)
  end

  def contains_nil?
    @arr.index(nil)
  end

  # TODO: Refactor these into a `#advance_pointer`
  def advance_next
    if @next < @capacity - 1
      @next += 1
    else
      @next = 0
    end
  end

  def advance_last
    if @last < @capacity - 1
      @last += 1
    else
      @last = 0
    end
  end
end
