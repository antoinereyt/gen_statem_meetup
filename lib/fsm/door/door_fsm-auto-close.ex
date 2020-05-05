defmodule DoorFsm.Autoclose do
  @behaviour :gen_statem

  @type state :: :opened | :closed
  @initial_state :closed

  # public api

  def open(pid) do
    :gen_statem.cast(pid, :open)
  end

  def close(pid) do
    :gen_statem.cast(pid, :close)
  end

  # gen_statem callbacks

  def closed(:cast, :close, _data) do
    :keep_state_and_data
  end

  def closed(:cast, :open, data) do
    actions = [{:state_timeout, 200, :open_ttl}]
    {:next_state, :opened, data, actions}
  end

  def opened(:cast, :open, _data) do
    :keep_state_and_data
  end

  def opened(:cast, :close, data) do
    {:next_state, :closed, data}
  end

  def opened(:state_timeout, _, data) do
    {:next_state, :closed, data}
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
