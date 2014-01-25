class SolarResults
    attr_accessor :estimated_installation_cost
    attr_accessor :assumed_electric_rate
    attr_accessor :payback_year
    attr_accessor :annual_savings

    def self.FromPVWattsV3Data(data)
        sr = SolarResults.new

        sr.estimated_installation_cost = data["outputs"]["financials"]["installed_cost"]
        sr.assumed_electric_rate = data["outputs"]["financials"]["electric_rate"]
        sr.payback_year = data["outputs"]["financials"]["payback"]
        sr.annual_savings = data["outputs"]["financials"]["util_cost_savings"]
        sr
    end

    # Crappy, but works
    def to_json
        {
            estimated_installation_cost: self.estimated_installation_cost,
            assumed_electric_rate: self.assumed_electric_rate,
            payback_year: self.payback_year,
            annual_savings: self.annual_savings
        }.to_json
    end
end


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

    get '/solarcalculator' do
        param :system_size,     Float, required: true
        param :derate_factor,   Float, default: 0.77
        param :lat,             Float, required: true
        param :lon,             Float, required: true

        pvw_data = fetch_pvwatts_data(ENV['PVWATTS_API_KEY'], params[:system_size], params[:derate_factor], params[:lat], params[:lon])

        if pvw_data['errors'].count > 0
            status 422
            { errors: pvw_data['errors'] }.to_json
        else
            solar_results = SolarResults.FromPVWattsV3Data(pvw_data)
            solar_results.to_json
        end
    end

    def fetch_pvwatts_data(api_key, system_size, derate_factor, lat, lon)
        response = HTTParty.get("http://developer.nrel.gov/api/pvwatts/v3.json?api_key=#{api_key}&system_size=#{system_size}&dataset=tmy2&derate=#{derate_factor}&lat=#{lat}&lon=#{lon}")

        puts "Response from PVWatts v3 API: Code=#{response.code}, Message=#{response.message}"

        response_data = response.parsed_response

        response_data["outputs"].delete("sam_output")

        response_data
    end
end