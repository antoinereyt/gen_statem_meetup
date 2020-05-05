defmodule FsmliveWeb.Component.TrafficLightManagerPlayground do
  use Phoenix.LiveComponent

  def render(assigns) do
    car_color = assigns[:car_color]
    people_color = assigns[:people_color]

    ~L"""
    <div class="flex flex-col">
      <div class="flex bg-blue-200 items-end w-64 h-64">
        <%= live_component @socket, FsmliveWeb.Component.TrafficLightCar, color: car_color %>
        <%= live_component @socket, FsmliveWeb.Component.TrafficLightPeople, color: people_color %>
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button phx-click="manager_cross" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-4">
          cross
        </button>
      </div>
    </div>
    """
  end

  def renderok(assigns) do
    car_color = assigns[:car_color]
    people_color = assigns[:people_color]

    ~L"""
    <div class="flex items-end">
      <%= live_component @socket, FsmliveWeb.Component.TrafficLightCar, color: car_color %>
      <%= live_component @socket, FsmliveWeb.Component.TrafficLightPeople, color: people_color %>
    </div>
    <div class="bg-blue-300 flex justify-center p-2">
      <button phx-click="cross" class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded">
        cross
      </button>
    </div>
    """
  end
end
