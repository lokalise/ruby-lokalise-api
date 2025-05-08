# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Team < Base
      MAIN_PARAMS = %i[team_id].freeze
      no_support_for %i[update destroy]
    end
  end
end
