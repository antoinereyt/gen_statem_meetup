defmodule FsmliveWeb.PageTrafficLightLive do
  use FsmliveWeb, :live_view

  require Logger

  def mount(_params, _session, socket) do
    {:ok, standalone_car_pid} = TrafficLight.CarFsm.start_link(self())
    {standalone_car_state, _} = :sys.get_state(standalone_car_pid)
    :sys.trace(standalone_car_pid, true)

    {:ok, standalone_people_pid} = TrafficLight.PeopleFsm.start_link(self())
    {standalone_people_state, _} = :sys.get_state(standalone_people_pid)
    :sys.trace(standalone_people_pid, true)

    {:ok, car_pid} = TrafficLight.CarFsm.start_link(self())
    {car_state, _} = :sys.get_state(car_pid)
    {:ok, people_pid} = TrafficLight.PeopleFsm.start_link(self())
    {people_state, _} = :sys.get_state(people_pid)
    {:ok, manager_pid} = TrafficLight.ManagerFsm.start_link(car_pid, people_pid, self())
    {manager_state, _} = :sys.get_state(people_pid)

    :sys.trace(people_pid, true)
    :sys.trace(car_pid, true)
    :sys.trace(manager_pid, true)

    {:ok,
     assign(socket,
       page_pid: self(),
       standalone_car: %{state: "#{standalone_car_state}", pid: standalone_car_pid},
       standalone_people: %{state: "#{standalone_people_state}", pid: standalone_people_pid},
       car: %{state: "#{car_state}", pid: car_pid},
       people: %{state: "#{people_state}", pid: people_pid},
       manager: %{state: "#{manager_state}", pid: manager_pid}
     )}
  end

  def handle_event("manager_cross", _, socket) do
    manager_pid = socket.assigns.manager.pid
    TrafficLight.ManagerFsm.cross(manager_pid)
    {:noreply, socket}
  end

  def handle_event("people_turn_red", _, socket) do
    standalone_people_pid = socket.assigns.standalone_people.pid
    TrafficLight.PeopleFsm.turn_red(standalone_people_pid)
    {:noreply, socket}
  end

  def handle_event("people_turn_green", _, socket) do
    standalone_people_pid = socket.assigns.standalone_people.pid
    TrafficLight.PeopleFsm.turn_green(standalone_people_pid)
    {:noreply, socket}
  end

  def handle_event("car_turn_red", _, socket) do
    standalone_car_pid = socket.assigns.standalone_car.pid
    TrafficLight.CarFsm.turn_red(standalone_car_pid)
    {:noreply, socket}
  end

  def handle_event("car_turn_green", _, socket) do
    standalone_car_pid = socket.assigns.standalone_car.pid
    TrafficLight.CarFsm.turn_green(standalone_car_pid)
    {:noreply, socket}
  end

  # standalone people
  def handle_info(
        {:update, fsm_pid, state},
        %{assigns: %{standalone_people: %{pid: fsm_pid}}} = socket
      ) do
    new_state = Atom.to_string(state)

    {:noreply,
     assign(socket, standalone_people: %{socket.assigns.standalone_people | state: new_state})}
  end

  # standalone car
  def handle_info(
        {:update, fsm_pid, state},
        %{assigns: %{standalone_car: %{pid: fsm_pid}}} = socket
      ) do
    new_state = Atom.to_string(state)

    {:noreply,
     assign(socket, standalone_car: %{socket.assigns.standalone_car | state: new_state})}
  end

  # manager people
  def handle_info({:update, fsm_pid, state}, %{assigns: %{people: %{pid: fsm_pid}}} = socket) do
    new_state = Atom.to_string(state)
    {:noreply, assign(socket, people: %{socket.assigns.people | state: new_state})}
  end

  # manager car
  def handle_info({:update, fsm_pid, state}, %{assigns: %{car: %{pid: fsm_pid}}} = socket) do
    new_state = Atom.to_string(state)
    {:noreply, assign(socket, car: %{socket.assigns.car | state: new_state})}
  end

  def handle_info({:manager_state, state}, socket) do
    new_state = Atom.to_string(state)
    {:noreply, assign(socket, manager: %{socket.assigns.manager | state: new_state})}
  end

  def handle_info(message, socket) do
    Logger.debug("Unhandled message #{inspect(message)}")
    {:noreply, socket}
  end
end
