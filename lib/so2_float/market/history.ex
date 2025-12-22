defmodule So2Float.Market.History do
  use Ecto.Schema

  alias So2Float.Market.{Skin}

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
end
