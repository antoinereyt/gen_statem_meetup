defmodule DoorFsm.HandleEventFunction.Call do
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

  @impl :gen_statem
  def handle_event({:call, from}, :close, :closed, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :open, :closed, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :opened, data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :open, :opened, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :close, :opened, data) do
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
    :handle_event_function
  end
end
