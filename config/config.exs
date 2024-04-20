# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :fsmlive,
  generators: [timestamp_type: :utc_datetime]

# Configures the endpoint
config :fsmlive, FsmliveWeb.Endpoint,
  url: [host: "localhost"],
  adapter: Bandit.PhoenixAdapter,
  render_errors: [
    formats: [html: FsmliveWeb.ErrorHTML, json: FsmliveWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Fsmlive.PubSub,
  live_view: [signing_salt: "1KoFwNhL"]

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :fsmlive, Fsmlive.Mailer, adapter: Swoosh.Adapters.Local

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.17.11",
  fsmlive: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.4.0",
  fsmlive: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

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

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
