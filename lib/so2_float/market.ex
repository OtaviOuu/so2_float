defmodule So2Float.Market do
  alias So2Float.Market.GetPriceHistory

  def list_skins_price_history(skin, opts \\ []) do
    GetPriceHistory.call(skin, opts)
  end

  def get_skin(complete_name) do
    So2Float.Market.GetSkin.call(complete_name)
  end
end
