#!/bin/bash
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )
source $SCRIPT_DIR/config
# Config

get_cover() {
	echo "COVER = ${COVER}"
	echo "COVER_TMP = ${COVER_TMP}"
	if [[ $(ls -d "${ROOT_PATH}"/* | grep "${COVER}") != "" ]] then
  		mv "${COVER}" "${COVER_TMP}"
  	fi
  music_file="${MUSIC_DIR}/$(mpc --host=$MPD_HOST current -f %file%)"
  album_dir=$(echo "${music_file}" | sed "s/\/[^\/]*$//")
  current_song="$(mpc --host=$MPD_HOST current)"
  if ffmpeg -i "${music_file}" "${COVER}" -y &> /dev/null; then
    echo "Found embedded art for $current_song"
  else
    music_file=$(find "${album_dir}/" -regextype posix-egrep -regex '.*(cover|folder).*' | head -n 1)
    cp "$music_file" "${COVER}" \
      && echo "Found art in folder for $current_song" \
      || echo "Could not find art for $current_song"
  fi
  cmp -s "${COVER_TMP}" "${COVER}"
  return $((! $?))
}

get_title() {
	echo "$(mpc --host=$MPD_HOST --format %title% | head -n 1)" > ${ROOT_PATH}/title.json
}

get_artist() {
	echo "$(mpc --host=$MPD_HOST --format %artist% | head -n 1)" > ${ROOT_PATH}/artist.json
}


MAGICK_OCL_DEVICE=true
qs -p ${ROOT_PATH} &
while "true"; do
  status="$(mpc --host=$MPD_HOST status %state%)"
  if get_cover; then
    echo "Cover different from last, changing wallpaper"
    if [[ ${status} == "playing" || ${status} == "paused" ]]; then
      get_title
      get_artist
      eval "$QUICKSHELL_COMMAND &"
      elif [[ ${status} == "MPD error: Connection refused" ]]; then
      sleep 1
      continue
    else
      echo "mpd status: $status"
      eval "$QUICKSHELL_COMMAND &"
      get_title
      get_artist
    fi
  fi
  mpc --host=$MPD_HOST current --wait > /dev/null
done

