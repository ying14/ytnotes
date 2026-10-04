


# use 3.5.2
test_libpath <- "C:/Users/Ying/R/packages_test"
dir_ggplot2_3.5.2 <- file.path(test_libpath,"ggplot2_3.5.2")
# detach("package:ggplot2", unload=TRUE)
library(ggplot2,lib.loc=dir_ggplot2_3.5.2)



#use 4.0.0
test_libpath <- "C:/Users/Ying/R/packages_test"
dir_ggplot2_4.0.0 <- file.path(test_libpath,"ggplot2_4.0.0")
# detach("package:ggplot2", unload=TRUE)
library(ggplot2,lib.loc=dir_ggplot2_4.0.0)


library(yingtools2)
library(tidyverse)


otu <- cid.phy %>%
  get.otu.melt() %>%
  filter(Patient_ID=="179")

# by sample
ggplot(data=otu,aes(x=sample,y=pctseqs,fill=otu,label=Genus)) +
  geom_taxonomy()
