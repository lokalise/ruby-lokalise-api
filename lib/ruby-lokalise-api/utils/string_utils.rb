# Initial code taken from Facets gem by Rubyworks
# https://github.com/rubyworks/facets/blob/master/lib/core/facets/string/snakecase.rb

class String
  # Underscore a string such that camelcase, dashes and spaces are
  # replaced by underscores.
  def snakecase
    base_class_name.
      gsub(/([A-Z]+)([A-Z][a-z])/, '\1_\2').
      gsub(/([a-z\d])([A-Z])/, '\1_\2').
      tr('-', '_').
      gsub(/\s/, '_').
      gsub(/__+/, '_').
      downcase
  end

  # Turn `Module::Nested::ClassName` to just `ClassName`
  def base_class_name
    split('::').last
  end

  def remove_trailing_slash
    gsub %r{/\z}, ''
  end
end
