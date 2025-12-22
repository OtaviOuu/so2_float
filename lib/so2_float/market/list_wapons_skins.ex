defmodule So2Float.Market.ListWaponsSkins do
  alias So2Float.Market.{Skin, Weapon}

  alias So2Float.Repo
  import Ecto.Query

  def call() do
    query =
      from s in Skin,
        select: %{
          complete_name: s.complete_name
        }

    Repo.all(query)
  end
end
