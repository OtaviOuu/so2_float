defmodule So2Float.Authorizer do
  alias So2Float.Accounts.Scope

  def call(:extract_skins_from_image, %Scope{user: %{role: :admin}}), do: :ok

  def call(:extract_skins_from_image, _scope) do
    {:error, :unauthorized}
  end
end
