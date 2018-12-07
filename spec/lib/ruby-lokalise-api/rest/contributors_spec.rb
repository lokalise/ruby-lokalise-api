RSpec.describe Lokalise::Client do
  let(:project_id) { '803826145ba90b42d5d860.46800099' }
  let(:contributor_id) { 25_953 }

  describe '#contributors' do
    it 'should return all contributors' do
      contributors = VCR.use_cassette('all_contributors') do
        test_client.contributors project_id
      end.collection

      expect(contributors.count).to eq(2)
      expect(contributors.first.fullname).to eq('John Doe')
    end

    it 'should support pagination' do
      contributors = VCR.use_cassette('all_contributors_pagination') do
        test_client.contributors project_id, limit: 1, page: 2
      end

      expect(contributors.collection.count).to eq(1)
      expect(contributors.total_results).to eq(2)
      expect(contributors.total_pages).to eq(2)
      expect(contributors.results_per_page).to eq(1)
      expect(contributors.current_page).to eq(2)
    end
  end

  specify '#contributor' do
    contributor = VCR.use_cassette('contributor') do
      test_client.contributor project_id, '20181'
    end

    expect(contributor.user_id).to eq(20_181)
    expect(contributor.email).to eq('bodrovis@protonmail.com')
    expect(contributor.fullname).to eq('Ilya')
    expect(contributor.created_at).to eq('2018-08-21 17:35:25 (Etc/UTC)')
    expect(contributor.is_admin).to eq(true)
    expect(contributor.is_reviewer).to eq(true)
    expect(contributor.languages.first['lang_id']).to eq(640)
    expect(contributor.admin_rights.first).to eq('upload')
  end

  specify '#create_contributors' do
    contributor = VCR.use_cassette('create_contributors') do
      test_client.create_contributors project_id,
                                      email: 'rspec@test.com',
                                      fullname: 'Rspec test',
                                      languages: [{
                                        lang_iso: 'en'
                                      },
                                                  {
                                                    lang_iso: 'ru'
                                                  }]
    end.collection.first

    expect(contributor.fullname).to eq('Rspec test')
    expect(contributor.email).to eq('rspec@test.com')
    expect(contributor.languages[1]['lang_iso']).to eq('ru')
  end

  specify '#update_contributor' do
    contributor = VCR.use_cassette('update_contributor') do
      test_client.update_contributor project_id, contributor_id,
                                     languages: [{lang_iso: 'en'}]
    end

    expect(contributor.user_id).to eq(contributor_id)
    expect(contributor.languages[0]['lang_iso']).to eq('en')
    expect(contributor.languages.length).to eq(1)
  end

  specify '#delete_contributor' do
    response = VCR.use_cassette('delete_contributor') do
      test_client.delete_contributor project_id, contributor_id
    end
    expect(response['project_id']).to eq(project_id)
    expect(response['contributor_deleted']).to eq(true)
  end
end
