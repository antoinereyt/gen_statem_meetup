defmodule FsmliveWeb.Components.Light do
  use Phoenix.Component

  attr :state, :atom, values: [:on, :off], required: true

  def bulb(assigns) do
    ~H"""
    <svg
      viewBox="0 0 100 100"
      xmlns="http://www.w3.org/2000/svg"
      width="128px"
      height="128px"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      style="width:100%;height:100%"
    >
      <g class="ldl-scale" style="transform-origin:50% 50%;transform:rotate(0deg) scale(0.8, 0.8);">
        <g>
          <g>
            <path
              fill="#e0e0e0"
              d="M60.812 72.351H39.188a1.519 1.519 0 1 1 0-3.038h21.624a1.519 1.519 0 1 1 0 3.038z"
            >
            </path>
          </g>
          <g>
            <path
              fill="#e0e0e0"
              d="M60.812 77.414H39.188a1.519 1.519 0 1 1 0-3.038h21.624a1.519 1.519 0 1 1 0 3.038z"
            >
            </path>
          </g>
          <g>
            <path
              fill="#e0e0e0"
              d="M60.812 82.477H39.188a1.519 1.519 0 1 1 0-3.038h21.624a1.519 1.519 0 1 1 0 3.038z"
            >
            </path>
          </g>
          <path
            fill="#e0e0e0"
            d="M56.251 90H43.749c-.563 0-1.06-.366-1.228-.903l-.854-2.738a1.287 1.287 0 0 1 1.228-1.67h14.211c.868 0 1.487.841 1.228 1.67l-.854 2.738a1.289 1.289 0 0 1-1.229.903z"
            style="fill:rgb(224, 224, 224);"
          >
          </path>
        </g>
        <g>
          <path
            style="transition: all 0.3s ease-in-out"
            fill={(@state == :on && "#f5e169") || "#999"}
            d="M75.714 35.714c0-14.749-12.417-26.597-27.367-25.662-12.526.783-22.83 10.782-23.954 23.282-.864 9.604 3.56 18.235 10.688 23.321a5.872 5.872 0 0 1 2.453 4.783v.004a5.905 5.905 0 0 0 5.905 5.905H56.56a5.905 5.905 0 0 0 5.905-5.905c0-1.87.864-3.659 2.389-4.741 6.571-4.658 10.86-12.32 10.86-20.987z"
          >
          </path>
        </g>
      </g>
    </svg>
    """
  end

  attr :state, :atom, values: [:on, :off], required: true

  def card(assigns) do
    ~H"""
    <div class="flex h-32 bg-blue-900">
      <.bulb state={@state} />
    </div>
    """
  end

  attr :state, :atom, values: [:on, :off], required: true

  def playground(assigns) do
    ~H"""
    <div class="flex flex-col">
      <div class="bg-blue-900 w-64 h-64">
        <.bulb state={@state} />
      </div>
      <div class="flex justify-center bg-blue-300 p-2 gap-x-4">
        <button
          phx-click="on"
          class="bg-green-500 hover:bg-green-700 text-white font-bold py-2 px-4 rounded"
        >
          on
        </button>
        <button
          phx-click="off"
          class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded"
        >
          off
        </button>
      </div>
    </div>
    """
  end
end
