require 'treetop'
Treetop.load(File.expand_path(File.join(File.dirname(__FILE__), 'hoot', 'hoot_grammar.treetop')))

require 'hoot/parser'
require 'hoot/runtime'

module Hoot
  def parse(definition)
    Runtime.new(Parser.parse(definition))
  end

  module_function :parse
end
