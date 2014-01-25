server
======

# API

Current endpoint:

http://planeteer.herokuapp.com/

### Solar Savings
`/solarcalculator?system_size={system_size_kw}&lat={geo_lat}&lon={geo_lon}`
Sample response:
```json
{
   "estimated_installation_cost":24000,
   "assumed_electric_rate":0.11,
   "payback_year":24.5,
   "annual_savings":[
      500.0,
      501.456,
      502.912,
      504.368,
      505.824,
      507.28,
      508.736,
      510.192,
      511.648,
      513.104,
      514.56,
      516.016,
      517.472,
      518.928,
      520.384,
      521.84,
      523.296,
      524.752,
      526.208,
      527.664,
      529.12,
      530.576,
      532.032,
      533.488,
      534.944,
      536.4,
      537.856,
      539.312,
      540.768,
      542.224
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
