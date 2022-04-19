#!/bin/bash

curl -L https://yt-dl.org/downloads/latest/youtube-dl --fail --retry 5 --retry-max-time 15 -o ./ytdl
chmod +x ./ytdl

INPUT_URL="${INPUT_URL:-https://magselect-stirr.amagi.tv/playlist1080p.m3u8}"
PRESET="${PRESET:-veryfast}"
CRF="${CRF:-24}"

if [[ -z "${SERVER_URL}" ]]; then
    echo "SERVER_URL is not set"
    exit 1
elif [[ -z "${STREAM_KEY}" ]]; then
   echo "STREAM_KEY is not set"
   exit 1
elif [[ $INPUT_URL =~ ^(https?\:\/\/)?(www\.)?(youtube\.com|youtu\.?be)\/.+$ ]]; then
    INPUT_URL=`./ytdl -g $INPUT_URL`
    echo "GENERATED URL: $INPUT_URL \n"
fi

printf "PREPARING TO STREAM \n"
ffmpeg -user_agent "REDLINECLIENT" -i "http://31.172.87.35:2200/R-EX/SPORTS_STAR_SPORTS_TAMIL-in/tracks-v1a1/mono.m3u8?token=RED_Nk8nfsUpJwXoqTzbuif8cw%3D%3D%2C1650434012.9659699029=" -i logo.png -filter_complex "overlay=main_w-overlay_w-5:25" -preset "ultrafast" -tune zerolatency -c:v libx264 -c:a aac -r 30 -crf 30 -f flv $SERVER_URL$STREAM_KEY
