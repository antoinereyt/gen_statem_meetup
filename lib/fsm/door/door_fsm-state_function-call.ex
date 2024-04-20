defmodule DoorFsm.StateFunction.Call do
  @behaviour :gen_statem

  @type state :: :opened | :closed
  @initial_state :closed

  # public api

  def open(pid) do
    :gen_statem.call(pid, :open)
  end

  def close(pid) do
    :gen_statem.call(pid, :close)
  end

  # gen_statem callbacks

  def closed({:call, from}, :close, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  def closed({:call, from}, :open, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :opened, data, actions}
  end

  def opened({:call, from}, :open, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  def opened({:call, from}, :close, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :closed, data, actions}
  end

  def start_link() do
    :gen_statem.start_link(__MODULE__, nil, [])
  end

  @impl :gen_statem
  def init(_) do
    {:ok, @initial_state, :no_real_data}
  end

  @impl :gen_statem
  def callback_mode() do
    :state_functions
  end
end
