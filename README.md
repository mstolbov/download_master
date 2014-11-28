DownloadMaster
===============
Console multry treads downloader

To use run follow commands in console
```
    $ git clone git@github.com:mstolbov/download_master.git
    $ bundle install
```

```
Usage: bin/grub URL DIR [options]
    URL - loading url
    DIR - directory to save images
Example: bin/grab "http://tamrecords.ru/podcasts/" /tmp
    -t, --timeout=N                  Connection timeout
    -l, --limit=N                    Limit urls count for one downloader
        --log=[file_name]            Log to file
    -h, --help                       Show this message
```
