defmodule Servy.BearController do
  alias Servy.Conv
  alias Servy.Wildthings

  def index(%Conv{} = conv) do
    bears = Wildthings.list_bears()

    bears_html =
      Enum.map(bears, fn bear ->
        "<li>#{bear.name} the #{bear.type} bear</li>"
      end)

    %{conv | status: 200, resp_body: "<ul>#{Enum.join(bears_html)}</ul>"}
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Bear #{id}"}
  end

  def create(%Conv{} = conv, params) do
    %{conv | status: 201, resp_body: "Created a #{params["type"]} bear named #{params["name"]}"}
  end

  def delete(%Conv{} = conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Deleted Bear #{id}"}
  end
end
