# frozen_string_literal: true

RSpec.describe String do
  let(:snake_result) { 'snake_case' }
  let(:bc_result) { 'Klass' }

  specify '#snakecase' do
    expect('SnakeCase'.snakecase).to eq snake_result
    expect('Snake-Case'.snakecase).to eq snake_result
    expect('Snake Case'.snakecase).to eq snake_result
    expect('Snake  -  Case'.snakecase).to eq snake_result
  end

  specify '#base_class_name' do
    expect('Namespace::Nested::Klass'.base_class_name).to eq bc_result
    expect('Nested::Klass'.base_class_name).to eq bc_result
    expect('Klass'.base_class_name).to eq bc_result
  end
end
