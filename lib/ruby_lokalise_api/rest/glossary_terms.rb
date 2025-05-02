# frozen_string_literal: true

module RubyLokaliseApi
  module Rest
    module GlossaryTerms
      using RubyLokaliseApi::Utils::Classes

      # Returns a single glossary term
      #
      # @see https://developers.lokalise.com/reference/retrieve-a-glossary-term
      # @return [RubyLokaliseApi::Resources::GlossaryTerm]
      # @param project_id [String]
      # @param term_id [String, Integer]
      def glossary_term(project_id, term_id)
        params = { query: [project_id, term_id] }

        data = endpoint(name: 'GlossaryTerms', params: params).do_get

        resource 'GlossaryTerm', data
      end

      # Returns glossary terms
      #
      # @see https://developers.lokalise.com/reference/list-glossary-terms
      # @return [RubyLokaliseApi::Collections::GlossaryTerms]
      # @param project_id [String]
      # @param req_params [Hash]
      def glossary_terms(project_id, req_params = {})
        name = 'GlossaryTerms'
        params = { query: project_id, req: req_params }

        data = endpoint(name: name, params: params).do_get

        collection name, data
      end

      # Creates one or multiple glossary terms in the project
      #
      # @see https://developers.lokalise.com/reference/create-glossary-terms
      # @return [RubyLokaliseApi::Collections::GlossaryTerms]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def create_glossary_terms(project_id, req_params)
        name = 'GlossaryTerms'
        params = { query: project_id, req: req_params.to_array_obj(:terms) }

        data = endpoint(name: name, params: params).do_post

        collection name, data
      end

      # Updates one or multiple glossary terms in the project
      #
      # @see https://developers.lokalise.com/reference/update-glossary-terms
      # @return [RubyLokaliseApi::Collections::GlossaryTerms]
      # @param project_id [String]
      # @param req_params [Hash, Array]
      def update_glossary_terms(project_id, req_params)
        name = 'GlossaryTerms'
        params = { query: project_id, req: req_params.to_array_obj(:terms) }

        data = endpoint(name: name, params: params).do_put

        collection name, data
      end

      # Deletes one or multiple glossary terms from the project
      #
      # @see https://developers.lokalise.com/reference/delete-glossary-terms
      # @return [RubyLokaliseApi::Generics::DeletedResource]
      # @param project_id [String]
      # @param term_ids [Array, String]
      def destroy_glossary_terms(project_id, term_ids)
        params = { query: project_id, req: term_ids.to_array_obj(:terms) }

        data = endpoint(name: 'GlossaryTerms', params: params).do_delete

        RubyLokaliseApi::Generics::DeletedResource.new data.content
      end
    end
  end
end
