#!/usr/bin/env bash

DEFAULT_BOOT_ORDER_STRING="0xf25641"

function get_boot_string_by_mode {
    local mode="$1"

    case $mode in
        sdcard)
            echo "0xf25641"
            ;;
        network)
            echo "0xf56412"
            ;;
        usb-msd)
            echo "0xf25614"
            ;;
        bcm-usb-msd)
            echo "0xf26415"
            ;;
        nvme)
            echo "0xf25416"
            ;;
        *)
            echo "skip"
            ;;
    esac
}

function get_boot_mode_by_nibble {
    local nibble="$1"

    case $nibble in
        1)
            echo "sdcard"
            ;;
        2)
            echo "network"
            ;;
        4)
            echo "usb-msd"
            ;;
        5)
            echo "bcm-usb-msd"
            ;;
        6)
            echo "nvme"
            ;;
        *) 
            echo "unknown"
            ;;
    esac
}

function get_current_boot_mode {
    local boot_mode_nibble="$(od -An -tu1 --skip 3 /proc/device-tree/chosen/bootloader/boot-mode |xargs)"
    get_boot_mode_by_nibble "$boot_mode_nibble"
}

boot_order="$1"
boot_from="$2"

if [ -n "$boot_order" ]; then
    echo "$boot_order"
    exit 0
fi

current_boot_mode="$(get_current_boot_mode)"
if [ "$boot_from" == "$current_boot_mode" ]; then
    echo "skip"
    exit 0
fi

get_boot_string_by_mode "$boot_from"    
