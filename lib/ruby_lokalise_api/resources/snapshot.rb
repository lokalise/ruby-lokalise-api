# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Snapshot < Base
      MAIN_PARAMS = %i[project_id snapshot_id].freeze
      no_support_for %i[update reload_data]

      delegate_call :restore, :restore_snapshot
    end
  end
end
