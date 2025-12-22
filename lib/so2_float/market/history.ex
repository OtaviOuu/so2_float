defmodule So2Float.Market.History do
  use Ecto.Schema

  alias So2Float.Market.{Skin}

  schema "history" do
    belongs_to :skin, Skin, type: :string, foreign_key: :skin_name, references: :id

    field :price, :integer
    field :units, :integer

    timestamps()
  end
end
