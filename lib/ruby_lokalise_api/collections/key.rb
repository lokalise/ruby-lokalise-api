# frozen_string_literal: true

module RubyLokaliseApi
  module Collections
    class Key < Base
      # Destroys all keys in the collection
      # @return [Hash]
      def destroy_all
        keys = collection.map(&:key_id)
        RubyLokaliseApi::Resources::Key.destroy @client, @path, keys: keys
      end

      class << self
        def endpoint(project_id, *_args)
          path_from projects: [project_id, 'keys']
        end
      end
    end
  end
end
