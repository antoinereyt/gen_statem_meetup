defmodule TrafficLight.ManagerFsmTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!
  setup :stub

  @moduletag :traffic_light

  alias TrafficLight.CarFsm, as: CarFsm
  alias TrafficLight.PeopleFsm, as: PeopleFsm
  alias TrafficLight.ManagerFsm, as: ManagerFsm

  defp durations, do: Application.get_env(:fsmlive, :traffic_light)[:durations]

  setup %{} do
    {:ok, car_pid} = CarFsm.start_link(self())
    # :sys.trace(car_pid, true)
    {:ok, people_pid} = PeopleFsm.start_link(self())
    # :sys.trace(people_pid, true)

    monitoring_pid = self()
    {:ok, manager} = ManagerFsm.start_link(car_pid, people_pid, monitoring_pid)
    # :sys.trace(manager, true)
    [manager: manager]
  end

  test "default state is car_pass", %{manager: manager} do
    assert {:car_pass, _} = :sys.get_state(manager)
  end

  test "cross/1", %{manager: manager} do
    ManagerFsm.cross(manager)
    assert {:waiting_all_stop, _} = :sys.get_state(manager)

    :timer.sleep(durations()[:orange] + 10)
    assert {:all_stop, _} = :sys.get_state(manager)

    :timer.sleep(durations()[:all_stop] + 10)
    assert {:people_pass, _} = :sys.get_state(manager)

    :timer.sleep(durations()[:people_pass] + 10)
    assert {:all_stop, _} = :sys.get_state(manager)

    :timer.sleep(durations()[:all_stop] + 10)
    assert {:car_pass, _} = :sys.get_state(manager)
  end

  defp stub(_) do
    stub_with(TrafficLight.HardwareMock, TrafficLight.Hardware.Test)
    :ok
  end
end
