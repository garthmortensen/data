# import libraries
if (!require("tesseract")) install.packages("tesseract")
if (!require("pdftools")) install.packages("pdftools")
library(tesseract)  # for OCR
library(pdftools)  # for pdf

img_file <- pdftools::pdf_convert('C:/gdrive/github/data/Programs/pdf_OCR/data/in/easy.pdf', format='tiff',  dpi=72)
text <- ocr(img_file)
cat(text)
write.table(text, 'C:/gdrive/github/data/Programs/pdf_OCR/data/out/OCR_text.txt')



