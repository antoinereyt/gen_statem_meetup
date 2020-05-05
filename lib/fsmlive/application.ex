defmodule Fsmlive.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      FsmliveWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Fsmlive.PubSub},
      # Start the Endpoint (http/https)
      FsmliveWeb.Endpoint
      # Start a worker by calling: Fsmlive.Worker.start_link(arg)
      # {Fsmlive.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Fsmlive.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    FsmliveWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
