defmodule FsmliveWeb.Component.TrafficLightCar do
  use Phoenix.LiveComponent

  attr :color, :string, values: ["red", "orange", "green"], required: true

  def render(assigns) do
    ~H"""
    <svg
      xml:space="preserve"
      viewBox="0 0 100 100"
      y="0"
      x="0"
      xmlns="http://www.w3.org/2000/svg"
      id="tf_car_1"
      version="1.1"
      width="128px"
      height="128px"
      xmlns:xlink="http://www.w3.org/1999/xlink"
      style="width:100%;height:100%"
      aastyle="width:100%;height:100%;background-size:initial;background-repeat-y:initial;background-repeat-x:initial;background-position-y:initial;background-position-x:initial;background-origin:initial;background-image:initial;background-color:rgb(255, 255, 255);background-clip:initial;background-attachment:initial;"
    >
      <g class="ldl-scale" style="transform-origin:50% 50%;transform:rotate(0deg) scale(0.8, 0.8);">
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M27.1 18.4c3.7 0 7.7 1.7 10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M27.1 42.7c3.7 0 7.7 1.7 10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M27.1 67c3.7 0 7.7 1.7 10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M72.9 18.4c-3.7 0-7.7 1.7-10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M72.9 42.7c-3.7 0-7.7 1.7-10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          stroke-miterlimit="10"
          stroke-linecap="round"
          stroke-width="3.888"
          stroke="#666"
          fill="none"
          d="M72.9 67c-3.7 0-7.7 1.7-10.1 8.7"
          style="stroke:rgb(102, 102, 102);"
        >
        </path>
        <path
          fill="#333"
          d="M53.9 10.9v-.6c0-2.1-1.7-3.8-3.8-3.8-2.1 0-3.8 1.7-3.8 3.8v.6h-6.5c-3.1 0-5.6 2.5-5.6 5.6v71.4c0 3.1 2.5 5.6 5.6 5.6h20.5c3.1 0 5.6-2.5 5.6-5.6V16.5c0-3.1-2.5-5.6-5.6-5.6h-6.4z"
          style="fill:rgb(51, 51, 51);"
        >
        </path>
        <circle
          style="transition: all 0.5s ease-in-out"
          fill={@color == "red" && "#e15b64"}
          r="9.7"
          cy="27.9"
          cx="50.1"
        >
        </circle>
        <circle
          style="transition: all 0.5s ease-in-out"
          fill={@color == "orange" && "#f5e169"}
          r="9.7"
          cy="52.2"
          cx="50.1"
        >
        </circle>
        <circle
          style="transition: all 0.5s ease-in-out"
          fill={@color == "green" && "#abbd81"}
          r="9.7"
          cy="76.5"
          cx="50.1"
        >
        </circle>
      </g>
      <!-- generated by https://loading.io/ -->
    </svg>
    """
  end
end
