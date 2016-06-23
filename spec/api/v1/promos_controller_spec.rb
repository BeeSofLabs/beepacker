require 'rails_helper'
describe Api::V1::PromosController do
  describe 'GET /api/v1/promos' do
    context "all promo according status" do
      let!(:promo) { create(:promo) }
      let(:params) {
        {
          status: "travel"
        }
      }
    
      subject { get "/api/v1/promos", params, {} }
    
      it "show promos" do
        subject
        
        expect(response.body).to eql({
          promos: [{
            title: promo.title,
            content: promo.content,
            picture_small: promo.picture.url(:small),
            picture_medium: promo.picture.url(:medium),
            lat: promo.lat,
            lng: promo.lng,
            visitor_count: promo.visitor_count
          }]
        }.to_json)
      end

    end
  end
end