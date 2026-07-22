# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Rest::V1::AuditLogs do
  describe '#audit_logs' do
    it 'requests audit logs' do
      stub(
        uri: 'audit-logs',
        req: {
          base_url: 'https://api.lokalise.com/v1'
        },
        resp: { body: fixture('audit_logs/list') }
      )

      logs = test_client_v1.audit_logs

      expect(logs.collection.length).to eq(2)
      expect(logs).to be_an_instance_of(RubyLokaliseApi::Collections::V1::AuditLogs)

      expect_to_have_valid_resources_v1(logs)

      expect(logs.next_cursor?).to be true
      expect(logs.has_more).to be true
      expect(logs.next_cursor).to eq('eyJpZCI6IjY5YjQxNTg4ZGExMDM1MTkyMDBkZTg2YSJ9')

      log = logs[0]

      expect(log.class_uid).to eq(6003)
      expect(log.class_name).to eq('API Activity')
      expect(log.category_uid).to eq(6)
      expect(log.category_name).to eq('Application Activity')
      expect(log.activity_id).to eq(99)
      expect(log.activity_name).to eq('Other')
      expect(log.type_uid).to eq(600_399)
      expect(log.severity_id).to eq(1)
      expect(log.severity).to eq('Informational')
      expect(log.status_id).to eq(1)
      expect(log.status).to eq('Success')
      expect(log.time).to eq(1_753_267_304)

      expect(log.metadata['event_code']).to eq('project.deleted')
      expect(log.metadata['version']).to eq('1.3.0')

      expect(log.actor.dig('user', 'uid')).to eq('20181')
      expect(log.src_endpoint['ip']).to eq('1.1.1.1')
      expect(log.http_request.dig('url', 'url_string')).to eq(
        'https://app.lokalise.com/project/delete'
      )

      expect(log.enrichments.map { |item| item['name'] }).to eq(
        %w[team project]
      )

      expect(log.unmapped['event_type_id']).to eq(1006)
    end

    it 'requests audit logs with params' do
      cursor_params = {

        limit: 2
      }

      stub(
        uri: 'audit-logs',
        req: {
          base_url: 'https://api.lokalise.com/v1',
          query: cursor_params
        },
        resp: { body: fixture('audit_logs/list_params') }
      )

      logs = test_client_v1.audit_logs cursor_params

      expect(logs.collection.length).to eq(2)
      expect(logs).to be_an_instance_of(RubyLokaliseApi::Collections::V1::AuditLogs)

      expect_to_have_valid_resources_v1(logs)

      expect(logs.next_cursor?).to be false
      expect(logs.has_more).to be false
      expect(logs.next_cursor).to eq('')

      log = logs[0]

      expect(log.class_uid).to eq(6003)
      expect(log.class_name).to eq('API Activity')
    end
  end
end
