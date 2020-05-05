defmodule Payphone.Fsm do
  @behaviour :gen_statem

  @type state :: :idle | :waiting_credit | :waiting_dial | :on_call
  @credit_duration Application.get_env(:fsmlive, :payphone)[:credit_duration]
  @initial_state :idle
  @initial_data %{
    credit: 0,
    call_started_at: nil,
    hardware_pid: nil,
    warning_threshold: Application.get_env(:fsmlive, :payphone)[:warning_threshold]
  }
  @hardware Application.get_env(:fsmlive, :payphone)[:services][:hardware]
  # public api

  def pick_up(pid) do
    :gen_statem.call(pid, :pick_up)
  end

  def hang_up(pid) do
    :gen_statem.call(pid, :hang_up)
  end

  def add_credit(pid, credit \\ 1) do
    :gen_statem.call(pid, {:add_credit, credit})
  end

  def dial(pid) do
    :gen_statem.call(pid, :dial)
  end

  # gen_statem callback

  # idle state
  def handle_event({:call, form}, :pick_up, :idle, data) do
    actions = [{:reply, form, :ok}]
    {:next_state, :waiting_credit, data, actions}
  end

  # add credit transition
  def handle_event({:call, form}, {:add_credit, _credit}, :idle, _data) do
    actions = [{:reply, form, :ok}]
    {:keep_state_and_data, actions}
  end

  def handle_event({:call, form}, {:add_credit, credit}, :waiting_credit, data) do
    actions = [{:reply, form, :ok}]
    new_data = %{data | credit: data.credit + credit}
    {:next_state, :waiting_dial, new_data, actions}
  end

  def handle_event({:call, form}, {:add_credit, credit}, :on_call, data) do
    new_data = %{data | credit: data.credit + credit}

    @hardware.exec(data.hardware_pid, :screen, :clear)

    actions = [
      {:reply, form, :ok},
      no_more_credit_timeout(new_data),
      warning_low_credit_timeout(new_data)
    ]

    {:keep_state, new_data, actions}
  end

  def handle_event({:call, form}, {:add_credit, credit}, _state, data) do
    actions = [{:reply, form, :ok}]
    new_data = %{data | credit: data.credit + credit}
    {:keep_state, new_data, actions}
  end

  # waiting_dial state
  def handle_event({:call, form}, :dial, :waiting_dial, data) do
    new_data = %{data | call_started_at: :erlang.monotonic_time(:millisecond)}

    actions = [
      {:reply, form, :ok},
      no_more_credit_timeout(new_data),
      warning_low_credit_timeout(new_data)
    ]

    {:next_state, :on_call, new_data, actions}
  end

  # on_call state
  def handle_event(:state_timeout, _, :on_call, data) do
    new_data = reset_data(data)
    @hardware.exec(data.hardware_pid, :screen, :clear)

    {:next_state, :idle, new_data}
  end

  # hang_up transition: from everywhere, once you call hang_up
  # you go back to initial state with initial data
  def handle_event({:call, form}, :hang_up, _state, data) do
    actions = [
      {:reply, form, :ok},
      cancel_warning_low_credit_timeout()
    ]

    new_data = reset_data(data)

    @hardware.exec(data.hardware_pid, :screen, :clear)

    {:next_state, :idle, new_data, actions}
  end

  # catch all: every other transitions, just keep_state_and_data
  def handle_event({:call, form}, _transition, _state, _data) do
    actions = [{:reply, form, :ok}]
    {:keep_state_and_data, actions}
  end

  def handle_event(:enter, _oldState, state, data) do
    @hardware.exec(data.hardware_pid, :state, state)

    :keep_state_and_data
  end

  # def handle_event({:timeout, :warning_low_credit}, nil, :on_call, data) do
  def handle_event({:timeout, :warning_low_credit}, nil, _state, data) do
    @hardware.exec(data.hardware_pid, :screen, :warning_low_credit)
    :keep_state_and_data
  end

  # helpers
  defp reset_data(data) do
    Map.merge(@initial_data, %{hardware_pid: data.hardware_pid})
  end

  defp credit_to_time(credit) do
    credit * @credit_duration
  end

  defp no_more_credit_timeout(data) do
    ts = data.call_started_at + credit_to_time(data.credit)
    {:state_timeout, ts, :no_more_credit, {:abs, true}}
  end

  defp warning_low_credit_timeout(data) do
    end_call = data.call_started_at + credit_to_time(data.credit)
    ts = end_call - data.warning_threshold
    {{:timeout, :warning_low_credit}, ts, nil, {:abs, true}}
  end

  defp cancel_warning_low_credit_timeout() do
    {{:timeout, :warning_low_credit}, :infinity, nil, {:abs, true}}
  end

  def start_link(hardware_pid) do
    :gen_statem.start(__MODULE__, hardware_pid, [])
  end

  def init(hardware_pid) do
    data = %{@initial_data | hardware_pid: hardware_pid}
    {:ok, @initial_state, data}
  end

  def callback_mode() do
    [:handle_event_function, :state_enter]
  end
end
