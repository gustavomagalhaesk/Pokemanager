require "net/http"
require "json"

class CurrencyService
  BASE_URL = "https://economia.awesomeapi.com.br/json/last/"

  def self.convert(from, to, amount)
    url = URI("#{BASE_URL}#{from}-#{to}")
    response = Net::HTTP.get(url)
    data = JSON.parse(response)

    pair = "#{from}#{to}"
    rate = data[pair]["bid"].to_f

    amount * rate
  end
end
