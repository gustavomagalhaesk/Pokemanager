class CurrencyService
  BASE_URL = 'https://economia.awesomeapi.com.br/json'.freeze

  def self.fetch_last_quote(pair = 'USD-BRL')
    response = Faraday.get("#{BASE_URL}/last/#{pair}")

    if response.success?
      data = JSON.parse(response.body)
      key = pair.delete('-')
      data[key]
    else
      nil
    end
  rescue Faraday::Error => e
    Rails.logger.error("Erro na API de Moedas: #{e.message}")
    nil
  end
end