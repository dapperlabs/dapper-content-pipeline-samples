# Dapper Content Pipeline Samples

in this repository will be some scripts and data to configure the inital samples and test cases to the project Dapper Content Pipeline 

# Setup
to setup the samples files execute

```
make getSamplesNBA
make getSamplesNFL
```

# Reports
- `make reportSamples` list how many files xmls and mp4 are for each productType nba/nfl
- `make getGamesData` list the input files and the data in the format `gameid=1022100070 eventNumber=438 title=ATL@WAS gameDate=6/17/2021`

# Test Plan
- clean 
    - clean db
    - ftp inbox
    - directory json gs://nba-ftp-staging/nba/json/
    - directory thumbailds gs://poc-node-video-processing-output
- set Scenario
    - copy test cases to ftp inbox
- process
    - startFTPwatcher
    - check FTPWatcher complexion
    - check ImageProcesor 
    - check ETL
    - check DB
    - Execute ReTool interaction
    - check DB after ReTool interaction
    - clean all

# Utilities
- To start SQL Cloud Proxy
    - run `nohup cloud_sql_proxy -instances=nba-content-pipeline:us-west1:nba-content-pipeline-staging=tcp:5432 > /tmp/cloud_sql_proxy.out 2>&1 &` to start cloud proxy

# Notes
- Added some scripts in ./sql
- Added targets to Makefile

# Data
- bird_s_assist_sqdap_seavpho_july_09_2021 - https://en.wikipedia.org/wiki/Sue_Bird WNBA
- ogunbowale_a_layup_sqdap_dalvsea_jun_4_2021 - https://en.wikipedia.org/wiki/Arike_Ogunbowale WNBA
- allen_r_jumper_sqdap_seavpho_jan_22_2006- Walter Allen - https://en.wikipedia.org/wiki/Ray_Allen NBA
- antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021 - Deandre Ayton - https://en.wikipedia.org/wiki/Deandre_Ayton NBA
