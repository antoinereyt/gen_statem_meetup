defmodule FsmliveWeb.Component.TrafficLightPeoplePlayground do
  use Phoenix.LiveComponent

  def render(assigns) do
    state = assigns[:state]

    ~L"""
    <div class="flex flex-col">
      <div class="flex items-center justify-center bg-blue-200 w-64 h-64">
        <%= live_component @socket, FsmliveWeb.Component.TrafficLightPeople, color: state %>
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button phx-click="people_turn_green" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-4">
          turn_green
        </button>
        <button phx-click="people_turn_red" class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded">
          turn_red
        </button>
      </div>
    </div>
    """
  end
end
