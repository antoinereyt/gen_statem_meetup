defmodule FsmliveWeb.Components.Fsm do
  use Phoenix.Component

  slot :animation
  slot :infos

  attr :image, :string, required: true

  def playground(assigns) do
    ~H"""
    <div class="flex mt-4">
      <div class="flex flex-col shadow">
        <div class="flex">
          <div style="min-width: 400px" class="flex items-center justify-center bg-gray-100 p-4">
            <img src={@image} />
          </div>
          <div class="flex">
            <%= render_slot(@animation) %>
          </div>
        </div>
        <div class="bg-gray-200 text-xs p-1 font-mono">
          <%= render_slot(@infos) %>
        </div>
      </div>
    </div>
    """
  end

  attr :label, :string, required: true
  attr :value, :string, required: true

  def info(assigns) do
    ~H"""
    <div>
      <span class="font-semibold"><%= @label %></span>
      <span class="font-thin"><%= @value %></span>
    </div>
    """
  end
end
