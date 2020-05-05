defmodule TrafficLight.CarFsm do
  @behaviour :gen_statem

  @type state :: :red | :orange | :green
  @initial_state :green

  @hardware Application.get_env(:fsmlive, :traffic_light)[:services][:hardware]

  # public api
  def turn_red(pid) do
    :gen_statem.call(pid, :turn_red)
  end

  def turn_green(pid) do
    :gen_statem.call(pid, :turn_green)
  end

  # gen_statem callbacks

  # green state

  @impl :gen_statem
  def handle_event({:call, {caller_pid, _ref} = from}, :turn_red, :green, data) do
    duration = Application.get_env(:fsmlive, :traffic_light)[:durations][:orange]

    actions = [
      {:reply, from, :ok},
      {:state_timeout, duration, :orange_ttl},
      {:next_event, :internal, {:callback, caller_pid, in_state: :red}}
    ]

    {:next_state, :orange, data, actions}
  end

  def handle_event({:call, from}, :turn_green, :green, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  # orange state
  @impl :gen_statem
  def handle_event(:state_timeout, _, :orange, data) do
    {:next_state, :red, data}
  end

  def handle_event({:call, from}, _, :orange, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  # red state
  def handle_event({:call, from}, :turn_green, :red, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :green, data, actions}
  end

  def handle_event({:call, from}, :turn_red, :red, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  # internal events: callback
  def handle_event(:internal, {:callback, caller_pid, in_state: state}, state, _data) do
    send(caller_pid, {:callback, self(), state})
    :keep_state_and_data
  end

  def handle_event(:internal, {:callback, _caller_pid, _}, _state, _data) do
    {:keep_state_and_data, :postpone}
  end

  # state_enter

  @impl :gen_statem
  def handle_event(:enter, _oldState, state, data) do
    @hardware.only_one_ligth_on(data.hardware_pid, self(), state)

    :keep_state_and_data
  end

  def start_link(hardware_pid) do
    :gen_statem.start_link(__MODULE__, hardware_pid, [])
  end

  @impl :gen_statem
  def init(hardware_pid) do
    data = %{
      hardware_pid: hardware_pid
    }

    {:ok, @initial_state, data}
  end

  @impl :gen_statem
  def callback_mode() do
    [:handle_event_function, :state_enter]
  end
end
