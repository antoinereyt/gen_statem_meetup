defmodule FsmliveWeb.Component.LightPlayground do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Light

  attr :state, :atom, values: [:on, :off], required: true

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="bg-blue-900 w-64 h-64">
        <.live_component id="light" module={Light} state={@state} />
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button
          phx-click="on"
          class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-4"
        >
          on
        </button>
        <button
          phx-click="off"
          class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        >
          off
        </button>
      </div>
    </div>
    """
  end
end
