# -*- coding: utf-8 -*-

""" DAIA comparison OPC4 <-> FOLIO
"""

from bs4 import BeautifulSoup
import logging
import re
import requests


def enable_http_debugging():
    import http.client as http_client
    http_client.HTTPConnection.debuglevel = 1
    logging.basicConfig()
    logging.getLogger().setLevel(logging.DEBUG)
    requests_log = logging.getLogger("requests.packages.urllib3")
    requests_log.setLevel(logging.DEBUG)
    requests_log.propagate = True


BASE_URL_FOLIO = "https://resolver.hebis.de/folioconnector/gi/objectInfo/"
# Produktiv OPAC
BASE_URL_OPC4 = "https://opac.uni-giessen.de/DB=1/SET=1/TTL=1/PRS=daia/CMD?ACT=SRCHA&IKT=6015&SRT=YOP&TRM=epn%3A+"

with open("./Examples/opc4_daia.txt", "w", encoding="UTF-8") as log:
    log.write ("DAIA-Tags OPAC Giessen\n")
    log.write ("======================\n\n")

#with open("daia_folio.txt", "w", encoding="UTF-8") as log:
#    log.write ("DAIA-Tags Testsystem FOLIO Giessen\n")
#    log.write ("=================================\n\n")

with open("./Examples/ppn_epn_list.txt", "r", encoding="UTF-8") as ppn_epn_list:
    ppn_epn_lines = ppn_epn_list.readlines()
    for ppn_epn_line in ppn_epn_lines:
        with open("./Examples/opc4_daia.txt", "a", encoding="UTF-8") as log:
            (example_nr, ppn, epn) = ppn_epn_line.split(";")
            example_nr = example_nr.strip()
            ppn = ppn.strip()
            epn = epn.strip()
            opc4_req = requests.get(BASE_URL_OPC4 + epn)
            soup = BeautifulSoup(opc4_req.text, 'html.parser')
#            print(soup.prettify())
#            daia_divs = soup.find_all("div", string=re.compile("DAIAinfo"))
            divs = soup.find_all("div")

            # extract DAIA tags for the current epn
            current_epn = 0
            daia_tags = []
            for div in divs:
                if ("DAIAinfo" in div.text and "epn" in div.text
                   and not (epn in div.text)):
                    current_epn = 0
                if ("DAIAinfo" in div.text and epn in div.text):
                    current_epn = 1
                if current_epn == 1:
                    daia_tags.append(div.text)
            # sort and write DAIA tags to log
            daia_tags.sort() 
            log.write("## Beispiel " + example_nr + ", PPN = " + ppn + 
                      ", EPN = " + epn + ".\n")
            for daia_tag in daia_tags:
                log.write(daia_tag + "\n")
            log.write("\n")
