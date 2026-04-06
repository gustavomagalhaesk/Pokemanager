class PagesController < ApplicationController
  def home
  end

  def pokeshop
    @items = Item.all
  end

end
