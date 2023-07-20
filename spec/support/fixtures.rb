# frozen_string_literal: true

require 'pathname'

module Fixtures
  class << self
    def eager_load
      cached_stubs = Pathname.glob("#{fixture_path}/**/*.json").each_with_object({}) do |full_path, result|
        result[
          full_path.relative_path_from(fixture_path).sub_ext('').to_s
        ] = File.read(full_path).freeze
      end

      const_set :STUBS, cached_stubs
    end

    private

    def fixture_path
      File.expand_path('../fixtures', __dir__)
    end
  end
end
