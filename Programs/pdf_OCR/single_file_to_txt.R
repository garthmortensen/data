# import libraries
if (!require("tesseract")) install.packages("tesseract")
if (!require("pdftools")) install.packages("pdftools")
if (!require("magick")) install.packages("magick")
library(tesseract)  # for OCR
library(pdftools)  # for pdf
library(magick)  # for improving images

# pointer
filename <- 'C:/gdrive/github/data/Programs/pdf_OCR/data/in/test_page_300dpi.pdf'

# source scans must be 300dpi+ for quality
img_file <- pdftools::pdf_convert(filename, format='png', dpi=600)

# https://cran.r-project.org/web/packages/tesseract/vignettes/intro.html
text <- tesseract::ocr(img_file)
cat(text)
write.table(text, 'C:/gdrive/github/data/Programs/pdf_OCR/data/out/OCR_text.txt')
