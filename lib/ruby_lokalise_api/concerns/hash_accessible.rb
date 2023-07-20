# frozen_string_literal: true

module RubyLokaliseApi
  module Concerns
    module HashAccessible
      def [](raw_key_attr)
        key_attr = :"@#{raw_key_attr}"

        return nil unless instance_variables.include?(key_attr) && respond_to?(raw_key_attr.to_sym)

        instance_variable_get(key_attr)
      end
    end
  end
end
