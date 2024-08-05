### Description
It's a batch script that create a voice mod for [OpenKH's mod manager](https://github.com/OpenKH/OpenKh/releases/latest) or a voice patch for [KHPCPatchManager](https://github.com/AntonioDePau/KHPCPatchManager/releases/latest) from the original .scd files and .wav files. It's only for Kingdom Hearts 1 PC version but the script can make your .scd files for any games the modified files will be in the output folder instead of a already created patch/mod.

The .scd files will have the maximum volume possible without clipping, the files are normalized and hex edited for that.

### How to use
- Firstly you'll need the files to put in "OGFilesHere" so you have to export the kh1_fifth.hed, kh1_first.hed, kh1_fourth.hed and kh1_third.hed in order to get the .scd files asked in "OGFilesHere\PutOGFilesHere.txt".
- Then you'll need all the .wav files to change the .scd it can be exported and converted from a PS2 copy or anything else.
  - For myself I used [KH1 ISOMaker.exe](http://crazycatz00.x10host.com/KH/files/app_KH1_ISOMaker.7z) V2.0.0.0 of CrazyCatz00 to extract the files from KH1.
  - Then I used [VAGExtractor.exe](https://github.com/Noxalus/KHPC-Toolkit/releases/latest) V1.0.0.0 of Noxalus to extract the .vag files from .dat, .mdls, .vsb and .vset files. (I suggest to do a command like this: VAGExtractor.exe inputfile.vsb output 2)
  - And finally I used [vgmstream](https://github.com/vgmstream/vgmstream/releases/latest) to convert the .vag files into .wav (PCM) files.
- For the combat voices clips (in .vsb folders) the voices clips are a bit shuffled so I suggest to use the kh1fm_mapping.json that I made for Noxalus to find the PC order (if the voices clips in combat are shuffled ingame it's that the kh1fm_mapping.json is wrong I'm not sure if it's correct for every version).
- Now that all your files are like the PutOGFilesHere.txt asked you just have to put the files in OGFilesHere and run the "~RunMeAfterPuttingTheFilesInOGFilesHere.bat".

### Update
You can update [ffmpeg](https://ffmpeg.org/download.html), [KHPCPatchManager](https://github.com/AntonioDePau/KHPCPatchManager/releases/latest), [MultiEncoder](https://github.com/Leinxad/KHPCSoundTools/releases/latest), the resources of KHPCPatchManager and the tools of MultiEncoder if you want but it shouldn't be needed.

However [Python](https://www.python.org/downloads) is needed. 