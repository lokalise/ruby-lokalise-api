# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::Screenshots do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:pagination_params) { { page: 2, limit: 2 } }
  let(:pagination_headers) do
    {
      'x-pagination-total-count': '3',
      'x-pagination-page-count': '2',
      'x-pagination-limit': '2',
      'x-pagination-page': '2'
    }
  end

  it 'supports pagination' do
    stub(
      uri: "projects/#{project_id}/screenshots",
      req: { query: pagination_params },
      resp: {
        body: fixture('screenshots/screenshots_page2'),
        headers: pagination_headers
      }
    )

    stub(
      uri: "projects/#{project_id}/screenshots",
      req: { query: pagination_params.merge(page: 1) },
      resp: {
        body: fixture('screenshots/screenshots_page1'),
        headers: pagination_headers.merge('x-pagination-page': 1)
      }
    )

    screenshots = test_client.screenshots project_id, pagination_params

    expect(screenshots.collection.length).to eq(1)
    expect_to_have_valid_resources(screenshots)
    expect(screenshots.next_page?).to be false
    expect(screenshots.prev_page?).to be true

    prev_page_screenshots = screenshots.prev_page

    expect(prev_page_screenshots).to be_an_instance_of(described_class)
    expect(prev_page_screenshots[0].screenshot_id).to eq(2_858_588)
    expect(prev_page_screenshots.next_page?).to be true
    expect(prev_page_screenshots.prev_page?).to be false

    next_page_screenshots = prev_page_screenshots.next_page

    expect(next_page_screenshots).to be_an_instance_of(described_class)
  end
end
