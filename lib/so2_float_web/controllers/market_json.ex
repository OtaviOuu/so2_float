defmodule So2FloatWeb.MarketJSON do
  alias So2Float.Market.History

  def publish_market_print(%{results: results}) do
    %{
      results: Enum.map(results, &data/1)
    }
  end

  defp data(%History{} = history) do
    %{
      skin_complete_name: history.skin_complete_name,
      units: history.units,
      price: history.price,
      inserted_at: history.inserted_at
    }
  end
end
