# Cursor Device ID Changer

This script is a simple tool designed to modify the device IDs used by the Cursor editor. It can be useful if frequent account switching causes your device to become locked. By running this script, you can reset these IDs.

## Features

- Automatically generate new random device IDs
- Automatically back up the original configuration file before making changes
- Supports providing a custom machine ID as an argument
- Uses system-provided tools and does not require additional dependencies

## Usage

1. Download the `change_id.sh` script.

2. Make the script executable:
    ```bash
    chmod +x change_id.sh
    ```
   
3. Run the script:
    - To use automatically generated IDs:
      ```bash
      ./change_id.sh
      ```
      
    - To specify a custom machine ID:
      ```bash
      ./change_id.sh your_custom_id
      ```

## Notes

- The script automatically creates a backup of the original configuration file before any modifications.
- The backup file is stored in the same directory as the original configuration file, with a timestamped suffix, e.g. `storage.json.backup_YYYYMMDD_HHMMSS`.
- Make sure to close the Cursor editor before running the script.
- This script has been tested on macOS systems.

## Configuration File Location

By default, the configuration file is located at:
```
~/Library/Application Support/Cursor/User/globalStorage/storage.json
```

## Disclaimer

This script is provided for educational and research purposes only. Using this script may violate the terms of service of the Cursor editor. Use at your own risk.
