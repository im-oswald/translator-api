require "rails_helper"

describe Term do
  context "validations" do
    context "when source_term empty" do
      let(:term) { build(:term, source_term: '') }
      subject { term.save }

      it "should give validation error" do
        expect(subject).to be_falsy
        expect(term.valid?).to be_falsy
        expect(term.errors.count).to_not eq(0)
      end
    end

    context "when target_term empty" do
      let(:term) { build(:term, source_term: '') }
      subject { term.save }

      it "should give validation error" do
        expect(subject).to be_falsy
        expect(term.valid?).to be_falsy
        expect(term.errors.count).to_not eq(0)
      end
    end    
  end
end
