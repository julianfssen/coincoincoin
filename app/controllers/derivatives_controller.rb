class DerivativesController < ApplicationController
  include Pagy::Backend
  CONTRACT_TYPES = ['any', 'futures', 'perpetual']
  BASE_CURRENCIES = ["Any", "ETH", "BCH", "BNB", "COTI", "RUNE", "BZRX", "ALICE", "LINK", "QTUM", "XEM", "DOT", "VET", "XRP", "LIT", "KAVA", "BAT", "KNC", "DEFI", "SXP", "LINA", "ADA", "LTC", "GRT", "BTC", "BEL", "LRC", "STORJ", "IOST", "AVAX", "BTCST", "MANA", "DOGE", "COMP", "EOS", "XLM", "NEO", "OCEAN", "BTS", "THETA", "REN", "FIL", "EGLD", "RVN", "DENT", "SRM", "TRX", "ZRX", "TRB", "STMX", "CRV", "UNFI", "FTM", "DODO", "ETC", "IOTA", "TRU", "ZEC", "RSR", "ICP", "MATIC", "FLM", "ATOM", "MTL", "TOMO", "ONT", "ZEN", "SKL", "SNX", "UNI", "BTT", "SUSHI", "BAND", "HNT", "AXS", "SOL", "ENJ", "CVC", "ONE", "XMR", "CELR", "ICX", "SFP", "RLC", "OKB", "SAND", "XTZ", "YFII", "DASH", "LUNA", "CHZ", "OGN", "OMG", "ALPHA", "ZIL", "BAKE", "YFI", "HOT", "KSM", "WAVES", "CTK", "NKN", "HBAR", "1INCH", "MKR", "BLZ", "NEAR", "ALGO", "AKRO", "CHR", "BAL", "REEF", "LEO", "RAMP", "CRO", "BAO", "KIN", "AAVE", "HT", "BNT", "AMPL", "ALT", "BSV", "XAUT", "AR", "MTA", "MEDIA", "SHIB", "DMG", "MID", "SHIT", "DRGN", "USDT", "BTMX", "STX", "CREAM", "BRZ", "FTT", "EXCH", "BADGER", "MAPS", "SRN", "CUSDT", "UNISWAP", "NPXS", "PRIV", "PAXG", "LEND", "RAY", "HOLY", "TRYB", "FLOW", "SECO", "FIDA", "SC", "AUDIO", "CAKE", "ALCX", "OXY", "CONV", "CEL", "ROOK", "DAWN", "PROM", "PUNDIX", "STEP", "ORBS", "HUM", "PERP", "ACH", "ANKR", "ANT", "BAGS", "BTM", "CSPR", "FORTH", "FRONT", "GXC", "JST", "LAT", "MASK", "MASS", "O3", "PEARL", "PHA", "RNDR", "SUN", "SWRV", "UMA", "WNXM", "WOO", "XCH", "YFV", "ZKS", "TORN", "LON", "MIR", "DORA", "XBT", "AMP", "BTCDOM", "EUR", "EUROPE50IX", "GBP", "GERMANY30IX", "IOT", "JPY", "XAG", "BBDX", "BDI", "XAUB", "DGB", "BCHA", "BEAM", "GRIN", "HIVE", "IRIS", "LPT", "MDA", "NEST", "ROSE", "SERO", "KLAY", "TMTG", "BCHABC", "DFN", "USDC", "1INCH-DIVE-5.00-D1001", "1INCH-MOON-3.50-M1001", "COPE-MOON-1.00-M1502", "DOT-DIVE-42.00-D0801", "DOT-MOON-30.00-M0801", "ETH-DIVE-2200-D0214", "FTT-DIVE-50.0-D0405", "FTT-MOON-32.0-M0405", "SUSHI-DIVE-20.50-D0901", "SUSHI-MOON-13.50-M0901", "WOZX", "1000SHIB", "LSK", "WRX", "PLINK", "WETH"]
  TARGET_CURRENCIES = ["Any", "USD", "USDT", "BUSD", "XBT", "BTCF0", "USDC", "USD-R", "DKKT", "BTC", "JPY", "DAI"]

  def index
    @derivative_exchanges = DerivativeExchange.all.order(:name)
    @contract_types = CONTRACT_TYPES
    @base_currencies = BASE_CURRENCIES
    @target_currencies = TARGET_CURRENCIES
    if params[:filters]
      @derivative_exchange_id = filter_params[:derivative_exchange_id] || 1
      @contract_type = filter_params[:contract_type] || 'any'
      @sort = filter_params[:sort]
    else
      @base_currency = 'BTC'
      @target_currency = 'USD'
      @derivative_exchange_id = 1
      @contract_type = 'any'
    end
    case @sort
    when 'volume_asc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_volume_24h_asc)
    when 'price_asc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_price_asc)
    when 'price_desc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_price_desc)
    when 'ticker_asc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_symbol_asc)
    when 'ticker_desc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_symbol_desc)
    when 'price_percentage_change_24h_asc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_price_percentage_change_24h_asc)
    when 'price_percentage_change_24h_desc'
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_price_percentage_change_24h_desc)
    else
      @pagy, @derivatives = pagy(Derivative.where(derivative_exchange_id: @derivative_exchange_id).by_volume_24h_desc)
    end
    @contract_type = @contract_type.downcase
    @pagy, @derivatives = pagy(@derivatives.where(contract_type: @contract_type)) unless @contract_type.eql? 'any'
  end

  def show
  end

  private

  def filter_params
    params.require(:filters).permit(:sort, :derivative_exchange_id, :contract_type, :base_currency, :target_currency)
  end
end
