setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

library(RedditExtractoR)
library(tidyverse)

#extract titles and upvotes
reddit_thread_urls <- find_thread_urls(
  subreddit = "IOPsychology",
  sort_by = "new",
  period = "year") %>%
  mutate(date_utc = ymd(date_utc))
thread_urls2 <- filter(reddit_thread_urls, timestamp > as.numeric(as.POSIXct(Sys.Date() - 365)))

reddit_content <- get_thread_content(thread_urls2$url)

title<-reddit_content$thread$title
upvotes<-reddit_content$thread$upvotes

#create a week12_tbl
week12_tbl<-tibble(title, upvotes)

#save csv file
write_csv(week12_tbl, "../data/week12_tbl.csv")

####call the data
week12_tbl<-read_csv("../data/week12_tbl.csv")