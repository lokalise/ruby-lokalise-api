# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Snapshots < Base
      ENDPOINT = RubyLokaliseApi::Endpoints::SnapshotsEndpoint
      RESOURCE = RubyLokaliseApi::Resources::Snapshot
    end
  end
end
