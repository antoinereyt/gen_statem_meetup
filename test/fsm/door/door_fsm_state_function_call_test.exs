defmodule DoorFsm.StateFunction.CallTest do
  use ExUnit.Case

  @moduletag :door

  alias DoorFsm.StateFunction.Call, as: Fsm

  setup %{} do
    {:ok, pid} = Fsm.start_link()
    # :sys.trace(pid, true)
    [pid: pid]
  end

  test "default state is closed", %{pid: pid} do
    assert {:closed, _} = :sys.get_state(pid)
  end

  describe "Closed state" do
    setup :closed

    test "[closed] -(open)-> [opened]", %{pid: pid} do
      Fsm.open(pid)
      assert {:opened, _} = :sys.get_state(pid)
    end

    test "[closed] -(close)-> [closed]", %{pid: pid} do
      Fsm.close(pid)
      assert {:closed, _} = :sys.get_state(pid)
    end
  end

  describe "Opened state" do
    setup :opened

    test "[opened] -(open)-> [opened]", %{pid: pid} do
      Fsm.open(pid)
      assert {:opened, _} = :sys.get_state(pid)
    end

    test "[opened] -(close)-> [closed]", %{pid: pid} do
      Fsm.close(pid)
      assert {:closed, _} = :sys.get_state(pid)
    end
  end

  defp closed(%{pid: pid}) do
    assert {:closed, _} = :sys.get_state(pid)

    :ok
  end

  defp opened(%{pid: pid}) do
    Fsm.open(pid)
    assert {:opened, _} = :sys.get_state(pid)

    :ok
  end
end
