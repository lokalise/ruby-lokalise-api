# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Screenshots do
  let(:project_id) { '88628569645b945648b474.25982965' }
  let(:screenshot_id) { 2_858_588 }

  specify '#screenshots' do
    stub(
      uri: "projects/#{project_id}/screenshots",
      resp: { body: fixture('screenshots/screenshots') }
    )

    screenshots = test_client.screenshots project_id

    expect(screenshots.collection.length).to eq(3)
    expect_to_have_valid_resources(screenshots)
    expect(screenshots.project_id).to eq(project_id)
    expect(screenshots.branch).to eq('master')

    screenshot = screenshots[0]

    expect(screenshot.screenshot_id).to eq(2_858_588)
  end

  specify '#screenshot' do
    stub(
      uri: "projects/#{project_id}/screenshots/#{screenshot_id}",
      resp: { body: fixture('screenshots/screenshot') }
    )

    screenshot = test_client.screenshot project_id, screenshot_id

    expect(screenshot.project_id).to eq(project_id)
    expect(screenshot.branch).to eq('master')
    expect(screenshot.screenshot_id).to eq(screenshot_id)
    expect(screenshot.key_ids).to include(319_782_369)
    expect(screenshot.keys[0]['key_id']).to eq(319_782_369)
    expect(screenshot.url).to include('lokalise-live-lok-app-main-assets')
    expect(screenshot.title).to eq('Registration')
    expect(screenshot.description).to eq('')
    expect(screenshot.screenshot_tags).to eq([])
    expect(screenshot.width).to eq(572)
    expect(screenshot.height).to eq(438)
    expect(screenshot.created_at).to eq('2023-04-18 16:52:10 (Etc/UTC)')
    expect(screenshot.created_at_timestamp).to eq(1_681_836_730)
  end

  specify '#create_screenshots' do
    screenshots_data = screenshot_from_file do |file|
      [
        data: file.read,
        title: 'Ruby',
        description: 'SDK'
      ]
    end

    stub(
      uri: "projects/#{project_id}/screenshots",
      req: { body: { screenshots: screenshots_data }, verb: :post },
      resp: { body: fixture('screenshots/create_screenshots') }
    )

    screenshots = test_client.create_screenshots project_id, screenshots_data

    expect(screenshots).to be_an_instance_of(RubyLokaliseApi::Collections::Screenshots)
    expect_to_have_valid_resources(screenshots)

    expect(screenshots.project_id).to eq(project_id)
    expect(screenshots.branch).to eq('master')
    expect(screenshots.errors).to eq([])
    expect(screenshots[0].screenshot_id).to eq(3_195_031)
    expect(screenshots[0].project_id).to eq(project_id)
  end

  specify '#update_screenshot' do
    screenshot_data = {
      title: 'Ruby updated',
      tags: %w[one two]
    }

    stub(
      uri: "projects/#{project_id}/screenshots/#{screenshot_id}",
      req: { body: screenshot_data, verb: :put },
      resp: { body: fixture('screenshots/update_screenshot') }
    )

    screenshot = test_client.update_screenshot project_id, screenshot_id, screenshot_data

    expect(screenshot).to be_an_instance_of(RubyLokaliseApi::Resources::Screenshot)
    expect(screenshot.title).to eq(screenshot_data[:title])
    expect(screenshot.screenshot_tags).to include(*screenshot_data[:tags])
    expect(screenshot.screenshot_id).to eq(screenshot_id)
  end

  specify '#destroy_screenshot' do
    delete_screen_id = 3_195_031
    stub(
      uri: "projects/#{project_id}/screenshots/#{delete_screen_id}",
      req: { verb: :delete },
      resp: { body: fixture('screenshots/destroy_screenshot') }
    )

    resp = test_client.destroy_screenshot project_id, delete_screen_id

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.screenshot_deleted).to be true
  end
end

def screenshot_from_file
  file = File.open File.expand_path('spec/fixtures/screenshots/screenshot_base64.txt')
  begin
    yield file
  rescue StandardError => e
    puts e
  ensure
    file.close
  end
end
