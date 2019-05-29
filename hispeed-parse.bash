#!/bin/bash
for a in $(find . -type d)
do
	metafile=$a/__metadata__.json
	workdir=./curated
	name=$(xidel $metafile -e "name" -s)
	rating=$(xidel $metafile -e "rating")
	developer=$(xidel $metafile -e "developer")
	launch_command=$(xidel $metafile -e "swf_url")
	if [[ $rating =~ Everyone ]]
	then nsfw="No"
	else nsfw="Yes"
	fi
	curadir="$workdir/$name"
	mkdir -p "$curadir"
	convert "$a"/_thumb_* "$curadir"/logo.png
	printf "Title: $name\nSeries: \nDeveloper: $developer\nPublisher: \nStatus: Playable\nExtreme: $nsfw\nGenre: \nSource: www.hi-speed.us\nLaunch command: $launch_command\nNotes: \nAuthor notes: " > "$curadir"/meta.txt
	test2=$(echo "${launch_command##http*://}")
	test3=$(echo "${test2%/*.swf}")
	mkdir -p "$curadir"/content/"$test3"
	cp "$a"/*.swf "$curadir"/content/"$test3"/
done