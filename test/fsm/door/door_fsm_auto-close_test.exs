defmodule DoorFsm.AutocloseTest do
  use ExUnit.Case

  @moduletag :door

  alias DoorFsm.Autoclose, as: Fsm

  test "An open door should close it-self after 200 ms" do
    {:ok, pid} = Fsm.start_link()
    Fsm.open(pid)
    assert {:opened, _} = :sys.get_state(pid)
    :timer.sleep(200)
    assert {:closed, _} = :sys.get_state(pid)
  end
end
