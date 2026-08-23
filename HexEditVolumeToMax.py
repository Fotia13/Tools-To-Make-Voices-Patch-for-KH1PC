# Just a warning... I hate python so much! Why can't it be as simple as c++, lua or batch?
# Everytime it demotivates me and I don't know why.
# I need to write what everything does or I'm going bald.

# Source - https://stackoverflow.com/a/70848620
# Posted by joerick
# Retrieved 2026-08-23, License - CC BY-SA 4.0
# Source - https://stackoverflow.com/a/1322579
# Posted by sth, modified by community. See post 'Timeline' for change history
# Retrieved 2026-08-23, License - CC BY-SA 3.0
# https://www.reddit.com/r/Python/comments/esvpv/how_do_you_display_and_edit_a_bin_file_using_hex/
# https://blog.bandinelli.net/index.php?post/2016/10/23/Python-to-look-for-hexadecimal-patterns-in-a-file

import argparse
import re

if __name__ == '__main__':
    # This takes the file given in the argument
    parser = argparse.ArgumentParser(
                        description="Hex edit a .scd file to change it's volume for the maximum which is 00 00 80 3F")
    parser.add_argument("ScdFile", help = "Path to a .scd file")
    args = parser.parse_args()

    # This open the .scd file in hex
    with open(args.ScdFile, 'rb+') as f:
        ScdFileHex = f.read()
        # This search for every D0 07 D0 07 which seems to be 16 bytes before the volume
        BytesSearched = re.compile(b'\xD0\x07\xD0\x07')
        for BytesSearchedAddress in BytesSearched.finditer(ScdFileHex):
            # This take the 4 bytes 16 bytes after D0 07 D0 07
            SupposedVolumeAddress = BytesSearchedAddress.start()+4+16
            SupposedVolumeHex = ScdFileHex[SupposedVolumeAddress:SupposedVolumeAddress+4]

            # If the 4 bytes found are 00 take the 16 bytes further
            if SupposedVolumeHex == b'\x00\x00\x00\x00':
                SupposedVolumeAddress += 16
                SupposedVolumeHex = ScdFileHex[SupposedVolumeAddress:SupposedVolumeAddress+4]
                # If still 00 then it's not a .scd used by KH1 it can be in the files but unused
                if SupposedVolumeHex == b'\x00\x00\x00\x00':
                    print("ERROR! The supposed volume addresses are empty either this file is unused either the structure is different.")
                    continue

            # Finally replace the volume by 00 00 80 3F
            print(f"Replacing the volume {SupposedVolumeHex}")
            f.seek(SupposedVolumeAddress)
            f.write(b'\x00\x00\x80\x3F')
