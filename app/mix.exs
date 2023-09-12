defmodule FF.MixProject do
  use Mix.Project

  def project do
    [
      app: :fish_finder,
      version: "0.1.0",
      elixir: "~> 1.12",
      elixirc_paths: elixirc_paths(Mix.env()),
      compilers: Mix.compilers(),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {FF.Application, []},
      extra_applications: [:logger, :runtime_tools, :tls_certificate_check]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:jason, "~> 1.4"},
      {:plug_cowboy, "~> 2.6"},
      {:phoenix, "~> 1.7.7"},
      {:phoenix_view, "~> 2.0"},
      {:phoenix_live_dashboard, "~> 0.8"},
      {:swoosh, "~> 1.11"},
      {:logger_json, "~> 5.1"},
      {:telemetry_metrics, "~> 0.6"},
      {:telemetry_poller, "~> 1.0"},
      {:telemetry_metrics_prometheus, "~> 1.1"},
      {:sibyl, github: "florius0/sibyl"},
      {:opentelemetry, "~> 1.3"},
      {:opentelemetry_api, "~> 1.2"},
      {:opentelemetry_process_propagator, "~> 0.2", override: true},
      {:opentelemetry_exporter, "~> 1.6"},
      {:opentelemetry_telemetry, "~> 1.0"},
      {:opentelemetry_phoenix, "~> 1.1"},
      {:opentelemetry_logger_metadata, "~> 0.1"},
      {:ssl_verify_fun, "~> 1.1.6", hex: "ssl_verify_fun", override: true, repo: "hexpm"}
      # {:opentelemetry_ecto, "~> 1.0.0-rc.3"},
      # {:opentelemetry_plug, github: "opentelemetry-beam/opentelemetry_plug", override: true},
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get"]
    ]
  end
end
