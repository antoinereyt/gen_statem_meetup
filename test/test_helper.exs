ExUnit.start()

ExUnit.configure(
  exclude: [
    # light: true,
    # payphone: true,
    # traffic_light: true
  ]
)

Mox.defmock(Light.BulbMock, for: Light.Bulb)
Mox.defmock(TrafficLight.HardwareMock, for: TrafficLight.Hardware)
