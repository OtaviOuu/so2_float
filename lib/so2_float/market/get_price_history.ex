defmodule So2Float.Market.GetPriceHistory do
  alias So2Float.Repo

  import Ecto.Query

  alias So2Float.Market.{History, Skin}

  def call(%Skin{} = skin, opts \\ []) do
    limit = Keyword.get(opts, :limit, 100)

    History
    |> where([h], h.skin_complete_name == ^skin.complete_name)
    |> order_by([h], asc: h.inserted_at)
    |> limit(^limit)
    |> select([h], %{price: h.price, units: h.units, inserted_at: h.inserted_at})
    |> Repo.all()
  end
end
