# frozen_string_literal: true

require 'pathname'

module Fixtures
  class << self
    def eager_load
      cached_stubs = load_fixtures

      const_set :STUBS, cached_stubs.freeze
    end

    private

    def load_fixtures
      Pathname.glob("#{fixture_path}/**/*.json").each_with_object({}) do |full_path, result|
        key = full_path.relative_path_from(fixture_path).sub_ext('').to_s
        result[key] = File.read(full_path)
      end
    end

    def fixture_path
      File.expand_path('../fixtures', __dir__)
    end
  end
end
