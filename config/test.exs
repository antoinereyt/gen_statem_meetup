use Mix.Config

config :fsmlive,
  light: [
    # duration in ms
    durations: [
      on_ttl: 200
    ],
    services: [
      bulb: Light.BulbMock
    ]
  ],
  payphone: [
    # one credit duration in ms
    credit_duration: 100,
    warning_threshold: 300,
    services: [
      hardware: Payphone.Hardware.Test
    ]
  ],
  traffic_light: [
    services: [
      hardware: TrafficLight.HardwareMock
    ],
    # durations in ms
    durations: [
      orange: 200,
      people_pass: 300,
      all_stop: 200
    ]
  ]

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :fsmlive, FsmliveWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
