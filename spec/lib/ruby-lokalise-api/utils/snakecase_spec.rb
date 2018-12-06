RSpec.describe String do
  describe '#snakecase' do
    let(:result) { 'snake_case' }

    it 'should convert the string properly' do
      expect('SnakeCase'.snakecase).to eq result
      expect('Snake-Case'.snakecase).to eq result
      expect('Snake Case'.snakecase).to eq result
      expect('Snake  -  Case'.snakecase).to eq result
    end
  end

  describe '#base_class_name' do
    let(:result) { 'Klass' }

    it 'should convert classes with namespaces to base class names' do
      expect('Namespace::Nested::Klass'.base_class_name).to eq result
      expect('Nested::Klass'.base_class_name).to eq result
      expect('Klass'.base_class_name).to eq result
    end
  end
end
