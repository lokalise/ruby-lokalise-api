# frozen_string_literal: true

module RubyLokaliseApi
  module Concerns
    # Allows to undefine certain methods
    module Unsupportable
      def no_support_for(methods)
        return unless methods.any?

        methods.each do |method|
          undef_method(method)
        end
      end
    end
  end
end
