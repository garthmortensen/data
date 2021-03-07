# Add searchable layer to pdf

It's easy to add a searchable text layer on top of a non-searchable pdf.

On AWS:

First, spin up a Cloud9 environment, debian linux.

Next, upload the pdf scans into it.

Next, run the following

```bash
~/environment $ history
    1  apt install ocrmypdf
    2  sudo apt install ocrmypdf
    3  python
    4  lsb_release -a
    5  sudo apt-get -y remove ocrmypdf
    6  sudo apt-get -y update
    7  sudo apt-get -y install     ghostscript     icc-profiles-free     liblept5     libxml2     pngquant     python3-cffi     python3-distutils     python3-pkg-resources     python3-reportlab     qpdf     tesseract-ocr     zlib1g     unpaper
    8  wget https://bootstrap.pypa.io/get-pip.py && python3 get-pip.py
    9  export PATH=$HOME/.local/bin:$PATH
   10  python3 -m pip install --user ocrmypdf
   11  ocrmypdf --help
   12  ls -la
   13  ocrmypdf test_page_600dpi1.pdf testing1.pdf
   14  ocrmypdf test_page_600dpi2.pdf testing2.pdf
   15  history
```

For the install setup, I used the [docs](https://ocrmypdf.readthedocs.io/en/latest/installation.html) for ocrmypdf.

For the commands, I used the SO solution for "[How to OCR a PDF file and get the text stored within the PDF](https://unix.stackexchange.com/questions/301318/how-to-ocr-a-pdf-file-and-get-the-text-stored-within-the-pdf)". That is:

```bash
ocrmypdf in.pdf out.pdf
```

Done!

Here's the output:

```bash
$ ocrmypdf test_page_600dpi1.pdf testing1.pdf
Scanning contents: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00,  9.56page/s]
OCR: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1.0/1.0 [00:09<00:00,  9.33s/page]
Postprocessing...
PDF/A conversion: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00,  4.03page/s]
JPEGs: 0image [00:00, ?image/s]
JBIG2: 0item [00:00, ?item/s]
Optimize ratio: 1.00 savings: 0.0%
Output file is a PDF/A-2B (as expected)
$ ocrmypdf test_page_600dpi2.pdf testing2.pdf                                                                                                                                                                            
Scanning contents: 100%|████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00,  9.61page/s]
    1 [tesseract] lots of diacritics - possibly poor OCR                                                                                                                                                                                            
OCR: 100%|██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1.0/1.0 [00:06<00:00,  6.12s/page]
Postprocessing...
PDF/A conversion: 100%|█████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████| 1/1 [00:00<00:00,  4.99page/s]
JPEGs: 0image [00:00, ?image/s]
JBIG2: 0item [00:00, ?item/s]
Optimize ratio: 1.00 savings: 0.0%
Output file is a PDF/A-2B (as expected)
```

It literally took less than 20 minutes...