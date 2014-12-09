DownloadMaster
===============
Console multry treads downloader

To use run follow commands in console:
```
    $ git clone git@github.com:mstolbov/download_master.git
    $ bundle install
```

How to use:
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

How to run test:
`$ ruby -Ilib:test test/dm_test.rb`

Benchmarks:

Running with using threads:
```
$ ruby -Ilib:test test/dm_benchmark.rb
Run options: --seed 42083

# Running:

bench_successDone!
	 1.390638Done!
	 1.401353Done!
	 0.979945Done!
	 1.190786Done!
	 1.025677
F

Finished in 6.028606s, 0.1659 runs/s, 0.1659 assertions/s.

  1) Failure:
DMBenchmark#bench_success [test/dm_benchmark.rb:18]:
Expected 0.25658956412875356 to be >= 0.99.

1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```

```
$ time bin/grab "http://tamrecords.ru/podcasts/" /tmp/img
Done!

real	0m1.368s
user	0m0.324s
sys	0m0.092s
```

Running without using threads: (for do this, I change code. See diff
below)
```
$ ruby -Ilib:test test/dm_benchmark.rb
Run options: --seed 52687

# Running:

bench_successDone!
	 7.805880Done!
	 8.501289Done!
	 9.206738Done!
	 9.097851Done!
	 8.704977
F

Finished in 43.356226s, 0.0231 runs/s, 0.0231 assertions/s.

  1) Failure:
DMBenchmark#bench_success [test/dm_benchmark.rb:18]:
Expected 0.00855938733443573 to be >= 0.99.

1 runs, 1 assertions, 1 failures, 0 errors, 0 skips
```


```
$ time bin/grab "http://tamrecords.ru/podcasts/" /tmp/img
Done!

real	0m8.471s
user	0m0.320s
sys	0m0.092s
```
