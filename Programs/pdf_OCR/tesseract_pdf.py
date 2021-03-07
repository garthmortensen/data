# -*- coding: utf-8 -*-
"""
Created on Fri Feb 26 22:19:52 2021

@author: morte
"""

import os
from PIL import Image
from pdf2image import convert_from_path
import pytesseract

pathname = r"C:\gdrive\github\data\Programs\pdf_OCR\data\in"
filename = "test_page_600dpi2.pdf"

doc = convert_from_path(pathname + filename)
fileBaseName, fileExtension = os.path.splitext(fileName)

