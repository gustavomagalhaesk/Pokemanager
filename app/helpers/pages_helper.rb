module PagesHelper

  def convert_price(price, to_price)
    if to_price == "real"
      price = CurrencyService.convert("USD", "BRL", price)
      return "R$ #{price.round(2)}"
    elsif to_price == "iene"
      price = CurrencyService.convert("USD", "JPY", price)
      return "¥ #{price.round(0)}"
    else 
      return "$ #{price.round(2)}"
    end
  end
end
