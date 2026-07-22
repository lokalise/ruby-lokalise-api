# frozen_string_literal: true

RSpec.describe RubyLokaliseApi::Collections::V1::AuditLogs do
  it 'supports cursor pagination' do
    cursor_params = {
      limit: 2
    }

    next_cursor = 'eyJpZCI6IjY5YjQxNTg4ZGExMDM1MTkyMDBkZTg2YSJ9'

    stub(
      uri: 'audit-logs',
      req: {
        base_url: 'https://api.lokalise.com/v1',
        query: cursor_params
      },
      resp: { body: fixture('audit_logs/list') }
    )

    stub(
      uri: 'audit-logs',
      req: {
        base_url: 'https://api.lokalise.com/v1',
        query: cursor_params.merge(cursor: next_cursor)
      },
      resp: {
        body: fixture('audit_logs/list_params')
      }
    )

    logs = test_client_v1.audit_logs cursor_params

    expect(logs.collection.length).to eq(2)
    expect(logs[0].class_uid).to eq(6003)
    expect_to_have_valid_resources_v1(logs)

    expect(logs.has_more).to be true
    expect(logs.next_cursor?).to be true
    expect(logs.next_cursor).to eq(next_cursor)

    next_cursor_logs = logs.load_next_cursor

    expect(next_cursor_logs.collection.length).to eq(2)

    expect(logs[0].class_uid).to eq(6003)

    expect(next_cursor_logs.next_cursor?).to be false
    expect(next_cursor_logs.has_more).to be false
    expect(next_cursor_logs.next_cursor).to eq('')
  end
end
