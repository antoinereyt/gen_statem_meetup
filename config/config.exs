# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :fsmlive,
  light: [
    # duration in ms
    durations: [
      on_ttl: 3_000
    ],
    services: [
      bulb: Light.Bulb.Liveview
    ]
  ],
  payphone: [
    # one credit duration in ms
    credit_duration: 1_000,
    warning_threshold: 3_000,
    services: [
      hardware: Payphone.Hardware.Liveview
    ]
  ],
  traffic_light: [
    services: [
      hardware: TrafficLight.Hardware.Liveview
    ],
    # durations in ms
    durations: [
      orange: 1_000,
      people_pass: 3000,
      all_stop: 2000
    ]
  ]

# Configures the endpoint
config :fsmlive, FsmliveWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "66JM+oVqj2omkSEG57C0O8Z0xr25Rlm2joZC0EMnHUS4SOEzQNEAH1dLpunI0Uhb",
  render_errors: [view: FsmliveWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Fsmlive.PubSub,
  live_view: [signing_salt: "b1cTxMvd"]

# Configures Elixir's Logger
config :logger, level: :warn

config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
