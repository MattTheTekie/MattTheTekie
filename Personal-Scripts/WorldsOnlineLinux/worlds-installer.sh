#!/bin/bash
export WTITLE="Worlds Linux"
export WORLDSVER="1922"
export WORLDSDIR="$(dirname $(readlink -f $0))"
export WINEPREFIX="$WORLDSDIR/prefix"
export WINEARCH=win32
export WORLDSINSTALL="$WINEPREFIX/drive_c/Program Files/Worlds/WorldsPlayer by Worlds.com"
export INSTALLER="$WORLDSDIR/WorldsInstaller.exe"

export WINE=$(which wine)

export WINETRICKSINSTALL="win7 droid renderer=gdi glsl=disabled devenum wmp9 dmsynth wmv9vcm directplay quartz ie8 mimeassoc=off"

start () {
	errorcheck
	zenity --info --title="$WTITLE Installer" --text 'Welcome to the Worlds Linux setup installer maintained by Wirlaburla. This will setup and install Worlds for use on Linux systems through WINE.' --width=320 --ok-label="Next"  
	zenity --info --title="$WTITLE Installer" --text 'NOTE: This wrapper has been known to become unreliable and may not work. Worlds is finnicky with WINE and may take manual tinkering to function.' --width=320 --ok-label="Next"  
	settings
}

errorcheck () {
	wine --version >> /dev/null || { zenity --error --title="$WTITLE Installer - Error" --text "Wine wasn't found! Please install it before continuing" --width=320 ; exit 1; }
	winetricks --help >> /dev/null || { zenity --error --title="$WTITLE Installer - Error" --text "Winetricks wasn't found! Please install it before continuing" --width=320 ; exit 1; }
	wget --help >> /dev/null || { zenity --error --title="$WTITLE Installer - Error" --text "Wget wasn't found! Please install it before continuing" --width=320 ; exit 1; }
}

settings () {
	SelOptions=$(zenity --list --title="$WTITLE - Settings" --text="Installer Options for $WTITLE" --column='Option' --column='Value' --cancel-label='Exit' --extra-button='Next' --width=400 --height=260 \
	"Install Location" "$WORLDSDIR" \
	"Wine Location" "$WINE" \
	"Prefix Location" "$WINEPREFIX" \
	"WineArch" "$WINEARCH" \
	"Worlds Version" "$WORLDSVER" \
	"Winetricks" "$WINETRICKSINSTALL" \
	2>/dev/null)
	case $SelOptions in
		'Install Location')
			WORLDSDIRSEL=$(zenity --file-selection --directory --title="$WTITLE - Install Location" --text="Wrapper Install Location" --save --confirm-overwrite --width=640 --height=480)
			if [[ ! $? -eq 1 ]]; then
				export WORLDSDIR=$WORLDSDIRSEL
			fi
			settings ;;
		'Wine Location')
			WINESEL=$(zenity --entry --title="$WTITLE - Wine Binary Location" --text="Path to wine binary" --entry-text="$WINE")
			if [[ ! $? -eq 1 ]]; then
				export WINE=$WINESEL
			fi
			settings ;;
		'Prefix Location')
			WINEPREFIXSEL=$(zenity --file-selection --directory --title="$WTITLE - WinePrefix" --text="Worlds Prefix location" --save --confirm-overwrite --width=640 --height=480)
			if [[ ! $? -eq 1 ]]; then
				export WINEPREFIX=$WINEPREFIXSEL
			fi
			settings ;;
		'WineArch')
			WINEARCHSEL=$(zenity --list --radiolist --title="$WTITLE - WineArch" --text="Architecture for Wine" --column='Use' --column='winearch' --hide-header --width=100 --height=200 \
				TRUE 'win32' \
				FALSE 'win64')
			if [[ ! $? -eq 1 ]]; then
				export WINEARCH=$WINEARCHSEL
			fi
			settings ;;
		'Worlds Version')
			WORVERSEL=$(zenity --list --radiolist --title="$WTITLE - Worlds Version" --text="Version of Worlds to install" --column='Use' --column='worldsver' --hide-header --width=100 --height=240 \
				TRUE '1922a10' \
				FALSE '1920' \
				FALSE '1900' \
				FALSE 'Custom')
			if [[ ! $? -eq 1 ]]; then
				export WORLDSVER=$WORVERSEL
			fi
			settings ;;
		'Winetricks')
			TRICKSEL=$(zenity --entry --title="$WTITLE - Winetricks" --text="Component to install." --entry-text="$WINETRICKSINSTALL" --width=400)
			if [[ ! $? -eq 1 ]]; then
				export WINETRICKSINSTALL=$TRICKSEL
			fi
			settings ;;
		'Next')
			work ;;
		esac
}

work () {
	if [[ "$WORLDSVER" -eq 'Custom' ]]; then
		INSTALLERSEL=$(zenity --file-selection --title="$WTITLE - Custom Worlds" --text="Worlds Custom Executable" --width=640 --height=480 --file-filter='Windows Executable (exe) | *.exe')
		if [[ ! $? -eq 1 ]]; then
			export INSTALLER=$INSTALLERSEL
		else
			download1922
		fi
		JAVASEL=$(zenity --question --title="$WTITLE - Java" --text="Will this Worlds install require Java 6 to be installed?" --width=300)
		if [[ ! $? -eq 1 ]]; then
			java
		fi
	else
		downloadVersion "$WORLDSVER"
	fi
	tricks
	codec
	worlds
	launchscript | zenity --progress --title="$WTITLE - Finalizing" --width=300 --height=50 --auto-close --auto-kill
	chmod +x "$WORLDSDIR/launch.sh"
	zenity --info --title="$WTITLE" --text="Worlds for Linux Wrapper has been setup and installed. You can now launch Worlds via the launch.sh script available at '$WORLDSDIR'." --width=340 --height=180
}

downloadVersion () {
	local ver="$1"
	export WORLDSINSTALL="$WINEPREFIX/drive_c/Program Files/Worlds Inc/WorldsPlayer - Win7"
	wget -O$INSTALLER "https://files.worlio.com/files/WorldsPlayer/software/Worlds$ver.exe" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="$WTITLE - Worlds $ver" --text="Starting Download.." --width=300 --height=50 --auto-close --auto-kill
	if [[ ! $ver -eq "1922a10" ]]; then
		java
	fi
}

java () {
	wget -O"$WORLDSDIR/JavaInstaller.exe" "http://users.worldsonline.com/jimbly/java/jre-6u23-windows-i586-s.exe" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="$WTITLE - Downloading Java 6" --text="Starting Download..." --width=300 --height=50 --auto-close --auto-kill
	$WINE "$WORLDSDIR/JavaInstaller.exe" /s 2>&1 | zenity --title="$WTITLE - Installing Java" --progress --pulsate --auto-close --width=300 --height=50 --auto-kill
}

tricks () {
	winetricks -f "$(echo $WINETRICKSINSTALL)" 2>&1 | zenity --title="$WTITLE - Winetricks" --text="Installing Components. This may require manual interaction." --progress --pulsate --auto-close --width=340 --height=50
}

codec() {
	wget -O"$WORLDSDIR/K-Lite.exe" "https://files3.codecguide.com/K-Lite_Codec_Pack_1535_Full.exe" 2>&1 | sed -u 's/.* \([0-9]\+%\)\ \+\([0-9.]\+.\) \(.*\)/\1\n# Downloading at \2\/s, ETA \3/' | zenity --progress --title="$WTITLE - Downloading K-Lite" --text="Starting Download..." --width=300 --height=50 --auto-close --auto-kill
	$WINE "$WORLDSDIR/K-Lite.exe" 2>&1 | zenity --title="$WTITLE - Installing K-Lite" --text="Please complete the setup." --progress --pulsate --auto-close --width=300 --height=50 --auto-kill
}

worlds () {
	wine "$(echo $INSTALLER)" 2>&1 | zenity --title="$WTITLE - Worlds Install" --text="Installing Worlds. Please complete the setup. Do NOT change the install location!" --progress --pulsate --auto-close --width=300 --height=50 --auto-kill
}

launchscript () {
	wget -O"$WORLDSDIR/launch.sh" "https://github.com/MattTheTekie/MattTheTekie/raw/master/Personal-Scripts/WorldsOnlineLinux/launch.sh"
	wget -qO- "http://www.worlds.net/favicon.ico" | convert - "$WORLDSDIR/icon.png"
	rm "$WORLDSDIR/wrldslinux"
	echo "# Configuration for Worlds on Linux." > "$WORLDSDIR/wrldslinux"
	echo "export WINE=\"$WINE\"" >> "$WORLDSDIR/wrldslinux"
	echo "export WINEPREFIX=\"$WINEPREFIX\"" >> "$WORLDSDIR/wrldslinux"
	echo "export WORLDSDIR=\"$WORLDSDIR\"" >> "$WORLDSDIR/wrldslinux"
	echo "export WORLDSINSTALL=\"$WORLDSINSTALL\"" >> "$WORLDSDIR/wrldslinux"
	echo "source \"$WORLDSDIR/wlrdscmd\"" >> "$WORLDSDIR/wrldslinux"
	touch "$WORLDSDIR/wlrdscmd"
	rm "$HOME/Desktop/WorldsPlayer Win7.*"
	menufile
}

menufile () {
    wget -O"$WORLDSDIR/worlds.desktop" "https://raw.githubusercontent.com/MattTheTekie/MattTheTekie/master/Personal-Scripts/WorldsOnlineLinux/worlds.desktop"
    echo "" > "$HOME/.local/share/applications/worlds.desktop" #Making sure the file is clear.
    while read line 
    do
        line=${line/\${WORLDSDIR\}/$WORLDSDIR}
        echo $line >> "$HOME/.local/share/applications/worlds.desktop"
    done < "$WORLDSDIR/worlds.desktop"
}

start
