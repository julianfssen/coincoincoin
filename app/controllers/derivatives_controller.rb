class DerivativesController < ApplicationController
  def index
    sort = params[:sort]
    @derivatives = Derivative.where(market_id: 1).top_10_by_volume_desc.limit(10)
    if sort.eql? 'volume_asc'
      @derivatives = Derivative.where(market_id: 1).top_10_by_volume_asc.limit(10)
    end
  end

  def show
  end
end
