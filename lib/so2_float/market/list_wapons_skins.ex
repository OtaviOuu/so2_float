defmodule So2Float.Market.ListWaponsSkins do
  alias So2Float.Market.{Skin, Weapon}

  alias So2Float.Repo
  import Ecto.Query

  def call() do
    Repo.all(Skin)
  end
end
