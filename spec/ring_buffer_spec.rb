require_relative '../ring_buffer.rb'

RSpec.describe RingBuffer do
  describe '.new' do
    subject(:result) { described_class.new(capacity: capacity) }

    context 'with a valid capacity' do
      let(:capacity) { 4 }

      it { is_expected.to be_a(RingBuffer) }

      it 'does not raise an exception' do
        expect { result }.to_not raise_error
      end

      it 'creates an empty array the with the same length as the given capacity' do
        expect(result.instance_variable_get(:@arr)).to eq([nil, nil, nil, nil])
      end
    end

    context 'with an invalid capacity' do
      let(:capacity) {0}
      it 'raises an ArgumentError' do
        expect { result }.to raise_error(ArgumentError)
      end
    end
  end

  describe '.push' do
    subject(:result) { ring.push('A')}

    let(:ring) { described_class.new(capacity: 4)}

    it{ is_expected.to be_an(Array) }

    it 'updates @arr' do
      result
      expect(ring.instance_variable_get(:@arr)).to eq ['A', nil, nil, nil]
    end

    it 'increments @newest by one' do
      result
      expect(ring.instance_variable_get(:@next)).to eq 1
    end

    context 'with an empty array' do
      it 'returns the modified array' do
        expect(result).to eq(['A', nil, nil, nil])
      end
    end

    context 'with a partially-filled array' do
      before do
        ring.instance_variable_set(:@arr, [1, nil, 3, nil])
      end

      it 'fills the first empty space' do
        expect(result).to eq([1, "A", 3, nil])
      end
    end

    context 'with a full array' do
      before do
        ring.instance_variable_set(:@arr, [4, 1, 2, 3])
        ring.instance_variable_set(:@next, 1)
      end

      it 'overwrites the oldest space' do
        expect(result).to eq([4, "A", 2, 3])
      end
    end
  end

end
