module Formattable
  def http_link(passed_url)
   if passed_url[0..3] != "http"
      passed_url.prepend("http://")
   else
      passed_url
    end
  end
end