---
author: "Mitja Ševerkar"
title: "How not to root a phone"
date: "2023-03-17"
description: "Guide on rooting an Exynos-based phone and installing custom OS onto it."
---

This article is about rooting and installing custom OS onto a Samsung Exynos phone.

I'm using a [Samsung Galaxy A21s](https://en.wikipedia.org/wiki/Samsung_Galaxy_A21s) with. an Exynos chip, bought right here in Slovenia and is carrier unlocked.

When I was starting on rooting my phone, it was a horrible experience. I haven't found many tutorials, which were beginner-friendly and some were riddled with words I didn't understand.
I've learnt a lot while rooting my phone, have passed many challanges, such as bootloops, and would like to help a beginner to root their phone and potentially even install their custom ROM
onto it. So, this post is dedicated to all the beginners out there, I know it's hard, but don't give up. Most of this article should be the same for all Samsung devices, except
you will have to find other TWRP recoveries.

It was also a huge undocumented pain on how to install Magisk onto GSIs, so that's why I'm writing it here.

If you believe, you've followed the article correctly, and there are any issues or this article is incorrect at some points,
you may [contact me](mailto:mytja@protonmail.com) anytime and send the logs and your issue.

__WARNING:__ The author shall not be liable for any misuse and/or any damage made to the device.

# Stage 0 - Preparation
Requirements:
- [Samsung Firmware Downloader](https://forum.xda-developers.com/t/tool-samsung-samsung-firmware-downloader.4240719/)
- [Samsung Odin](https://forum.xda-developers.com/t/patched-odin-3-13-1.3762572/), preferably patched variant & newer version
- [adb](https://developer.android.com/studio/releases/platform-tools)
- [TWRP](https://github.com/DozNaka/exynos3830-a21s-twrp/releases/tag/twrp-2)
- [Magisk](https://github.com/topjohnwu/Magisk/releases/latest)
- Phone

# Stage 1 - Patch the stock firmware with Magisk
Open up the Samsung Firmware Downloader and download the appropriate image for your phone.

## Stage 1.1 - Find your CSC
1. Open your Samsung phone dialer, type in __*#1234#__.
2. You'll see a new screen with your firmware information.
3. Look at the CSC section, there you can find 4 characters, which are the model number, followed by three characters, which are the region codes.

## Stage 1.2 - Download
Input the region code and your model number into the corresponding inputs in Samsung Firmware Downloader, afterwards just download the latest image.

File will be downloading for some time, output file should be a `.tar.md5` file.

## Stage 1.3 - Transfer the stock image to your phone
You can use any file explorer for this. Preferably you should copy it to external media, such as an SD card, as it won't be erased onwards.

## Stage 1.4 - Install Magisk Manager
Install the latest `apk` from [Magisk's official GitHub](https://github.com/topjohnwu/Magisk/releases/latest).

## Stage 1.5 - Patch the stock image using Magisk Manager
Open the Magisk app on your phone and go to section, where it says Magisk and the currently installed version (none). Click `Install` and click `Select and Patch a File`,
where you'll find your Samsung stock image, select it and afterwards click `Let's go`.

__WARNING:__ If Magisk suddenly crashes, it's best to relaunch it after a reboot and restart the process of patching the file. Patched file is probably corrupted and shall not be used and/or flashed,
unless you want bootloops.

## Stage 1.6 - Transfer the patched Magisk image back to your computer
You can use any file explorer for this job. Meanwhile it's copying, you can do part 1.7.

## Stage 1.7 - Ensuring bootloader unlocking
On your phone, go to settings and enable developer mode. Afterwards, go to developer settings and enable `OEM unlocking`.
Wait for file transfer from beforehand to finish, before proceeding to Part 1.8.

## Stage 1.8 - Unlocking the bootloader
__WARNING:__ This __will__ trip Samsung Knox eFuse and there's no way to undo it. Once you do this process,
your bootloader will be unlocked and your warranty might be void (though legally, it wouldn't have been, yet manufacturers don't obey the laws).
After you trip your Knox eFuse, you won't be able to install and/or make some propriatery Samsung apps work (such as Samsung Pay, Samsung Wear).
Do this on your own responsibility.

Turn off the phone compeletely. Afterwards, hold Volume Up and Volume Down buttons, both together until a blue screen is displayed,
while plugging your phone into the computer's USB port through an USB-C to USB-A cable. Your device'll go into the Download mode,
where you'll be able to unlock the bootoloader. By holding the Volume Up button for long time, the device'll unlock the bootloader.

When the bootloader is unlocked, you can confirm this by an annoying message, that tells you about an unlocked bootloader on every device boot.

If your device reboots back to your operating system, go ahead and repeat the instructions about going into the Download mode.

## Stage 1.9 - Flash the patched image
__WARNING:__ You might have to download additional drivers for Odin to detect your device.

__WARNING:__ This might erase all of your data. Please make a backup beforehand.

Once in Download mode, go ahead and click Volume Up button to download a custom OS. Connect your phone to your computer, afterwards use Odin to flash the patched `AP` image.
Leave every field in Odin empty, except `AP`, where you should select the patched Magisk version.

After you've done that, click `Start` and wait for the process to finish. Once it finishes, it should reboot back to your operating system. You might have to set it up again.

__WARNING:__ You must go through the entire setup process before continuing to Part 2.

If you reinstall the Magisk apk, your device should now be rooted with a default ROM.
You do not have to continue with the process anymore, if you're happy with just rooting your phone and not changing the whole OS.

# Stage 2 - Installing TWRP and disabling filesystem-based encryption
If you want to install TWRP, make sure not to install any important applications, as we'll once again erase the whole `/data` partition.
## Stage 2.1 - Actual installation
As simple as going into Download mode in your phone and flashing the previously downloaded TWRP through the `AP` tab in Odin.

## Stage 2.2 - Disable Samsung filesystem encryption
You should now be back in your operating system (rooted with Magisk). Go into the Magisk app and click the reboot button in app bar. Click `Reboot to recovery`.

__WARNING:__ This __will__ erase all of your data.

Once in recovery, go to `Erase` or `Wipe`, where you'll click `Format Data` and confirm everything. After that's done, go back to your main screen,
where you'll go into Advanced -> Terminal, where you'll run the following command:

```sh
multidisabler
```

This command will disable Samsung's filesystem-based encryption, which will come in handy in case of wanting to install other operating systems.

# Stage 3 - Installing custom OS
I recommend the following GSIs, as they have been tested on my device:
- [phhusson's GSI](https://github.com/phhusson/treble_experimentations/releases/latest). You'd want to download the `system-squeak-arm64-ab-vndklite-*.img.xz`. `gogapps` comes with preinstalled Google Go apps, `gapps` comes with preinstalled Google (not Go) apps, `vanilla` comes with no preinstalled apps and `floss` comes with FOSS alternatives to Google's apps. Make sure to install the `vndklite` variant, as it'll make installing Magisk actually possible later on.

GSI is a system image, thus doesn't come with a kernel and doesn't come with a boot image. This means, your manufacturer provides the GSI

Once you download the custom OS, uncompress it (using 7-zip or something similar, so that file extension becomes `.img`), afterwards transfer it onto an SD card in your phone.
This'll make it much easier to install the GSI later on using TWRP.

Boot into recovery, if you aren't there already. Afterwards, you should go into the `Install` section, where you'll select the appropriate storage using the button `Select Storage`.
You should have your SD card selected. Make sure that there is a button `Install Zip`. If there is s button `Install Image`, click it, as we want to install a system image.
Select your downloaded image and in the section `Select Partition to Flash Image`, go ahead and select `System Image`. Once you're ready, go ahead and swipe to confirm the flash.
This'll take some time, but afterwards, you can reboot into your system, where you'll see your new OS successfully installed. You now may proceed with installation of your apps and
make the phone yours again, as we won't be erasing the `/data` partition anymore.

phhusson's GSI come with preinstalled root using phh-su, which is a fork of SuperSU. This is very outdated and not recommended, as it also isn't very practical to modify and customize your
system with. So, if you want to root your phone with Magisk, go ahead and read further.

# Stage 4 - Installing Magisk
Huge thanks to [@OnlyCS](https://github.com/topjohnwu/Magisk/issues/3593#issuecomment-751534120) on GitHub for his work on applying Magisk onto GSIs. It was very helpful.

## Stage 4.1 - Uninstalling phh-su
As phhusson's GSIs come with phh-su preinstalled instead of Magisk, it'll conflict with Magisk (which is installed in our boot image, which was patched in Stage 1) and use `phh-su` instead.
This means that Magisk will (even though the latest version is installed) report back an outdated version.
Ignore that as Magisk is installed and instead, let's focus on uninstalling the annoying `phh-su`, so that we can use Magisk.

OnlyCS's GitHub comment was adapted to be minimal. I only actually needed following things, if it doesn't work for you, you can always have a look at his comment and try other suggested things.

### Stage 4.1.1 - `adb shell`
Run the following commands in your terminal (command prompt, PowerShell, GNOME Terminal etc.).

1. `adb shell`
2. `su`
3. You might need to approve the superuser elevation request on your phone
4. `phh-securize.sh`

After you've done that, try restarting your phone and if Magisk doesn't report an outdated Magisk installation, you have succeeded in rooting your phone properly.
Now you can customize your phone even further. Congratulations. Continue to Stage 4.1.4.

If it still reports too low Magisk version, you might want to consider next step.

### Stage 4.1.2 - UnSU Script
Download the [UnSU script](https://forum.xda-developers.com/t/beta-2017-10-01-supersu-v2-82-sr5.2868133/page-122#post-63615067) and move it to the SD card of your phone.

Now go ahead and reboot to TWRP, where you'll go to `Install` part and click on `Install Zip` and find the downloaded UnSU `zip`.
The UnSU script will remove all traces of any root frameworks (such as Magisk, phh-su, SuperSU etc.).

You might want to try and repeat Stage 4.1.1 before and after this process just to be sure it's removed.

### Stage 4.1.3 - Other methods
If Magisk app now says, the phone is not rooted and doesn't display any messages about too old version of Magisk, please refer to the following methods of getting Magisk back on.

After each of these methods, check if Magisk works. If it doesn't continue to the next one.

#### Stage 4.1.3.1 - Install Magisk to Boot image
If Magisk now says, the phone is not rooted, then try to repeat the process, mentioned in stage 1.5 once again, but this time, you don't want to reset the whole operating system.
Try to open the before downloaded Samsung Stock image (not modified by Magisk) with 7-zip and extract the `boot.img` or the `boot.img.lz4`.
__GSIs are only system images and don't come with a Boot image, therefore you cannot use the phhusson's GSI in Magisk app.__
Afterwards, transfer it to the phone's SD card and patch the Boot image using the Magisk app. Transfer the patched Boot image back to your computer and flash it in Odin as `AP` file.
Of course, you need to be in Download mode to do this.

If Magisk app now says, the phone is rooted (or needs additional configuration), just follow the instructions in Magisk app, then you'll have your phone successfully rooted. Congratulations. 🎉

#### Stage 4.1.3.2 - Install Magisk as a zip
This is supposed to be your last resort.

Rename the downloaded Magisk apk for it's extension to be `.zip` (for example, rename from `Magisk-v25.1.apk` to `Magisk-v25.1.zip`) and move the made zip file to an SD card.
This can all be done on your phone. Then reboot to TWRP (can be done through the Magisk app) and install the zip, like mentioned in stage 4.1.2 (UnSU Script).
If Magisk installation zip in TWRP reports no errors, then it should be installed, otherwise, please reread the article, you must've done something incorrectly.
If you believe, you've followed the article, and the issue persists, you may [contact me](mailto:mytja@protonmail.com) and send the logs, that TWRP is outputing.

## Stage 4.2 - Success
If Magisk app now says, the phone is rooted (or needs additional configuration), just follow the instructions in Magisk app, then you'll have your phone successfully rooted. Congratulations. 🎉

## Stage 4.3 - Failure
If Magisk still insists, that it has a way too outdated image, you might also want to try things mentioned in the attached OnlyCS's comment on the issue, but if even that doesn't work,
then sorry, but I cannot help any further, as it was working for me using these steps, but you can always ask people on [XDA-Developers forum](https://forum.xda-developers.com/) 😄.

In this case, you might want (have) to stick to phh-su... 😔

Thank you so much for reading this article. I hope you've enjoyed it and found success in your renewed operating system and/or root options.

# Special thanks
- [@phhusson](https://github.com/phhusson) for the [treble_experimentations](https://github.com/phhusson/treble_experimentations) repository.
- [@topjohnwu](https://github.com/topjohnwu) for [Magisk](https://github.com/topjohnwu/Magisk).
- [@osm0sis](https://forum.xda-developers.com/m/osm0sis.4544860) for the [UnSU Script](https://forum.xda-developers.com/t/beta-2017-10-01-supersu-v2-82-sr5.2868133/page-122#post-63615067).
- [@OnlyCS](https://github.com/OnlyCS) for [their comment](https://github.com/topjohnwu/Magisk/issues/3593#issuecomment-751534120).
- [@DozNaka](https://github.com/DozNaka) for [A21s TWRP](https://github.com/DozNaka/exynos3830-a21s-twrp).

# Sources
- [OnlyCS's comment about GSI Magisk installation](https://github.com/topjohnwu/Magisk/issues/3593#issuecomment-751534120)
- [phhusson's treble_experimentations wiki about Samsung Galaxy A21s](https://github.com/phhusson/treble_experimentations/wiki/Samsung-Galaxy-A21s)
- [phhusson's treble_experimentations wiki](https://github.com/phhusson/treble_experimentations/wiki)

