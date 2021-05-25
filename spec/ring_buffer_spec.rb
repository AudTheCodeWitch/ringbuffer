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

end
