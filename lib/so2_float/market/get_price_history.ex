defmodule So2Float.Market.GetPriceHistory do
  alias So2Float.Repo

  import Ecto.Query

  alias So2Float.Market.History

  def call(skin_complete_name) do
    History
    |> where([h], h.skin_complete_name == ^skin_complete_name)
    |> order_by([h], asc: h.inserted_at)
    |> limit(20)
    |> select([h], %{price: h.price, units: h.units, inserted_at: h.inserted_at})
    |> Repo.all()
  end
end
