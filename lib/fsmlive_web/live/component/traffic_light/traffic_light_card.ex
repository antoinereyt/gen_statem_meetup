defmodule FsmliveWeb.Component.TrafficLightCard do
  use Phoenix.LiveComponent

  def render(assigns) do
    car_color = assigns[:car_color] || "red"
    people_color = assigns[:people_color] || "green"

    ~L"""
    <div class="flex items-end bg-blue-200 h-32">
        <%= live_component @socket, FsmliveWeb.Component.TrafficLightCar, color: car_color %>
        <%= live_component @socket, FsmliveWeb.Component.TrafficLightPeople, color: people_color %>
    </div>
    """
  end
end
