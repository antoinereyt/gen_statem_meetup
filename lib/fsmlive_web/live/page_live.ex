defmodule FsmliveWeb.PageLive do
  use FsmliveWeb, :live_view

  @impl true
  def mount(_params, _session, socket) do
    {:ok, assign(socket, examples: examples())}
  end

  def card(%{id: :light} = assigns) do
    assigns =
      assigns
      |> assign(:state, assigns.params.state)

    ~H"""
    <FsmliveWeb.Components.Light.card state={@state} />
    """
  end

  def card(%{id: :payphone} = assigns) do
    assigns =
      assigns
      |> assign(:state, assigns.params.state)
      |> assign(:screen, assigns.params.screen)

    ~H"""
    <FsmliveWeb.Components.Payphone.card state={@state} screen={@screen} />
    """
  end

  def card(%{id: :traffic_light} = assigns) do
    assigns =
      assigns
      |> assign(:state, assigns.params.state)

    ~H"""
    <FsmliveWeb.Components.TrafficLight.card state={@state} />
    """
  end

  def examples() do
    [
      %{
        title: "Light",
        description: "Simple FSM to grasp the basic concepts and the syntax.",
        card_component: %{
          id: :light,
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
          id: :payphone,
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
          id: :traffic_light,
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
