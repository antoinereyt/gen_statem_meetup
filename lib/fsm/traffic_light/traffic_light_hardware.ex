defmodule TrafficLight.Hardware do
  @type color :: :red | :orange | :green

  # turn one light on and turn all the others off.
  @callback only_one_ligth_on(pid, String.t(), color) :: :ok
end

defmodule TrafficLight.Hardware.Console do
  require Logger

  @behaviour TrafficLight.Hardware

  @impl TrafficLight.Hardware
  def only_one_ligth_on(pid, name, color) do
    Logger.debug("[#{inspect(pid)} - #{inspect(name)}] Turn on color: #{color}")
  end
end

defmodule TrafficLight.Hardware.Test do
  @behaviour TrafficLight.Hardware

  @impl TrafficLight.Hardware
  def only_one_ligth_on(_pid, _name, _color) do
    :ok
  end
end

defmodule TrafficLight.Hardware.Liveview do
  @behaviour TrafficLight.Hardware

  @impl TrafficLight.Hardware
  def only_one_ligth_on(pid, name, color) do
    send(pid, {:update, name, color})
  end
end
