devtools::install_github("doehm/eyedroppeR")

library(eyedroppeR)
Logo_colors <- extract_pal(
  n = 8,
  img_path = "www/logo2v2.jpg"
)

save(Logo_colors, file="Logo_colors.RData")
