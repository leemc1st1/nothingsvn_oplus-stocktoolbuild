#!/bin/bash
work_dir=$(pwd)

base_name=$(cat $work_dir/bin/ddevice/device_name.txt 2>/dev/null)
base_model=$(cat $work_dir/bin/ddevice/device_model.txt 2>/dev/null)
base_code=$(cat $work_dir/bin/ddevice/device_code.txt 2>/dev/null)

rom_type=$(cat $work_dir/bin/ddevice/brand_os.txt 2>/dev/null)
rom_version=$(cat $work_dir/bin/ddevice/rom_version.txt 2>/dev/null)
if [ -z "$rom_version" ]; then rom_version=$(cat $work_dir/bin/ddevice/base_build_id.txt 2>/dev/null); fi
rom_region=$(cat $work_dir/bin/ddevice/rom_region.txt 2>/dev/null)
android_ver=$(cat $work_dir/bin/ddevice/androidver.txt 2>/dev/null)

ntver=$(cat $work_dir/Version 2>/dev/null)
build_date=$(date +"%Y-%m-%d")

if [ -z "$base_model" ]; then
    base_model="unknown"
fi

OUTPUT_FILE="$work_dir/bin/script2flash/${base_model}.install"

cat <<EOF > "$OUTPUT_FILE"
{
    "Devices": {
        "Name": "${base_name:-Unknown}",
        "Brand": "OPLUS",
        "Model": "${base_model}",
        "Codename": "${base_code:-Unknown}"
    },
    "ROM": {
        "Type": "${rom_type:-Unknown}",
        "Version": "${rom_version:-Unknown}",
        "Region": "${rom_region:-Unknown}",
        "Android": "${android_ver:-Unknown}"
    },
    "ToolBuild": {
        "Version": "${ntver:-1.0}",
        "BuildDate": "${build_date}",
        "Author": "${builder_name:-Nothings}",
        "BuildType": "PureST-Release"
    },
    "Directory": {
        "Firmware": "firmware-update",
        "Images": "images",
        "System": "system"
    }
}
EOF

echo "Generated $OUTPUT_FILE"
