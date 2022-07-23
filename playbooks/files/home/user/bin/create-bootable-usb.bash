#!/usr/bin/env bash
#
# !!! WARNING !!!
# Use this script with caution. It can wipe out your entire drive.
#
#
# As outlined in:
# https://gitlab.com/perobertson/scripts/-/issues/29
# It is intented to take an ISO as the first parameter and write it out to the disk specified in the second parameter.
set -euo pipefail

ISO="${1:? path to ISO is required}"
DISK="${2:? block device to write to is required}"

if basename "${ISO}" | grep --ignore-case '^win.*\.iso$' >/dev/null; then
    echo "ERROR: this script does not work with Windows ISOs."
    echo "TLDR: Use rufus on Windows to make one."
    echo "---"
    echo "See: https://itsfoss.com/bootable-windows-usb-linux/"
    echo "TLDR: Partition the drive using GPT."
    # ExFAT or NTFT must be used because there are files larger than 4G
    echo "TLDR: Create ExFAT or NTFS filesystem on the new partition."
    echo "TLDR: Copy the contents of the ISO to the new filesystem."
    exit 1
fi

ISO_SIZE="$(/usr/bin/du -b "${ISO}" | cut -f1)"

available=$(lsblk -o NAME,TYPE --noheadings -l | grep '[[:space:]]disk' | cut -f1 -d' ')

for drive in ${available[*]}; do
    if [[ "/dev/$drive" == "${DISK}" ]]; then
        if [[ $(id -u) -ne 0 ]]; then
            echo "re-run as root to run this command:"
            echo "dd if=\"${ISO}\" | pv -s \"${ISO_SIZE}\" | dd iflag=fullblock oflag=direct of=\"${DISK}\" bs=4M"
        else
            dd if="${ISO}" | pv -s "${ISO_SIZE}" | dd iflag=fullblock oflag=direct of="${DISK}" bs=4M
        fi
        exit 0
    fi
done

echo "Failed to find disk. Check lsblk"
