def stub_start_url_200
  stub_request(:get, "https://www.test.host/images").
    to_return(:status => 200, :body => load_fixrute("start_page.html"), :headers => {})
end

def stub_start_url_502
  stub_request(:get, "https://www.badtest.host/images").
    to_return(:status => 502, :body => "Bad Request", :headers => {})
end
