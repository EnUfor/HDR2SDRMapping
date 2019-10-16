# HDR2SDRMapping
Batch scripts to tonemap 4k HDR content to 1080p SDR

# Filename
Formatting for input files should be as follows:

Title (year)

The script truncates all text after the close parenthesis ')' to add on the corresponding encode information into the filename

# FFMPEG Parameters

scale
  Scales video to the corresponding input width (1080p)
  
tonemap=tonemap=hable:desat=0
  Tonemap HDR content to SDR using habel tonemap with desaturation = 0
