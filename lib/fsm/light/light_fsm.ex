defmodule Light.Fsm do
  @behaviour :gen_statem

  defp on_ttl, do: Application.get_env(:fsmlive, :light)[:durations][:on_ttl]
  defp bulb, do: Application.get_env(:fsmlive, :light)[:services][:bulb]

  @type state :: :on | :off
  @initial_state :off

  # public api

  def turn_on(pid) do
    :gen_statem.cast(pid, :turn_on)
  end

  def turn_off(pid) do
    :gen_statem.cast(pid, :turn_off)
  end

  # gen_statem callbacks

  # state off
  def off(:cast, :turn_off, _data) do
    :keep_state_and_data
  end

  def off(:cast, :turn_on, data) do
    actions = [{:state_timeout, on_ttl(), :turn_on_ttl}]
    {:next_state, :on, data, actions}
  end

  def off(:enter, _oldState, data) do
    bulb().off(data.bulb_pid)
    :keep_state_and_data
  end

  # state on
  def on(:cast, :turn_on, _data) do
    :keep_state_and_data
  end

  def on(:cast, :turn_off, data) do
    {:next_state, :off, data}
  end

  def on(:state_timeout, _, data) do
    {:next_state, :off, data}
  end

  def on(:enter, _oldState, data) do
    bulb().on(data.bulb_pid)
    :keep_state_and_data
  end

  def start_link(bulb_pid) do
    :gen_statem.start_link(__MODULE__, bulb_pid, [])
  end

  @impl :gen_statem
  def init(bulb_pid) do
    data = %{bulb_pid: bulb_pid}
    {:ok, @initial_state, data}
  end

  @impl :gen_statem
  def callback_mode() do
    [:state_functions, :state_enter]
  end
end
