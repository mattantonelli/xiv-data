# Another Triple Triad Tracker - Data

This is a collection of CSV and image files used in generating the ATTT database and card images. This data is generated using [Saint Coinach](https://github.com/ufx/SaintCoinach).

### Generating the latest data

1. Download the latest SaintCoinach.Cmd binary from the project's [releases page](https://github.com/ufx/SaintCoinach/releases)
2. Unzip the archive and navigate to it using PowerShell
3. Run the following commands:
```
.\SaintCoinach.Cmd.exe 'C:\Path\To\Game\FINAL FANTASY XIV - A Realm Reborn'
allexd ENpcBase ENpcResident Map TripleTriad TripleTriadCard TripleTriadCardResident TripleTriadCardType
rawexd Level TripleTriad TripleTriadRule
ui 082101 082999
```
4. Move the files from `exd-all` to the project's `csv` directory
5. Append the text `.raw` to the files in `rawexd` and move them to the project's `csv` directory
5. Move the files from `ui\icon\082000` to the project's `images` directory
