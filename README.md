# XIVData

This is a collection of CSV and image files used for updating my Final Fantasy XIV web applications. The data is generated using [Saint Coinach](https://github.com/ufx/SaintCoinach).

## Requirements
* [7-Zip](https://www.7-zip.org/)

### Generating the latest data

To generate the latest CSV data, see the instructions for [XIVData Oxidizer](https://github.com/mattantonelli/xiv-data-oxidizer).

The `extract.bat` script (which is soon to be obsolete) can be used to extract images.

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

Music samples are no longer supported.

---

FINAL FANTASY is a registered trademark of Square Enix Holdings Co., Ltd.

FINAL FANTASY XIV © SQUARE ENIX CO., LTD.
