defmodule Light.FsmTest do
  use ExUnit.Case

  import Mox

  setup :set_mox_global
  setup :verify_on_exit!
  setup :stub

  @moduletag :light

  alias Light.Fsm, as: Fsm

  @on_ttl Application.get_env(:fsmlive, :light)[:durations][:on_ttl]

  setup %{} do
    bulb_pid = self()
    {:ok, pid} = Fsm.start_link(bulb_pid)
    # :sys.trace(pid, true)
    [pid: pid]
  end

  test "default state is off", %{pid: pid} do
    assert {:off, _} = :sys.get_state(pid)
  end

  describe "off state" do
    setup :off

    test "[off] -(turn_on)-> [on]", %{pid: pid} do
      Fsm.turn_on(pid)
      assert {:on, _} = :sys.get_state(pid)
    end

    test "[off] -(turn_off)-> [off]", %{pid: pid} do
      Fsm.turn_off(pid)
      assert {:off, _} = :sys.get_state(pid)
    end
  end

  describe "on state" do
    setup :on

    test "[on] -(turn_on)-> [on]", %{pid: pid} do
      Fsm.turn_on(pid)
      assert {:on, _} = :sys.get_state(pid)
    end

    test "[on] -(turn_off)-> [off]", %{pid: pid} do
      Fsm.turn_off(pid)
      assert {:off, _} = :sys.get_state(pid)
    end

    test "Should turn it-self to state off after a given time", %{pid: pid} do
      :timer.sleep(@on_ttl + 10)
      assert {:off, _} = :sys.get_state(pid)
    end
  end

  defp off(%{pid: pid}) do
    assert {:off, _} = :sys.get_state(pid)

    :ok
  end

  defp on(%{pid: pid}) do
    Fsm.turn_on(pid)
    assert {:on, _} = :sys.get_state(pid)

    :ok
  end

  defp stub(_) do
    stub_with(Light.BulbMock, Light.Bulb.Noop)
    :ok
  end
end
