
library(ggplot2)
library(dplyr)
library(reshape)
library(car)

data<- read.csv("Airbnb_data.csv")
data.df <- as.data.frame(data)
dataNA <- data.df[rowSums(is.na(data.df)) > 0,]

data_Airbnb <- data.df %>%
  mutate(response_category = case_when(
    host_response_time == "within an hour" ~ 0,
    host_response_time == "within a few hours" ~ 1,
    host_response_time == "within a day" ~ 2,
    TRUE ~ NA_integer_  # If none of the above conditions are met
  ))
  
#Question 1(Five number Summary for child's weight)
within_an_hour <- data_Airbnb[which(data_Airbnb$response_category == '0'),]
within_a_few_hour <- data_Airbnb[which(data_Airbnb$response_category == '1'),]
within_a_day <- data_Airbnb[which(data_Airbnb$response_category == '2'),]

summ_h=round(summary(within_an_hour$log_price),2)
summ_fh=round(summary(within_a_few_hour$log_price),2)
summ_d=round(summary(within_a_day$log_price),2)


summ_all= list(summ_h,summ_fh,summ_d)
df_summ <- data.frame(matrix(unlist(summ_all), nrow=length(summ_all), byrow=TRUE))

variables_ <- c("Bookings accepted within an hour", "Bookings accepted within a few hours",
                "Bookings accepted within a day")
df_summ  <- data.frame(variables_, df_summ)
colnames(df_summ) <- c("Variable Name","Min", "1st Qu", "Median", "Mean",
                       "3rd Qu","Max")
#added

# comparison reasons: (add the deep purple in the legend)
hist(within_an_hour$log_price, main = "Booking Acceptance time",
     col = rgb(0.2, 0.4, 0.8, 0.7),
     xlim = c(3, 6),
     ylim = c(0,35))

hist(within_a_few_hour$log_price,
     col = rgb(0.8, 0.2, 0.4, 0.7),
     add = TRUE)
hist(within_a_day$log_price,
     col = rgb(0.4, 0.8, 0.2, 0.7),
     add = TRUE)


legend('topright', c('Within an hour', 'Within a few hours', 'Within a day'),
       fill=c(rgb(0.2, 0.4, 0.8, 0.7), rgb(0.8, 0.2, 0.4, 0.7),rgb(0.4, 0.8, 0.2, 0.7), rgb(146, 90, 204, maxColorValue = 255)))

#Most frequent response time
getmode <- function(v) {
  uniqv <- unique(v)
  uniqv[which.max(tabulate(match(v, uniqv)))]
}
response_time <- getmode(data_Airbnb$response_category)
response_time#what are the smoking habits of nost women.
#Descriptive analyasis of mother's smoking habits
# frequency for categorical variables
frequency_booking <- data_Airbnb %>% count(data_Airbnb$response_category)
frequency_booking
# Description using graphical methods: Histograms
booking_accepted_Factor <- as.factor(data_Airbnb$response_category)

bar_chart <- ggplot(data_Airbnb, aes(x = factor(response_category), fill = factor(response_category))) +
  geom_bar(color = "black") +
  scale_fill_manual(values = c("lightblue", "lightgreen", "lightcoral")) +  # Set your desired colors
  labs(title = "Response Category Frequencies",
       x = "Response Category",
       y = "Frequency")

bar_chart
##Question 2
####For calculating normality
# never group does not follow normality
shapiro.test(within_an_hour$response_category)

shapiro.test(within_a_few_hour$response_category)
shapiro.test(within_a_day$response_category)

boxplot(data_Airbnb$log_price ~ data_Airbnb$response_category, xlab = 'Booking acceptance time',ylab = "Log price")
# graphical representation
ns <- qqnorm(within_an_hour$log_price)
qqline(within_an_hour$log_price, col = 'red', lwd = 2, lty = 2 )

now_s <- qqnorm(within_a_few_hour$log_price)
qqline(within_a_few_hour$log_price, col = 'red', lwd = 2, lty = 2)

up <- qqnorm(within_a_day$log_price)
qqline(within_a_day$log_price, col = 'red', lwd = 2, lty = 2)




# (p < 0.05), so it appears that the type of smoke used has a real impact on the final baby weight
one.way <- aov(log_price~as.factor(response_category), data=data_Airbnb,projections = TRUE,qr = TRUE,
               contrasts = NULL)
summary(one.way)
# p value 0.104867 which is greater than 0.05  So, we do not reject the null hypothesis. variances are same
leveneTest(data_Airbnb$log_price, data_Airbnb$response_category) 

##Question 3 and Question 4
#pairwise difference if less then 0,05 the significant otherwise not significant



non_adjusted_test <- pairwise.t.test(data_Airbnb$log_price, data_Airbnb$response_category, p.adjust.method = "none")
pairwise_test_adjusted <- pairwise.t.test(data_Airbnb$response_category,data_Airbnb$response_category,pool.sd = TRUE, p.adjust.method ='bonferroni')


#Tukey's HSD test
tukey.test <- TukeyHSD(one.way)

#Tukey's HSD test results
print(tukey.test)
print(non_adjusted_test)
print(pairwise_test_adjusted)
plot(tukey.test)

