# frozen_string_literal: true

module Lokalise
  module Collections
    class Segment < Base
      class << self
        def endpoint(project_id, key_id, lang_iso, *_args)
          path_from projects: project_id,
                    keys: key_id,
                    segments: lang_iso
        end
      end
    end
  end
end
