###small RNA seq
#Extended Data Fig. 5s
library("DESeq2")
library("ggplot2")
library("ggprism")

#Differential gene expression analysis
data <- read.table("N2_WAN611_SR_featurecounts.txt",sep="\t",header = TRUE,row.names = 1)
data <- data[,-(1:5)]
countdata <- data[rowMeans(data)>1,]  
condition <- factor(c(rep("control",2),rep("treat",2)))
colData <- data.frame(row.names=colnames(countdata), condition)
#
dds <- DESeqDataSetFromMatrix(countData = countdata, colData = colData, design= ~condition)
dds1 <- DESeq(dds)
res <- results(dds1, contrast = c('condition', 'treat', 'control'))
write.csv(res,file="DESeq2_results.csv")
#
res <- data.frame(res)
res[which(res$log2FoldChange >= 1 & res$padj < 0.05),'sig'] <- 'up'
res[which(res$log2FoldChange <= -1 & res$padj < 0.05),'sig'] <- 'down'
res [which(abs(res$log2FoldChange) <= 1 | res$padj >= 0.05),'sig'] <- 'none'
diff_gene_deseq2 <- subset(res, sig %in% c('up', 'down'))
write.csv(diff_gene_deseq2,file="diff_gene_deseq2.csv")
#
res_up <- subset(res, sig == 'up')
res_down <- subset(res, sig == 'down')
write.csv(res_up, file = 'diff_gene_up.csv')
write.csv(res_down, file = 'diff_gene_down.csv')
##
ggplot(res, aes(log2FoldChange, -log10(res$padj), col = sig)) +
  geom_point() +
  theme_bw() +
  labs(x="log2 (fold change)",y="-log10 (p.adj)") +
  geom_hline(yintercept = -log10(0.05), lty=4,col="grey",lwd=1) +
  geom_vline(xintercept = c(-1, 1), lty=4,col="grey",lwd=1) +
  theme(legend.position = "none",
        panel.grid=element_blank(),
        axis.title = element_text(size = 18),
        axis.text = element_text(size = 14))+
  scale_color_manual(values = c("gold", "#BBBBBB","#AB82FF"),limits = c('up', 'none', 'down'))+theme_prism()+theme(legend.position = "none")
ggsave("volcano.tiff",width = 5,height = 5,dpi=300)



