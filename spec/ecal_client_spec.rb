require 'spec_helper'
require 'pp'
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
        company:   "Tinder",
        firstName: "James",
        lastName:  "Blunt",
        email:     "ginger3@gmail.com"
      }
    end

    describe "#get" do
      it 'should return all', vcr: '/organisation/get' do
        response = @api.organisation.get
        expect(response.status).to eq(200)
      end

      it 'should return organisation', vcr: '/organisation/get_id' do
        response = @api.organisation.get(id: 3256)
        expect(response.status).to eq(200)
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
      it 'should return all', vcr: '/publisher/get' do
        response = @api.publisher.get
        expect(response.status).to eq(200)
      end

      it 'should return publisher', vcr: '/publisher/get_id' do
        response = @api.publisher.get(id: 11319)
        expect(response.status).to eq(200)
      end
    end

    describe "#put" do
      it 'should update the publisher', vcr: '/publisher/put' do
        response = @api.publisher.put(firstName: 'a', lastName: 'b', email: 'abc@gmail.com', phone: "01677777777")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "calendar" do
    let(:params) do
      {
        name:         "FZ Calendar",
        type:         "birthday",
        categories:   "sports/tennis",
        reference:    "FZ2",
        tags:         ["sports", "tofu"],
        note:         "This is my calendar",
        logo:         "http://3.bp.blogspot.com/_5pqCqLjs8WA/TGmMutN5ISI/AAAAAAAAACw/rMgIXNxHSN8/s400/Aspect1x1.png",
        draftCalendar: 0
      }
    end

    describe "#get" do
      it 'should return all', vcr: '/calendar/get' do
        response = @api.calendar.get
        expect(response.status).to eq(200)
      end

      it 'should return calendar', vcr: '/calendar/get_id' do
        response = @api.calendar.get(id: "56a7a008039069d866000000")
        expect(response.status).to eq(200)
      end
    end

    describe "#post" do
      it 'should create new calendar', vcr: '/calendar/post' do
        response = @api.calendar.post(params)
        expect(response.status).to eq(200)
      end
    end

    describe "#put" do
      it 'should update the calendar', vcr: '/calendar/put' do
        response = @api.publisher.put(id: "56ab169d7f4b3f3937000007", categories: params[:categories], name: "FZ-Modified")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "event" do
    let(:params) do
      {
        calendarId: "56a7a008039069d866000000",
        location:   "ECAL HQ 4 Bank Place Melbourne",
        name:       "Liga Tennis",
        startDate:  "2016-08-29",
        startTime:  "18:00",
        endDate:    "2016-08-30",
        endTime:    "19:00",
        reference:  "sport 1",
        alert:      "15M",
        details:    "This is a test fixture event",
        draft:      0
      }
    end

    describe "#get" do
      it 'should return all', vcr: '/event/get' do
        response = @api.event.get
        expect(response.status).to eq(200)
      end

      it 'should return event', vcr: '/event/get_id' do
        response = @api.event.get(id: "56ab1eee7f4b3fad35000008")
        expect(response.status).to eq(200)
      end
    end

    describe "#post" do
      it 'should create new event', vcr: '/event/post' do
        response = @api.event.post(params)
        expect(response.status).to eq(200)
      end
    end

    describe "#put" do
      it 'should update the event', vcr: '/event/put' do
        response = @api.publisher.put(id: "56ab1eee7f4b3fad35000008", alert: "5M")
        expect(response.status).to eq(200)
      end
    end
  end

  describe "subscription_widget" do
    describe "#get" do
      it 'should return all', vcr: '/subscription_widget/get' do
        response = @api.subscription_widget.get
        expect(response.status).to eq(204)
      end

      it 'should return a subscription widget', vcr: '/subscription_widget/get_id' do
        response = @api.subscription_widget.get(id: "1")
        expect(response.status).to eq(204)
      end
    end
  end

  describe "subscriber" do
    let(:params) do
      {
        email:       "test_subscriber@exmaple.com",
        category:    "Mobile",
        application: "iphone",
        calendarIds: ["56a7a008039069d866000000"]
      }
    end

    describe "#get" do
      it 'should return 501', vcr: '/subscriber/get' do
        response = @api.subscriber.get
        expect(response.status).to eq(501)
      end

      it 'should return a subscriber', vcr: '/subscriber/get_id' do
        response = @api.subscriber.get(id: "56ab1c900390694974000007")
        expect(response.status).to eq(200)
      end
    end

    describe "#post" do
      it 'should create new subscriber', vcr: '/subscriber/post' do
        response = @api.subscriber.post(params)
        expect(response.status).to eq(200)
      end
    end

    describe "#put" do
      it 'should update the subscriber', vcr: '/subscriber/put' do
        response = @api.subscriber.put(id: "56ab1c900390694974000007", gender: "M", age_group: "15-24")
        expect(response.status).to eq(200)
      end
    end
  end
end
