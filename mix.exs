defmodule EphpWeb.MixProject do
  use Mix.Project

  def project do
    [
      app: :ephp_web,
      version: "0.1.0",
      elixir: "~> 1.15",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {EphpWeb.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:bandit, "~> 1.0-pre"},
      {:plug, "~> 1.14"},
      {:cowboy, "~> 2.0"},
      {:ephp, "~> 0.3.1"}
    ]
  end
end
