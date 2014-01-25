server
======

# Data Sources

Currently using PVWatts API v3 for savings information.  Given a system system size (in kW) and a lat/lon, it will return a 30 year cost model based on a bunch of internal assumptions on total system cost, utility rate information, etc.

Ideally, we'd probably use a combination of data sources to have more realistic numbers (and ones that mirrored the PVWatt tool):

PVWatts API v4: http://developer.nrel.gov/docs/solar/pvwatts-v4/
OpenEI Average Annual Utility Rate by location:  http://developer.nrel.gov/docs/electricity/utility-rates-v3/
Use calculations from PVWatt Web Tool:
- Tool: http://pvwatts.nrel.gov/pvwatts.php
- Documentation: http://nrelpubs.nrel.gov/WebtopSecure/ws/nich/int/nrel/Record?rpp=25&upp=0&m=1&w=NATIVE%28%27TITLE_V+ph+words+%27%27PVWatts+Version+1+Technical+Reference%27%27%27%29&order=native%28%27pubyear%2FDescend%27%29 (currently not working)
- SAM Cost model: https://www.nrel.gov/analysis/sam/help/html-php/index.html?cf_residential_and_commercial.htm
- Sample Excel worksheet for PV calculations: http://pvwatts.nrel.gov/downloads/pvwatts_economic_results_sample.xls