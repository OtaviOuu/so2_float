defmodule So2Float.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      So2FloatWeb.Telemetry,
      So2Float.Repo,
      {DNSCluster, query: Application.get_env(:so2_float, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: So2Float.PubSub},
      # Start a worker by calling: So2Float.Worker.start_link(arg)
      # {So2Float.Worker, arg},
      # Start to serve requests, typically the last entry
      So2FloatWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: So2Float.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    So2FloatWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
