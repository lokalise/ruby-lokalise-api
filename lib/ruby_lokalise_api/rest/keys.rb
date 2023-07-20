# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Keys
      using RubyLokaliseApi::Utils::Classes

      # Returns a single translation key
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-key
      # @return [RubyLokaliseApi::Resources::Key]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params[Hash]
      def key(project_id, key_id, req_params = {})
        params = { query: [project_id, key_id], req: req_params }

        data = endpoint(name: 'Keys', params: params).do_get

        resource 'Key', data
      end

      # Returns project translation keys
      #
      # @see https://developers.lokalise.com/reference/list-all-keys
      # @return [RubyLokaliseApi::Collections::Keys]
      # @param project_id [String]
      # @param req_params [Hash]
      def keys(project_id, req_params = {})
        name = 'Keys'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates one or multiple keys in the project
      #
      # @see https://developers.lokalise.com/reference/create-keys
      # @return [RubyLokaliseApi::Collections::Keys]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_keys(project_id, req_params)
        name = 'Keys'
        params = { query: project_id, req: req_params.to_array_obj(:keys) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Updates a single translation key
      #
      # @see https://developers.lokalise.com/reference/update-a-key
      # @return [RubyLokaliseApi::Resources::Key]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params[Hash]
      def update_key(project_id, key_id, req_params = {})
        params = { query: [project_id, key_id], req: req_params }

        data = endpoint(name: 'Keys', params: params).do_put

        resource 'Key', data
      end

      # Updates multiple keys in the project
      #
      # @see https://developers.lokalise.com/reference/bulk-update
      # @return [RubyLokaliseApi::Collections::Keys]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def update_keys(project_id, req_params)
        name = 'Keys'
        params = { query: project_id, req: req_params.to_array_obj(:keys) }

        data = endpoint(name: name, params: params).do_put

        collection name, data
      end

      # Deletes a single key from the project
      #
      # @see https://developers.lokalise.com/reference/delete-a-key
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param key_id [String, Integer]
      def destroy_key(project_id, key_id)
        params = { query: [project_id, key_id] }

        data = endpoint(name: 'Keys', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end

      # Deletes multiple keys from the project
      #
      # @see https://developers.lokalise.com/reference/delete-multiple-keys
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param key_ids [Array, String]
      def destroy_keys(project_id, key_ids)
        params = { query: project_id, req: key_ids.to_array_obj(:keys) }

        data = endpoint(name: 'Keys', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
