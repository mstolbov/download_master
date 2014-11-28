# Run tests:
# $ ruby -Ilib:test test/dm_benchmark.rb

require "minitest/autorun"
require 'minitest/benchmark'
require "./dm"


class DMBenchmark < Minitest::Benchmark
  def setup
    @default_options = {log: "dm_test.log"}
  end

  def bench_success
    Dir.mkdir "/tmp/dm"
    url = "http://tamrecords.ru/podcasts/"

    assert_performance_linear 0.99 do |n| # n is a range value
      DM.start(url, @default_options.merge(download_path: "/tmp/dm"))
    end


    system("rm -rf /tmp/dm")
  end

end
