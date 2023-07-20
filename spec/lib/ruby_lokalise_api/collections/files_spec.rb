# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Files do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:pagination_params) { { page: 1, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '4',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '1'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/files",
      req: { query: pagination_params },
      resp: {
        body: fixture('files/files_page1'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/files",
      req: { query: pagination_params.merge(page: 2) },
      resp: {
        body: fixture('files/files_page2'),
        headers: pagination_headers.merge('x-pagination-page': 2)
      }
    )

    files = test_client.files project_id, pagination_params

    expect(files.collection.length).to eq(2)
    expect_to_have_valid_resources(files)
    expect(files[0].file_id).to eq(1_642_774)
    expect(files.next_page?).to be true
    expect(files.prev_page?).to be false

    next_page_files = files.next_page

    expect(next_page_files).to be_an_instance_of(described_class)
    expect(next_page_files[0].project_id).to eq(project_id)
    expect(next_page_files.next_page?).to be false
    expect(next_page_files.prev_page?).to be true
  end
end
