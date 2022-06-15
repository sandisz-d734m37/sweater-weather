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

describe "User registration error handling" do
  it "returns 409 error if user already exists" do
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
    post "/api/v1/users", headers: headers, params: JSON.generate(body)

    error_data = JSON.parse(response.body, symbolize_names:true)

    expect(error_data[:data][:type]).to eq("error")
    expect(error_data[:data][:error_code]).to eq(409)
    expect(error_data[:data][:error_mesage]).to eq("Conflict: user already exists")
  end

  it "returns 400 error if password confirmation is incorrect" do
    headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    body = {
      email: "user_1@firstuser.com",
      password: "user1password",
      password_confirmation: "incorect_password"
    }

    post "/api/v1/users", headers: headers, params: JSON.generate(body)

    error_data = JSON.parse(response.body, symbolize_names:true)

    expect(error_data[:data][:type]).to eq("error")
    expect(error_data[:data][:error_code]).to eq(400)
    expect(error_data[:data][:error_mesage]).to eq("Bad request: all fields must be populated and passwords must match")
  end

  it "returns 400 error if password is missing" do
    headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    body = {
      email: "nothing@error_user.com",
      password_confirmation: "nothing_password"
    }

    post "/api/v1/users", headers: headers, params: JSON.generate(body)

    error_data = JSON.parse(response.body, symbolize_names:true)

    expect(error_data[:data][:type]).to eq("error")
    expect(error_data[:data][:error_code]).to eq(400)
    expect(error_data[:data][:error_mesage]).to eq("Bad request: all fields must be populated and passwords must match")
  end

  it "returns 400 error if email is missing" do
    headers = {
      "Content-type": "application/json",
      "Accept": "application/json"
    }
    body = {
      password: "user1password",
      password_confirmation: "incorect_password"
    }

    post "/api/v1/users", headers: headers, params: JSON.generate(body)

    error_data = JSON.parse(response.body, symbolize_names:true)

    expect(error_data[:data][:type]).to eq("error")
    expect(error_data[:data][:error_code]).to eq(400)
    expect(error_data[:data][:error_mesage]).to eq("Bad request: all fields must be populated and passwords must match")
  end
end
