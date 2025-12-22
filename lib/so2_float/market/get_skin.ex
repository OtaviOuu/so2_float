defmodule So2Float.Market.GetSkin do
  alias So2Float.Repo

  def call(complete_name) do
    Repo.get_by(So2Float.Market.Skin, complete_name: complete_name)
  end
end
