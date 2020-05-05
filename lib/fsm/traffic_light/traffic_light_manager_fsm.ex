defmodule TrafficLight.ManagerFsm do
  @behaviour :gen_statem

  @type state :: :car_pass | :waiting_all_stop | :all_stop | :people_pass
  @initial_state :car_pass

  @durations Application.get_env(:fsmlive, :traffic_light)[:durations]

  alias TrafficLight.CarFsm, as: CarFsm
  alias TrafficLight.PeopleFsm, as: PeopleFsm

  # public api

  def cross(pid) do
    :gen_statem.cast(pid, :cross)
  end

  # state car_pass
  @impl :gen_statem
  def handle_event(:cast, :cross, :car_pass, data) do
    :ok = CarFsm.turn_red(data.car_pid)
    {:next_state, :waiting_all_stop, data}
  end

  # state waiting_all_stop
  def handle_event(:info, {:callback, _car_fsm_pid, :red}, :waiting_all_stop, data) do
    actions = [{:state_timeout, @durations[:all_stop], :before_people_pass}]
    {:next_state, :all_stop, data, actions}
  end

  # state all_stop
  def handle_event(:state_timeout, :before_people_pass, :all_stop, data) do
    :ok = PeopleFsm.turn_green(data.people_pid)
    actions = [{:state_timeout, @durations[:people_pass], nil}]
    {:next_state, :people_pass, data, actions}
  end

  def handle_event(:state_timeout, :back_to_start, :all_stop, data) do
    :ok = CarFsm.turn_green(data.car_pid)
    {:next_state, :car_pass, data}
  end

  # state people_pass
  def handle_event(:state_timeout, _, :people_pass, data) do
    :ok = PeopleFsm.turn_red(data.people_pid)
    actions = [{:state_timeout, @durations[:all_stop], :back_to_start}]
    {:next_state, :all_stop, data, actions}
  end

  def handle_event(:cast, :cross, _state, _data) do
    :keep_state_and_data
  end

  # state_enter

  @impl :gen_statem
  def handle_event(:enter, _oldState, state, data) do
    send(data.monitoring_pid, {:manager_state, state})

    :keep_state_and_data
  end

  # gen_statem callbacks

  def start_link(car_pid, people_pid, monitoring_pid) do
    :gen_statem.start_link(__MODULE__, [car_pid, people_pid, monitoring_pid], [])
  end

  @impl :gen_statem
  def init([car_pid, people_pid, monitoring_pid]) do
    data = %{
      car_pid: car_pid,
      people_pid: people_pid,
      monitoring_pid: monitoring_pid
    }

    {:ok, @initial_state, data}
  end

  @impl :gen_statem
  def callback_mode() do
    [:handle_event_function, :state_enter]
  end
end
