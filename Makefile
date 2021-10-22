listSamples:
	gsutil ls gs://dapper-content-pipeline-samples

getSamplesNBA:
	mkdir -p nba
	gsutil rsync gs://dapper-content-pipeline-samples/nba ./nba

uploadSamples:
	#gsutil cp nba/antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021*         gs://dapper-content-pipeline-samples/nba/
	gsutil rsync  ./nba gs://dapper-content-pipeline-samples/nba

getGamesIds:
	@grep gameid nba/batum_n_block_lacvdal*.xml  > /tmp/nba.txt 
	@gawk  'BEGIN { FS="\"" ; } { print $$4  }' /tmp/nba.txt

getGamesData:
	@echo "::: Input Files :::"
	@ls -1 nba/*.* 
	@grep gameid nba/*.xml  > /tmp/nba.txt 
	@echo "::: Data :::"
	@gawk  'BEGIN { FS="\"" ; } { print "gameid=" $$4 " eventNumber=" $$6 " title=" $$8 " gameDate=" $$10 }' /tmp/nba.txt | sort -u

listJsonsBucket:
	gsutil ls gs://nba-ftp-staging/nba/json/*

cleanJsonsBucket: 
	gsutil rm gs://nba-ftp-staging/nba/json/*


backupDB:
	D=$$( date "+%Y-%m-%d_%H-%M-%S" ) ; pg_dump postgres://$$DB_USER:$$DB_PASS@$$DB_IP:5432/nba-content-pipeline-staging-db > dump-$$D.sql
	#D=` date "+%Y-%m-%d_%H-%M-%S" `  ; echo $$D
	#D=$$( date "+%Y-%m-%d_%H-%M-%S" )  ; echo $$D

clean:
	rm -f dump*.sql


startFTPwatcher:
	curl http://b-ftpwatcher-test-dot-nba-content-pipeline.uc.r.appspot.com/tasks/startProcess