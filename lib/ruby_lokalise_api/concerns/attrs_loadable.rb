# frozen_string_literal: true

module RubyLokaliseApi
  module Concerns
    module AttrsLoadable
      class << self
        def extended(klass)
          klass.class_exec do
            define_method :supported_attrs do
              that_klass = self.class
              that_klass.const_defined?(:ATTRS) ? that_klass.const_get(:ATTRS) : []
            end
          end
        end
      end

      def inherited(subclass)
        klass_attributes = attributes_for subclass, const_get(:ATTRS_FILENAME)

        if klass_attributes&.any?
          subclass.class_exec do
            const_set :ATTRS, klass_attributes
            attr_reader(*klass_attributes)
          end
        end

        super
      end
    end
  end
end
