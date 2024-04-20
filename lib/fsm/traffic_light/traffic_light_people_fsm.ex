defmodule TrafficLight.PeopleFsm do
  @behaviour :gen_statem

  @type state :: :red | :green
  @initial_state :red

  defp hardware, do: Application.get_env(:fsmlive, :traffic_light)[:services][:hardware]

  # public api
  def turn_red(pid) do
    :gen_statem.call(pid, :turn_red)
  end

  def turn_green(pid) do
    :gen_statem.call(pid, :turn_green)
  end

  @impl :gen_statem
  def handle_event({:call, from}, :turn_red, :red, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :turn_green, :red, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :green, data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :turn_green, :green, _data) do
    actions = [{:reply, from, :ok}]
    {:keep_state_and_data, actions}
  end

  @impl :gen_statem
  def handle_event({:call, from}, :turn_red, :green, data) do
    actions = [{:reply, from, :ok}]
    {:next_state, :red, data, actions}
  end

  @impl :gen_statem
  def handle_event(:enter, _oldState, state, data) do
    hardware().only_one_ligth_on(data.hardware_id, self(), state)
    :keep_state_and_data
  end

  # gen_statem callbacks

  def start_link(hardware_id) do
    :gen_statem.start_link(__MODULE__, hardware_id, [])
  end

  @impl :gen_statem
  def init(hardware_id) do
    data = %{
      hardware_id: hardware_id
    }

    {:ok, @initial_state, data}
  end

  @impl :gen_statem
  def callback_mode() do
    [:handle_event_function, :state_enter]
  end
end
