# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Resources::Comment do
  subject do
    described_class.new response(nil, nil)
  end

  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:key_id) { 301_832_195 }
  let(:comment_id) { 16_588_650 }

  it { is_expected.not_to respond_to(:update) }

  specify '#reload_data' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    comment = test_client.comment(project_id, key_id, comment_id)

    reloaded_comment = comment.reload_data

    expect(reloaded_comment.key_id).to eq(key_id)
  end

  specify '#destroy' do
    comment_to_delete = 16_784_634

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_to_delete}",
      resp: { body: fixture('comments/comment2') }
    )

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_to_delete}",
      req: { verb: :delete },
      resp: { body: fixture('comments/destroy_comment') }
    )

    comment = test_client.comment project_id, key_id, comment_to_delete

    resp = comment.destroy

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.comment_deleted).to be true
  end
end
