#!/bin/bash

# Set source and destination directories
DOWNLOADS_DIR="$HOME/Downloads/Bandcamp"
MUSIC_DIR="/media/ej/T7/Music/Library"

# Create music directory if it doesn't exist
mkdir -p "$MUSIC_DIR"

# Change to downloads directory
cd "$DOWNLOADS_DIR" || exit 1

# Iterate through all zip files
for zip_file in *.zip; do
    # Skip if no zip files found
    [[ -e "$zip_file" ]] || { echo "No zip files found in $DOWNLOADS_DIR"; exit 0; }
    
    # Extract artist and album from filename
    # Expected format: "Artist - Album.zip"
    if [[ $zip_file =~ (.+)\ -\ (.+)\.zip ]]; then
        artist="${BASH_REMATCH[1]}"
        album="${BASH_REMATCH[2]}"
        
        echo "Processing: $artist - $album"
        
        # Create artist directory if it doesn't exist
        artist_dir="$MUSIC_DIR/${artist}"
        mkdir -p "$artist_dir/$album"
        
        # Create temporary directory for extraction
        temp_dir=$(mktemp -d)
        
        # Unzip the file to temp directory
        unzip -q "$zip_file" -d "$temp_dir"
        
	# Move the contents to final destination
	mv "$temp_dir"/* "$artist_dir/$album"

        # Clean up temp directory
        rm -rf "$temp_dir"

	# Remove zip file
	rm "$zip_file"

        echo "✓ Moved to: $artist_dir/$album"
    else
        echo "⚠️  Warning: '$zip_file' doesn't match expected format 'Artist - Album.zip'"
    fi
done

echo "Done organizing music files!"

# test :! ./bandcamp.sh
