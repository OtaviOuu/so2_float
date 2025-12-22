defmodule So2Float.Market.Skin do
  use Ecto.Schema

  alias So2Float.Market.Weapon

  @primary_key {:id, :string, autogenerate: false}
  schema "skins" do
    field :name, :string

    belongs_to :weapon, Weapon,
      type: :string,
      foreign_key: :weapon_name,
      references: :name

    timestamps()
  end
end
