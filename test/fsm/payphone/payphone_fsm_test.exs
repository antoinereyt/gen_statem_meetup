defmodule Payphone.FsmTest do
  use ExUnit.Case

  @moduletag :payphone

  alias Payphone.Fsm, as: Fsm

  defp credit_duration, do: Application.get_env(:fsmlive, :payphone)[:credit_duration]
  defp warning_threshold, do: Application.get_env(:fsmlive, :payphone)[:warning_threshold]

  setup %{} do
    {:ok, pid} = Fsm.start_link(self())
    # :sys.trace(pid, true)
    [pid: pid]
  end

  test "default state is idle", %{pid: pid} do
    assert {:idle, _} = :sys.get_state(pid)
  end

  describe "idle state" do
    setup :idle

    test "[idle] -(pick_up)-> [waiting_credit]", %{pid: pid} do
      Fsm.pick_up(pid)
      assert {:waiting_credit, _} = :sys.get_state(pid)
    end

    test "[idle] -(add_credit)-> [idle]", %{pid: pid} do
      Fsm.add_credit(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "add_credit don't add credit", %{pid: pid} do
      Fsm.add_credit(pid)
      assert {_, %{credit: 0}} = :sys.get_state(pid)
    end

    test "[idle] -(dial)-> [idle]", %{pid: pid} do
      Fsm.dial(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "[idle] -(hang_up)-> [idle]", %{pid: pid} do
      Fsm.hang_up(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end
  end

  describe "waiting_credit state" do
    setup :waiting_credit

    test "[waiting_credit] -(add_credit)-> [waiting_dial]", %{pid: pid} do
      Fsm.add_credit(pid)
      assert {:waiting_dial, _} = :sys.get_state(pid)
    end

    test "add_credit increment credit", %{pid: pid} do
      Fsm.add_credit(pid, 5)
      assert {_, %{credit: 5}} = :sys.get_state(pid)
    end

    test "[waiting_credit] -(dial)-> [waiting_credit]", %{pid: pid} do
      Fsm.dial(pid)
      assert {:waiting_credit, _} = :sys.get_state(pid)
    end

    test "[waiting_credit] -(hang_up)-> [idle]", %{pid: pid} do
      Fsm.hang_up(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end
  end

  describe "waiting_dial state" do
    setup :waiting_dial

    test "[waiting_dial] -(dial)-> [on_call]", %{pid: pid} do
      Fsm.dial(pid)
      assert {:on_call, _} = :sys.get_state(pid)
    end

    test "[waiting_dial] -(hang_up)-> [idle]", %{pid: pid} do
      Fsm.hang_up(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "add_credit increment credit", %{pid: pid} do
      {_, %{credit: credit}} = :sys.get_state(pid)
      Fsm.add_credit(pid)
      {_, %{credit: new_credit}} = :sys.get_state(pid)

      assert new_credit == credit + 1
    end
  end

  describe "on_call state" do
    setup :on_call

    test "[state] -(hang_up)-> [idle]", %{pid: pid} do
      Fsm.hang_up(pid)
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "add_credit increment credit", %{pid: pid} do
      {_, %{credit: credit}} = :sys.get_state(pid)
      Fsm.add_credit(pid)
      {_, %{credit: new_credit}} = :sys.get_state(pid)

      assert new_credit == credit + 1
    end

    test "Should hang_up automatically when user have no more credit", %{pid: pid} do
      assert {:on_call, %{credit: credit}} = :sys.get_state(pid)
      :timer.sleep(credit * credit_duration())
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "add_credit delays the low credit warning signal" do
      {:ok, pid} = Fsm.start_link(self())
      Fsm.pick_up(pid)

      Fsm.add_credit(pid, 2)
      Fsm.add_credit(pid, trunc(warning_threshold() / credit_duration()))
      # now we have a total of 2 + warning_threshold credits

      # After one credit duration, I add one more credit
      spawn(fn ->
        :timer.sleep(credit_duration())
        Fsm.add_credit(pid, 1)
      end)

      Fsm.dial(pid)

      # At the end I had been able to call for 3 credit time without any warning signal
      refute_receive {:hardware_mock, ^pid, :screen, :warning_low_credit}, 3 * credit_duration()
      assert_receive {:hardware_mock, ^pid, :screen, :warning_low_credit}, 50
    end

    test "add_credit delays the end of the call spawn" do
      {:ok, pid} = Fsm.start_link(self())
      assert_receive {:hardware_mock, ^pid, :state, :idle}
      Fsm.pick_up(pid)

      # Start with two credits
      Fsm.add_credit(pid, 2)

      # After one credit duration, I add one more credit
      spawn(fn ->
        :timer.sleep(credit_duration())
        Fsm.add_credit(pid, 1)
      end)

      Fsm.dial(pid)

      # At the end I had been able to call for my total 3 credit time.
      refute_receive {:hardware_mock, ^pid, :state, :idle}, 3 * credit_duration()
      assert_receive {:hardware_mock, ^pid, :state, :idle}, 50
    end

    test "add_credit delays the end of the call" do
      {:ok, pid} = Fsm.start_link(self())
      Fsm.pick_up(pid)
      Fsm.add_credit(pid, 2)
      Fsm.dial(pid)

      # sleep for 1 credit
      :timer.sleep(1 * credit_duration())
      assert {:on_call, _} = :sys.get_state(pid)

      Fsm.add_credit(pid)

      # wait for the two last credits: the one remaning, plus the new added.
      :timer.sleep(2 * credit_duration() - trunc(credit_duration() / 2))
      assert {:on_call, _} = :sys.get_state(pid)

      :timer.sleep(trunc(credit_duration() / 2))
      assert {:idle, _} = :sys.get_state(pid)
    end

    test "user receive a warning when its credit is low" do
      {:ok, pid} = Fsm.start_link(self())
      Fsm.pick_up(pid)
      Fsm.add_credit(pid, 1)
      Fsm.add_credit(pid, trunc(warning_threshold() / credit_duration()))
      # now we have a total of 1 + warning_threshold credits

      Fsm.dial(pid)

      message = {:hardware_mock, pid, :screen, :warning_low_credit}
      refute_receive ^message, 1 * credit_duration()
      assert_receive ^message, 50
    end

    test "user do not receive a warning when he hang up before the warning" do
      {:ok, pid} = Fsm.start_link(self())
      Fsm.pick_up(pid)
      Fsm.add_credit(pid, 2)
      Fsm.add_credit(pid, trunc(warning_threshold() / credit_duration()))
      {_, %{credit: total_credit}} = :sys.get_state(pid)
      # now we have a total of 2 + warning_threshold credits

      Fsm.dial(pid)

      refute_receive {:screen, ^pid, :warning_low_credit}, 1 * credit_duration()
      Fsm.hang_up(pid)
      refute_receive {:screen, ^pid, :warning_low_credit}, total_credit * credit_duration()
    end
  end

  defp idle(%{pid: pid}) do
    assert {:idle, _} = :sys.get_state(pid)

    :ok
  end

  defp waiting_credit(%{pid: pid}) do
    Fsm.pick_up(pid)
    assert {:waiting_credit, _} = :sys.get_state(pid)

    :ok
  end

  defp waiting_dial(%{pid: pid} = ctx) do
    waiting_credit(ctx)
    Fsm.add_credit(pid)
    assert {:waiting_dial, _} = :sys.get_state(pid)

    :ok
  end

  defp on_call(%{pid: pid} = ctx) do
    waiting_dial(ctx)
    Fsm.dial(pid)
    assert {:on_call, _} = :sys.get_state(pid)

    :ok
  end
end
