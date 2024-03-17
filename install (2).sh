#!/bin/bash

main() {
    clear
    echo -e "Welcome to the MacSploit Experience!"
    echo -e "Install Script Version 2.2"
    
    


    echo -n "Downloading JSON Parser... "
    curl -s "https://git.abyssdigital.xyz/main/jq-macos-amd64" -o "./jq"
    chmod +x ./jq
    echo -e "Done."

    echo -e "Downloading Latest Roblox..."
    [ -f ./RobloxPlayer.zip ] && rm ./RobloxPlayer.zip
    local version=$(curl -s "https://clientsettingscdn.roblox.com/v2/client-version/MacPlayer" | ./jq -r ".clientVersionUpload")
    curl "http://setup.rbxcdn.com/mac/$version-RobloxPlayer.zip" -o "./RobloxPlayer.zip"
    rm ./jq

    echo -n "Installing Latest Roblox... "
    unzip -o -q "./RobloxPlayer.zip"
    mv ./RobloxPlayer.app /Users/pablovandersande/test/Roblox.app
    rm ./RobloxPlayer.zip
    echo -e "Done."

    echo -e "Downloading MacSploit..."
    curl "https://git.abyssdigital.xyz/main/macsploit.zip" -o "./MacSploit.zip"

    echo -n "Installing MacSploit... "
    unzip -o -q "./MacSploit.zip"
    echo -e "Done."

    echo -n "Updating Dylib..."
    curl -Os "https://git.abyssdigital.xyz/main/macsploit.dylib"
    echo -e " Done."

    echo -e "Patching Roblox..."
    mv ./macsploit.dylib "/Users/pablovandersande/test/Roblox.app/Contents/MacOS/macsploit.dylib"
    ./insert_dylib "/Users/pablovandersande/test/Roblox.app/Contents/MacOS/macsploit.dylib" "/Users/pablovandersande/test/Roblox.app/Contents/MacOS/RobloxPlayer" --strip-codesig --all-yes
    mv "/Users/pablovandersande/test/Roblox.app/Contents/MacOS/RobloxPlayer_patched" "/Users/pablovandersande/test/Roblox.app/Contents/MacOS/RobloxPlayer"
    rm ./insert_dylib

    echo -n "Installing MacSploit App... "
    mv ./MacSploit.app /Users/pablovandersande/test/MacSploit.app
    rm ./MacSploit.zip
    echo -e "Done."

    echo -e "Install Complete! Developed by Nexus42!"
    exit
}

main
