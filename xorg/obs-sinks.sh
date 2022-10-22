#!/bin/bash

DEVICE="alsa_output.pci-0000_0b_00.3.pro-output-0"

pactl load-module module-remap-sink sink_name="OBS_output" \
master="$DEVICE" channels=2 \
master_channel_map=front-left,front-right channel_map=front-left,front-right \
remix=no sink_properties=device.description="OBS-Base-Output"
# pacmd update-sink-proplist base_output device.description="Base_Sink"
pactl load-module module-remap-sink sink_name="Music_output" \
master="$DEVICE" channels=2 \
master_channel_map=front-left,front-right channel_map=front-left,front-right \
remix=no sink_properties=device.description="OBS-Music-Output"
# pacmd update-sink-proplist music_output device.description="Music_Sink"
