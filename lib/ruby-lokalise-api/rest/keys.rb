module Lokalise
  class Client
    # Returns all translation keys for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-list-all-keys-get
    # @return [Lokalise::Collection::Key<Lokalise::Resources::Key>]
    # @param project_id [String]
    # @param params [Hash]
    def keys(project_id, params = {})
      c_r Lokalise::Collections::Key, :all, project_id, params
    end

    # Returns a single translation key for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-retrieve-a-key-get
    # @return [Lokalise::Resources::Key]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param params [Hash]
    def key(project_id, key_id, params = {})
      c_r Lokalise::Resources::Key, :find, [project_id, key_id], params
    end

    # Creates one or more translation keys for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-create-keys-post
    # @return [Lokalise::Collection::Key<Lokalise::Resources::Key>]
    # @param project_id [String]
    # @param params [Hash, Array<Hash>]
    def create_keys(project_id, params = {})
      c_r Lokalise::Resources::Key, :create, project_id, params, :keys
    end

    # Updates translation key for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-update-a-key-put
    # @return [Lokalise::Resources::Key]
    # @param project_id [String]
    # @param key_id [String, Integer]
    # @param params [Hash]
    def update_key(project_id, key_id, params = {})
      c_r Lokalise::Resources::Key, :update, [project_id, key_id], params
    end

    # Updates one or multiple translation keys for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-bulk-update-put
    # @return [Lokalise::Collection::Key<Lokalise::Resources::Key>]
    # @param project_id [String]
    # @param params [Hash, Array<Hash>]
    def update_keys(project_id, params)
      c_r Lokalise::Resources::Key, :update, project_id, params, :keys
    end

    # Deletes translation key for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-a-key-delete
    # @return [Hash]
    # @param project_id [String]
    # @param key_id [String, Integer]
    def delete_key(project_id, key_id)
      c_r Lokalise::Resources::Key, :destroy, [project_id, key_id]
    end

    # Deletes one or multiple translation keys for the given project
    #
    # @see https://lokalise.co/api2docs/ruby/#transition-delete-multiple-keys-delete
    # @return [Hash]
    # @param project_id [String]
    # @param key_ids [String, Integer, Array<String>, Array<Integer>]
    def delete_keys(project_id, key_ids)
      c_r Lokalise::Resources::Key, :destroy, project_id, key_ids, :keys
    end
  end
end
