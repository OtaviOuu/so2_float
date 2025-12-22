defmodule So2Float.Market do
  alias So2Float.Market.GetPriceHistory

  def list_skins_price_history(skin_complete_name) do
    GetPriceHistory.call(skin_complete_name)
  end
end
