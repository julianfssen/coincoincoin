# frozen_string_literal: true
class DerivativesController < ApplicationController
  include Pagy::Backend
  CONTRACT_TYPES = %w[Any Futures Perpetual].freeze
  BASE_CURRENCIES = %w[Any 1000SHIB 1INCH 1INCH-DIVE-5.00-D1001 1INCH-MOON-3.50-M1001 AAVE ACH ADA AKRO ALCX ALGO ALICE ALPHA ALT AMP AMPL ANKR ANT AR ATOM AUDIO AVAX AXS BADGER BAGS BAKE BAL BAND BAO BAT BBDX BCH BCHA BCHABC BDI BEAM BEL BLZ BNB BNT BRZ BSV BTC BTCDOM BTCST BTM BTMX BTS BTT BZRX CAKE CEL CELR CHR CHZ COMP CONV COPE-MOON-1.00-M1502 COTI CREAM CRO CRV CSPR CTK CUSDT CVC DASH DAWN DEFI DENT DFN DGB DMG DODO DOGE DORA DOT DOT-DIVE-42.00-D0801 DOT-MOON-30.00-M0801 DRGN EGLD ENJ EOS ETC ETH ETH-DIVE-2200-D0214 EUR EUROPE50IX EXCH FIDA FIL FLM FLOW FORTH FRONT FTM FTT FTT-DIVE-50.0-D0405 FTT-MOON-32.0-M0405 GBP GERMANY30IX GRIN GRT GXC HBAR HIVE HNT HOLY HOT HT HUM ICP ICX IOST IOT IOTA IRIS JPY JST KAVA KIN KLAY KNC KSM LAT LEND LEO LINA LINK LIT LON LPT LRC LSK LTC LUNA MANA MAPS MASK MASS MATIC MDA MEDIA MID MIR MKR MTA MTL NEAR NEO NEST NKN NPXS O3 OCEAN OGN OKB OMG ONE ONT ORBS OXY PAXG PEARL PERP PHA PLINK PRIV PROM PUNDIX QTUM RAMP RAY REEF REN RLC RNDR ROOK ROSE RSR RUNE RVN SAND SC SECO SERO SFP SHIB SHIT SKL SNX SOL SRM SRN STEP STMX STORJ STX SUN SUSHI SUSHI-DIVE-20.50-D0901 SUSHI-MOON-13.50-M0901 SWRV SXP THETA TMTG TOMO TORN TRB TRU TRX TRYB UMA UNFI UNI UNISWAP USDC USDT VET WAVES WETH WNXM WOO WOZX WRX XAG XAUB XAUT XBT XCH XEM XLM XMR XRP XTZ YFI YFII YFV ZEC ZEN ZIL ZKS ZRX].freeze
  TARGET_CURRENCIES = %w[Any BTC BTCF0 BUSD DAI DKKT JPY USD USD-R USDC USDT XBT].freeze

  def index
    @derivative_exchanges = DerivativeExchange.all.order(:name)
    @contract_types = CONTRACT_TYPES
    @base_currencies = BASE_CURRENCIES
    @target_currencies = TARGET_CURRENCIES
    if params[:filters]
      @derivative_exchange_id = filter_params[:derivative_exchange_id] || 1
      @contract_type = filter_params[:contract_type] || 'Any'
      @sort = filter_params[:sort]
      @base_currency = filter_params[:base_currency] || 'Any'
      @target_currency = filter_params[:target_currency] || 'Any'
    else
      @base_currency = 'Any'
      @target_currency = 'Any'
      @derivative_exchange_id = 1
      @contract_type = 'Any'
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
    @pagy, @derivatives = pagy(@derivatives.where(contract_type: @contract_type.downcase)) unless @contract_type.eql? 'Any'
    @pagy, @derivatives = pagy(@derivatives.where(base: @base_currency)) unless @base_currency.eql? 'Any'
    @pagy, @derivatives = pagy(@derivatives.where(target: @target_currency)) unless @target_currency.eql? 'Any'
    @page = (@pagy.page - 1) * 20
  end

  def show
    @derivative = Derivative.find(params[:id])
    @derivative_exchange = DerivativeExchange.find(@derivative.derivative_exchange_id)
  end

  private

  def filter_params
    params.require(:filters).permit(:sort, :derivative_exchange_id, :contract_type, :base_currency, :target_currency)
  end
end
