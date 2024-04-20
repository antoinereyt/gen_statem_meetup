defmodule FsmliveWeb.Component.PayphoneCard do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Payphone

  attr :state, :atom, values: [:idle, :waiting_credit, :waiting_dial, :on_call], required: true
  attr :screen, :atom, values: [:clear, :warning_low_credit], required: true

  def render(assigns) do
    ~H"""
    <div class="flex justify-center h-32 bg-green-400">
      <.live_component id="payphone" module={Payphone} state={@state} screen={@screen} />
    </div>
    """
  end
end
