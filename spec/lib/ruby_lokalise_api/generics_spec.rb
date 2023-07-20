# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Generics do
  let(:generic) { described_class.new(answer: 42) }

  it 'responds to the initialized methods' do
    expect(generic).to respond_to(:answer)
  end

  it 'does not respond to the uninitialized methods' do
    expect(generic).not_to respond_to(:wrong_reader)
  end

  specify '#[]' do
    expect(generic[:answer]).to eq(42)
    expect(generic['answer']).to eq(42)
    expect(generic['wrong_attr']).to be_nil
    expect(generic[:wrong_attr]).to be_nil
  end
end
