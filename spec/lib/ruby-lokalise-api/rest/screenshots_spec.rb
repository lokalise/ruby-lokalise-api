RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:screenshot_id) { 115185 }

  describe '#screenshots' do
    it 'should return all screenshots' do
      screenshots = VCR.use_cassette('all_screenshots') do
        test_client.screenshots project_id
      end.collection

      expect(screenshots.count).to eq(1)
    end

    it 'should support pagination' do
      screenshots = VCR.use_cassette('all_screenshots_pagination') do
        test_client.screenshots project_id, limit: 1, page: 1
      end

      expect(screenshots.collection.count).to eq(1)
      expect(screenshots.total_results).to eq(1)
      expect(screenshots.total_pages).to eq(1)
      expect(screenshots.results_per_page).to eq(1)
      expect(screenshots.current_page).to eq(1)
    end
  end

  specify '#screenshot' do
    screenshot = VCR.use_cassette('screenshot') do
      test_client.screenshot project_id, screenshot_id
    end

    expect(screenshot.screenshot_id).to eq(screenshot_id)
    expect(screenshot.key_ids).to eq([])
    expect(screenshot.url).to include('amazonaws.com')
    expect(screenshot.title).to eq('rspec screen')
    expect(screenshot.description).to eq('')
    expect(screenshot.screenshot_tags).to eq([])
    expect(screenshot.width).to eq(125)
    expect(screenshot.height).to eq(32)
  end

  specify '#create_screenshots' do
    file = File.open File.expand_path('spec/fixtures/screenshot_base64.txt')
    begin
      screenshot = VCR.use_cassette('create_screenshots') do
        test_client.create_screenshots project_id, data: file.read, title: 'rspec screen'
      end.collection.first

      expect(screenshot.title).to eq('rspec screen')
      expect(screenshot.url).to include('amazonaws.com')
    rescue => e
      puts e
    ensure
      file.close
    end
  end

  specify '#update_screenshot' do
    screenshot = VCR.use_cassette('update_screenshot') do
      test_client.update_screenshot project_id, screenshot_id, tags: %w(demo rspec),
                                    description: 'demo desc'
    end

    expect(screenshot.screenshot_id).to eq(screenshot_id)
    expect(screenshot.screenshot_tags).to eq(%w(demo rspec))
    expect(screenshot.description).to eq('demo desc')
  end

  specify '#delete_screenshot' do
    response = VCR.use_cassette('delete_screenshot') do
      test_client.delete_screenshot project_id, screenshot_id
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['screenshot_deleted']).to eq(true)
  end
end
