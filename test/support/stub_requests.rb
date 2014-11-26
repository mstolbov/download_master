def stub_start_page
  stub_request(:get, "https://www.test.host/images").
    with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Ruby'}).
    to_return(:status => 200, :body => load_fixrute("start_page.html"), :headers => {})
end
