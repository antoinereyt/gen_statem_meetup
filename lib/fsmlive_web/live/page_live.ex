defmodule FsmliveWeb.PageLive do
  use FsmliveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, examples: examples())}
  end

  def examples() do
    [
      %{
        title: "Light",
        description: "Simple FSM to grasp the basic concepts and the syntax.",
        card_component: %{
          name: FsmliveWeb.Component.LightCard,
          params: %{state: :on}
        },
        route: "/light",
        card_image: "",
        tags: ["state_function", "state_timeout", "state_enter"]
      },
      %{
        title: "Payphone",
        description:
          "Introduce the handle_function syntax and learn about generic_timeout using absolute time.",
        card_component: %{
          name: FsmliveWeb.Component.PayphoneCard,
          params: %{state: :idle, screen: :clear}
        },
        route: "/payphone",
        card_image: "",
        tags: ["handle_function", "generic_timeout"]
      },
      %{
        title: "Traffic light",
        description:
          "Synchronize two FSMs and discover the power of postpone and internal_event when used together.",
        card_component: %{
          name: FsmliveWeb.Component.TrafficLightCard,
          params: %{state: "on"}
        },
        route: "/traffic-light",
        card_image: "",
        tags: [
          "postpone",
          "internal_event"
        ]
      }
      # %{
      # title: "Elevator",
      # description: "",
      #   card_component: %{
      #     name: FsmliveWeb.Component.LightCard,
      #     params: %{state: "off"}
      #   },
      #   route: "/",
      #   card_image: "",
      #   tags: []
      # }
    ]
  end
end
