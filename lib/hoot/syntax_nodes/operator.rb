module Hoot
  class Operator < SyntaxNode
    def perform(a, b)
      raise NotImplementedError
    end
  end
end

require 'hoot/syntax_nodes/operators/equality'
require 'hoot/syntax_nodes/operators/inequality'
