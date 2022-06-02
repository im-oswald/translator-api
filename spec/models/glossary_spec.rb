require "rails_helper"

describe Glossary do
  context "validations" do
    context "when new glossary being added" do
      let(:old_glossary) { create(:glossary) }
      let(:new_glossary) { build(:glossary) }
      subject { new_glossary.save}

      context "and have the existing source and target language" do
        before { expect(old_glossary).to_not be(nil) }

        it "should give validation error" do
          expect(subject).to be_falsy
          
          expect(new_glossary.errors.count).to_not eql(0)
        end
      end

      context "and dont have existing source and target language" do
        it "should not give validation error" do
          expect(subject).to be_truthy
          
          expect(new_glossary.errors.count).to eql(0)
        end
      end

      context "and source language is empty" do
        let(:new_glossary) { build(:glossary, source_language_code: '') }

        it "should give validation error" do
          expect(subject).to be_falsy

          expect(new_glossary.errors.count).to_not eql(0)
          expect(new_glossary.errors.messages[:base]).to include(I18n.t('glossary.errors.not_given', field: 'source_language_code'))
        end
      end

      context "and target language is empty" do
        let(:new_glossary) { build(:glossary, target_language_code: '') }

        it "should give validation error" do
          expect(subject).to be_falsy

          expect(new_glossary.errors.count).to_not eql(0)
          expect(new_glossary.errors.messages[:base]).to include(I18n.t('glossary.errors.not_given', field: 'target_language_code'))
        end
      end     
      
      context "and dont have valid source language code" do
        let(:new_glossary) { build(:glossary, source_language_code: 'pp') }

        it "should give validation error" do
          expect(subject).to be_falsy

          expect(new_glossary.errors.count).to_not eql(0)
          expect(new_glossary.errors.messages[:base]).to include(I18n.t('glossary.errors.not_valid', field: 'source_language_code'))
        end
      end

      context "and dont have valid target language code" do
        let(:new_glossary) { build(:glossary, target_language_code: 'qq') }

        it "should give validation error" do
          expect(subject).to be_falsy

          expect(new_glossary.errors.count).to_not eql(0)
          expect(new_glossary.errors.messages[:base]).to include(I18n.t('glossary.errors.not_valid', field: 'target_language_code'))
        end
      end
    end
  end
end
