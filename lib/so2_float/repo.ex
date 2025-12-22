defmodule So2Float.Repo do
  use Ecto.Repo,
    otp_app: :so2_float,
    adapter: Ecto.Adapters.Postgres
end
