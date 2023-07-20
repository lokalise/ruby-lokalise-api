# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module Languages
      using RubyLokaliseApi::Utils::Classes

      # Returns Lokalise system languages
      #
      # @see https://developers.lokalise.com/reference/list-system-languages
      # @return [RubyLokaliseApi::Collections::SystemLanguages]
      # @param req_params [Hash]
      def system_languages(req_params = {})
        name = 'SystemLanguages'
        params = { req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns project languages
      #
      # @see https://developers.lokalise.com/reference/list-project-languages
      # @return [RubyLokaliseApi::Collections::ProjectLanguages]
      # @param project_id [String]
      # @param req_params [Hash]
      def project_languages(project_id, req_params = {})
        name = 'ProjectLanguages'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Returns a single project language
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-language
      # @return [RubyLokaliseApi::Resources::ProjectLanguage]
      # @param project_id [String]
      # @param language_id [String, Integer]
      def project_language(project_id, language_id)
        params = { query: [project_id, language_id] }

        data = endpoint(name: 'ProjectLanguages', params: params).do_get

        resource 'ProjectLanguage', data
      end

      # Creates one or multiple languages for a project
      #
      # @see https://developers.lokalise.com/reference/create-languages
      # @return [RubyLokaliseApi::Collections::ProjectLanguages]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_project_languages(project_id, req_params)
        name = 'ProjectLanguages'
        params = { query: project_id, req: req_params.to_array_obj(:languages) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Updates a language for a project
      #
      # @see https://developers.lokalise.com/reference/update-a-language
      # @return [RubyLokaliseApi::Resources::ProjectLanguage]
      # @param project_id [String]
      # @param language_id [String, Integer]
      # @param req_params [Hash]
      def update_project_language(project_id, language_id, req_params = {})
        params = { query: [project_id, language_id], req: req_params }

        data = endpoint(name: 'ProjectLanguages', params: params).do_put

        resource 'ProjectLanguage', data
      end

      # Deletes a single language from the project
      #
      # @see https://developers.lokalise.com/reference/delete-a-language
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param language_id [String, Integer]
      def destroy_project_language(project_id, language_id)
        params = { query: [project_id, language_id] }

        data = endpoint(name: 'ProjectLanguages', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
