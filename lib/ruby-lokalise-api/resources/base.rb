module Lokalise
  module Resources
    class Base
      extend Lokalise::Request

      attr_reader :content

      def initialize(response)
        @content = response['content']
      end

      private

      def self.load_record(path, token, id)
        new get(path + '/'  + id.to_s, token)
      end

      def self.create_record(path, token, params)
        new post(path, token, params)
      end

      def self.update_record(path, token, params = {})
        new put(path, token, params)
      end

      def self.destroy_record(path, token, id)
        new delete(path + '/'  + id.to_s, token)
      end
    end
  end
end