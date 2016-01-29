require 'spec_helper'

describe EcalClient do

  KEY = "7adbab10934acf84648d87c71b65fac556a7a008205d2"
  SECRET = "xo6m8ea5"

  EcalClient.configure do |config|
    config.key = KEY
    config.secret = SECRET
    config.options = { verbose: false }
  end

  before do
    @api = EcalClient::Api.new
  end

  describe "organisation" do
    let(:params) do
      {
        company: "Tinder",
        firstName: "James",
        lastName: "Blunt",
        email: "ginger1@gmail.com"
      }
    end

    describe "#get" do
      it 'should return all', vcr: '/organisation/get' do
        response = @api.organisation.get
        expect(response.status).to eq(200)
      end

      it 'should return no organisation', vcr: '/organisation/get/id' do
        response = @api.organisation.get(id: 1)
        expect(response.status).to eq(204)
      end
    end

    describe "#post" do
      it 'should create new organisation', vcr: '/organisation/post' do
        response = @api.organisation.post(params)
        expect(response.status).to eq(200)
      end
    end

    describe "#put" do
      it 'should update the organisation', vcr: '/organisation/put' do
        response = @api.organisation.put(company: params[:company], logo: "http://ecal.net/site-logo.png")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "publisher" do
    describe "#get" do
    end

    describe "#put" do
    end
  end

  describe "calendar" do
    describe "#get" do
    end

    describe "#post" do
    end

    describe "#put" do
    end
  end

  describe "event" do
    describe "#get" do
    end

    describe "#post" do
    end

    describe "#put" do
    end
  end

  describe "subscription_widget" do
    describe "#get" do
    end
  end

  describe "subscriber" do
    describe "#get" do
    end

    describe "#post" do
    end

    describe "#put" do
    end
  end
end

