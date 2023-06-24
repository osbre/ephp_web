defmodule EphpWeb.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Bandit, plug: EphpWeb.EphpPlug}#, scheme: :http, options: [port: 4000]},
      # Starts a worker by calling: EphpWeb.Worker.start_link(arg)
      # {EphpWeb.Worker, arg}
    ]

    :ephp.start()

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: EphpWeb.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
