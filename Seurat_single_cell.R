install.packages("Seurat")
library(Seurat)
install.packages("dplyr")
install.packages("Seurat")
library(Seurat)
library(Seurat)
library(dplyr)
install.packages("dplyr")
library(dplyr)
library(ggplot2)
demo.data <- Read10X(data.dir = "/Users/ahuang/Desktop/raw_feature_bc_matrix")
demo <- CreateSeuratObject(counts = demo.data, project = "demo", min.cells = 3, min.features = 200)
demo
demo@assays$RNA@counts[1:5,1:5]
demo[["percent.mt"]] <- PercentageFeatureSet(demo, pattern = "^MT-")
VlnPlot(demo,features = c("nFeature_RNA", "nCount_RNA", "percent.mt"), ncol = 3)
demo@assays$RNA
demo@meta.data$percent.mt
filter_demo <- subset(demo, subset = nFeature_RNA > 200 & nFeature_RNA < 2500 & percent.mt < 5)
filter_demo
filter_demo <- NormalizeData(filter_demo, normalization.method = "LogNormalize", scale.factor = 10000)

filter_demo <- FindVariableFeatures(filter_demo, selection.method = "vst", nfeatures = 2000)
# 前10的高变异基因
top10 <- head(VariableFeatures(filter_demo), 10)
# 将前10的高变异基因在图中标注出来
plot1 <- VariableFeaturePlot(filter_demo)
plot2 <- LabelPoints(plot = plot1, points = top10, repel = TRUE)
CombinePlots(plots = list(plot1, plot2))

all.genes <- rownames(filter_demo)
filter_demo_1 <- ScaleData(filter_demo, features = all.genes)


filter_demo_1 <- RunPCA(filter_demo_1, features = VariableFeatures(object = filter_demo_1))
#选择前5个维度进行查看
print(filter_demo_1[["pca"]], dims = 1:5, nfeatures = 5)
DimPlot(filter_demo_1, reduction = "pca")

DimHeatmap(filter_demo_1, dims = 1:6, cells = 500, balanced = TRUE)

#将数据的1%打乱重新运行pca，构建特征得分的“零分布”，这个过程重复100次
filter_demo_1 <- JackStraw(filter_demo_1, num.replicate = 100)
filter_demo_1 <- ScoreJackStraw(filter_demo_1, dims = 1:20)
plot1<-JackStrawPlot(filter_demo_1, dims = 1:15)
plot2<-ElbowPlot(filter_demo_1)
CombinePlots(plots = list(plot1, plot2))

#计算最邻近距离
filter_demo_1 <- FindNeighbors(filter_demo_1, dims = 1:15)
#聚类，包含设置下游聚类的“间隔尺度”的分辨率参数resolution ，增加值会导致更多的聚类。
filter_demo_1 <- FindClusters(filter_demo_1, resolution = 0.5)
head(Idents(filter_demo_1), 5)

filter_demo_1 <- RunUMAP(filter_demo_1, dims = 1:15)
filter_demo_1 <- RunTSNE(filter_demo_1, dims = 1:15)
DimPlot(filter_demo_1, reduction = "umap")
DimPlot(filter_demo_1, reduction = "tsne")


#找到cluster1中的markgene
cluster1.markers <- FindMarkers(filter_demo_1, ident.1 = 1, min.pct = 0.25)
#找到cluster5和cluster0、3之间的markgene
cluster5.markers <- FindMarkers(filter_demo_1, ident.1 = 5, ident.2 = c(0, 3), min.pct = 0.25)
#找到每个cluster相比于其余cluster的markgene，只报道阳性的markgene
filter_demo_1.markers <- FindAllMarkers(filter_demo_1, only.pos = TRUE, min.pct = 0.25, logfc.threshold = 0.25)


saveRDS(filter_demo, "/Users/ahuang/Desktop/raw_feature_bc_matrix/filter_demo.rds")


