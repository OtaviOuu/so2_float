defmodule So2Float.Market.Skin do
  use Ecto.Schema

  import Ecto.Changeset

  alias So2Float.Market.Weapon

  @primary_key {:complete_name, :string, autogenerate: false}
  schema "skins" do
    field :name, :string

    belongs_to :weapon, Weapon,
      type: :string,
      foreign_key: :weapon_name,
      references: :name

    timestamps()
  end

  def changeset(skin, attrs) do
    skin
    |> cast(attrs, [:complete_name, :name, :weapon_name])
    |> validate_required([:complete_name, :name, :weapon_name])
    |> foreign_key_constraint(:weapon_name)
  end
end
