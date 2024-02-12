import folioclient


def translate_umlauts(text):
    # Define translation dictionary for German Umlauts
    umlauts = {'&' : '&amp;', 'ä': '&#xe4;', 'ö': '&#xf6;', 'ü': '&#xfc;',
               'ß': '&#xdf;'}

    # Replace German Umlauts with XML entities in hexadecimal format
    for key, value in umlauts.items():
        text = text.replace(key, value)
    return text


# input configuration
tenant_uri = "https://folio-okapi-tst.hebis-services.de" # no trailing forward slash
tenant = "iln204"
user = input("enter FOLIO user: ")
user_pw = input("enter FOLIO user password: ")

# login user and receive token
conn = folioclient.FolioClient(tenant_uri, tenant, user, user_pw)

response = conn.folio_get_all("/locations", query="", limit=10, key="locations")

filename = "locations-results.xml"

with open(filename, 'w', encoding="UTF-8") as file_object:
    file_object.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<data>\n")
    for location in response:
        file_object.write("<e>\n")
        file_object.write("    <c>")
        file_object.write(str(location.get('code')))
        file_object.write("</c>\n")
        file_object.write('    <n xml:lang="de">')
        file_object.write(translate_umlauts(str(location.get('name'))))
        file_object.write("</n>\n")
        file_object.write("    <url>https://www.uni-giessen.de/ub/de/ueber-uns/standorte/ub-db/1</url>\n")
        file_object.write("</e>\n")
    file_object.write("</data>")


