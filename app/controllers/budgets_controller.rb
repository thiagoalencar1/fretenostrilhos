class BudgetsController < ApplicationController
  before_action :authenticate_admin!

  def index
    @carriers = Carrier.where(status: :active)
  end
end
