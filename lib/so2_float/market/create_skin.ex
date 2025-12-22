defmodule So2Float.Market.CreateSkin do
  alias So2Float.Market.Skin

  def call(attrs) do
    %Skin{}
    |> Skin.changeset(attrs)
    |> So2Float.Repo.insert()
  end
end
