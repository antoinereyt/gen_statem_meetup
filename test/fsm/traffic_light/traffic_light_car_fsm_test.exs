defmodule TrafficLight.CarFsmTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!
  setup :stub

  @moduletag :traffic_light

  alias TrafficLight.CarFsm, as: Fsm

  @durations Application.get_env(:fsmlive, :traffic_light)[:durations]

  setup %{} do
    {:ok, pid} = Fsm.start_link(self())
    # :sys.trace(pid, true)
    [pid: pid]
  end

  test "default state is green", %{pid: pid} do
    assert {:green, _} = :sys.get_state(pid)
  end

  describe "Green state" do
    setup :green

    test "[green] -turn_red-> [red]", %{pid: pid} do
      callback_message = {:callback, pid, :red}

      Fsm.turn_red(pid)

      assert {:orange, _} = :sys.get_state(pid)
      refute_receive ^callback_message, @durations[:orange]

      assert_receive ^callback_message
      assert {:red, _} = :sys.get_state(pid)
    end
  end

  describe "Red state" do
    setup :red

    test "[red] -turn_green-> [green]", %{pid: pid} do
      :ok = Fsm.turn_green(pid)
      assert {:green, _} = :sys.get_state(pid)
    end
  end

  defp green(%{pid: pid}) do
    assert {:green, _} = :sys.get_state(pid)

    :ok
  end

  defp red(%{pid: pid}) do
    callback_message = {:callback, pid, :red}
    :ok = Fsm.turn_red(pid)

    # wait it to be red
    assert_receive ^callback_message, @durations[:orange] + 50
    assert {:red, _} = :sys.get_state(pid)

    :ok
  end

  defp stub(_) do
    stub_with(TrafficLight.HardwareMock, TrafficLight.Hardware.Test)
    :ok
  end
end
