# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class PermissionTemplate < Base
      MAIN_PARAMS = %i[nil].freeze
      no_support_for %i[update destroy reload_data]
    end
  end
end
