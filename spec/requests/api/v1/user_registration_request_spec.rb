require "rails_helper"

describe "User registration" do
  before do
    headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    body = {
      email: "user_1@firstuser.com",
      password: "user1password",
      password_confirmation: "user1password"
    }

    post "/api/v1/users", headers: headers, params: JSON.generate(body)
  end

  it "responds successfully" do
    expect(response).to be_successful

    user_data = JSON.parse(response.body, symbolize_names:true)

    expect(user_data[:data][:id]).to be_an(Integer)
    expect(user_data[:data][:type]).to eq("user")
    expect(user_data[:data][:attributes]).to be_a(Hash)
    expect(user_data[:data][:attributes][:email]).to eq("user_1@firstuser.com")
    expect(user_data[:data][:attributes]).to have_key(:api_key)
  end
end
