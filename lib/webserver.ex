defmodule RaxxDemo.WebServer do
  use Ace.HTTP.Service

  require Logger

  @impl Raxx.Server
  def handle_head(r, s) do
    try do
      case r do
        %{path: ["downloads" | _], method: :GET, body: false} ->
          downlod_request(r, s)

        _ ->
          Logger.debug("404: #{r.path}")
          response(404)
      end
    rescue
      ex ->
        Logger.error(
          "[#{inspect(self())}] #{inspect(ex)}\n#{
            Exception.format_stacktrace(System.stacktrace())
          }"
        )

        {[response(500) |> set_body(false)], s}
    end
  end

  @impl Raxx.Server
  def handle_request(_request, greeting) do
    Raxx.response(:ok)
    |> Raxx.set_body(greeting)
  end

  defp downlod_request(r, _s) do
    f = Path.join(r.path)
    f = Path.absname(f)
    n = Path.basename(f)
    # d = Path.dirname(f)
    # a = Path.absname(d)
    "." <> e = Path.extname(f)
    m = MIME.type(e)
    b = File.read!(f)

    Logger.debug("File: #{n} - size: #{byte_size(b)}")

    response(200)
    |> set_header("content-type", "#{m}; charset=utf-8")
    |> set_header("content-disposition", "attachment; filename='#{n}'")
    |> set_header("content-length", "#{byte_size(b)}")
    |> set_body(b)
  end
end
