: Download historical trip data from January 2022 to December 2022
wget https://divvy-tripdata.s3.amazonaws.com/202201-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202202-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202203-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202204-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202205-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202206-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202207-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202208-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202209-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202210-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202211-divvy-tripdata.zip
wget https://divvy-tripdata.s3.amazonaws.com/202212-divvy-tripdata.zip 

: Extract all zip files
unzip 202201-divvy-tripdata.zip
unzip 202202-divvy-tripdata.zip
unzip 202203-divvy-tripdata.zip
unzip 202204-divvy-tripdata.zip
unzip 202205-divvy-tripdata.zip
unzip 202206-divvy-tripdata.zip
unzip 202207-divvy-tripdata.zip
unzip 202208-divvy-tripdata.zip
unzip 202209-divvy-tripdata.zip
unzip 202210-divvy-tripdata.zip
unzip 202211-divvy-tripdata.zip
unzip 202212-divvy-tripdata.zip

: Rename September data to 202209-divvy-tripdata
mv 202209-divvy-publictripdata.csv 202209-divvy-tripdata.csv

: Remove __MACOSX directory
rm -r __MACOSX