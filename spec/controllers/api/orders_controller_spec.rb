require 'rails_helper'
require 'faker'

begin
  user = User.create!(name: Faker::Name.name, email: Faker::Internet.email)
rescue StandardError => _e
  puts _e.message
end


stub_create_order = {
  "order": {
    "amount": Faker::Number.number(digits: 5),
    "user_id": user.id
  }
}

describe "post a new order", type: :request do
  
  before do
    post '/api/orders', params: stub_create_order
  end

  it "returns the amount a order" do
    expect(JSON.parse(response.body)['order']['amount'].to_i).to eq(stub_create_order[:order][:amount].to_i)
  end

  it "returns the payment_status a order" do
    expect(JSON.parse(response.body)['order']['payment_status'].to_s).to eq('pending_payment')
  end

  it "returns the order_status a order" do
    expect(JSON.parse(response.body)['order']['order_status'].to_s).to eq('in_preparation')
  end
  
  it "returns correct status code" do
    expect(response.code).to eq("200")
  end

  it "returns a created status" do
    expect(response).to have_http_status(:ok)
  end
end