import re

# Function to split the text into blocks
def split_blocks(text):
    return re.split(r'\n\n', text)

# Function to sort and join the blocks
def sort_and_join_blocks(blocks):
    sorted_blocks = []
    block_lines = []
    for block in blocks:
        block_lines = block.split('\n')
        block_lines.sort()
        sorted_blocks.append('\n'.join(block_lines))
    return sorted_blocks

# Read the input text from a file
input_file = './Examples/fallsammlung.xml.txt'

with open(input_file, 'r') as file:
    input_text = file.read()
    input_text = re.sub(r'ofniAIAD\s+DAIAinfo epn', 'ofniAIAD\n\nDAIAinfo epn',
                       input_text)

# Split the text into blocks
blocks = split_blocks(input_text)

# Sort the blocks
sorted_blocks = sort_and_join_blocks(blocks)

# Write the sorted blocks back to a file
header = 'DAIA-Tags FOLIO Giessen\n=======================\n\n'

output_file = './Examples/fallsammlung_sorted.txt'
with open(output_file, "w", encoding="UTF-8") as outfile:
    outfile.write(header)

with open("./Examples/ppn_epn_list.txt", "r", encoding="UTF-8") as ppn_epn_list:
    ppn_epn_lines = ppn_epn_list.readlines()
    for ppn_epn_line in ppn_epn_lines:
        with open(output_file, "a", encoding="UTF-8") as outfile:
            (nr, description, ppn, epn) = ppn_epn_line.split(";")
            nr = nr.strip()
            description = description.strip()
            ppn = ppn.strip()
            epn = epn.strip()
            for block in sorted_blocks:
                if epn in block:
                    outfile.write("## Beispiel " + nr + ", " + description + ", + PPN = " + ppn + ", EPN = " + epn + ".\n")
                    outfile.write(block + "\n\n")

print(f"Blocks sorted and written to {output_file}.")

