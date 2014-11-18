module Hoot
  class Literal < SyntaxNode
    def value
      raise NotImplementedError
    end
  end
end

require 'hoot/syntax_nodes/literals/float'
require 'hoot/syntax_nodes/literals/integer'
require 'hoot/syntax_nodes/literals/string'
