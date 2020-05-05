defmodule FsmliveWeb.Component.PayphoneCard do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Payphone

  def render(assigns) do
    state = assigns[:state]
    screen = assigns[:screen]

    ~L"""
      <div class="flex justify-center h-32 bg-green-400">
        <%= live_component @socket, Payphone, state: state, screen: screen %>
      </div>
    """
  end
end
