# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::PermissionTemplates do
  let(:team_id) { 176_692 }

  specify '#permission_templates' do
    stub(
      uri: "teams/#{team_id}/roles",
      resp: { body: fixture('permission_templates/list') }
    )

    permission_templates = test_client.permission_templates team_id

    expect(permission_templates.collection.length).to eq(5)
    expect(permission_templates).to be_an_instance_of(RubyLokaliseApi::Collections::PermissionTemplates)

    template = permission_templates[0]

    expect(template.id).to eq(1)
    expect(template.role).to eq('Manager')
    expect(template.permissions).to include('branches_main_modify')
    expect(template.description).to include('Manage project settings')
    expect(template.tag).to eq('Full access')
    expect(template.tagColor).to eq('green')
    expect(template.tagInfo).to be_nil
    expect(template.doesEnableAllReadOnlyLanguages).to be true
  end
end
