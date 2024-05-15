# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Keys do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:params) { { page: 2, limit: 3, include_comments: 0, include_translations: 0 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '5',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '3',
      'x-pagination-page': '2'
    }
  end
  let(:cursor_params) do
    {
      cursor: 'eyIxIjozMTk3ODIzNzJ9',
      pagination: 'cursor',
      limit: 2
    }
  end
  let(:cursor_headers) do
    {
      'x-pagination-limit': cursor_params[:limit],
      'x-pagination-next-cursor': 'eyIxIjozMTk3ODIzNzV9'
    }
  end

  it 'supports cursor pagination' do
    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: cursor_params },
      resp: {
        body: fixture('keys/keys_cursor_1'),
        headers: cursor_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: cursor_params.merge(cursor: 'eyIxIjozMTk3ODIzNzV9') },
      resp: {
        body: fixture('keys/keys_cursor_2'),
        headers: cursor_headers.merge('x-pagination-next-cursor': 'eyIxIjozMjQ3MjkyMTd9')
      }
    )

    keys = test_client.keys project_id, cursor_params

    expect(keys.collection.length).to eq(2)
    expect(keys[0].key_id).to eq(319_782_369)
    expect_to_have_valid_resources(keys)
    expect(keys.next_page?).to be false
    expect(keys.prev_page?).to be false
    expect(keys.next_cursor?).to be true
    expect(keys.next_cursor).to eq('eyIxIjozMTk3ODIzNzV9')

    expect(keys.prev_page).to be_nil
    expect(keys.next_page).to be_nil

    next_cursor_keys = keys.load_next_cursor
    expect(next_cursor_keys.collection.length).to eq(2)
    expect(next_cursor_keys[0].key_id).to eq(319_782_375)
    expect(next_cursor_keys.next_page?).to be false
    expect(next_cursor_keys.prev_page?).to be false
    expect(next_cursor_keys.next_cursor?).to be true
    expect(next_cursor_keys.next_cursor).to eq('eyIxIjozMjQ3MjkyMTd9')
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: params },
      resp: {
        body: fixture('keys/keys_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/keys",
      req: { query: params.merge(page: 1) },
      resp: {
        body: fixture('keys/keys_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    keys = test_client.keys project_id, params

    expect(keys.collection.length).to eq(2)
    expect(keys[0].key_id).to eq(319_782_375)
    expect_to_have_valid_resources(keys)
    expect(keys.next_page?).to be false
    expect(keys.prev_page?).to be true
    expect(keys.next_cursor?).to be false

    prev_page_keys = keys.prev_page

    expect(prev_page_keys).to be_an_instance_of(described_class)
    expect(prev_page_keys[0].key_id).to eq(319_782_369)
    expect(prev_page_keys.next_page?).to be true
    expect(prev_page_keys.prev_page?).to be false
  end
end
