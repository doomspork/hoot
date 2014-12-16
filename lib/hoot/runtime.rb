module Hoot
  class Runtime
    attr_reader :context, :tree

    def initialize(tree)
      @tree = tree
    end

    def run(context)
      @context = context
      execute if true?
    end

    protected

    def actions
      tree.actions(context)
    end


    def evaluate
      tree.evaluate(context)
    end

    def execute
      actions.each { |name, args| context.function(name).call(args) }
    end

    def true?
      !!evaluate
    end
  end
end
