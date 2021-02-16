
jpeg("/Users/lscpuser/Desktop/rplot_real.jpg", res=100, width=1215,height=700, pointsize=17)
slices <- c(311.5, 50.3, 150, 45.4, 22.9, 5)
lbls <- c("Asia", "S. America", "Africa", "Europe", "N. America", "Oceania")
pie(slices, labels = lbls, col=terrain.colors(6))
legend("bottomright", c("Asia", "South America", "Africa", "Europe", "North America", "Oceania"), cex=1, fill=terrain.colors(6))
dev.off()

jpeg("/Users/lscpuser/Desktop/rplot_lit.jpg", res=100,  height=700, width=950, pointsize=17)
slices <- c(5.43, 0.7, 0.63, 23.92, 66.65, 1.45)
lbls <- c("Asia", "South America", "Africa", "Europe", "North America", "Non-humans")
pie(slices, labels = lbls, col=terrain.colors(6))
legend("topright", c("Asia", "South America", "Africa", "Europe", "North America", "Non-humans"), cex=1, fill=terrain.colors(6))
dev.off()


jpeg("/Users/lscpuser/Desktop/rplot_lang_real.jpg", res=100, width=1250,height=900, pointsize=17.5)
slices <- c(444, 1526, 1227, 477, 455, 2622, 366)
lbls <- c("Indo-European","Niger-Congo (1526)","Austronesian","Trans-New Guinea","Sino-Tibetan","Others","Afro-Asiatic")
pie(slices, labels = lbls, col=magma(7), cex=1)
legend("bottomleft", c("Indo-European","Niger-Congo (1526)","Austronesian","Trans-New Guinea","Sino-Tibetan","Afro-Asiatic"), cex=1.1, fill=magma(7))
dev.off()

jpeg("/Users/lscpuser/Desktop/rplot_lang_lit.jpg",res=100,  height=700, width=950, pointsize=17)
slices <- c(17, 69, 14)
lbls <- c("Indo-European","English","Other families")
pie(slices, labels = lbls, col=magma(3))
legend("topleft", c("Other Indo-European","English","Other families"), cex=1, fill=magma(3))

dev.off()
