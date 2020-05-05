defmodule FsmliveWeb.Component.LightCard do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Light

  def render(assigns) do
    state = assigns[:state]

    ~L"""
      <div class="flex h-32 bg-blue-900">
        <%= live_component @socket, Light, state: state %>
      </div>
    """
  end
end
