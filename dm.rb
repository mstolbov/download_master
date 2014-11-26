require 'net/http'
require 'uri'

uri = URI("https://www.google.ru/search?q=funbox&newwindow=1&espv=2&biw=1177&bih=682&source=lnms&tbm=isch&sa=X&ei=J0t2VN-gF8mGywPwzYGYAQ&ved=0CAYQ_AUoAQ")
h = Net::HTTP.new(uri.host, uri.port)
h.use_ssl = true if uri.scheme.eql?("https")
resp = h.get("#{uri.path}?#{uri.query}")
puts resp.code
puts resp.message
