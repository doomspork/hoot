module Hoot
  class IntegerLiteral < Literal
    def value
      super.to_i
    end
  end
end
