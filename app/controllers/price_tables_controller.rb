class PriceTablesController < ApplicationController
  def index
    @weight_table = WeightTable.all
    @distance_table = DistanceTable.all
  end
end

