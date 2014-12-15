require 'spec_helper'

describe Hoot do
  describe '.parse' do
    let(:code) do
      <<-CODE
          WHEN
            value = 1
            AND
            foo = "bar"
          THEN
            EMAIL("test@orwell.io", "Test Email", "")
            AND
            SMS("")
      CODE
    end

    subject { Hoot.parse(code) }

    it { is_expected.to be_a Hoot::Runtime }

    context 'with invalid code' do
      let(:code) do
        <<-CODE
          WHEN
            a value = 1
          THN
            EMAIL("test@orwell.io", "Test Email", "")
        CODE
      end

      it 'will raise a SyntaxError' do
        expect { subject }.to raise_error Hoot::SyntaxError
      end
    end
  end
end
