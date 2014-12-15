require 'hoot/syntax_nodes'
require 'hoot/syntax_error'

module Hoot
  class Parser
    def self.parse(data)
      tree = grammar.parse(data)
      raise SyntaxError.new("Parsing error at offset: #{grammar.index}") unless tree
      tree
    end

    private

    def self.grammar
      @grammar ||= HootGrammarParser.new
    end
  end
end
