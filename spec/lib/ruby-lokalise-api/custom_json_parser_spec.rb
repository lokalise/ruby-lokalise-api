require 'oj'

RSpec.describe 'Custom JSON parser' do
  let(:loaded_json) do
    {'projects' => [{'project_id' => '547879415c01a0e6e0b855.29978928',
                     'name' => 'demo phoenix copy',
                     'description' => '',
                     'created_at' => '2018-11-30 20:43:18 (Etc/UTC)',
                     'created_by' => 20_181,
                     'created_by_email' => 'bodrovis@protonmail.com',
                     'team_id' => 176_692,
                     'statistics' =>
           {'progress' => 0,
            'keys' => 1,
            'team' => 1,
            'base_words' => 0,
            'qa_issues' => 1,
            'languages' =>
              [{'language_id' => 640, 'language_iso' => 'en', 'progress' => 0, 'words_to_do' => 0},
               {'language_id' => 597, 'language_iso' => 'ru', 'progress' => 0, 'words_to_do' => 0},
               {'language_id' => 673, 'language_iso' => 'f_over', 'progress' => 0, 'words_to_do' => 0}]}}]}
  end

  let(:dumped_json) do
    '{":name":"rspec proj",":description":"demo project for rspec"}'
  end

  before :all do
    module Lokalise
      module JsonHandler
        def custom_dump(obj)
          Oj.dump obj
        end

        def custom_load(obj)
          Oj.load obj
        end
      end
    end
  end

  after :all do
    module Lokalise
      module JsonHandler
        def custom_dump(obj)
          JSON.dump obj
        end

        def custom_load(obj)
          JSON.parse obj
        end
      end
    end
  end

  it 'should allow to customize #load' do
    expect(Oj).to receive(:load).and_return(loaded_json)
    expect(JSON).not_to receive(:parse)
    projects = VCR.use_cassette('all_projects_pagination') do
      test_client.projects limit: 1, page: 2
    end

    expect(projects.collection.count).to eq(1)
    expect(projects.total_results).to eq(5)
    expect(projects.collection.first.name).to eq('demo phoenix copy')
  end

  it 'should allow to customize #dump' do
    expect(Oj).to receive(:dump).and_return(dumped_json)
    expect(JSON).not_to receive(:dump)
    project = VCR.use_cassette('new_project') do
      test_client.create_project name: 'rspec proj', description: 'demo project for rspec'
    end

    expect(project.name).to eq('rspec proj')
  end
end
