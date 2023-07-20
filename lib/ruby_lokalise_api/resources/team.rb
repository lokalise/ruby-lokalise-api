# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Team < Base
      MAIN_PARAMS = [].freeze
      no_support_for %i[update destroy reload_data]
    end
  end
end
