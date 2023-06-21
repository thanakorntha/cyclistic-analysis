# ----- EXPORT FULL DATA -----

# Export full ride trip data for data visualization
write.csv(trip_data_v2, file = "./data/processed-data/trip-data.csv", row.names = FALSE, na = '', quote = FALSE)


# ----- EXPORT STATIONS -----

# Export station data (pre and post clean)
write.csv(preclean_start_station, file = "./data/clean-data/preclean-start-station.csv", row.names = FALSE, na = '', quote = FALSE)
write.csv(preclean_end_station, file = "./data/clean-data/preclean-end-station.csv", row.names = FALSE, na = '', quote = FALSE)
write.csv(postclean_start_station, file = "./data/clean-data/postclean-start-station.csv", row.names = FALSE, na = '', quote = FALSE)
write.csv(postclean_end_station, file = "./data/clean-data/postclean-end-station.csv", row.names = FALSE, na = '', quote = FALSE)
