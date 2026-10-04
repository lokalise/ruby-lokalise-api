# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::TranslationMemories do
  let(:project_id) { '7565202469c53c30428ce0.33693563' }

  specify '#translation_memories' do
    stub(
      uri: "projects/#{project_id}/translation-memories",
      resp: { body: fixture('translation_memories/translation_memories') }
    )

    memories = test_client.translation_memories project_id

    expect(memories.collection.length).to eq(3)
    expect(memories).to be_an_instance_of(RubyLokaliseApi::Collections::TranslationMemories)

    first_memory = memories[0]
    expect(first_memory).to be_an_instance_of(RubyLokaliseApi::Resources::TranslationMemory)
    expect(first_memory.name).to eq('Lokalise Translation Memory')

    expect(memories[1].id).to eq(2592)
  end
end
