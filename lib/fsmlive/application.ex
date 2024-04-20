defmodule Fsmlive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FsmliveWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:fsmlive, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Fsmlive.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Fsmlive.Finch},
      # Start a worker by calling: Fsmlive.Worker.start_link(arg)
      # {Fsmlive.Worker, arg},
      # Start to serve requests, typically the last entry
      FsmliveWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fsmlive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FsmliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
