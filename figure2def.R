library("ggseqlogo")
library("ggplot2")
library("ggprism")

# Fig 2d
seq <- read.table("sequence.txt", sep="\t", header=TRUE)
seq2 <- seq[seq$PValue < 0.05,]
seq3 <- seq2 %>% group_by(type) %>% top_n(5, Count)
seq3$PValue <- -log10(seq3$PValue)
seq3$type <- factor(seq3$type, levels=c("P", "Z", "M", "PZ", "PM", "ZM", "PZM"))

ggplot(seq3, aes(x=Term, y=Count, fill=PValue)) +
  geom_bar(stat="identity") +
  scale_fill_gradient(low="#FF1493", high="#97FFFF", name="-lg(p value)") +
  coord_flip() +
  facet_grid(~type, scales="free_x") +
  theme_classic() +
  theme_prism(base_size=24) +
  theme(
    legend.key.width=unit(10, "pt"),
    legend.title=element_text(margin=margin(b=15)),
    axis.title.x=element_text(size=26),
    strip.text.x=element_text(size=28)
  ) +
  xlab(NULL) +
  ylab("sequence feature Counts")

# Fig 2e
domain <- read.table("domain.txt", sep="\t", header=TRUE)
domain2 <- domain[domain$PValue < 0.05,]
domain3 <- domain2 %>% group_by(type) %>% top_n(5, Count)
domain3$PValue <- -log10(domain3$PValue)
domain3$type <- factor(domain3$type, levels=c("P", "Z", "M", "PZ", "PM", "ZM", "PZM"))

ggplot(domain3, aes(x=Term, y=Count, fill=PValue)) +
  geom_bar(stat="identity") +
  scale_fill_gradient(low="#FF8C00", high="#BF3EFF", name="-lg(p value)") +
  coord_flip() +
  facet_grid(~type, scales="free_x") +
  theme_prism(base_size=20) +
  theme(
    legend.key.width=unit(10, "pt"),
    legend.title=element_text(margin=margin(b=15)),
    axis.title.x=element_text(size=23),
    strip.text.x=element_text(size=23)
  ) +
  xlab(NULL) +
  ylab("domain feature Counts")

# Fig 2f
luorescent_colors <- c( "#FF0000","#FF4D00" ,"#FF9900", "#FFE500", "#CCFF00", "#80FF00", "#33FF00",
                         "#00FF19" ,"#00FF66" ,"#00FFB2", "#00FFFF", "#00B3FF", "#0066FF", "#001AFF",
                       "#3300FF" ,"#7F00FF" ,"#CC00FF" ,"#FF00E6", "#FF0099", "#FF004D")
cs1 = make_col_scheme(chars= c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y"), 
                      cols=luorescent_colors)
test <- read.table("test.txt")
test <- as.matrix（t(test)）
rownames(test) <- c("A", "C", "D", "E", "F", "G", "H", "I", "K", "L", "M", "N", "P", "Q", "R", "S", "T", "V", "W", "Y")
ggseqlogo(test, method="bits", col_scheme=cs1) +
  theme_prism(base_size=21) +
  xlab("position") +
  ggtitle("P-value = 0.0338, ER = 4.06") +
  theme(
    axis.title.x=element_text(size=26),
    axis.title.y=element_text(size=26),
    axis.text.x=element_text(size=26),
    axis.text.y=element_text(size=26)
  )
