server
======

# Setup
Set your NREL API key

Development: `echo "PVWATTS_API_KEY=YOUR_KEY" > .env`
Heroku: `heroku config:set PVWATTS_API_KEY=YOUR_KEY`

# API

Current endpoint:

http://planeteer.herokuapp.com/

### Solar Savings
`/solarcalculator?system_size={system_size_kw}&lat={geo_lat}&lon={geo_lon}`
Sample response:
```json
{
   "estimated_installation_cost":22440.0,
   "assumed_electric_rate":0.11691000312566757,
   "payback_year":24.555768966674805,
   "annual_savings":[
      587.7269897460938,
      599.4076538085938,
      ...
      1019.7415161132812,
      1040.0091552734375
   ],
   "cumulative_annual_savings":[
      587.7269897460938,
      1187.1346435546875,
      ...
      22756.325439453125,
      23796.334594726562
   ]
}
```

# Data Sources

Currently using PVWatts API v3 for savings information.  Given a system system size (in kW) and a lat/lon, it will return a 30 year cost model based on a bunch of internal assumptions on total system cost, utility rate information, etc.

Ideally, we'd probably use a combination of data sources to have more realistic numbers (and ones that mirrored the PVWatt tool):

PVWatts API v4: http://developer.nrel.gov/docs/solar/pvwatts-v4/
OpenEI Average Annual Utility Rate by location:  http://developer.nrel.gov/docs/electricity/utility-rates-v3/
Use calculations from PVWatt Web Tool:
- Tool: http://pvwatts.nrel.gov/pvwatts.php
- Documentation: http://nrelpubs.nrel.gov/WebtopSecure/ws/nich/int/nrel/Record?rpp=25&upp=0&m=1&w=NATIVE%28%27TITLE_V+ph+words+%27%27PVWatts+Version+1+Technical+Reference%27%27%27%29&order=native%28%27pubyear%2FDescend%27%29 (currently not working)
- SAM Cost model: https://www.nrel.gov/analysis/sam/help/html-php/index.html?cf_residential_and_commercial.htm
- SAM Modeling Software: https://sam.nrel.gov/
- Sample Excel worksheet for PV calculations: http://pvwatts.nrel.gov/downloads/pvwatts_economic_results_sample.xls
