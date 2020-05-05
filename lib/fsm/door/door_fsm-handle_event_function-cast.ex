defmodule DoorFsm.HandleEventFunction.Cast do
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

  @impl :gen_statem
  def handle_event(:cast, :close, :closed, _data) do
    :keep_state_and_data
  end

  @impl :gen_statem
  def handle_event(:cast, :open, :closed, data) do
    {:next_state, :opened, data}
  end

  @impl :gen_statem
  def handle_event(:cast, :open, :opened, _data) do
    :keep_state_and_data
  end

  @impl :gen_statem
  def handle_event(:cast, :close, :opened, data) do
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
    :handle_event_function
  end
end
