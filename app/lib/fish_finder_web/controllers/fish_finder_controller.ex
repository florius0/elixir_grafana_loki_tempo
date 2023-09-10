defmodule FFWeb.FishFinderController do
  use FFWeb, :controller

  use OpenTelemetryDecorator

  require OpenTelemetry.Tracer, as: Tracer
  require Logger

  @fishery [
    "Anchovy",
    "Bass (black)",
    "Bass (striped)",
    "Bluefish",
    "Buffalo Fish",
    "Butterfish",
    "Calamari (Squid)",
    "Carp",
    "Catfish (farm-raised)",
    "Chilean sea bass",
    "Clam",
    "Cod",
    "Crab (Blue, King and Snow)",
    "Crayfish (Crawfish)",
    "Croaker (Atlantic)",
    "Flounder",
    "Golden Snapper",
    "Grouper",
    "Haddock",
    "Hake",
    "Halibut",
    "Herring",
    "Jack (Amber, Crevalle)",
    "Jacksmelt",
    "King Mackerel",
    "Lobster (northern, Maine, A...",
    "Lobster (spiny)",
    "Mackerel (Atlantic, jack, chub)",
    "Mahi Mahi (Dolphin-fish)",
    "Marlin",
    "Mullet"
  ]

  @decorate with_span("Start")
  def index(conn, _params) do
    small_fish = Tracer.with_span("casting", do: find_fish())
    large_fish = Tracer.with_span("casting", do: find_fish("large"))

    Tracer.with_span("releasing all the 🐡", do: json(conn, small_fish ++ large_fish))
  end

  @decorate with_span("🎣 ")
  defp find_fish(hope \\ "smol")

  defp find_fish(hope) do
    # "Focus" on catching a fish...
    :timer.sleep(:rand.uniform(700))

    captures =
      @fishery
      |> Enum.shuffle()
      |> Enum.take_random(:rand.uniform(10))

    Logger.info("#{hope} fishy captured: #{Enum.join(captures, ",")}")

    captures
  end
end
