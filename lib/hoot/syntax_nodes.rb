module Hoot
  class Definition < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      decision.evaluate(context)
    end

    def actions(context)
      functions.map { |func| func.evaluate(context) }
    end

    private

    def functions
      action.elements.each_with_object([]) do |elm, memo|
        if elm.is_a? Function
          memo.push(elm)
        elsif elm.respond_to?(:function)
          memo.push(elm.function)
        end
      end
    end
  end



  ##############
  # Operations #
  ##############

  class BinaryDecision < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      left  = operand_1.evaluate(context)
      right = operand_2.evaluate(context)
      op = Operations.lookup(operator)
      op.call(left, right)
    end
  end

  class Parenthesized < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      contents.evaluate(context)
    end
  end

  class Operations
    def self.lookup(op)
      key = op.text_value
      case key
      when '=', 'EQUALS'
        OPERATORS['==']
      when 'NOT EQUALS'
        OPERATORS['!=']
      else
        OPERATORS[key]
      end
    end

    private

    OPERATORS = {
      '!='.freeze     => proc { |a, b| a != b },
      '<'.freeze      => proc { |a, b| a < b },
      '<='.freeze     => proc { |a, b| a <= b },
      '=='.freeze     => proc { |a, b| a == b },
      '>'.freeze      => proc { |a, b| a > b },
      '>='.freeze     => proc { |a, b| a >= b },
      'AND'.freeze    => proc { |a, b| a && b },
      'IN'.freeze     => proc { |a, b| b.include?(a) },
      'NOT IN'.freeze => proc { |a, b| !b.include?(a) },
      'OR'.freeze     => proc { |a, b| a || b },
      'XOR'.freeze    => proc { |a, b| a ^ b }
    }
  end

  ##############
  #  Variables #
  ##############

  class LocalVariable < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      context.local(text_value)
    end
  end

  class GlobalVariable < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      context.shared(text_value)
    end
  end

  ##############
  #  Literals  #
  ##############

  class IntegerLiteral < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      text_value.to_i
    end
  end

  class FloatLiteral < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      text_value.to_f
    end
  end

  class StringLiteral < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      str_value.text_value
    end
  end

  ##############
  #   Actions  #
  ##############

  class Args < Treetop::Runtime::SyntaxNode
  end

  class Function < Treetop::Runtime::SyntaxNode
    def evaluate(context)
      [name.text_value, evaluate_args(func_args(self), context)]
    end

    private

    def func_args(elm)
      params = []
      while elm.respond_to?(:args) && (elements = elm.args.elements) do
        params.push(elements.first)
        elm = elements.last
      end
      params
    end

    def evaluate_args(args, context)
      args.map { |arg| arg.evaluate(context) }
    end
  end
end
