defmodule TrafficLight.PeopleFsmTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!
  setup :stub

  @moduletag :traffic_light

  alias TrafficLight.PeopleFsm, as: Fsm

  setup %{} do
    {:ok, pid} = Fsm.start_link(nil)
    # :sys.trace(pid, true)
    [pid: pid]
  end

  test "default state is red", %{pid: pid} do
    assert {:red, _} = :sys.get_state(pid)
  end

  describe "Red state" do
    setup :red

    test "[red] -(turn_green)-> [green]", %{pid: pid} do
      Fsm.turn_green(pid)
      assert {:green, _} = :sys.get_state(pid)
    end

    test "[red] -(turn_red)-> [red]", %{pid: pid} do
      Fsm.turn_red(pid)
      assert {:red, _} = :sys.get_state(pid)
    end
  end

  describe "Green state" do
    setup :green

    test "[green] -(turn_green)-> [green]", %{pid: pid} do
      Fsm.turn_green(pid)
      assert {:green, _} = :sys.get_state(pid)
    end

    test "[green] -(turn_red)-> [red]", %{pid: pid} do
      Fsm.turn_red(pid)
      assert {:red, _} = :sys.get_state(pid)
    end
  end

  defp red(%{pid: pid}) do
    assert {:red, _} = :sys.get_state(pid)
    :ok
  end

  defp green(%{pid: pid}) do
    Fsm.turn_green(pid)

    assert {:green, _} = :sys.get_state(pid)
    :ok
  end

  defp stub(_) do
    stub_with(TrafficLight.HardwareMock, TrafficLight.Hardware.Test)
    :ok
  end
end
