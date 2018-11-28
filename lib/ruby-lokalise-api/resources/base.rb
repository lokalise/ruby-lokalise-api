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

        def load_record(path, token, id)
          new get(path + '/' + id.to_s, token)
        end

        def create_record(path, token, params)
          new post(path, token, params)
        end

        def update_record(path, token, params = {})
          new put(path, token, params)
        end

        def destroy_record(path, token, id)
          new delete(path + '/' + id.to_s, token)
        end
      end
    end
  end
end
