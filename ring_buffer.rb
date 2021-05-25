class RingBuffer
  def initialize(capacity:)
    @arr = Array.new(capacity)
    @start = 0
    @end = 0

    raise ArgumentError if capacity < 1
  end
end

