defmodule FsmliveWeb.PageLightLive do
  use FsmliveWeb, :live_view

  alias Light.Fsm, as: Fsm

  def mount(_params, _session, socket) do
    {:ok, pid} = Fsm.start_link(self())
    {state, _} = :sys.get_state(pid)
    :sys.trace(pid, true)

    {:ok, assign(socket, state: state, pid: pid)}
  end

  def handle_event("on", _, socket) do
    pid = socket.assigns.pid
    Fsm.turn_on(pid)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    pid = socket.assigns.pid
    Fsm.turn_off(pid)
    {:noreply, socket}
  end

  def handle_info({:update, _, state}, socket) do
    {:noreply, assign(socket, state: state)}
  end
end
