require "rails_helper"

describe "Create a Session" do
  before do
    user_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    user_body = {
      email: "user_1@firstuser.com",
      password: "user1password",
      password_confirmation: "user1password"
    }

    post "/api/v1/users", headers: user_headers, params: JSON.generate(user_body)

    session_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    session_body = {
      email: "user_1@firstuser.com",
      password: "user1password"
    }

    post "/api/v1/sessions", headers: session_headers, params: JSON.generate(session_body)
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

describe "Create a Session error handling" do
  before do
    user_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    user_body = {
      email: "user_1@firstuser.com",
      password: "correct",
      password_confirmation: "correct"
    }

    post "/api/v1/users", headers: user_headers, params: JSON.generate(user_body)

  end

  it "returns a 401 response if password is incorrect" do
    session_headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    session_body = {
      email: "user_1@firstuser.com",
      password: "completely_incorrect!"
    }

    post "/api/v1/sessions", headers: session_headers, params: JSON.generate(session_body)

    error_data = JSON.parse(response.body, symbolize_names:true)

    expect(error_data[:data][:type]).to eq("error")
    expect(error_data[:data][:error_code]).to eq(401)
    expect(error_data[:data][:error_mesage]).to eq("Invalid log in credentials")
  end
end
