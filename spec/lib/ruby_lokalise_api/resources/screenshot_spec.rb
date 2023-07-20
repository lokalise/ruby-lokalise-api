# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Screenshot do
  let(:project_id) { '88628569645b945648b474.25982965' }

  let(:loaded_screen_fixture) { loaded_fixture('screenshots/screenshot') }

  let(:screen_id) { loaded_screen_fixture['screenshot']['screenshot_id'] }

  let(:screen_endpoint) do
    endpoint name: 'Screenshots', client: test_client, params: { query: [project_id, screen_id] }
  end

  let(:screen) do
    resource 'Screenshot', response(loaded_screen_fixture, screen_endpoint)
  end

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/screenshots/#{screen_id}",
      resp: { body: fixture('screenshots/screenshot') }
    )

    reloaded_screen = screen.reload_data

    expect(reloaded_screen.screenshot_id).to eq(screen_id)
  end

  specify '#update' do
    screenshot_data = {
      title: 'Ruby updated',
      tags: %w[one two]
    }

    stub(
      uri: "projects/#{project_id}/screenshots/#{screen_id}",
      req: { body: screenshot_data, verb: :put },
      resp: { body: fixture('screenshots/update_screenshot') }
    )

    updated_screen = screen.update screenshot_data

    expect(updated_screen).to be_an_instance_of(described_class)
    expect(updated_screen.title).to eq(screenshot_data[:title])
    expect(updated_screen.screenshot_tags).to include(*screenshot_data[:tags])
    expect(updated_screen.screenshot_id).to eq(screen_id)
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/screenshots/#{screen_id}",
      req: { verb: :delete },
      resp: { body: fixture('screenshots/destroy_screenshot') }
    )

    resp = screen.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.branch).to eq('master')
    expect(resp.screenshot_deleted).to be true
  end
end
