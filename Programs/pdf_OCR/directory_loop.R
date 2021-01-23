# import libraries
if (!require("tesseract")) install.packages("tesseract")
if (!require("pdftools")) install.packages("pdftools")
if (!require("tools")) install.packages("tools")
library(tesseract)  # for OCR
library(pdftools)  # for pdf
library(tools)  # for filename sans extension

# data in folder
dir_in <- "C:/gdrive/github/data/Programs/pdf_OCR/data/in/"
dir_out <- "C:/gdrive/github/data/Programs/pdf_OCR/data/out/"

# list all .pdf in folder
# files <- list.files(path=dir_in, pattern='*.pdf', full.names=FALSE)  # i need them seperated for filewrite
files <- file_path_sans_ext(list.files(path=dir_in, pattern='*.pdf'))
print(files)

# for each file in directory, perform OCR
for (file in files) {
  fil_in = paste(dir_in, file, ".pdf", sep="")
  print(fil_in)

  # source scans must be 300dpi+ for quality
  img_file <- pdftools::pdf_convert(fil_in, format='png', dpi=600)

  # if pdf quality is poor, consider using magick
  text <- tesseract::ocr(img_file)
  cat(text)

  # write out as txt
  filepath_out = paste(dir_out, file, ".txt", sep="")
  write.table(text, filepath_out)

}


