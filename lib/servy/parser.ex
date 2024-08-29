defmodule Servy.Parser do
  alias Servy.Conv

  def parse(request) do
    IO.puts("➡️  Received request:\n")
    IO.puts(request)
    IO.puts("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")

    # [top, params_string] = String.split(request, "\r\n\r\n")
    [request_line | header_lines] = String.split(request, "\r\n")

    IO.puts("Request Line: #{request_line}")
    IO.inspect(header_lines)
    IO.puts("🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥🔥")

    [method, path, _] = String.split(request_line, " ")

    header_lines = Enum.filter(header_lines, fn line -> String.contains?(line, ":") end)
    headers = parse_headers(header_lines, %{})
    # params = parse_params(headers["Content-Type"], params_string)

    %Conv{method: method, path: path, params: %{}, headers: headers}
  end

  @doc """
  Parses the given param striing of the form `key1=value1&key2=value2`
  into a map with corresponding key-value pairs.

  ## Examples
      iex> params_string = "name=Baloo&type=Brown"
      iex> Servy.Parser.parse_params("application/x-www-form-urlencoded", params_string)
      %{"name" => "Baloo", "type" => "Brown"}

      iex> params_string = "name=Baloo&type=Brown"
      iex> Servy.Parser.parse_params("multipart/form-data", params_string)
      %{}
  """
  def parse_params("application/x-www-form-urlencoded", params_string) do
    params_string
    |> String.trim()
    |> URI.decode_query()
  end

  def parse_params(_, _), do: %{}

  def parse_headers([head | tail], headers) do
    [key, value] = String.split(head, ": ")
    headers = Map.put(headers, key, value)
    parse_headers(tail, headers)
  end

  def parse_headers([], headers), do: headers
end
