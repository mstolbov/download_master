# Run tests:
# $ ruby -Ilib:test test/dm_benchmark.rb

require "minitest/autorun"
require 'minitest/benchmark'
require "./dm"

module DMBenchmarkPatch
  def on_success(respond)
    logger.info "Success load page #{@page_uri}"
    urls = images_urls respond.body

    until urls.empty? do
      next_load_urls_part = urls.pop(@options[:urls_limit])

      downloader = DM::Downloader.new(next_load_urls_part, @options[:download_path], logger, {timeout: @options[:timeout]})
      downloader.start
    end
    logger.info "Done!"
    puts "Done!"
  end
end

class DMBenchmark < Minitest::Benchmark
  def setup
    system("rm -rf /tmp/dm") if Dir.exists? "/tmp/dm"
    @default_options = {log: "dm_test.log"}
  end

  def bench_without_threads
    DM.include DMBenchmarkPatch
    Dir.mkdir "/tmp/dm"
    url = "http://tamrecords.ru/podcasts/"

    assert_performance_linear 0.99 do |n| # n is a range value
      DM.start(url, @default_options.merge(download_path: "/tmp/dm"))
    end
    system("rm -rf /tmp/dm")
  end

  def bench_with_threads
    Dir.mkdir "/tmp/dm"
    url = "http://tamrecords.ru/podcasts/"

    assert_performance_linear 0.99 do |n| # n is a range value
      DM.start(url, @default_options.merge(download_path: "/tmp/dm"))
    end
    system("rm -rf /tmp/dm")
  end

end
