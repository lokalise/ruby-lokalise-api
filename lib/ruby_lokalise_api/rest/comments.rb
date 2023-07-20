# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Comments
      using RubyLokaliseApi::Utils::Classes

      # Returns a single key comment
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-comment
      # @return [RubyLokaliseApi::Resources::Comment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def comment(project_id, key_id, comment_id)
        params = { query: [project_id, key_id, comment_id] }

        data = endpoint(name: 'KeyComments', params: params).do_get

        resource 'Comment', data
      end

      # Returns all comments for a key
      #
      # @see https://developers.lokalise.com/reference/list-key-comments
      # @return [RubyLokaliseApi::Collections::KeyComments]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params [Hash]
      def comments(project_id, key_id, req_params = {})
        name = 'KeyComments'
        params = { query: [project_id, key_id], req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns all comments for a project
      #
      # @see https://developers.lokalise.com/reference/list-project-comments
      # @return [RubyLokaliseApi::Collections::ProjectComments]
      # @param project_id [String]
      # @param req_params [Hash]
      def project_comments(project_id, req_params = {})
        name = 'ProjectComments'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates one or multiple comments for a key
      #
      # @see https://developers.lokalise.com/reference/create-comments
      # @return [RubyLokaliseApi::Collections::KeyComments]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param req_params [Hash, Array]
      def create_comments(project_id, key_id, req_params)
        name = 'KeyComments'
        params = { query: [project_id, key_id], req: req_params.to_array_obj(:comments) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Deletes a single key comment
      #
      # @see https://developers.lokalise.com/reference/delete-a-comment
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def destroy_comment(project_id, key_id, comment_id)
        params = { query: [project_id, key_id, comment_id] }

        data = endpoint(name: 'KeyComments', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
