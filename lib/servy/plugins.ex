defmodule Servy.Plugins do
  alias Servy.Conv

  @doc "Logs 404 requests"
  def track(%Conv{status: 404, path: path} = conv) do
    if Mix.env() != :test do
      IO.puts("Warning: #{path} is on the loose!")
    end

    conv
  end

  def track(%Conv{} = conv), do: conv

  def rewrite_path(%Conv{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(%Conv{} = conv), do: conv

  def log(%Conv{} = conv) do
    if Mix.env() != :test do
      IO.inspect(conv)
    end

    conv
  end

  def rewrite_path_params(%Conv{path: path} = conv) do
    case String.split(path, "?id=") do
      [base_path, id] ->
        %{conv | path: "#{base_path}/#{id}"}

      _ ->
        conv
    end
  end
end
