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

BASE_URL_FOLIO = "https://resolver.hebis.de/folioconnector/gi/originalInfo/"

with open("./Examples/ppn_epn_list.txt", "r", encoding="UTF-8") as ppn_epn_list:
    ppn_epn_lines = ppn_epn_list.readlines()
    for ppn_epn_line in ppn_epn_lines:
        (nr, description, ppn, epn) = ppn_epn_line.split(";")
        nr = nr.strip()
        description = description.strip()
        ppn = ppn.strip()
        epn = epn.strip()
        opc4_req = requests.get(BASE_URL_FOLIO + ppn + "/xml")
        out_path = "./Examples/" + nr + "_" + ppn + ".xml"
        with open (out_path, "w", encoding="UTF-8") as xml_out:
            xml_out.write(opc4_req.text)
