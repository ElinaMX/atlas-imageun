library(scatterD3)

W3A_data <- read.csv("../data/W3A_data.csv")

scatterD3(data = W3A_data, x = coo1, y = coo2, lab = label,
          col_var = type,
          xlab = "coo1", ylab = "coo2", col_lab = "inr",
          labels_positions = "auto", 
          width = "90%", menu = FALSE)
