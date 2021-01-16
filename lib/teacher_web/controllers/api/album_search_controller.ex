defmodule TeacherWeb.Api.AlbumController do
  use TeacherWeb, :controller

  alias Teacher.Recordings

  defp changeset(params) do
    data = %{}
    types = %{title: :string, year: :integer, artist: :string}

    {data, types}
    |> Ecto.Changeset.cast(params, Map.keys(types))
    |> Ecto.Changeset.validate_length(:title, min: 3)
  end

  def index(conn, params) do
    changeset = changeset(params)

    if changeset.valid? do
      albums = Recordings.album_search(changeset.changes)
      render(conn, "index.json", albums: albums)
    else
      errors = Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
        Enum.reduce(opts, msg, fn {key, value}, acc ->
          String.replace(acc, "%{#{key}}", to_string(value))
        end)
      end)
      render(conn, "error.json", errors: errors)
    end
  end


end
