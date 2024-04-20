defmodule FsmliveWeb.PagePayphoneLive do
  require Logger

  use FsmliveWeb, :live_view

  alias Payphone.Fsm, as: PayphoneFsm

  alias FsmliveWeb.Components.Fsm
  alias FsmliveWeb.Components.Payphone

  def mount(_params, _session, socket) do
    {:ok, pid} = PayphoneFsm.start_link(self())
    {state, _} = :sys.get_state(pid)
    :sys.trace(pid, true)

    {:ok, assign(socket, screen: :clear, state: state, pid: pid)}
  end

  def handle_event("pick_up", _, socket) do
    pid = socket.assigns.pid
    PayphoneFsm.pick_up(pid)
    {:noreply, socket}
  end

  def handle_event("hang_up", _, socket) do
    pid = socket.assigns.pid
    PayphoneFsm.hang_up(pid)
    {:noreply, socket}
  end

  def handle_event("dial", _, socket) do
    pid = socket.assigns.pid
    PayphoneFsm.dial(pid)
    {:noreply, socket}
  end

  def handle_event("add_credit", _, socket) do
    pid = socket.assigns.pid
    PayphoneFsm.add_credit(pid)
    {:noreply, socket}
  end

  def handle_info({:screen, _pid, state}, socket) do
    {:noreply, assign(socket, screen: state)}
  end

  def handle_info({:state, _pid, state}, socket) do
    {:noreply, assign(socket, state: state)}
  end
end
