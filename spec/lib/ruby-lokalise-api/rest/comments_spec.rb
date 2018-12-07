RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:key_id) { 15_305_182 }

  describe '#comments' do
    it 'should return all comments' do
      comments = VCR.use_cassette('all_comments') do
        test_client.comments project_id, key_id
      end.collection

      comment = comments.first

      expect(comments.count).to eq(3)
      expect(comment.comment).to eq('test')
      expect(comment.comment_id).to eq(767_938)
      expect(comment.key_id).to eq(key_id)
      expect(comment.added_by).to eq(20_181)
      expect(comment.added_by_email).to eq('bodrovis@protonmail.com')
      expect(comment.added_at).to eq('2018-12-03 19:11:58 (Etc/UTC)')
    end

    it 'should support pagination' do
      comments = VCR.use_cassette('all_comments_pagination') do
        test_client.comments project_id, key_id, limit: 1, page: 2
      end

      expect(comments.collection.count).to eq(1)
      expect(comments.total_results).to eq(3)
      expect(comments.total_pages).to eq(3)
      expect(comments.results_per_page).to eq(1)
      expect(comments.current_page).to eq(2)
      expect(comments.collection.first.comment).to eq('demo comment')
    end
  end

  specify '#create_comments' do
    comments = VCR.use_cassette('create_comments') do
      test_client.create_comments project_id, key_id, [
        {comment: 'demo comment'},
        {comment: 'from rspec'}
      ]
    end

    first_comment = comments.collection.first
    second_comment = comments.collection[1]

    expect(comments.project_id).to eq(project_id)
    expect(first_comment.comment).to eq('demo comment')
    expect(first_comment.key_id).to eq(key_id)
    expect(second_comment.comment).to eq('from rspec')
    expect(second_comment.key_id).to eq(key_id)
  end

  specify '#project_comments' do
    comments = VCR.use_cassette('project_comments') do
      test_client.project_comments project_id
    end

    comment = comments.collection.first

    expect(comments.total_results).to eq(3)
    expect(comment.comment).to eq('test')
    expect(comment.comment_id).to eq(767_938)
  end

  specify '#delete_comment' do
    response = VCR.use_cassette('delete_comment') do
      test_client.delete_comment project_id, key_id, 767_938
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['comment_deleted']).to eq(true)
  end
end
