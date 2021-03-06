class UrHouseCrawler
  include HTTParty
  attr_reader :city, :page

  def initialize(city: 'taipei', page: 1)
    raise 'city should be either "taipei" or "new taipei"' if !['taipei', 'new taipei'].include?(city)

    @city = city
    @page = page
  end

  def perform
    self.class.get(url)["data"]["items"]
  end

  private

  def url
    return url_taipei if city == 'taipei'
    url_new_taipei
  end

  def url_taipei
    # base on request form urhouse.com
    # get condition with: 台北市，住宅，NTD 30000 - 100000, sort from low to hight
    # the filter params is encrypted
   "https://www.urhouse.com.tw/tw/rentals/ajax?page=#{page}&filter=JTdCJTIydHlwZSUyMiUzQSUyMnJlc2lkZW50aWFsJTIyJTJDJTIyY2l0eSUyMiUzQSUyMiVFNSU4RiVCMCVFNSU4QyU5NyVFNSVCOCU4MiUyMiUyQyUyMmRpc3QlMjIlM0ElNUIlNUQlMkMlMjJsYXlvdXQlMjIlM0ElMjIlMjIlMkMlMjJyZW50JTIyJTNBJTdCJTIybWluJTIyJTNBJTIyMzAwMDAlMjIlMkMlMjJtYXglMjIlM0ElMjIxMDAwMDAlMjIlN0QlMkMlMjJmbG9vcl9zaXplJTIyJTNBJTdCJTIybWluJTIyJTNBJTIyJTIyJTJDJTIybWF4JTIyJTNBJTIyJTIyJTdEJTJDJTIycGFya2luZyUyMiUzQSU3QiUyMnBsYW5lJTIyJTNBJTIyJTIyJTJDJTIybWVjaGFuaWNhbCUyMiUzQSUyMiUyMiU3RCUyQyUyMmhhc19wYXJraW5nJTIyJTNBJTIyJTIyJTJDJTIybWFwJTIyJTNBJTdCJTIyc291dGglMjIlM0EwJTJDJTIyd2VzdCUyMiUzQTAlMkMlMjJub3J0aCUyMiUzQTAlMkMlMjJlYXN0JTIyJTNBMCU3RCUyQyUyMnJlc2lkZW50aWFsJTIyJTNBJTdCJTIydG90YWxfcm9vbSUyMiUzQSU3QiUyMm1pbiUyMiUzQSUyMjElMjIlMkMlMjJtYXglMjIlM0ElMjIzJTIyJTdEJTJDJTIyYnVpbGRpbmdfYWdlJTIyJTNBJTdCJTIybWluJTIyJTNBJTIyJTIyJTJDJTIybWF4JTIyJTNBJTIyJTIyJTdEJTJDJTIyZmxvb3IlMjIlM0ElN0IlMjJtaW4lMjIlM0ElMjIlMjIlMkMlMjJtYXglMjIlM0ElMjIlMjIlMkMlMjJ0b3duaG91c2UlMjIlM0ElMjIlMjIlN0QlMkMlMjJmbG9vcl9zaXplJTIyJTNBJTdCJTIybWluJTIyJTNBJTIyJTIyJTJDJTIybWF4JTIyJTNBJTIyJTIyJTdEJTJDJTIybWFpZF9yb29tJTIyJTNBJTIyJTIyJTJDJTIydGVycmFjZSUyMiUzQSUyMiUyMiUyQyUyMm9wZW5fa2l0Y2hlbiUyMiUzQSUyMiUyMiUyQyUyMmJhdGh0dWIlMjIlM0ElMjIlMjIlMkMlMjJpc19wZXR0YWJsZSUyMiUzQSUyMiUyMiUyQyUyMnNob3J0X3Rlcm0lMjIlM0ElMjIlMjIlMkMlMjJiYWxjb255JTIyJTNBJTIyJTIyJTJDJTIyaG9hJTIyJTNBJTIyJTIyJTJDJTIyZ2FyYmFnZSUyMiUzQSUyMiUyMiUyQyUyMmRlc2tfY2hhaXIlMjIlM0ElMjIlMjIlMkMlMjJ3aWZpJTIyJTNBJTIyJTIyJTJDJTIycGF5X2NhYmxlJTIyJTNBJTIyJTIyJTJDJTIyZ2FzJTIyJTNBJTIyJTIyJTJDJTIyYWlyX2NvbmRpdGlvbiUyMiUzQSUyMiUyMiUyQyUyMnRlbGV2aXNpb24lMjIlM0ElMjIlMjIlMkMlMjJ3YXJkcm9iZSUyMiUzQSUyMiUyMiUyQyUyMmJlZCUyMiUzQSUyMiUyMiUyQyUyMmJvaWxlciUyMiUzQSUyMiUyMiUyQyUyMndhc2hlciUyMiUzQSUyMiUyMiUyQyUyMnJlZnJpZ2VyYXRvciUyMiUzQSUyMiUyMiUyQyUyMm1pY3Jvd2F2ZSUyMiUzQSUyMiUyMiU3RCUyQyUyMm9mZmljZSUyMiUzQSU3QiU3RCUyQyUyMnN0b3JlZnJvbnQlMjIlM0ElN0IlN0QlN0Q%3D&ordering=price&direction=ASC&mode=list"
  end

  def url_new_taipei
     # base on request form urhouse.com
    # get condition with: 新北市，住宅，NTD 30000 - 100000, sort from low to hight
    # the filter params is encrypted
    "https://www.urhouse.com.tw/tw/rentals/ajax?page=#{page}&filter=JTdCJTIydHlwZSUyMiUzQSUyMnJlc2lkZW50aWFsJTIyJTJDJTIyY2l0eSUyMiUzQSUyMiVFNiU5NiVCMCVFNSU4QyU5NyVFNSVCOCU4MiUyMiUyQyUyMmRpc3QlMjIlM0ElNUIlNUQlMkMlMjJsYXlvdXQlMjIlM0ElMjIlMjIlMkMlMjJyZW50JTIyJTNBJTdCJTIybWluJTIyJTNBJTIyMzAwMDAlMjIlMkMlMjJtYXglMjIlM0ElMjIxMDAwMDAlMjIlN0QlMkMlMjJmbG9vcl9zaXplJTIyJTNBJTdCJTIybWluJTIyJTNBJTIyJTIyJTJDJTIybWF4JTIyJTNBJTIyJTIyJTdEJTJDJTIycGFya2luZyUyMiUzQSU3QiUyMnBsYW5lJTIyJTNBJTIyJTIyJTJDJTIybWVjaGFuaWNhbCUyMiUzQSUyMiUyMiU3RCUyQyUyMmhhc19wYXJraW5nJTIyJTNBJTIyJTIyJTJDJTIybWFwJTIyJTNBJTdCJTIyc291dGglMjIlM0EwJTJDJTIyd2VzdCUyMiUzQTAlMkMlMjJub3J0aCUyMiUzQTAlMkMlMjJlYXN0JTIyJTNBMCU3RCUyQyUyMnJlc2lkZW50aWFsJTIyJTNBJTdCJTIydG90YWxfcm9vbSUyMiUzQSU3QiUyMm1pbiUyMiUzQSUyMiUyMiUyQyUyMm1heCUyMiUzQSUyMiUyMiU3RCUyQyUyMmJ1aWxkaW5nX2FnZSUyMiUzQSU3QiUyMm1pbiUyMiUzQSUyMiUyMiUyQyUyMm1heCUyMiUzQSUyMiUyMiU3RCUyQyUyMmZsb29yJTIyJTNBJTdCJTIybWluJTIyJTNBJTIyJTIyJTJDJTIybWF4JTIyJTNBJTIyJTIyJTJDJTIydG93bmhvdXNlJTIyJTNBJTIyJTIyJTdEJTJDJTIyZmxvb3Jfc2l6ZSUyMiUzQSU3QiUyMm1pbiUyMiUzQSUyMiUyMiUyQyUyMm1heCUyMiUzQSUyMiUyMiU3RCUyQyUyMm1haWRfcm9vbSUyMiUzQSUyMiUyMiUyQyUyMnRlcnJhY2UlMjIlM0ElMjIlMjIlMkMlMjJvcGVuX2tpdGNoZW4lMjIlM0ElMjIlMjIlMkMlMjJiYXRodHViJTIyJTNBJTIyJTIyJTJDJTIyaXNfcGV0dGFibGUlMjIlM0ElMjIlMjIlMkMlMjJzaG9ydF90ZXJtJTIyJTNBJTIyJTIyJTJDJTIyYmFsY29ueSUyMiUzQSUyMiUyMiUyQyUyMmhvYSUyMiUzQSUyMiUyMiUyQyUyMmdhcmJhZ2UlMjIlM0ElMjIlMjIlMkMlMjJkZXNrX2NoYWlyJTIyJTNBJTIyJTIyJTJDJTIyd2lmaSUyMiUzQSUyMiUyMiUyQyUyMnBheV9jYWJsZSUyMiUzQSUyMiUyMiUyQyUyMmdhcyUyMiUzQSUyMiUyMiUyQyUyMmFpcl9jb25kaXRpb24lMjIlM0ElMjIlMjIlMkMlMjJ0ZWxldmlzaW9uJTIyJTNBJTIyJTIyJTJDJTIyd2FyZHJvYmUlMjIlM0ElMjIlMjIlMkMlMjJiZWQlMjIlM0ElMjIlMjIlMkMlMjJib2lsZXIlMjIlM0ElMjIlMjIlMkMlMjJ3YXNoZXIlMjIlM0ElMjIlMjIlMkMlMjJyZWZyaWdlcmF0b3IlMjIlM0ElMjIlMjIlMkMlMjJtaWNyb3dhdmUlMjIlM0ElMjIlMjIlN0QlMkMlMjJvZmZpY2UlMjIlM0ElN0IlN0QlMkMlMjJzdG9yZWZyb250JTIyJTNBJTdCJTdEJTdE&ordering=price&direction=ASC&mode=list"
  end
end
