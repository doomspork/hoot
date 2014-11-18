module Hoot
  class Expression < SyntaxNode
    def resolve
    end
  end
end

require 'hoot/syntax_nodes/expressions/and'
require 'hoot/syntax_nodes/expressions/comparative'
