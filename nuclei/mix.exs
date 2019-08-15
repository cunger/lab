defmodule Nuclei.MixProject do
  use Mix.Project

  def project do
    [
      app: :nuclei,
      version: "0.1.0",
      elixir: "~> 1.8",
      start_permanent: Mix.env() == :prod,
      preferred_cli_env: [espec: :test],
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:espec, github: "antonmi/espec", only: :test}
    ]
  end
end
