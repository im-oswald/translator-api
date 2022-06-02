require "rails_helper"

describe Api::V1::GlossariesController do
  let(:glossary_terms) { create_list(:term  , 2, glossary: glossary) }
  let(:glossary) { create(:glossary) }
  let(:results) { JSON.parse(response.body) }

  describe "GET /index" do
    subject { get :index }

    context "when authorized" do
      before(:each) { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      context "and no records are there" do
        it "should give 404" do
          subject

          expect(response.status).to be(404)
        end
      end

      context "and record exists" do
        it "should return all glossaries with terms" do
          expect(glossary).to_not be(nil)
  
          subject
  
          expect(response.status).to be(200)
          expect(results.count).to_not be(0)
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

  describe "POST /create" do
    let(:params) { { glossary: { source_language_code: 'fr', target_language_code: 'ee' } } }
    subject { post :create, params: params }

    context "when authorized" do
      before { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      it "should create the glossary" do
        subject

        expect(response.status).to be(201)
        expect(results['source_language_code']).to eql(params[:glossary][:source_language_code])
        expect(results['target_language_code']).to eql(params[:glossary][:target_language_code])
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
    let(:params) { { id: glossary.id } }
    subject { get :show, params: params }

    context "when authorized" do
      before { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      it "should return the required glossary with terms" do
        expect(glossary_terms).to_not be(nil)
        expect(glossary).to_not be(nil)

        subject

        expect(response.status).to be(200)
        expect(results['source_language_code']).to eql(glossary.source_language_code)
        expect(results['target_language_code']).to eql(glossary.target_language_code)
        expect(results['terms'].count).to eql(glossary_terms.count)
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
