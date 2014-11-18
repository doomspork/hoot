module Hoot
  class FloatLiteral < Literal
    def value
      super.to_f
    end
  end
end
