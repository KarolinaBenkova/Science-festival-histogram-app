# Science-festival-histogram-app
Repo for a Shiny app that updates values in a histogram in real time.

Hypothesis: The heights of the visitors are normally distributed. 
As the height of humans stabilises after reaching adulthood, we can divide the visitors into categories: 
- adults (16 years or older)  -> should be normally distributed but may be skewed
- children (0-15 years old)   -> most probably won’t be normally distributed due to age range (still growing)

## Running on a server
The app runs on a server so one only needs an internet connection and a browser to use.
Open the Google Sheet used in the server.R file, e.g. [heights_data_GS](https://docs.google.com/spreadsheets/d/1TuGqU7fLzumpWgD-WyiQVLLULAmkZOzzGvZarbLyrek/edit?gid=1744621385#gid=1744621385). The adults' data is initialised with the heights of team members at the last MOT meeting, the children's heights are arbitrary. 
The participants will have the option to report their height in feet+inches or cm. 
View the histogram [here](https://7g87ms-karolina0benkova.shinyapps.io/science-festival-histogram-app/)

## Running locally
No need for a browser/internet connection. Update the height values in the ```heights_data.xlsx``` sheet, open the ```shiny_histogram.R``` app in Rstudio and run the app. 

The data in the histogram shown is refreshed every 10 seconds.
