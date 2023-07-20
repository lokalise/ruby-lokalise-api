# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class SystemLanguage < Base
      MAIN_PARAMS = [].freeze
      no_support_for %i[update destroy reload_data]
    end
  end
end
