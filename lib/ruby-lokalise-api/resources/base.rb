module Lokalise
  module Resources
    class Base
      extend Lokalise::Request

      attr_reader :content

      def initialize(response)
        @content = response['content']
      end

      class << self
        def find(token, endpoint_ids, resource_id = '', params = {})
          new get("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  token,
                  params)
        end

        def create(token, endpoint_ids, params)
          new post(endpoint(*endpoint_ids),
                   token,
                   body_from(params))
        end

        def update(token, endpoint_ids, resource_id, params)
          new put("#{endpoint(*endpoint_ids)}/#{resource_id}",
                  token,
                  body_from(params))
        end

        # Destroys records by given ids. resource_id may be a string or a hash with an array of ids
        def destroy(token, endpoint_ids, resource_id)
          resp = if resource_id.is_a?(Hash)
                   delete path, token, resource_id
                 else
                   delete "#{endpoint(*endpoint_ids)}/#{resource_id}",
                          token
                 end
          new resp
        end

        private

        # Converts `params` to hash with arrays under the `object_key` key
        # Used in bulk operations
        def body_from(params)
          return params unless params.key?(:object_key)

          object_key = params.delete :object_key
          params = [params] unless params.is_a?(Array)
          Hash[object_key, params]
        end
      end
    end
  end
end
