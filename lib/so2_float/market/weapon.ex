defmodule So2Float.Market.Weapon do
  use Ecto.Schema
  import Ecto.Changeset

  alias So2Float.Market.Skin

  schema "weapons" do
    field :name, :string, primary_key: true

    has_many :skins, Skin,
      foreign_key: :weapon_name,
      references: :name,
      on_delete: :nothing

    timestamps()
  end
end
