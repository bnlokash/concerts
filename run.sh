#!/bin/bash

# Initialize variables with default values
input_file=""
start_time=""
end_time=""
artist=""
date=""
venue=""
shadow_color=""
output_file=""

# Parse command-line arguments
while [[ "$#" -gt 0 ]]; do
  case "$1" in
    --input) input_file="$2"; shift 2 ;;
    --start) start_time="$2"; shift 2 ;;
    --end) end_time="$2"; shift 2 ;;
    --artist) artist="$2"; shift 2 ;;
    --date) date="$2"; shift 2 ;;
    --venue) venue="$2"; shift 2 ;;
    --shadow) shadow_color="$2"; shift 2 ;;
    --output) output_file="$2"; shift 2 ;;
    *) echo "Unknown option: $1"; exit 1 ;;
  esac
done

# Check if all required arguments are provided
if [[ -z "$input_file" || -z "$start_time" || -z "$end_time" || -z "$artist" || -z "$date" || -z "$venue" || -z "$shadow_color" ]]; then
  echo "Usage: $0 --input input.mkv --start START_TIME --end END_TIME --artist ARTIST --date DATE --venue VENUE --shadow SHADOW_COLOR --output output.mp4"
  exit 1
fi

# Calculate the length in seconds
length=$((end_time - start_time))

# Calculate the time to begin fading out
fade_out_start=$((end_time - 2))

# If output file is not specified, construct it by concatenating artist and date
if [[ -z "$output_file" ]]; then
  output_file="${artist}_${date}.mp4"
fi

# Construct the ffmpeg command with double quotes around variables
ffmpeg_command="ffmpeg -i \"$input_file\" -ss $start_time -t $length -vf \"crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='$artist
$date
$venue':fontcolor=white:fontsize=48:line_spacing=50:shadowcolor=$shadow_color:shadowx=3:shadowy=3:x=100:y=h-th-100,fade=t=in:st=$start_time:d=2,fade=t=out:st=$fade_out_start:d=2\" -af \"afade=t=in:st=$start_time:d=2,afade=t=out:st=$fade_out_start:d=2\" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k -y \"$output_file\""



# Execute the ffmpeg command
echo "Running ffmpeg command:"
echo "$ffmpeg_command"
eval "$ffmpeg_command"

echo "Video processing complete. Output file: $output_file"
