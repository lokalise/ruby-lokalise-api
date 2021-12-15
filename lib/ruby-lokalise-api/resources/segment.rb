# frozen_string_literal: true

module Lokalise
  module Resources
    class Segment < Base
      DATA_KEY = 'Segment'
      ID_KEY = 'segment_number'
      supports :update, [:reload_data, '', :find]

      class << self
        def endpoint(project_id, key_id, lang_iso, segment_number = nil)
          path_from projects: project_id,
                    keys: key_id,
                    segments: [lang_iso, segment_number]
        end
      end
    end
  end
end
