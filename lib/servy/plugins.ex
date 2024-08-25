defmodule Servy.Plugins do
  @doc "Logs 404 requests"
  def track(%{status: 404, path: path} = conv) do
    IO.puts("Warning: #{path} is on the loose!")
    conv
  end

  def track(conv), do: conv

  def rewrite_path(%{path: "/wildlife"} = conv) do
    %{conv | path: "/wildthings"}
  end

  def rewrite_path(conv), do: conv

  def log(conv), do: IO.inspect(conv)

  def rewrite_path_params(%{path: path} = conv) do
    case String.split(path, "?id=") do
      [base_path, id] ->
        %{conv | path: "#{base_path}/#{id}"}

      _ ->
        conv
    end
  end
end
