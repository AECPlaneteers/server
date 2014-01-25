class App < Sinatra::Base
    helpers Sinatra::Param

    before do
        content_type :json
    end

    get '/' do
        content_type :html
        erb :index
    end

    get '/solar' do
        param :system_size,     Float, required: true
        param :derate_factor,   Float, default: 0.77
        param :lat,             Float, required: true
        param :lon,             Float, required: true

        fetch_pvwatts_data(ENV['PVWATTS_API_KEY'], params[:system_size], params[:derate_factor], params[:lat], params[:lon]).to_json
    end

    get '/solarsavings' do

        annual_savings = []

        30.times do |year|
            annual_savings << 500 + year * 1.456
        end

        {
            estimated_installation_cost: 24000,
            assumed_electric_rate: 0.11,
            payback_year: 24.5,
            annual_savings: annual_savings

        }.to_json
    end

    def fetch_pvwatts_data(api_key, system_size, derate_factor, lat, lon)
        response = HTTParty.get("http://developer.nrel.gov/api/pvwatts/v3.json?api_key=#{api_key}&system_size=#{system_size}&dataset=tmy2&derate=#{derate_factor}&lat=#{lat}&lon=#{lon}")

        response_data = response.parsed_response

        response_data["outputs"].delete("sam_output")

        response_data
    end
end