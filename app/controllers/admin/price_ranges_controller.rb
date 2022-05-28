class Admin::PriceRangesController < ApplicationController
  def index
    @price_ranges = PriceRange.all
  end
end
