# XIVData

This is a collection of CSV and image files used for updating my Final Fantasy XIV web applications. The data is generated using [Saint Coinach](https://github.com/ufx/SaintCoinach).

## Requirements
* [7-Zip](https://www.7-zip.org/)
* [FFmpeg](https://ffmpeg.org/download.html) (FFXIV Collect Music Samples)
* [Vorbis](https://xiph.org/vorbis/) (FFXIV Collect Music Samples)


### Generating the latest data

1. Download the latest version of SaintCoinach.Cmd from the project's [releases page](https://github.com/xivapi/SaintCoinach/releases)
2. Unzip the archive and navigate into it
3. Copy `extract.bat` from this repository into the Saint Coinach folder
4. Edit the paths in the script as necessary
5. Run the script and check the changes into GitHub (Note: Windows has a serious fear of bats)

### Images

Image data is no longer stored in this repository. The extract script will generate a `ui.zip` file in this directory, but it is up to the user to unarchive this where it is needed. My applications will expect the images to exist under `/var/rails/images/ffxiv`. After creating this directory with the necessary permissions, you can use the following script to unzip the archive in this directory:

```sh
#!/usr/bin/env sh
mv ui.zip /var/rails/images/ffxiv
cd /var/rails/images/ffxiv
unzip -oq ui.zip
find ui -type f -exec chmod 664 {} \;
rm ui.zip
```

### Music Samples

A similar script can be used for processing music samples for FFXIV Collect:

```sh
mv music.zip /var/rails/music/ffxiv
cd /var/rails/music/ffxiv
unzip -oq music.zip
find . -type f -exec chmod 664 {} \;
rm music.zip
```

---

FINAL FANTASY is a registered trademark of Square Enix Holdings Co., Ltd.

FINAL FANTASY XIV © SQUARE ENIX CO., LTD.
