defmodule Servy.BearController do
  alias Servy.Bear
  alias Servy.Conv
  alias Servy.Wildthings

  @templates_path Path.expand("templates", File.cwd!())

  defp render(conv, template, bindings \\ []) do
    content =
      @templates_path
      |> Path.join(template)
      |> EEx.eval_file(bindings)

    %{conv | status: 200, resp_body: content}
  end

  def index(%Conv{} = conv) do
    bears =
      Wildthings.list_bears()
      |> Enum.sort(&Bear.order_asc_by_name/2)

    render(conv, "index.eex", bears: bears)
  end

  def show(%Conv{} = conv, %{"id" => id}) do
    bear = Wildthings.get_bear(id)

    render(conv, "show.eex", bear: bear)
  end

  def create(%Conv{} = conv, params) do
    %{conv | status: 201, resp_body: "Created a #{params["type"]} bear named #{params["name"]}"}
  end

  def delete(%Conv{} = conv, %{"id" => id}) do
    %{conv | status: 200, resp_body: "Deleted Bear #{id}"}
  end
end
