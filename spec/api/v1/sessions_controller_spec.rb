require 'rails_helper'

describe Api::V1::SessionsController do
  describe 'POST /api/v1/sessions' do
    let(:user) { create(:manual_user) }
    context "login [+]" do
      let(:params) {
        {
          session: {
            email:    user.email,
            password: user.password
          }
        }
      }
    
      subject { post '/api/v1/sessions', params }
    
      it "login user" do
        subject
   
        expect(response.body).to eql({
          user: {
            id: user.id,
            email: user.email,
            gender: user.gender,
            authentication_token: user.authentication_token,
            username: user.username,
            first_name: user.first_name,
            last_name: user.last_name,           
            full_name: user.full_name,             
            avatar: user.avatar,
            avatar_small: user.avatar.url(:small),
            avatar_medium: user.avatar.url(:medium)
          }
        }.to_json)
      end

    end
    
    context "login [-]" do
      let(:params) {
        {
          session: {
            email:    "fail@test.com",
            password: "xxxxcxdsaldjsakldjaslkj"
          }
        }
      }
    
      subject { post '/api/v1/sessions', params }
    
      it "login user" do
        subject
        
        expect(response.status).to eql(500)
        expect(response.body).to eql({ error: "No user found" }.to_json)
      end
    end
    
    context "logout" do
      
      subject { delete "/api/v1/sessions/#{user.id}", '', { 'Authorization' => "Token token=\"#{user.authentication_token}\", email=\"#{user.email}\"" } }
    
      it "logout user" do
        subject
   
        expect(response.body).to eql({
          user: {
            id: user.id,
            email: user.email,
            gender: user.gender,
            authentication_token: nil,
            username: user.username,
            first_name: user.first_name,
            last_name: user.last_name,
            full_name: user.full_name,
            avatar: user.avatar,
            avatar_small: user.avatar.url(:small),
            avatar_medium: user.avatar.url(:medium)
          }
        }.to_json)
      end
    end
    
  end
end