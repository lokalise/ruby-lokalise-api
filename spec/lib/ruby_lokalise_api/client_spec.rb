# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Client do
  context 'with API errors' do
    it 'raises BadRequest when API token is invalid' do
      token = 'fake token'

      stub(
        uri: 'projects',
        req: { token: token },
        resp: {
          body: fixture('errors/invalid_token'),
          code: 400
        }
      )

      expect do
        test_client(token).projects
      end.to raise_error(RubyLokaliseApi::Error::BadRequest, /Invalid `X-Api-Token` header/)
    end

    it 'raises NotFound when the URL is invalid' do
      project_id = '88628569645b945648b474.25982965'
      fake_contributor_id = '123'

      stub(
        uri: "projects/#{project_id}/contributors/#{fake_contributor_id}",
        resp: {
          body: fixture('errors/not_found'),
          code: 404
        }
      )

      expect do
        test_client.contributor(project_id, fake_contributor_id)
      end.to raise_error(RubyLokaliseApi::Error::NotFound, /Not Found/)
    end
  end
end
