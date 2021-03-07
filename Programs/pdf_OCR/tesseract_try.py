# -*- coding: utf-8 -*-
"""
Created on Fri Feb 26 21:20:33 2021

@author: morte
"""

from PIL import Image
import pytesseract  # pip install pytesseract in console

# If you don't have tesseract executable in your PATH, include the following:
pytesseract.pytesseract.tesseract_cmd = r'C:\Program Files\Tesseract-OCR\tesseract.exe'

# %%

image = Image.open(r'C:\gdrive\github\data\Programs\pdf_OCR\data\in\hello.png')
text = pytesseract.image_to_string(image)
print(text)
