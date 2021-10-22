lftp $FTP_HOST << EOT
cd $FTP_REMOTEDIR
ls
bye
EOT
