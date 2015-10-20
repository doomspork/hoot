require 'spec_helper'

module Hoot
  describe Parser do
    describe '.parse' do
      let(:code) do
        <<-CODE
          WHEN
            value = 1
            AND
            foo = "bar"
          THEN
            EMAIL("test@example.com", "Test Email", "")
            AND
            SMS("")
        CODE
      end

      subject { Parser.parse(code) }

      it { is_expected.to be_a Definition }

      context 'with invalid code' do
        let(:code) do
          <<-CODE
          WHEN
            a value = 1
          THN
            EMAIL("test@example.com", "Test Email", "")
          CODE
        end

        it 'will raise a SyntaxError' do
          expect { subject }.to raise_error SyntaxError
        end
      end
    end
  end
end
