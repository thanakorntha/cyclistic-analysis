# Download the Data

There are two options to download the data.

## Option #1 - Manually Download

To download the historical bike trip data, you can find the datasets at https://divvy-tripdata.s3.amazonaws.com/index.html.

## Option #2 - Scripting Download

If you want to download 2022 bike trip data, you can clone my repository and then run the following commands to execute `bulk-download.bat`:

``` bash
cd ./cyclistic-analysis/data
./bulk-download.bat
```

After completely running the code, there are 12 CSV files (and 12 ZIP files) in the data folder.

1.  `202201-divvy-tripdata.csv`
2.  `202202-divvy-tripdata.csv`
3.  `202203-divvy-tripdata.csv`
4.  `202204-divvy-tripdata.csv`
5.  `202205-divvy-tripdata.csv`
6.  `202206-divvy-tripdata.csv`
7.  `202207-divvy-tripdata.csv`
8.  `202208-divvy-tripdata.csv`
9.  `202209-divvy-tripdata.csv`
10. `202210-divvy-tripdata.csv`
11. `202211-divvy-tripdata.csv`
12. `202212-divvy-tripdata.csv`

## Note

*The datasets have a different name because Cyclistic is a fictional company created for this course. The real company name is Divvy. However, for this case study, the datasets are appropriate and will enable you to answer the business questions. The data has been made available by Motivate International Inc. under this [license](https://ride.divvybikes.com/data-license-agreement).*