library(ggplot2)

APR <- read.csv('./data/2016DI_Datafile5SquadFiles_20161212.csv')
APR.Football <- subset(APR, SPORT_CODE == 4)[c('SCL_UNITID', 'SCL_NAME', 'D1_FB_CONF_16', 'APR_RATE_2016_1000', 'APR_RATE_2015_1000', 'APR_RATE_2014_1000', 'APR_RATE_2013_1000', 'APR_RATE_2012_1000', 'APR_RATE_2011_1000', 'APR_RATE_2010_1000', 'APR_RATE_2009_1000', 'APR_RATE_2008_1000', 'APR_RATE_2007_1000')]

APR.Football$APR_AVG <- rowMeans(APR.Football[c('APR_RATE_2016_1000', 'APR_RATE_2015_1000', 'APR_RATE_2014_1000', 'APR_RATE_2013_1000', 'APR_RATE_2012_1000', 'APR_RATE_2011_1000', 'APR_RATE_2010_1000', 'APR_RATE_2009_1000', 'APR_RATE_2008_1000', 'APR_RATE_2007_1000')])

WL <- read.csv('./data/records.csv', header = TRUE)

all <- merge(APR.Football, WL, by = 'SCL_UNITID')[c('Team.name', 'D1_FB_CONF_16', 'Win.Pct', 'APR_AVG')]

ggplot(all, aes(APR_AVG, Win.Pct)) + geom_point(aes(colour = all$D1_FB_CONF_16)) + xlab("Academic Progress Rate") + ylab("Win Percent") + labs(colour = "Conferences") + geom_text(data=subset(all, APR_AVG > 980), aes(label = Team.name))

cor(all$APR_AVG, all$Win.Pct) ## 0.3592891