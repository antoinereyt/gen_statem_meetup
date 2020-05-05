defmodule Payphone.Hardware do
  @type command :: any()
  @type device :: atom()
  @callback exec(pid, device, command) :: :ok
end

defmodule Payphone.Hardware.Console do
  @behaviour Payphone.Hardware

  require Logger

  def exec(pid, device, command) do
    Logger.debug(
      "Hardware #{inspect(pid)} executing #{inspect(command)} on device #{inspect(device)}"
    )
  end
end

defmodule Payphone.Hardware.Test do
  @behaviour Payphone.Hardware

  def exec(pid, device, command) do
    send(pid, {:hardware_mock, self(), device, command})
  end
end

defmodule Payphone.Hardware.Liveview do
  @behaviour Payphone.Hardware

  def exec(pid, device, command) do
    send(pid, {device, self(), command})
  end
end
