module Lokalise
  module Resources
    class Base
      extend Lokalise::Request

      attr_reader :content

      def initialize(response)
        @content = response['content']
      end

      class << self
        private

        def load_record(path, token, id, params = {})
          new get(path + '/' + id.to_s, token, params)
        end

        def create_record(path, token, params)
          new post(path, token, params)
        end

        def update_record(path, token, params = {})
          new put(path, token, params)
        end

        # Destroys records by given ids. id_or_ids may be a string or a hash with an array of ids
        def destroy_record(path, token, id_or_ids)
          resp = if id_or_ids.is_a?(Hash)
                   delete(path, token, id_or_ids)
                 else
                   delete(path + '/' + id_or_ids.to_s, token)
                 end
          new resp
        end
      end
    end
  end
end
