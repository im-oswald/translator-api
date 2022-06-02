require "rails_helper"

describe Api::V1::TermsController do
  let(:glossary) { create(:glossary) }
  let(:results) { JSON.parse(response.body) }

  describe "POST /create" do
    let(:params) { { term: { source_term: 'boy', target_term: 'younge' }, glossary_id: glossary.id } }
    subject { post :create, params: params }

    context "when authorized" do
      before { request.headers['API-Auth-Token'] = ENV['API_AUTH_TOKEN'] }

      it "should create the glossary" do
        subject

        expect(response.status).to be(201)
        expect(results['source_term']).to eql(params[:term][:source_term])
        expect(results['target_term']).to eql(params[:term][:target_term])
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
