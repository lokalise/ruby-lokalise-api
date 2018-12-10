module Lokalise
  class Client
    # Returns a single comment for the given key
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-comment-get
    # @return [Lokalise::Resources::Comment]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param comment_id [String, Integer]
    def comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.find self, [project_id, key_id], comment_id
    end

    # Returns all comments for all keys inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-project-comments-get
    # @return [Lokalise::Collection::Comment<Lokalise::Resources::Comment>]
    # @param project_id [String]
    # @param params [Hash]
    def project_comments(project_id, params = {})
      Lokalise::Collections::ProjectComment.all self, params, project_id
    end

    # Returns all comments for the given key inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-key-comments-get
    # @return [Lokalise::Collection::Comment<Lokalise::Resources::Comment>]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param params [Hash]
    def comments(project_id, key_id, params = {})
      Lokalise::Collections::KeyComment.all self, params, project_id, key_id
    end

    # Creates one or more comments for the given key inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-comments-post
    # @return [Lokalise::Collection::Comment<Lokalise::Resources::Comment>]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param params [Hash, Array<Hash>]
    def create_comments(project_id, key_id, params)
      Lokalise::Resources::KeyComment.create self, [project_id, key_id], params, :comments
    end

    # Deletes comment for the given key inside the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-comment-delete
    # @return [Hash]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param comment_id [String, Integer]
    def delete_comment(project_id, key_id, comment_id)
      Lokalise::Resources::KeyComment.destroy self, [project_id, key_id], comment_id
    end
  end
end
