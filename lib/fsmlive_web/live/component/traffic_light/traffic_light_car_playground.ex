defmodule FsmliveWeb.Component.TrafficLightCarPlayground do
  use Phoenix.LiveComponent

  attr :state, :string, required: true

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="flex bg-blue-200 items-end w-64 h-64">
        <.live_component
          id="TrafficLightCar"
          module={FsmliveWeb.Component.TrafficLightCar}
          color={@state}
        />
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button
          phx-click="car_turn_green"
          class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded mr-4"
        >
          turn_green
        </button>
        <button
          phx-click="car_turn_red"
          class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        >
          turn_red
        </button>
      </div>
    </div>
    """
  end
end
