# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::File do
  let(:loaded_files_fixture) { loaded_fixture('files/doc_files') }

  let(:project_id) { loaded_files_fixture['project_id'] }

  let(:files_endpoint) do
    endpoint name: 'Files', client: test_client, params: { query: [project_id] }
  end

  let(:files) do
    collection 'Files', response(loaded_files_fixture, files_endpoint)
  end

  let(:file) do
    files[1]
  end

  it 'does not support update' do
    expect(file).not_to respond_to(:update)
  end

  it 'does not support reload_data' do
    expect(file).not_to respond_to(:reload_data)
  end

  specify '#destroy' do
    stub(
      uri: "projects/#{project_id}/files/#{file.file_id}",
      req: { verb: :delete },
      resp: { body: fixture('files/destroy_file') }
    )

    resp = file.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.file_deleted).to be true
  end
end
