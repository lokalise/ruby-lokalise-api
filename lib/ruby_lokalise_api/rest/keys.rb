# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Keys
      # Returns all translation keys for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-all-keys-get
      # @return [RubyLokaliseApi::Collection::Key<RubyLokaliseApi::Resources::Key>]
      # @param project_id [String]
      # @param params [Hash]
      def keys(project_id, params = {})
        c_r RubyLokaliseApi::Collections::Key, :all, project_id, params
      end

      # Returns a single translation key for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-key-get
      # @return [RubyLokaliseApi::Resources::Key]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param params [Hash]
      def key(project_id, key_id, params = {})
        c_r RubyLokaliseApi::Resources::Key, :find, [project_id, key_id], params
      end

      # Creates one or more translation keys for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-keys-post
      # @return [RubyLokaliseApi::Collection::Key<RubyLokaliseApi::Resources::Key>]
      # @param project_id [String]
      # @param params [Hash, Array<Hash>]
      def create_keys(project_id, params = {})
        c_r RubyLokaliseApi::Resources::Key, :create, project_id, params, :keys
      end

      # Updates translation key for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-update-a-key-put
      # @return [RubyLokaliseApi::Resources::Key]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param params [Hash]
      def update_key(project_id, key_id, params = {})
        c_r RubyLokaliseApi::Resources::Key, :update, [project_id, key_id], params
      end

      # Updates one or multiple translation keys for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-bulk-update-put
      # @return [RubyLokaliseApi::Collection::Key<RubyLokaliseApi::Resources::Key>]
      # @param project_id [String]
      # @param params [Hash, Array<Hash>]
      def update_keys(project_id, params)
        c_r RubyLokaliseApi::Resources::Key, :update, project_id, params, :keys
      end

      # Deletes translation key for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-key-delete
      # @return [Hash]
      # @param project_id [String]
      # @param key_id [String, Integer]
      def destroy_key(project_id, key_id)
        c_r RubyLokaliseApi::Resources::Key, :destroy, [project_id, key_id]
      end

      # Deletes one or multiple translation keys for the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-delete-multiple-keys-delete
      # @return [Hash]
      # @param project_id [String]
      # @param key_ids [String, Integer, Array<String>, Array<Integer>]
      def destroy_keys(project_id, key_ids)
        c_r RubyLokaliseApi::Resources::Key, :destroy, project_id, key_ids, :keys
      end
    end
  end
end
