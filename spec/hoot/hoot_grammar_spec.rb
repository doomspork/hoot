require 'spec_helper'

module Hoot
  describe HootGrammar do
    shared_examples 'a valid grammar rule' do
      let(:parser) { HootGrammarParser.new }
      subject { parser.parse(code) }
      it { is_expected.to be_a Definition }
    end

    it_behaves_like 'a valid grammar rule' do
      let(:code) { 'WHEN 1 = 1 THEN EMAIL("")' }
    end

    describe 'Conditions' do
      describe 'Operations' do
        describe 'Equality Operator' do
          context 'when `=`' do
            it_behaves_like 'a valid grammar rule' do
              let(:code) { 'WHEN value = 1 THEN EMAIL("")' }
            end
          end

          context 'when `==`' do
            it_behaves_like 'a valid grammar rule' do
              let(:code) { 'WHEN value == 1 THEN EMAIL("")' }
            end
          end

          context 'when `EQUALS`' do
            it_behaves_like 'a valid grammar rule' do
              let(:code) { 'WHEN value EQUALS 1 THEN EMAIL("")' }
            end
          end
        end
      end

      describe 'Inequality Operator' do
        context 'when `!=`' do
          it_behaves_like 'a valid grammar rule' do
            let(:code) { 'WHEN value != 1 THEN EMAIL("")' }
          end
        end

        context 'when `NOT EQUALS`' do
          it_behaves_like 'a valid grammar rule' do
            let(:code) { 'WHEN value NOT EQUALS 1 THEN EMAIL("")' }
          end
        end
      end

      context 'compound conditions' do
        it_behaves_like 'a valid grammar rule' do
          let(:code) { 'WHEN value == 1 AND foo = "1" THEN EMAIL("")' }
        end
      end

      context 'nested conditions' do
        it_behaves_like 'a valid grammar rule' do
          let(:code) { 'WHEN value == 1 AND (foo = "1" AND bar = 1) THEN EMAIL("")' }
        end
      end
    end

    describe 'Actions' do
      context 'with multiple arguments' do
        it_behaves_like 'a valid grammar rule' do
          let(:code) { 'WHEN value == 1 THEN EMAIL("", "Subject", "Body 123")' }
        end
      end

      context 'with many actions' do
        it_behaves_like 'a valid grammar rule' do
          let(:code) { 'WHEN value == 1 THEN EMAIL("", "Subject", "Body 123") AND SMS("")' }
        end
      end
    end
  end
end

