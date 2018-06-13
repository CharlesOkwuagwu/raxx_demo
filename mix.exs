defmodule RaxxDemo.MixProject do
  use Mix.Project

  def project do
    [
      app: :raxx_demo,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {RaxxDemo.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:exsync, "~> 0.2.1"},
      {:mime, "~> 1.2"},
      {:ace, git: "https://github.com/CrowdHailer/Ace"}
    ]
  end
end
