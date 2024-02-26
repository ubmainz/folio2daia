import os
import glob

input_directory = "./Examples"

# List all XML files in the directory
xml_files = glob.glob(os.path.join(input_directory, "*.xml"))

if not xml_files:
    print("No XML files found in the directory.")
else:
    # Sort the XML files by filename
    xml_files.sort()

    # Initialize an empty list to store the sorted content
    sorted_content = []

    # Read and sort the content of each XML file
    for xml_file in xml_files:
        if xml_file != "fallsammlung.xml":
            with open(xml_file, 'r', encoding="UTF-8") as file:
                content = file.read()
                sorted_content.append(content)

    # Sort the content in ascending order
    sorted_content.sort()

    # Specify the output file
    output_file = input_directory + "/fallsammlung.xml"

    # Write the merged and sorted content to the output file
    with open(output_file, 'w', encoding="UTF-8") as file:
        file.write("<root>\n")
        for content in sorted_content:
            file.write(content)
        file.write("</root>\n")

    print(f"Merged and sorted content written to {output_file}.")

