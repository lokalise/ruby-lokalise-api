# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Utils::Classes do
  using described_class

  describe '#to_array_obj' do
    it 'returns an array with key' do
      obj1 = { name: 'test' }

      expect(obj1.to_array_obj(:parent)).to eq({ parent: [obj1] })
    end

    it 'keeps array intact' do
      obj1 = [{ name: 'test' }]

      expect(obj1.to_array_obj(:parent)).to eq({ parent: obj1 })
    end

    it 'hash with array intact' do
      obj1 = { parent: [{ name: 'test' }] }

      expect(obj1.to_array_obj(:parent)).to eq(obj1)
    end
  end
end
