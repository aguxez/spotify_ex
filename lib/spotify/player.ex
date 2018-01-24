defmodule Spotify.Player do
  @moduledoc false

  use Responder

  import Helpers

  alias Spotify.Client

  defstruct ~w(context timestamp is_playing progress_ms item)a

  def currently_playing(conn) do
    url = player_url("currently-playing")

    conn
    |> Client.get(url)
    |> handle_response()
  end

  def build_response(body) do
    case body do
      {:ok, playing} -> to_struct(__MODULE__, playing)
      playing        -> playing
    end
  end

  defp player_url(endpoint),
    do: "https://api.spotify.com/v1/me/player/#{endpoint}"
end
