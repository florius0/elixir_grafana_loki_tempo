defmodule FF.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _env) do
    children = [
      # Start the Telemetry supervisor
      FFWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: FF.PubSub},
      # Start the Endpoint (http/https)
      FFWeb.Endpoint
      # Start a worker by calling: FF.Worker.start_link(arg)
      # {FF.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FF.Supervisor]
    Supervisor.start_link(children, opts)
  after
    OpentelemetryLoggerMetadata.setup()
    OpentelemetryPhoenix.setup()

    Sibyl.Handlers.attach_all_events(Sibyl.Handlers.OpenTelemetry)
    # OpentelemetryPlug.setup()
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FFWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
