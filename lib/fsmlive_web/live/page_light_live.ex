defmodule FsmliveWeb.PageLightLive do
  use FsmliveWeb, :live_view

  alias Light.Fsm, as: LightFsm

  alias FsmliveWeb.Components.Fsm
  alias FsmliveWeb.Components.Light

  def mount(_params, _session, socket) do
    {:ok, pid} = LightFsm.start_link(self())
    {state, _} = :sys.get_state(pid)
    :sys.trace(pid, true)

    {:ok, assign(socket, state: state, pid: pid)}
  end

  def handle_event("on", _, socket) do
    pid = socket.assigns.pid
    LightFsm.turn_on(pid)
    {:noreply, socket}
  end

  def handle_event("off", _, socket) do
    pid = socket.assigns.pid
    LightFsm.turn_off(pid)
    {:noreply, socket}
  end

  def handle_info({:update, _, state}, socket) do
    {:noreply, assign(socket, state: state)}
  end
end
