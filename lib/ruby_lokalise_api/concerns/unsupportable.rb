# frozen_string_literal: true

module RubyLokaliseApi
  module Concerns
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
