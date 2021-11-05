listSamples:
	gsutil ls gs://dapper-content-pipeline-samples

getSamplesNBA:
	mkdir -p nba
	gsutil rsync -c gs://dapper-content-pipeline-samples/nba ./nba

getSamplesNFL:
	mkdir -p nfl
	gsutil rsync -c gs://dapper-content-pipeline-samples/nfl ./nfl

reportSamples:
	@NBA_VIDEOS=`find ./nba -name "*.mp4" | wc -l` ; echo "NBA_VIDEOS=$$NBA_VIDEOS" 
	@NBA_XML=`find ./nba -name "*.xml" | wc -l` ; echo "NBA_XML=$$NBA_XML" 
	@NFL_VIDEOS=`find ./nfl -name "*.mp4" | wc -l` ; echo "NFL_VIDEOS=$$NFL_VIDEOS" 
	@NFL_XML=`find ./nfl -name "*.xml" | wc -l` ; echo "NFL_XML=$$NFL_XML" 


syncVideo2Samples:
	gsutil rsync gs://nba-ftp-staging/nba/videos/* gs://dapper-content-pipeline-samples/nba 

syncXML2Samples:
	gsutil rsync gs://nba-ftp-staging/nba/xml/* gs://dapper-content-pipeline-samples/nba 

uploadSamples:
	#gsutil cp nba/antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021*         gs://dapper-content-pipeline-samples/nba/
	#gsutil -m rsync -c  ./nba gs://dapper-content-pipeline-samples/nba
	gsutil -m rsync -c  ./nfl gs://dapper-content-pipeline-samples/nfl

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

listAllTables:
	psql postgres://$$DB_USER:$$DB_PASS@$$DB_IP:5432/nba-content-pipeline-staging-db -f sql/query.sql | cat
