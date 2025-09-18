import tkinter as tk
from tkinter import filedialog, messagebox

def convert_to_xml(line):
    # Split the line based on two spaces
    parts = line.split('  ')

    # Extract the data enclosed in quotes
    nr = parts[0].strip().strip('"')
    address = parts[1].strip().strip('"').strip(',"')
    address = translate_umlauts(address)
    # Construct the XML tag using the provided structure in 'b'
    xml_tag = f'<hap nr="{nr}">{address}</hap>'
    return xml_tag

def translate_umlauts(text):
    # Define translation dictionary for German Umlauts
    umlauts = {'\\ae': '&#xe4;', '\\oe': '&#xf6;', '\\ue': '&#xfc;', '\\ss': '&#xdf;'}

    # Replace German Umlauts with XML entities in hexadecimal format
    for key, value in umlauts.items():
        text = text.replace(key, value)
    return text

def process_files(input_file, output_file):
    # Flag to indicate if we should start processing lines
    start_processing = False

    # Read the input file and process lines after the specified line
    with open(input_file, 'r') as file:
        # Read each line
        lines = file.readlines()
        # Initialize a list to store processed lines
        processed_lines = []

        # Iterate over the lines
        for line in lines:
            if 'default "Handapparat"' in line:
                start_processing = False
            # Process lines only if start_processing flag is True
            if start_processing:
                # Convert line to XML tag and add to processed lines
                processed_lines.append(convert_to_xml(line))
            # Check if we should start processing lines
            if "table jlu_handapparate =" in line:
                start_processing = True
    # Write the processed lines to the output file
    with open(output_file, 'w') as file:
        # Write XML declaration and root element if needed
        file.write("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<data>\n")
        # Write each XML tag to the output file
        for xml_tag in processed_lines:
            file.write(xml_tag + '\n')
        # Write closing root element
        file.write("</data>")
    print(f"Data successfully converted and written to {output_file}.")
    # Display message box for successful processing
    messagebox.showinfo("Success", f"Data successfully converted and written to {output_file}.")

def select_input_file():
    input_file = filedialog.askopenfilename(filetypes=[("All files", "*.*")])
    input_entry.delete(0, tk.END)
    input_entry.insert(0, input_file)

def select_output_file():
    output_file = filedialog.asksaveasfilename(filetypes=[("XML files", "*.xml")])
    output_entry.delete(0, tk.END)
    output_entry.insert(0, output_file)

# Create the main window
root = tk.Tk()
root.title("Hap list (fcv table) to XML Converter")

# Create input file selection widgets
input_frame = tk.Frame(root)
input_frame.pack(pady=10)
input_label = tk.Label(input_frame, text="Input File:")
input_label.pack(side=tk.LEFT)
input_entry = tk.Entry(input_frame, width=50)
input_entry.pack(side=tk.LEFT)
input_button = tk.Button(input_frame, text="Browse", command=select_input_file)
input_button.pack(side=tk.LEFT)

# Create output file selection widgets
output_frame = tk.Frame(root)
output_frame.pack(pady=10)
output_label = tk.Label(output_frame, text="Output File:")
output_label.pack(side=tk.LEFT)
output_entry = tk.Entry(output_frame, width=50)
output_entry.pack(side=tk.LEFT)
output_button = tk.Button(output_frame, text="Browse", command=select_output_file)
output_button.pack(side=tk.LEFT)

# Create process button
process_button = tk.Button(root, text="Convert", command=lambda: process_files(input_entry.get(), output_entry.get()))
process_button.pack(pady=10)

# Run the main event loop
root.mainloop()

