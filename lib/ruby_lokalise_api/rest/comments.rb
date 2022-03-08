# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Comments
      # Returns a single comment for the given key
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-retrieve-a-comment-get
      # @return [RubyLokaliseApi::Resources::Comment]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def comment(project_id, key_id, comment_id)
        c_r RubyLokaliseApi::Resources::KeyComment, :find, [project_id, key_id, comment_id]
      end

      # Returns all comments for all keys inside the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-project-comments-get
      # @return [RubyLokaliseApi::Collection::Comment<RubyLokaliseApi::Resources::Comment>]
      # @param project_id [String]
      # @param params [Hash]
      def project_comments(project_id, params = {})
        c_r RubyLokaliseApi::Collections::ProjectComment, :all, project_id, params
      end

      # Returns all comments for the given key inside the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-list-key-comments-get
      # @return [RubyLokaliseApi::Collection::Comment<RubyLokaliseApi::Resources::Comment>]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param params [Hash]
      def comments(project_id, key_id, params = {})
        c_r RubyLokaliseApi::Collections::KeyComment, :all, [project_id, key_id], params
      end

      # Creates one or more comments for the given key inside the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-create-comments-post
      # @return [RubyLokaliseApi::Collection::Comment<RubyLokaliseApi::Resources::Comment>]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param params [Hash, Array<Hash>]
      def create_comments(project_id, key_id, params)
        c_r RubyLokaliseApi::Resources::KeyComment, :create, [project_id, key_id], params, :comments
      end

      # Deletes comment for the given key inside the given project
      #
      # @see https://app.lokalise.com/api2docs/curl/#transition-delete-a-comment-delete
      # @return [Hash]
      # @param project_id [String]
      # @param key_id [String, Integer]
      # @param comment_id [String, Integer]
      def destroy_comment(project_id, key_id, comment_id)
        c_r RubyLokaliseApi::Resources::KeyComment, :destroy, [project_id, key_id, comment_id]
      end
    end
  end
end
