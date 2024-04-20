defmodule FsmliveWeb.Component.TrafficLightManagerPlayground do
  use Phoenix.LiveComponent

  attr :car_color, :string, values: ["red", "orange", "green"], required: true
  attr :people_color, :string, values: ["red", "orange", "green"], required: true

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="flex bg-blue-200 items-end w-64 h-64">
        <.live_component
          id="MTrafficLightCar"
          module={FsmliveWeb.Component.TrafficLightCar}
          color={@car_color}
        />
        <.live_component
          id="MTrafficLightPeople"
          module={FsmliveWeb.Component.TrafficLightPeople}
          color={@people_color}
        />
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button
          phx-click="manager_cross"
          class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-4"
        >
          cross
        </button>
      </div>
    </div>
    """
  end
end
