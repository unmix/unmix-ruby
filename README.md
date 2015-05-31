# Unmix

```bash
./unmix [ youtube | mixcloud | soundcloud | other ] -i [ input ] 
```
Command line tool to: 
  * Download
  * Cut
  * Rename files
  * Move to a compilation folder on your desktop
  * Download Album Artwork (WIP!)
  * Add to iTunes (WIP!)

Supported Sources:
  * Full Albums on YouTube
  * Mixcloud mixes
  * Soundcloud mixes (WIP!)

## Examples:

```bash

# check if depended software is installed.
# this was not tested much and still considered WIP!
macbook:unmix elad$ ./unmix.rb doctor
youtube-dl was found
ffmpeg was found


# the following will download and orginize the 
# "Gentle Giant - The Power and the Glory" album from the given YouTube URL.
macbook:unmix elad$ ./unmix.rb youtube --input https://www.youtube.com/watch?v=5S8lKZ0MMUQ

Step 1: Analyzing source https://www.youtube.com/watch?v=5S8lKZ0MMUQ
Found the following information:
INDEX | NAME                           | DURATION | START_TIME | END_TIME
------|--------------------------------|----------|------------|---------
01    |  "Proclamation"                | 408.0    | 00:00      | 06:48   
02    |  "So Sincere"                  | 232.0    | 06:48      | 10:40   
03    |  "Aspirations"                 | 280.0    | 10:40      | 15:20   
04    |  "Playing the Game"            | 407.0    | 15:20      | 22:07   
05    |  "Cogs in Cogs"                | 187.0    | 22:07      | 25:14   
06    |  "No God's a Man"              | 268.0    | 25:14      | 29:42   
07    |  "The Face"                    | 252.0    | 29:42      | 33:54   
08    |  "Valedictory"                 | 200.0    | 33:54      | 37:14   
09    |  "The Power and the Glory" ... | 15766.0  | 37:14      | 5:00:00 

Donwloading.
[youtube] 5S8lKZ0MMUQ: Downloading webpage
[youtube] 5S8lKZ0MMUQ: Extracting video information
[youtube] 5S8lKZ0MMUQ: Downloading DASH manifest
[download] Destination: ./tmp/_download.m4a
[download] 100% of 36.46MiB in 00:13
[ffmpeg] Correcting container in "./tmp/_download.m4a"

Cutting Video File.

Orginizing Into an Album Folder.

All Done!

macbook:unmix elad$ cd exports/Gentle_Giant_-_The_Power_and_the_Glory__full_album_/

macbook:Gentle_Giant_-_The_Power_and_the_Glory__full_album_ elad$ ls -l
total 74680
-rw-r--r--  1 elad  staff  6476897 May 31 14:25 01.Proclamation.m4a
-rw-r--r--  1 elad  staff  3682740 May 31 14:25 02.SoSincere.m4a
-rw-r--r--  1 elad  staff  4445152 May 31 14:25 03.Aspirations.m4a
-rw-r--r--  1 elad  staff  6460672 May 31 14:25 04.PlayingtheGame.m4a
-rw-r--r--  1 elad  staff  2969172 May 31 14:25 05.CogsinCogs.m4a
-rw-r--r--  1 elad  staff  4254448 May 31 14:25 06.NoGodsaMan.m4a
-rw-r--r--  1 elad  staff  4000778 May 31 14:25 07.TheFace.m4a
-rw-r--r--  1 elad  staff  3175227 May 31 14:25 08.Valedictory.m4a
-rw-r--r--  1 elad  staff  2751830 May 31 14:25 09.ThePowerandtheGlorybonustrack.m4a


# The following will download the Headphone Commute's DJ Set: "Stationary Travels – The Ocean Inside"
# from the given mixcloud URL and will cut and originize the set into songs.

macbook:unmix elad$ ./unmix.rb mixcloud --input https://www.mixcloud.com/HeadphoneCommute/stationary-travels-the-ocean-inside/
...
macbook:Stationary_Travels___The_Ocean_Inside elad$ ls -l
total 252168
-rw-r--r--  1 elad  staff  13441759 May 31 10:46 01.SiavashAmini-AMistofGreyLight.mp3
-rw-r--r--  1 elad  staff   8065132 May 31 10:46 02.SiavashAmini-AlioshaandtheFire.mp3
-rw-r--r--  1 elad  staff   9825576 May 31 10:46 03.Idlefon-Reminiscence.mp3
-rw-r--r--  1 elad  staff   7138098 May 31 10:46 04.IdlefonwithNimaPourkarimi-PickersofEmptyCocoons.mp3
-rw-r--r--  1 elad  staff   9153498 May 31 10:46 05.Umchunga-TheDuskTheCarTheRainandDowninTheBottle.mp3
-rw-r--r--  1 elad  staff  13761916 May 31 10:47 06.PoryaHatami-Ladybug.mp3
-rw-r--r--  1 elad  staff  16865680 May 31 10:47 07.PoryaHatami-Farewell.mp3
-rw-r--r--  1 elad  staff  11713915 May 31 10:47 08.Tegh-Down.mp3
-rw-r--r--  1 elad  staff  13026308 May 31 10:47 09.TeghandKamyarTavakoli-Hollow.mp3
-rw-r--r--  1 elad  staff  11201497 May 31 10:47 10.ArashAkbari-RaysFromaDeadStar.mp3
-rw-r--r--  1 elad  staff  14897813 May 31 10:47 11.ArashAkbari-UntilTimeSitsbyYourSideSoftRecordings.mp3

```

## Dependencies
1. youtube-dl (always latest!)
2. ffmpeg (v2+)

## License
Copyright (c) 2011-2014. See the LICENSE file for license rights and limitations (MIT).