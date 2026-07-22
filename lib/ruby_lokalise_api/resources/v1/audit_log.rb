# frozen_string_literal: true

module RubyLokaliseApi
  module Resources
    module V1
      class AuditLog < ::RubyLokaliseApi::Resources::Base
        MAIN_PARAMS = %i[class_uid].freeze
        no_support_for %i[update destroy reload_data]
      end
    end
  end
end
