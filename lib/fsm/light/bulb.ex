defmodule Light.Bulb do
  @callback on(pid) :: :ok
  @callback off(pid) :: :ok
end

defmodule Light.Bulb.Console do
  @behaviour Light.Bulb

  def on(_pid) do
    IO.puts("ON")
  end

  def off(_pid) do
    IO.puts("OFF")
  end
end

defmodule Light.Bulb.Noop do
  @behaviour Light.Bulb

  def on(_pid), do: :ok
  def off(_pid), do: :ok
end

defmodule Light.Bulb.Test do
  @behaviour Light.Bulb

  def on(pid) do
    send(pid, :on)
  end

  def off(pid) do
    send(pid, :off)
  end
end

defmodule Light.Bulb.Liveview do
  @behaviour Light.Bulb

  def on(pid) do
    send(pid, {:update, __MODULE__, :on})
  end

  def off(pid) do
    send(pid, {:update, __MODULE__, :off})
  end
end
