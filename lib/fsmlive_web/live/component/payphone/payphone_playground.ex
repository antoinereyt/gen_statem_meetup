defmodule FsmliveWeb.Component.PayphonePlayground do
  use Phoenix.LiveComponent
  alias FsmliveWeb.Component.Payphone

  attr :state, :atom, values: [:idle, :waiting_credit, :waiting_dial, :on_call], required: true
  attr :screen, :atom, values: [:clear, :warning_low_credit], required: true

  def render(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="flex justify-center items-center bg-green-400 w-64 h-64">
        <.live_component id="payphone" module={Payphone} state={@state} screen={@screen} />
      </div>
      <div class="flex justify-center bg-blue-300 p-2">
        <button
          title="pick_up"
          phx-click="pick_up"
          class="mr-1 bg-green-500 hover:bg-green-600 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M13.04 14.69l1.07-2.14a1 1 0 0 1 1.2-.5l6 2A1 1 0 0 1 22 15v5a2 2 0 0 1-2 2h-2A16 16 0 0 1 2 6V4c0-1.1.9-2 2-2h5a1 1 0 0 1 .95.68l2 6a1 1 0 0 1-.5 1.21L9.3 10.96a10.05 10.05 0 0 0 3.73 3.73zM8.28 4H4v2a14 14 0 0 0 14 14h2v-4.28l-4.5-1.5-1.12 2.26a1 1 0 0 1-1.3.46 12.04 12.04 0 0 1-6.02-6.01 1 1 0 0 1 .46-1.3l2.26-1.14L8.28 4z"
            />
          </svg>
        </button>
        <button
          title="hang_up"
          phx-click="hang_up"
          class="mr-1 bg-red-500 hover:bg-red-600 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M13.04 14.69l1.07-2.14a1 1 0 0 1 1.2-.5l6 2A1 1 0 0 1 22 15v5a2 2 0 0 1-2 2h-2A16 16 0 0 1 2 6V4c0-1.1.9-2 2-2h5a1 1 0 0 1 .95.68l2 6a1 1 0 0 1-.5 1.21L9.3 10.96a10.05 10.05 0 0 0 3.73 3.73zM8.28 4H4v2a14 14 0 0 0 14 14h2v-4.28l-4.5-1.5-1.12 2.26a1 1 0 0 1-1.3.46 12.04 12.04 0 0 1-6.02-6.01 1 1 0 0 1 .46-1.3l2.26-1.14L8.28 4z"
            />
          </svg>
        </button>
        <button
          title="dial"
          phx-click="dial"
          class="mr-1 bg-blue-600 hover:bg-blue-700 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M5 3h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2V5c0-1.1.9-2 2-2zm0 2v4h4V5H5zm10-2h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2h-4a2 2 0 0 1-2-2V5c0-1.1.9-2 2-2zm0 2v4h4V5h-4zM5 13h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2v-4c0-1.1.9-2 2-2zm0 2v4h4v-4H5zm10-2h4a2 2 0 0 1 2 2v4a2 2 0 0 1-2 2h-4a2 2 0 0 1-2-2v-4c0-1.1.9-2 2-2zm0 2v4h4v-4h-4z"
            />
          </svg>
        </button>
        <button
          title="add_credit"
          phx-click="add_credit"
          class="bg-orange-400 hover:bg-orange-500 text-gray-300 font-bold py-2 px-4 rounded"
        >
          <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" width="24" height="24">
            <path
              class="fill-current h-4"
              d="M12 22a10 10 0 1 1 0-20 10 10 0 0 1 0 20zm0-2a8 8 0 1 0 0-16 8 8 0 0 0 0 16zm1-11v2h1a3 3 0 0 1 0 6h-1v1a1 1 0 0 1-2 0v-1H8a1 1 0 0 1 0-2h3v-2h-1a3 3 0 0 1 0-6h1V6a1 1 0 0 1 2 0v1h3a1 1 0 0 1 0 2h-3zm-2 0h-1a1 1 0 1 0 0 2h1V9zm2 6h1a1 1 0 0 0 0-2h-1v2z"
            />
          </svg>
        </button>
      </div>
    </div>
    """
  end
end
