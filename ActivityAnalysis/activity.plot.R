library(dplyr)
library(tidyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(grid)
q0<-tbl_df(read.csv('time.active.zero.csv', header=T))
q1<-tbl_df(read.csv('time.active.1q.csv', header=T))
q2<-tbl_df(read.csv('time.active.2q.csv', header=T))
q3<-tbl_df(read.csv('time.active.3q.csv', header=T))
q4<-tbl_df(read.csv('time.active.4q.csv', header=T))
quart<-tbl_df(data.frame(quartile=rep(c('q0', 'q1', 'q2', 'q3', 'q4'), each=68)))
quart<-quart[-c(205, 206), ] # Remove 2 from q3

plot.data<-q0 %>%
    bind_rows(q1,q2,q3,q4) %>%
    select(id,pain,minutes.per.day) %>%
    bind_cols(quart) %>%
    select(quartile, pain, minutes.per.day)
str(plot.data)

pdf('activity.plot.pdf', paper='a4r', width=10, height=9)
gg<-ggplot(data=plot.data, aes(x=quartile, y=minutes.per.day, fill=pain)) +
    geom_boxplot(position=position_dodge(0.85)) + # set to dodge and line thickness
    scale_x_discrete(labels=c("0", "1-24", "25-49", "50-74", "75-100")) +
    coord_cartesian(ylim=c(-20, 1400), xlim=c(0.5,5.5)) +
    scale_y_continuous(breaks=c(0, 200, 400, 600,800,1000,1200, 1400)) +
    labs(y="Time (minutes)", x="Percentage of maximum activity (%)") +
    theme_classic() +
    scale_fill_hue(labels = c("No Pain", "Pain")) +
    theme(axis.text=element_text(size=18),
          axis.title.y=element_text(size=18, vjust=2),
          axis.title.x=element_text(size=18, vjust=-2),
          legend.title=element_blank(),
          legend.text=element_text(size=18),
          legend.position = c(0.9, 0.9),
          plot.margin=unit(c(1,1,2,1), "cm"))
gg
dev.off()
