defmodule RclexOnNervesOnF3rp70.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: RclexOnNervesOnF3rp70.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: RclexOnNervesOnF3rp70.Worker.start_link(arg)
        # {RclexOnNervesOnF3rp70.Worker, arg},
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: RclexOnNervesOnF3rp70.Worker.start_link(arg)
      # {RclexOnNervesOnF3rp70.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: RclexOnNervesOnF3rp70.Worker.start_link(arg)
      # {RclexOnNervesOnF3rp70.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:rclex_on_nerves_on_f3rp70, :target)
  end
end
