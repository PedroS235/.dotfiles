mp4todavinci() {
	basename="${1%.*}"
	ffmpeg -i "$1" -c:v prores_ks -profile:v 3 -qscale:v 9 -c:a pcm_s16le "$basename".mov
}
