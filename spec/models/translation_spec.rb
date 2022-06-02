require "rails_helper"

describe Translation do
  context "validations" do
    let(:glossary) { create(:glossary) }

    context "when translation is being created" do
      let(:translation) { build(:translation) }
      subject { translation.save }

      context "and glossary is not there" do
        it "should create translation" do
          expect(subject).to be_truthy

          expect(translation.errors.count).to eq(0)
        end
      end

      context "and glossary is there" do
        let(:translation) { build(:translation, glossary: glossary) }

        context "and source language is not same as glossary" do
          it "should give validation error" do
            expect(subject).to be_falsy

            expect(translation.errors.count).to_not eq(0)
            expect(translation.errors.messages[:base]).to include(
              I18n.t('translation.errors.not_matched', field: 'source_language_code')
            )
          end
        end

        context "and target language is not same as glossary" do
          it "should give validation error" do
            expect(subject).to be_falsy

            expect(translation.errors.count).to_not eq(0)
            expect(translation.errors.messages[:base]).to include(
              I18n.t('translation.errors.not_matched', field: 'target_language_code')
            )
          end
        end

        context "and source, target language is same as glossary" do
          let(:translation) { build(:translation, :with_same_languages, glossary: glossary) }

          it "should create translation" do
            expect(subject).to be_truthy

            expect(translation.errors.count).to eq(0)
          end
        end
      end
    end
  end
end
