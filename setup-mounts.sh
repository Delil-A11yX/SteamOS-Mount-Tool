#!/bin/bash

# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #
#                                                                             #
#                      SteamOS Easy Mount Tool                                #
#                                                                             #
# # # # # # # # # # #s# # # # # # # # # # # # # # # # # # # # # # # # # # # # # # #

# --- Main Function ---
main() {
    clear
    echo "====================================================="
    echo "           Steam Deck Easy Mount Tool"
    echo "====================================================="
    echo
    echo "This script will help you permanently auto-mount"
    echo "a drive (partition) on your SteamOS device."
    echo

    # --- Partition Selection ---
    echo "Scanning for available drives..."
    echo "-----------------------------------------------------"

    mapfile -t partitions < <(lsblk -o NAME,FSTYPE,LABEL,SIZE,UUID --noheadings --list | grep -E 'ntfs|ext4|btrfs|exfat|vfat')

    if [ ${#partitions[@]} -eq 0 ]; then
        echo "No suitable drives (ntfs, ext4, etc.) were found."
        read -p "Press Enter to exit."
        exit 1
    fi

    echo "Please select the drive (partition) you want to set up:"
    PS3="Enter the number of the drive: "
    select choice in "${partitions[@]}" "Cancel"; do
        if [ "$choice" == "Cancel" ]; then
            echo "Operation cancelled."
            exit 0
        elif [ -n "$choice" ]; then
            break
        else
            echo "Invalid selection. Please try again."
        fi
    done

    # --- Extract Info ---
    DEVICE_NAME=$(echo "$choice" | awk '{print $1}')
    DEVICE_PATH="/dev/$DEVICE_NAME"

    UUID=$(lsblk -o UUID -n "$DEVICE_PATH")
    FSTYPE=$(lsblk -o FSTYPE -n "$DEVICE_PATH")

    if [ -z "$UUID" ] || [ -z "$FSTYPE" ]; then
        echo "Error: Could not get details for $DEVICE_NAME."
        read -p "Press Enter to exit."
        exit 1
    fi

    echo "-----------------------------------------------------"
    echo "Selected Drive: $DEVICE_NAME"
    echo "UUID: $UUID"
    echo "Filesystem: $FSTYPE"
    echo "-----------------------------------------------------"

    # --- Get Mount Name ---
    read -p "Enter a short, simple name for this drive (e.g. 'games', 'sdcard', no spaces): " mount_name
    mount_name=$(echo "$mount_name" | tr '[:upper:]' '[:lower:]' | tr -d ' /')

    if [ -z "$mount_name" ]; then
        echo "No name entered. Aborting."
        read -p "Press Enter to exit."
        exit 1
    fi

    # --- Create and Apply Configuration ---
    MOUNT_PATH="/var/mnt/$mount_name"
    UNIT_FILENAME="var-mnt-$mount_name.mount"
    UNIT_FILE_PATH="/etc/systemd/system/$UNIT_FILENAME"

    echo "Creating mount folder at $MOUNT_PATH..."
    mkdir -p "$MOUNT_PATH"

    echo "Creating systemd service file: $UNIT_FILENAME..."

    cat > "$UNIT_FILE_PATH" <<EOF
[Unit]
Description=Mount $mount_name Partition
After=local-fs.target

[Mount]
What=/dev/disk/by-uuid/$UUID
Where=$MOUNT_PATH
Type=$FSTYPE
Options=defaults,nofail

[Install]
WantedBy=multi-user.target
EOF

    echo "Activating the new service..."
    systemctl daemon-reload
    systemctl enable --now "$UNIT_FILENAME"

    echo "-----------------------------------------------------"
    if systemctl is-active --quiet "$UNIT_FILENAME"; then
        echo "✅ Success! Your drive is now permanently mounted at $MOUNT_PATH"
    else
        echo "❌ Error! The service could not be started."
        echo "   Check the status with: systemctl status $UNIT_FILENAME"
    fi

    echo
    read -p "Press Enter to exit."
}

# --- Run the main function ---
main
