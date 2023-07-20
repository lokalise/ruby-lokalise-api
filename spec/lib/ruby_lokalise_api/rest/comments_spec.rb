# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::Comments do
  let(:project_id) { '20603843642073fe124fb8.14291681' }
  let(:key_id) { 301_832_195 }
  let(:comment_id) { 16_588_650 }

  specify '#comment' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_id}",
      resp: { body: fixture('comments/comment') }
    )

    comment = test_client.comment(project_id, key_id, comment_id)

    expect(comment.project_id).to eq(project_id)
    expect(comment.comment_id).to eq(comment_id)
    expect(comment.key_id).to eq(key_id)
    expect(comment.comment).to eq('<p>Hi!</p>')
    expect(comment.added_by).to eq(20_181)
    expect(comment.added_by_email).to eq('bodrovis@protonmail.com')
    expect(comment.added_at).to eq('2023-04-21 14:11:11 (Etc/UTC)')
    expect(comment.added_at_timestamp).to eq(1_682_086_271)
  end

  specify '#comments' do
    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments",
      resp: { body: fixture('comments/comments') }
    )

    comments = test_client.comments project_id, key_id
    expect(comments.collection.length).to eq(3)
    expect_to_have_valid_resources(comments)
    expect(comments.project_id).to eq(project_id)
    expect(comments.branch).to be_nil

    comment = comments[0]

    expect(comment.comment_id).to eq(16_588_650)
    expect(comment.project_id).to eq(project_id)
  end

  specify '#project_comments' do
    stub(
      uri: "projects/#{project_id}/comments",
      resp: { body: fixture('comments/project_comments') }
    )

    comments = test_client.project_comments project_id
    expect_to_have_valid_resources(comments)
    expect(comments.project_id).to eq(project_id)
    expect(comments.branch).to be_nil

    comment = comments[0]

    expect(comment.comment_id).to eq(16_588_650)
    expect(comment.project_id).to eq(project_id)
  end

  describe '#create_comments' do
    it 'creates one comment' do
      comment_data = { comment: 'A single Ruby comment' }
      params = { comments: [comment_data] }

      stub(
        uri: "projects/#{project_id}/keys/#{key_id}/comments",
        req: { body: params, verb: :post },
        resp: { body: fixture('comments/single_created_comment') }
      )

      comments = test_client.create_comments project_id, key_id, comment_data

      expect(comments).to be_an_instance_of(RubyLokaliseApi::Collections::KeyComments)
      expect(comments.collection.length).to eq(1)
      expect_to_have_valid_resources(comments)

      comment = comments[0]

      expect(comment.project_id).to eq(project_id)
      expect(comment.comment).to eq(comment_data[:comment])
    end

    it 'creates multiple comments' do
      comment_data = [{ comment: 'Comment1' }, { comment: 'Comment2' }]

      params = { comments: comment_data }

      stub(
        uri: "projects/#{project_id}/keys/#{key_id}/comments",
        req: { body: params, verb: :post },
        resp: { body: fixture('comments/multiple_created_comments') }
      )

      comments = test_client.create_comments project_id, key_id, comment_data

      expect(comments).to be_an_instance_of(RubyLokaliseApi::Collections::KeyComments)
      expect(comments.collection.length).to eq(2)
      expect_to_have_valid_resources(comments)

      comment = comments[0]

      expect(comment.project_id).to eq(project_id)
      expect(comment.comment).to eq(comment_data[0][:comment])
    end
  end

  specify '#destroy_comment' do
    comment_to_delete = 16_784_635

    stub(
      uri: "projects/#{project_id}/keys/#{key_id}/comments/#{comment_to_delete}",
      req: { verb: :delete },
      resp: { body: fixture('comments/destroy_comment') }
    )

    resp = test_client.destroy_comment(project_id, key_id, comment_to_delete)

    expect(resp).to be_an_instance_of(RubyLokaliseApi::Generics::DeletedResource)
    expect(resp.project_id).to eq(project_id)
    expect(resp.comment_deleted).to be true
  end
end
