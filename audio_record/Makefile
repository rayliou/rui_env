

rx:
	ffmpeg -f pulse -i @DEFAULT_MONITOR@ \
	  -ac 1 -ar 16000 \
	  -af "dynaudnorm,volume=3,alimiter=limit=0.95" \
	  -f segment -segment_time 300 -reset_timestamps 1 \
	  rx_%03d.wav
clean:
	rm -vf *.wav

