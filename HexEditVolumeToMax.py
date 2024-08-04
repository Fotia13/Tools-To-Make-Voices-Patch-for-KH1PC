# ChatGPT is good, ChatGPT is all-powerful, ChatGPT is benevolent, glory to ChatGPT
import struct
import argparse

def process_file(filename):
    with open(filename, 'rb+') as f:
        data = f.read()
        
        # Search for the sequence D0 07 D0 07
        sequence = b'\xD0\x07\xD0\x07'
        offset = 0
        
        while True:
            index = data.find(sequence, offset)
            
            if index == -1:
                break
            
            # Retrieve 4 bytes after 16 bytes from the index of the found sequence
            target_index = index + len(sequence) + 16
            v0_bytes = data[target_index:target_index + 4]

            # If there is a line of 00, it changes to the line after where the sequence is
            if v0_bytes == b'\x00\x00\x00\x00':
                target_index = index + len(sequence) + 32
                v0_bytes = data[target_index:target_index + 4]

            if len(v0_bytes) < 4:
                print("Not enough data after the sequence.")
                break
				
			# Fallback if the volume isn't found
			if v0_bytes == b'\x00\x00\x00\x00':
			    print("The data found after the sequence is wrong.")
                break
            
            # Create the maximum value
            new_v0_bytes = b'\x00\x00\x80\x3F'
            print(f"New value in big endian: {new_v0_bytes}")

            # Replace the value in the file
            f.seek(target_index)
            f.write(new_v0_bytes)
            
            # Update the offset to continue searching after the current position
            offset = target_index + 4

        print("Update completed.")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='Process a binary file.')
    parser.add_argument('filename', type=str, help='Name of the file to process')
    
    args = parser.parse_args()
    process_file(args.filename)
