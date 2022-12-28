# EG2501 Studio 3

library(ggplot2)
library(dplyr)
library(ggpubr)
setwd("/Users/yilong/Desktop/Semester 3/EG2501/Studio 3")

# train data
august_train_origin_to_dest <- read.csv("origin_destination_train_202208.csv", sep = ",", header = TRUE)
july_train_origin_to_dest <- read.csv("origin_destination_train_202207.csv", sep = ",", header = TRUE)
june_train_origin_to_dest <- read.csv("origin_destination_train_202206.csv", sep = ",", header = TRUE)

# bus data
august_bus_origin_to_dest <- read.csv("origin_destination_bus_202208.csv", sep = ",", header = TRUE)
july_bus_origin_to_dest <- read.csv("origin_destination_bus_202207.csv", sep = ",", header = TRUE)
june_bus_origin_to_dest <- read.csv("origin_destination_bus_202206.csv", sep = ",", header = TRUE)

# population data
init_pop_2000 <- read.csv("2000_data.csv", sep = ",", header = FALSE)
AG = c("00_to_04",	"05_to_10",	"10_to_14",	"15_to_19",	"20_to_24",
       "25_to_29",	"30_to_34",	"35_to_39",	"40_to_44",	"45_to_49",
       "50_to_54",	"55_to_59",	"60_to_64",	"65+")
population_2000 <- data.frame("string", "string", 0)
names(population_2000) <- c("PA", "AG", "Pop")
for (i in 1:22) {
  for (j in 1:14) {
    population_2000 <- population_2000 %>% add_row(PA = init_pop_2000[i, 1], AG = AG[j], Pop = init_pop_2000[i, j + 1])
  }
}
population_2000 <- subset(population_2000, population_2000$PA != "string")
population_2011_2020 <- read.csv("respopagesexfa2011to2020.csv", sep = ",", header = TRUE)
population_2021 <- read.csv("respopagesexfa2021.csv", sep = ",", header = TRUE)
population_2022 <- read.csv("respopagesexfa2022.csv", sep = ",", header = TRUE)

# data transformation
# june + july + august
months <- c("2022-06", "2022-07", "2022-08")
num_weekdays <- c(22, 20, 22)
num_weekends <- c(8, 10, 8)
days_matrix <- data.frame(months, num_weekdays, num_weekends)
june_train_origin_to_dest <- june_train_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(june_train_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    june_train_origin_to_dest$TOTAL_TRIPS / 22,
                                    june_train_origin_to_dest$TOTAL_TRIPS / 8))
july_train_origin_to_dest <- july_train_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(july_train_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    july_train_origin_to_dest$TOTAL_TRIPS / 20,
                                    july_train_origin_to_dest$TOTAL_TRIPS / 10))
august_train_origin_to_dest <- august_train_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(august_train_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    august_train_origin_to_dest$TOTAL_TRIPS / 22,
                                    august_train_origin_to_dest$TOTAL_TRIPS / 8))
total_train <- rbind(june_train_origin_to_dest, july_train_origin_to_dest, august_train_origin_to_dest)
total_train <- total_train %>%
  mutate(peak_type = ifelse(TIME_PER_HOUR >= 7 & TIME_PER_HOUR <= 9, "AM Peak",
                            ifelse(TIME_PER_HOUR >= 17 & TIME_PER_HOUR <= 19, "PM Peak", "Off Peak")))
june_bus_origin_to_dest <- june_bus_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(june_bus_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    june_bus_origin_to_dest$TOTAL_TRIPS / 22,
                                    june_bus_origin_to_dest$TOTAL_TRIPS / 8))
july_bus_origin_to_dest <- july_bus_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(july_bus_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    july_bus_origin_to_dest$TOTAL_TRIPS / 20,
                                    july_bus_origin_to_dest$TOTAL_TRIPS / 10))
august_bus_origin_to_dest <- august_bus_origin_to_dest %>%
  mutate(daily_total_trips = ifelse(august_bus_origin_to_dest$DAY_TYPE == "WEEKDAY",
                                    august_bus_origin_to_dest$TOTAL_TRIPS / 22,
                                    august_bus_origin_to_dest$TOTAL_TRIPS / 8))
total_bus = rbind(june_bus_origin_to_dest, july_bus_origin_to_dest, august_bus_origin_to_dest)
total_bus <- total_bus %>%
  mutate(peak_type = ifelse(TIME_PER_HOUR >= 7 & TIME_PER_HOUR <= 9, "AM Peak",
                            ifelse(TIME_PER_HOUR >= 17 & TIME_PER_HOUR <= 19, "PM Peak", "Off Peak")))
total_pop <- rbind(population_2011_2020, population_2021, population_2022) %>%
  mutate(AG = ifelse(AG == "0_to_4", "00_to_04",
                     ifelse(AG == "5_to_9", "05_to_09",
                            ifelse(AG %in% c("90_and_over", "65_to_69", "70_to_74", "75_to_79", "80_to_84", "85_to_89"), "65+", population_2022$AG))))

# quantify train congestion

# punggol train stations
no_Punggol_codes <- c("PE1", "PE2", "PE3", "PE4", "PE5", "PE6", "PE7", "PW1", "PW2", "PW3", "PW4", "PW5", "PW6", "PW7")

train_total_hour_capacity_peak = 60 * 204 / 2.5
train_total_hour_capacity_offpeak = 60 * 204 / 7

# main overview
punggol_total_train <- subset(total_train,  (total_train$ORIGIN_PT_CODE %in% no_Punggol_codes) |
                                            (total_train$ORIGIN_PT_CODE == "NE17/PTC" & total_train$DESTINATION_PT_CODE %in% no_Punggol_codes))
punggol_total_train %>%
  group_by(TIME_PER_HOUR, peak_type, DAY_TYPE) %>%
  summarise(sum_total_trips = sum(daily_total_trips) / 3) %>% {
      ggplot(., aes(x = TIME_PER_HOUR, y = sum_total_trips)) +
      geom_point(aes(color = peak_type), size = 5) +
      geom_line(size = 3, alpha = 0.2) +
      geom_hline(yintercept = train_total_hour_capacity_peak, linetype = "dashed", size = 1) +
      geom_hline(yintercept = train_total_hour_capacity_offpeak, linetype = "dotted", size = 1) +
      facet_wrap(~DAY_TYPE) +
      labs(x = "Time", y = "Sum of Daily Total Trips", color = "Peak Type",
           title = "Graph of Sum of Total Trips against Time (2022)") +
      theme(legend.position = "bottom", text = element_text(size = 20))
    }

total_resident = 174450 # census 2020
expected_total_resident = 300000
daily_passengers = total_train %>%
  subset(ORIGIN_PT_CODE %in% no_Punggol_codes | ORIGIN_PT_CODE == "NE17/PTC") %>%
  summarise(total = sum(daily_total_trips)) / 2
proportion_residents_take_trains = 177142.2 / total_resident
proportion_increase_in_resident_pop = (expected_total_resident * proportion_residents_take_trains / total_resident)

punggol_total_train %>%
  group_by(TIME_PER_HOUR, peak_type, DAY_TYPE) %>%
  summarise(sum_total_trips = sum(daily_total_trips) * proportion_increase_in_resident_pop / 3) %>% {
    ggplot(., aes(x = TIME_PER_HOUR, y = sum_total_trips)) +
      geom_point(aes(color = peak_type), size = 5) +
      geom_line(size = 3, alpha = 0.2) +
      facet_wrap(~DAY_TYPE) +
      geom_hline(yintercept = train_total_hour_capacity_peak, linetype = "dashed", size = 1) +
      geom_hline(yintercept = train_total_hour_capacity_offpeak, linetype = "dotted", size = 1) +
      labs(x = "Time", y = "Sum of Daily Total Trips", color = "Peak Type",
           title = "Graph of Sum of Total Trips against Time at Full Population") +
      theme(legend.position = "bottom", text = element_text(size = 20))
  }

# quantify bus congestion

# punggol bus stops
punggol_bus_stops <- c(65191, 65171, 65379, 65149, 65351, 65271, 65231, 65639, 65429, 65151, 65551, 65391, 65459, 65341, 65389, 65539, 65461, 65419, 65641, 65061, 
                       65331, 65199, 65521, 65401, 65161, 65381, 65329, 65359, 65621, 65609, 65679, 65571, 65311, 65431, 65529, 65159, 65209, 65411, 65451, 65069,
                       65269, 65651, 65179, 65549, 65319, 65281, 65339, 65279, 65249, 65671, 65081, 65559, 65491, 65099, 65009, 65371, 65489, 65561, 65449, 65221,
                       65241, 65169, 65441, 65631, 65579, 65499, 65289, 65259, 65481, 65141, 65569, 65681, 65251, 65629, 65091, 65139, 65399, 65469, 65619, 65201,
                       65541, 65349, 65611, 65229, 65661, 65409, 65189, 65439, 65261, 65239, 65531, 65309, 65601, 65321, 65089, 65301, 65181)
busy_stops <- c(65191, 65199, 65009, 65061, 65069)

# identifying the 5 busy stops
busy_vs_non_busy <- total_bus %>%
  subset(total_bus$ORIGIN_PT_CODE %in% punggol_bus_stops |
         total_bus$DESTINATION_PT_CODE %in% punggol_bus_stops) %>%
  mutate(is_busy = ORIGIN_PT_CODE %in% busy_stops |
                   DESTINATION_PT_CODE %in% busy_stops) %>%
  group_by(TIME_PER_HOUR, is_busy) %>%
  summarise(total_bus_trips = ifelse(is_busy, sum(daily_total_trips) / (5 * 3), sum(daily_total_trips) / (92 * 3))) %>% {
    ggplot(., aes(x = TIME_PER_HOUR, y = total_bus_trips, color = is_busy)) +
      geom_point(size = 5) +
      geom_line(size = 1) +
      labs(x = "Time", y = "Average Total Bus Trips", color = "Is Busy Bus Stop",
           title = "Comparing Trips for Busy vs Non-Busy Bus Stops in Punggol") +
      theme(legend.position = "bottom", text = element_text(size = 20))
  }
busy_vs_non_busy

# zoomed in on 65199 and bus 3
codes_to_65199_for_3 <- c(65009, 65221, 65281, 65271, 65261, 65239, 65179, 65169, 65159, 65079)
codes_from_65199_for_3 <- c(77339, 77289, 77169, 77319, 77309, 77061, 78049, 77019, 77029, 77329,
                            77379, 77009, 78109, 78119, 78221, 78209, 78219, 98099, 76249, 76239,
                            76039, 76189, 76179, 76169, 76159, 76149, 76139, 76051, 75009)
bus_total_capacity_peak = 60 * 90 / 12 # taken from businterchange.net
bus_total_capacity_offpeak = 60 * 90 / 15
special_to_65199 <- total_bus %>%
  subset(total_bus$DESTINATION_PT_CODE %in% codes_from_65199_for_3 & total_bus$ORIGIN_PT_CODE %in% codes_to_65199_for_3) %>%
  group_by(TIME_PER_HOUR) %>%
  summarise(daily_trips = sum(daily_total_trips) / 3) %>%
  mutate(daily_trips = ifelse((TIME_PER_HOUR >= 6 & TIME_PER_HOUR <= 8) | (TIME_PER_HOUR >= 17 & TIME_PER_HOUR <=19),
                                 bus_total_capacity_peak - daily_trips, bus_total_capacity_offpeak - daily_trips)) %>%
  mutate(label = "Bus Hourly Capacity")
special_65199 <- total_bus %>%
  subset(total_bus$ORIGIN_PT_CODE == 65199 & total_bus$DESTINATION_PT_CODE %in% codes_from_65199_for_3) %>%
  group_by(TIME_PER_HOUR) %>%
  summarise(daily_trips = sum(daily_total_trips) / 3) %>% 
  mutate(label = "Bus Demand") %>%
  rbind(special_to_65199)
ggplot(special_65199, aes(x = TIME_PER_HOUR, y = daily_trips, color = label)) +
  geom_point(size = 5) +
  geom_line(size = 1) +
  labs(x = "Time", y = "Daily Bus Trips", color = "",
       title = "Congestion for Bus Service 3 at Bus Stop 65199") +
  theme(legend.position = "bottom", text = element_text(size = 20))

# rapid elderly population increase within 20yrs
total_punggol_pop_2022 = total_pop %>%
  subset(Time == 2022 & PA == "Punggol") %>%
  summarise(s = sum(Pop))
punggol_2022 <- total_pop %>%
  subset(Time == 2022 & PA == "Punggol") %>%
  group_by(AG) %>%
  summarise(pop = sum(Pop) * 100 / total_punggol_pop_2022$s)
ggplot(punggol_2022, aes(x = AG, y = pop, fill = AG)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0, 20)) +
  labs(x = "Age Group", y = "Percentage",
       title = "Punggol Population Demographic in 2022") +
  theme(axis.text.x = element_text(angle = 90), text = element_text(size = 20), legend.position = "none")
sum(punggol_2022[punggol_2022$AG %in% c("30_to_34", "35_to_39", "40_to_44", "45_to_49"), "pop"])
sum(punggol_2022[punggol_2022$AG %in% c("00_to_04", "05_to_09", "10_to_14", "15_to_19"), "pop"])
sum(punggol_2022[punggol_2022$AG == "65+", "pop"])
  
# obtain 2000 census data, remove planning areas with <50k people
# find a 20-year change factor = age_group_in_2020 / age_group_in_2000 for each town for each age group
# find the average 20_year change factor
# multiply change factor to current demographic
targets <- c("Ang Mo Kio", "Bedok", "Bukit Batok", "Bukit Merah", "Bukit Panjang", "Bishan", "Bukit Timah", "Choa Chu Kang", "Clementi", "Geylang",
             "Hougang", "Jurong East", "Jurong West", "Kallang", "Pasir Ris", "Queenstown", "Sengkang", "Serangoon", "Tampines", "Toa Payoh", "Woodlands", "Yishun")
pop_2020_for_multiplier <- total_pop %>%
  subset(Time == 2020 & PA %in% targets) %>%
  group_by(PA, AG) %>%
  summarise(pop = sum(Pop)) %>%
  mutate(multiplier = pop / population_2000[PA == population_2000$PA & AG == population_2000$ AG, "Pop"]) %>%
  group_by(AG) %>%
  summarise(mean = mean(multiplier))

total_punggol_pop_2042 = total_pop %>%
  subset(Time == 2022 & PA == "Punggol") %>%
  group_by(AG) %>%
  summarise(pop = sum(Pop)) %>%
  mutate(expected_pop = pop * pop_2020_for_multiplier[pop_2020_for_multiplier$AG == AG, "mean"]) %>% 
  summarise(s = sum(expected_pop))
punggol_2042 <- total_pop %>%
  subset(Time == 2022 & PA == "Punggol") %>%
  group_by(AG) %>%
  summarise(pop = sum(Pop)) %>%
  mutate(percent = pop * pop_2020_for_multiplier[pop_2020_for_multiplier$AG == AG, "mean"] * 100 / total_punggol_pop_2042$s)
ggplot(punggol_2042, aes(x = AG, y = percent$mean, fill = AG)) +
  geom_bar(stat = "identity") +
  scale_y_continuous(limits = c(0, 20)) +
  labs(x = "Age Group", y = "Percentage",
       title = "Punggol Population Demographic in 2042") +
  theme(axis.text.x = element_text(angle = 90), text = element_text(size = 20), legend.position = "none")
sum(punggol_2042[punggol_2042$AG %in% c("30_to_34", "35_to_39", "40_to_44", "45_to_49"), "percent"])
sum(punggol_2042[punggol_2042$AG %in% c("00_to_04", "05_to_09", "10_to_14", "15_to_19"), "percent"])
sum(punggol_2042[punggol_2042$AG == "65+", "percent"])

# shuttle bus

# shuttle bus capacity used = 40
# shuttle bus frequency used = 20 min from 6am - 8am
# assumption: getting to 65199 is far more inconvenient than bus stops before 65199.
# users have more incentive to take the shuttle bus if they initially board bus service 3 at 65199
shuttle_bus_pick_up = 40 * 60 / 20;
special_65199_with_shuttle <- total_bus %>%
  subset(total_bus$ORIGIN_PT_CODE == 65199 & total_bus$DESTINATION_PT_CODE %in% codes_from_65199_for_3) %>%
  group_by(TIME_PER_HOUR) %>%
  summarise(daily_trips = ifelse(TIME_PER_HOUR %in% c(6, 7, 8), sum(daily_total_trips) / 3 - shuttle_bus_pick_up, sum(daily_total_trips) / 3)) %>% 
  mutate(label = "Bus Demand After Shuttle") %>%
  rbind(special_65199) %>% {
    ggplot(., aes(x = TIME_PER_HOUR, y = daily_trips, color = label)) +
      geom_point(size = 5) +
      geom_line(size = 1) +
      labs(x = "Time", y = "Daily Bus Trips", color = "",
           title = "Congestion for Bus Service 3 at Bus Stop 65199") +
      theme(legend.position = "bottom", text = element_text(size = 20))
  }
special_65199_with_shuttle

# determination of shuttle service destination
destination_codes <- c(46009, 59041, 59079, 75359, 75009, 75231, 67441, 77289, 95109, 95029)
destination_areas <- c("Woodlands", "Khatib", "Yishun", "Tampines", "Tampines", "Tampines", "Sengkang", "Pasir Ris", "Changi", "Changi")
destination_map <- data.frame(destination_codes, destination_areas)
punggol_destinations <- total_bus %>%
  subset(ORIGIN_PT_CODE %in% punggol_bus_stops & !(DESTINATION_PT_CODE %in% punggol_bus_stops)) %>%
  group_by(DESTINATION_PT_CODE) %>%
  summarise(daily_trips = sum(daily_total_trips) / 3) %>%
  mutate(destination_area = ifelse(daily_trips > 1000, destination_map[match(DESTINATION_PT_CODE, destination_codes), "destination_areas"], "Others")) %>% {
    ggplot(., aes(x = DESTINATION_PT_CODE, y = daily_trips)) +
      geom_point(aes(color = destination_area)) +
      geom_text(aes(label = "Changi", x = 95100, y = 1500, size = 2)) +
      geom_text(aes(label = "Khatib", x = 59041, y = 2450, size = 2)) +
      geom_text(aes(label = "Others", x = 25000, y = 500, size = 2)) +
      geom_text(aes(label = "Pasir Ris", x = 82000, y = 1100, size = 2)) +
      geom_text(aes(label = "Sengkang", x = 67400, y = 1300, size = 2)) +
      geom_text(aes(label = "Tampines", x = 77000, y = 2000, size = 2)) +
      geom_text(aes(label = "Woodlands", x = 46009, y = 2750, size = 2)) +
      geom_text(aes(label = "Yishun", x = 54000, y = 1100, size = 2)) +
      labs(x = "Destination Planning Area", y = "Daily Bus Trips", color = "",
           title = "Bus Destination Trips from Punggol") +
      theme(legend.position = "none", text = element_text(size = 20))
  }
punggol_destinations
