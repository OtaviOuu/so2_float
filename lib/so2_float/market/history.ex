defmodule So2Float.Market.History do
  use Ecto.Schema

  alias So2Float.Market.{Skin}

  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "history" do
    belongs_to :skin, Skin,
      type: :string,
      foreign_key: :skin_complete_name,
      references: :complete_name

    field :price, :integer
    field :units, :integer

    timestamps()
  end

  def changeset(history, attrs) do
    history
    |> cast(attrs, [:skin_complete_name, :price, :units])
    |> validate_required([:skin_complete_name, :price, :units])
    |> foreign_key_constraint(:skin_complete_name)
  end
end
