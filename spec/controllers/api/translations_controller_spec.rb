require "rails_helper"

describe Api::V1::TranslationsController do
  let(:glossary) { create(:glossary) }
  let(:results) { JSON.parse(response.body) }

  describe "POST /create" do
    let(:params) { {
      translation: {
        source_language_code: 'ur',
        target_language_code: 'eo',
        source_text: 'This is a testing text',
        glossary_id: glossary.id
    } } }
    subject { post :create, params: params }

    context "when authorized" do
      before { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      context "and glossary exists against translation" do
        context "and same languages as glossary is being used" do
          before do
            params[:translation][:source_language_code] = glossary.source_language_code
            params[:translation][:target_language_code] = glossary.target_language_code
          end
  
          it "should create the glossary" do
            subject
    
            expect(response.status).to be(201)
            expect(results['source_language_code']).to eql(params[:translation][:source_language_code])
            expect(results['target_language_code']).to eql(params[:translation][:target_language_code])
            expect(results['source_text']).to eql(params[:translation][:source_text])
            expect(results['glossary']['id']).to eql(params[:translation][:glossary_id])
          end
        end
  
        context "and different languages from glossary is being used" do
          it "should give 422 error" do
            subject
    
            expect(response.status).to be(422)
          end
        end
      end

      context "and glossary does not exists against translation" do
        let(:params) { {
          translation: {
            source_language_code: 'ur',
            target_language_code: 'eo',
            source_text: 'This is a testing text'
        } } }

        it "should create the glossary" do
          subject
    
          expect(response.status).to be(201)
          expect(results['source_language_code']).to eql(params[:translation][:source_language_code])
          expect(results['target_language_code']).to eql(params[:translation][:target_language_code])
          expect(results['source_text']).to eql(params[:translation][:source_text])
        end
      end
    end

    context "when unauthorized" do
      it "should give 401" do
        subject

        expect(response.status).to be(401)
      end
    end
  end

  describe "GET /show" do
    let(:glossary_terms) { create_list(:term, 2, glossary: glossary) }
    let(:text) { "this is #{glossary_terms.first.source_term} and #{glossary_terms.last.source_term}" }
    let(:translation) { create(:translation, source_text: text) }
    let(:params) { { id: translation.id } }
    subject { get :show, params: params }

    context "when authorized" do
      before { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      context "and no glossary is there for translation" do
        it "should not return highlighted source text" do
          subject

          expect(results.keys).to_not include('highlighted_source_text')
          expect(results['source_language_code']).to eql(translation.source_language_code)
          expect(results['target_language_code']).to eql(translation.target_language_code)
        end
      end

      context "and glossary is there for translation" do
        let(:translation) { create(:translation, :with_same_languages, source_text: text, glossary: glossary) }

        it "should add the highlighted text against those terms" do
          subject

          expect(results.keys).to include('highlighted_source_text')
          expect(results['source_language_code']).to eql(glossary.source_language_code)
          expect(results['target_language_code']).to eql(glossary.target_language_code)
        end
      end
    end

    context "when unauthorized" do
      it "should give 401" do
        subject

        expect(response.status).to be(401)
      end
    end
  end
end
