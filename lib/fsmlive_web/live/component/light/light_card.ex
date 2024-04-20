defmodule FsmliveWeb.Component.LightCard do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Light

  attr :state, :atom, values: [:on, :off], required: true

  def render(assigns) do
    ~H"""
    <div class="flex h-32 bg-blue-900">
      <.live_component id="light_card" module={Light} state={@state} />
    </div>
    """
  end
end
