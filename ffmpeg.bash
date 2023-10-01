
# crop 
ffmpeg -i input.mkv -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1" -c:v libx264 -crf 23 
    \ -c:a aac -strict experimental -b:a 192k output.mp4

# crop + trim
    ffmpeg -i input.mkv -ss 28 -t 10 -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k output.mp4

# text
    ffmpeg -i input.mkv -ss 28 -t 10 -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='Stack Overflow':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=(w-text_w)/2:y=(h-text_h)/2" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k output.mp4

# text + padding
    ffmpeg -i input.mkv -ss 28 -t 10 -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='Stack Overflow':fontcolor=white:fontsize=24:box=1:boxcolor=black@0.5:boxborderw=5:x=100:y=h-th-100" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k output.mp4

# text + padding + 3 lines
# remember to escape colons
    ffmpeg -i input.mkv -ss 28 -t 10 -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='LINE1
LINE2
LINE3':fontcolor=white:fontsize=48:line_spacing=50:box=1:boxcolor=black@0.5:boxborderw=5:x=100:y=h-th-100" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k output.mp4

# text + padding + 3 lines
# remember to escape colons
# trying to add dark bg
    ffmpeg -i input.mkv -ss 28 -t 10 -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='LINE1
LINE2
LINE3':fontcolor=white:fontsize=48:line_spacing=50:x=100:y=h-th-100,drawbox=y=0:color=black@0.2:width=10000:height=10000:t=fill" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k output.mp4

# text + padding + 3 lines
# remember to escape colons
# trying to add text shadow
    ffmpeg -i input.mkv -ss _STARTTIME -t _LENGTH -vf "crop=min(iw\,ih):min(iw\,ih),setsar=1,drawtext=fontfile=./font.ttf:text='_ARTIST
_DATE
_VENUE':fontcolor=white:fontsize=48:line_spacing=50:shadowcolor=_SHADOWCOLOR:shadowx=3:shadowy=3:x=100:y=h-th-100" -c:v libx264 -crf 23 -c:a aac -strict experimental -b:a 192k -y _ARTIST_DATE.mp4