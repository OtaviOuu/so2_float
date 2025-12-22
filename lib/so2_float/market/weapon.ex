defmodule So2Float.Market.Weapon do
  use Ecto.Schema

  alias So2Float.Market.Skin

  @primary_key {:name, :string, autogenerate: false}
  schema "weapons" do
    has_many :skins, Skin,
      foreign_key: :weapon_name,
      references: :name,
      on_delete: :nothing

    timestamps()
  end
end
