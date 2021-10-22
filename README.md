# Dapper Content Pipeline Samples

in this repository will be some scripts and data to configure the inital samples and test cases to the project Dapper Content Pipeline 

# Test Plan
- clean 
    - ftp inbox
    - directory json gs://nba-ftp-staging/nba/json/
    - directory thumbailds gs://poc-node-video-processing-output
- process
    - copy test cases to ftp inbox
    - startFTPwatcher
    - check FTPWatcher complexion
    - check ImageProcesor 
    - check ETL
    - check DB
    - Show ReTool interaction
    - check DB after ReTool interaction



# Data
- bird_s_assist_sqdap_seavpho_july_09_2021 - https://en.wikipedia.org/wiki/Sue_Bird WNBA
- ogunbowale_a_layup_sqdap_dalvsea_jun_4_2021 - https://en.wikipedia.org/wiki/Arike_Ogunbowale WNBA
- allen_r_jumper_sqdap_seavpho_jan_22_2006- Walter Allen - https://en.wikipedia.org/wiki/Ray_Allen NBA
- antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021 - Deandre Ayton - https://en.wikipedia.org/wiki/Deandre_Ayton NBA


# Notes
- Added some scripts in ./sql