Bing Wallpaper for Gnome
========================

This script will download the Bing wallpaper of the day and set it as the background in Gnome.
In addition, it will set the background colour to the average pixel in the image.

Don't have a directory called ".wallpaper". It will delete its contents.

Based on a Bash script by [SeanKD](http://ubuntuforums.org/showthread.php?t=2074098)


Options
-------

*`--market <string>` / `-m <string>`*

Specify the Bing market. Currently these are:
* en-US
* en-GB
* zh-CN
* ja-JP
* en-AU    
* de-DE    
* en-NZ    
* en-CA
    
*`--bgopts` / `-b <string>`*

Specify the background options. One of:
* none
* wallpaper - Tiled wallpaper
* centered  - Centre wallpaper on desktop
* scaled    - Fit to size
* stretched - Stretch image regardless of aspect ratio
* zoom	    - Zoom image to fit width
* spanned   - Zoom across two or more screens
