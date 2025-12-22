defmodule So2Float.Market.CreateHistoryRecord do
  alias So2Float.Market.History
  alias So2Float.Repo

  def call(attrs) do
    %History{}
    |> History.changeset(attrs)
    |> Repo.insert()
  end
end
