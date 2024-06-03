##
library("DEP")
library("dplyr")
#DEP analysis
run_app("LFQ")
data <- UbiLength
data <- filter(data, Reverse != "+", Potential.contaminant != "+")
data$Gene.names %>% duplicated() %>% any()
data %>% group_by(Gene.names) %>% summarize(frequency = n()) %>% 
  arrange(desc(frequency)) %>% filter(frequency > 1)
data_unique <- make_unique(data, "Gene.names", "Protein.IDs", delim = ";")
data$name %>% duplicated() %>% any()
knitr::kable(UbiLength_ExpDesign)
LFQ_columns <- grep("LFQ.", colnames(data_unique)) # get LFQ column numbers
experimental_design <- UbiLength_ExpDesign
data_se <- make_se(data_unique, LFQ_columns, experimental_design)
LFQ_columns <- grep("LFQ.", colnames(data_unique)) # get LFQ column numbers
data_se_parsed <- make_se_parse(data_unique, LFQ_columns)
data_filt <- filter_missval(data_se, thr = 0)
data_filt2 <- filter_missval(data_se, thr = 1)
data_norm <- normalize_vsn(data_filt)
#
plot_normalization(data_filt, data_norm)
plot_missval(data_filt)
plot_detect(data_filt)
#
impute(data_norm, fun = "")
data_imp <- impute(data_norm, fun = "MinProb", q = 0.01)
data_imp_man <- impute(data_norm, fun = "man", shift = 1.8, scale = 0.3)
data_imp_knn <- impute(data_norm, fun = "knn", rowmax = 0.9)
#
plot_imputation(data_norm, data_imp)
#
data_diff <- test_diff(data_imp, type = "control", control = "Ctrl")
data_diff_all_contrasts <- test_diff(data_imp, type = "all")
data_diff_manual <- test_diff(data_imp, type = "manual", 
                              test = c("Ubi4_vs_Ctrl","Ubi6_vs_Ctrl"))
dep <- add_rejections(data_diff, alpha = 0.05, lfc = log2(1.5))
#
plot_pca(dep, x = 1, y = 2, n = 500, point_size = 4)
plot_cor(dep, significant = TRUE, lower = 0, upper = 1, pal = "Reds")
plot_heatmap(dep, type = "centered", kmeans = TRUE, 
             k = 6, col_limit = 4, show_row_names = FALSE,
             indicate = c("condition", "replicate"))
plot_heatmap(dep, type = "contrast", kmeans = TRUE, 
             k = 6, col_limit = 10, show_row_names = FALSE)
plot_volcano(dep, contrast = "Ubi6_vs_Ctrl", label_size = 2, add_names = TRUE)
plot_single(dep, proteins = c("USP15", "IKBKG"))
plot_single(dep, proteins = "USP15", type = "centered")
plot_cond(dep)
#
data_results <- get_results(dep)
data_results %>% filter(significant) %>% nrow()
data <- UbiLength
experimental_design <- UbiLength_ExpDesign
data_results <- LFQ(data, experimental_design, fun = "MinProb", 
                    type = "control", control = "Ctrl", alpha = 0.05, lfc = 1)
names(data_results)
results_table <- data_results$results
results_table %>% filter(significant) %>% nrow()
full_data <- data_results$dep
plot_heatmap(full_data, type = "contrast", kmeans = TRUE, 
             k = 6, col_limit = 4, show_row_names = FALSE)
sessionInfo()
