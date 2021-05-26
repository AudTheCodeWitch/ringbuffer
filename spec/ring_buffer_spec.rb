# frozen_string_literal: true

require_relative '../ring_buffer'

# rubocop:disable Metrics/BlockLength
RSpec.describe RingBuffer do
  describe '.new' do
    subject(:result) { described_class.new(capacity: capacity) }

    context 'with a valid capacity' do
      let(:capacity) { 4 }

      it { is_expected.to be_a(RingBuffer) }

      it 'does not raise an exception' do
        expect { result }.to_not raise_error
      end
    end

    context 'with an invalid capacity' do
      let(:capacity) { 0 }
      it 'raises an ArgumentError' do
        expect { result }.to raise_error(ArgumentError)
      end
    end
  end

  describe '#push' do
    subject(:result) { ring.push('A') }

    let(:ring) { described_class.new(capacity: 4) }

    it { is_expected.to be_an(Array) }

    it { is_expected.to eq(['A', nil, nil, nil]) }

    context 'with a partially-filled array' do
      before do
        build_ring_buffer_from_array([1, nil, 3, nil])
      end

      it 'fills the first empty space' do
        expect(result).to eq([1, 'A', 3, nil])
      end
    end

    context 'with a full array' do
      before do
        build_ring_buffer_from_array([4, 1, 2, 3])
        set_pointer(pointer: :@next, index: 1)
      end

      it 'overwrites the oldest space' do
        expect(result).to eq([4, 'A', 2, 3])
      end
    end
  end

  describe '#pop' do
    subject(:result) { ring.pop }

    let(:ring) { described_class.new(capacity: 4) }

    context 'with an empty array' do
      it 'returns nil' do
        expect(result).to eq(nil)
      end
    end

    context 'with a partially-filled array' do
      before do
        build_ring_buffer_from_array([1, 2, nil, 4])
        set_pointer(pointer: :@oldest, index: 3)
      end

      it 'removes the oldest space' do
        expect(result).to eq(4)
      end
    end

    context 'with a full array' do
      before do
        build_ring_buffer_from_array([1, 2, 3, 4])
        set_pointer(pointer: :@oldest, index: 2)
      end

      it 'removes the oldest space' do
        expect(result).to eq(3)
      end
    end
  end

  def build_ring_buffer_from_array(arr)
    ring.instance_variable_set(:@arr, arr)
  end

  def set_pointer(pointer:, index:)
    ring.instance_variable_set(pointer, index)
  end
end
# rubocop:enable Metrics/BlockLength
