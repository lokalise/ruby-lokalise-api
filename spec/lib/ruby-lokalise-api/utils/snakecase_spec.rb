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
end
