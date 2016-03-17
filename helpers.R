



tripTarget <- unique(A80$TripTarget); names(tripTarget)=paste(tripTarget)
dateRange  <- range(ymd(A80$HaulDate))

A80 <- A80 %>% mutate(HalibutCPUE=PreMortalityPacificHalibutWt/Duration)

varRadius <- c("Halibut CPUE (t/hour)" = "HalibutCPUE")
