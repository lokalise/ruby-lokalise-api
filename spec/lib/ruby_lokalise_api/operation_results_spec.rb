# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::OperationResults do
  let(:op_result) { described_class.new(answer: 42) }

  it 'responds to the initialized methods' do
    expect(op_result).to respond_to(:answer)
  end

  it 'does not respond to the uninitialized methods' do
    expect(op_result).not_to respond_to(:wrong_reader)
  end

  specify '#[]' do
    expect(op_result[:answer]).to eq(42)
    expect(op_result['answer']).to eq(42)
    expect(op_result['wrong_attr']).to be_nil
    expect(op_result[:wrong_attr]).to be_nil
  end
end
