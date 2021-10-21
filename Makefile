listSamples:
	gsutil ls gs://dapper-content-pipeline-samples

getSamplesNBA:
	mkdir -p nba
	gsutil rsync gs://dapper-content-pipeline-samples/nba ./nba

uploadSamples:
	gsutil cp nba/antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021*         gs://dapper-content-pipeline-samples/nba/



getGamesIds:
	@grep gameid nba/batum_n_block_lacvdal*.xml  > /tmp/nba.txt 
	@gawk  'BEGIN { FS="\"" ; } { print $$4  }' /tmp/nba.txt

getGamesData:
	echo "::: Input Files :::"
	@ls -1 nba/*.* 
	@grep gameid nba/*.xml  > /tmp/nba.txt 
	echo "::: Data :::"
	@gawk  'BEGIN { FS="\"" ; } { print "gameid=" $$4 " eventNumber=" $$6 " title=" $$8 " gameDate=" $$10 }' /tmp/nba.txt | sort -u