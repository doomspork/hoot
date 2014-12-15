require 'spec_helper'

module Hoot
  describe Runtime do
    class BogusContext
      def initialize(values)
        @values = values
      end

      def local(name)
        @values['local'][name]
      end

      def shared(name)
        @values['global'][name]
      end
    end

    describe '.run' do
      let(:code) do
        <<-CODE
          WHEN
            value = 1
            AND
            (foo = "bar" OR value > 0)
          THEN
            EMAIL("test@orwell.io", "Test Email", "")
            AND
            SMS("")
        CODE
      end

      let(:tree)    { Parser.parse(code) }
      let(:runtime) { Runtime.new(tree) }
      let(:context) { BogusContext.new('local' => { 'value' => 1, 'foo' => 'foo' }) }

      subject { runtime.run(context) }

      context 'when evaluated to true' do
        it 'will execute actions' do
          mock(context).function('EMAIL') do
            proc { |args| expect(args).to eq ['test@orwell.io', 'Test Email', ''] }
          end

          mock(context).function('SMS') do
            proc { |args| expect(args).to eq [''] }
          end

          subject
        end
      end

      context 'when evaluated to true' do
        let(:context) { BogusContext.new('local' => { 'value' => 2, 'foo' => 'foo' }) }

        subject { runtime.run(context) }
        it 'will execute actions' do
          dont_allow(runtime).execute
          subject
        end
      end
    end
  end
end
