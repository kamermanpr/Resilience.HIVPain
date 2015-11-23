# Load required packages
library(dplyr)
library(ggplot2)
library(scales)
library(grid)

# Import data
q0<-tbl_df(read.csv('time.active.zero.csv', header=T))
q1<-tbl_df(read.csv('time.active.1q.csv', header=T))
q2<-tbl_df(read.csv('time.active.2q.csv', header=T))
q3<-tbl_df(read.csv('time.active.3q.csv', header=T))
q4<-tbl_df(read.csv('time.active.4q.csv', header=T))

# Create a grouping variable
quart<-tbl_df(data.frame(quartile=rep(c('q0', 'q1', 'q2', 'q3', 'q4'), each=68)))
quart<-quart[-c(205, 206), ] # Remove 2 from q3 (only 66 rows long)

# Create a dataframe using the imported data and the grouping variable
plot.data <- q0 %>%
    bind_rows(q1,q2,q3,q4) %>% # bind imported data q0 through q4
    select(id,pain,minutes.per.day) %>% # select the columns to retain (intermediate)
    bind_cols(quart) %>% # bind grouping variable
    select(quartile, pain, minutes.per.day) # select the columns to retain (final)

# Quick check
str(plot.data)

# Create a hex colour colourblind palette
cb1 <- c("#0072B2", "#D55E00") # line colours
cb2 <- c('#6fafd3', '#e7a46f') # lighter shade for fill

# Plot the data
gg<-ggplot(data=plot.data, aes(x=quartile, y=minutes.per.day, fill = pain, colour = pain)) +
    geom_boxplot(position=position_dodge(0.85)) + 
    scale_x_discrete(labels=c("0", "1-24", "25-49", "50-74", "75-100")) +
    coord_cartesian(ylim=c(-20, 1400), xlim=c(0.5,5.5)) +
    scale_y_continuous(breaks=c(0, 200, 400, 600,800,1000,1200, 1400)) +
    labs(y="Time (minutes)\n", x="\nPercentage of maximum activity (%)") +
    scale_colour_manual(values = cb1, labels = c("No pain", "Pain")) +
    scale_fill_manual(values = cb2, labels = c("No pain", "Pain")) +
    theme(axis.text=element_text(size=18, colour = 'black'),
          axis.title=element_text(size=18, colour = 'black'),
          axis.line=element_line(colour = 'black'),
          panel.background=element_blank(),
          panel.grid=element_blank(),
          legend.title=element_blank(),
          legend.key=element_blank(),
          legend.text=element_text(size=18),
          legend.position = c(0.9, 0.9))
gg
ggsave('activity.plot.pdf')

# Session information
Sys.info()