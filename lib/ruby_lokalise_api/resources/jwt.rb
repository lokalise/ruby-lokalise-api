# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    class Jwt < Base
      MAIN_PARAMS = :project_id
      no_support_for %i[update destroy reload_data]
    end
  end
end
