defmodule FsmliveWeb.Component.TrafficLightCard do
  use Phoenix.LiveComponent

  attr :car_color, :string, values: ["red", "orange", "green"], default: "red"
  attr :people_color, :string, values: ["red", "orange", "green"], default: "green"

  def render(assigns) do
    ~H"""
    <div class="flex items-end bg-blue-200 h-32">
      <.live_component
        id="TrafficLightCar"
        module={FsmliveWeb.Component.TrafficLightCar}
        color={@car_color}
      />
      <.live_component
        id="TrafficLightPeople"
        module={FsmliveWeb.Component.TrafficLightPeople}
        color={@people_color}
      />
    </div>
    """
  end
end
