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

uploadSamples:
	#gsutil cp nba/antetokounmpo_g_block_phxvmil_verdap_phantom_jul_14_2021*         gs://dapper-content-pipeline-samples/nba/
	#gsutil -m rsync -c  ./nba gs://dapper-content-pipeline-samples/nba
	gsutil -m rsync -c  ./nfl gs://dapper-content-pipeline-samples/nfl

getGamesIds:
	@grep gameid nba/*.xml  > /tmp/nba.txt 
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


createTestCase01:
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 


createTestCase02:
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 
	# gsutil cp gs:/samples a input 

stopCloudProxies:
	echo kill -9 `ps -ef | grep cloud_sql_proxy | grep -v  grep | gawk '{ pid=pid " " $$2 } END { print pid }'`
	kill -9 `ps -ef | grep cloud_sql_proxy | grep -v  grep | gawk '{ pid=pid " " $$2 } END { print pid }'`

startCloudProxies:
	nohup cloud_sql_proxy -instances=nba-content-pipeline:us-west1:nba-content-pipeline-staging=tcp:5433 > /tmp/cloud_sql_proxy_dev.out 2>&1 &
	nohup cloud_sql_proxy -instances=nba-content-pipeline-qa:us-west1:nba-content-pipeline-qa=tcp:5434 > /tmp/cloud_sql_proxy_qa.out 2>&1 &
	
checkCloudProxies:	
	psql postgres://$$DB_USER:$$DB_PASS@127.0.0.1:5433/nba-content-pipeline-staging-db -c "\d"
	psql postgres://$$QA_DB_USER:$$QA_DB_PASS@127.0.0.1:5434/nba-content-pipeline-qa-db -c "\d"

setCloudProxiesAlias:
	alias psql-dev='psql postgres://$$DB_USER:$$DB_PASS@$DB_IP:$$DB_PORT/nba-content-pipeline-staging-db'
	alias psql-qa='psql postgres://$$QA_DB_USER:$$QA_DB_PASS@127.0.0.1:5434/nba-content-pipeline-qa-db'