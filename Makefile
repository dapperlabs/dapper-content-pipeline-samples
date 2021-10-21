listSamples:
	gsutil ls gs://dapper-content-pipeline-samples

uploadSamples:
	gsutil cp nba/ogunbowale_a_layup_sqdap_dalvsea_jun_4_2021_square.mp4				gs://dapper-content-pipeline-samples/nba/
	gsutil cp nba/ogunbowale_a_layup_sqdap_dalvsea_jun_4_2021_square.xml				gs://dapper-content-pipeline-samples/nba/
	gsutil cp nba/ogunbowale_a_layup_verdap_dalvsea_jun_4_2021_vertical_9x16.mp4		gs://dapper-content-pipeline-samples/nba/
	gsutil cp nba/ogunbowale_a_layup_verdap_dalvsea_jun_4_2021_vertical_9x16.xml		gs://dapper-content-pipeline-samples/nba/

getGamesIds:
	@grep gameid nba/ogunbowale*.xml  > /tmp/nba.txt 
	@gawk  'BEGIN { FS="\"" ; } { print $$4  }' /tmp/nba.txt

getGamesData:
	@grep gameid nba/ogunbowale*.xml  > /tmp/nba.txt 
	@gawk  'BEGIN { FS="\"" ; } { print $$4 " " $$6 " " $$8 " " $$10 }' /tmp/nba.txt