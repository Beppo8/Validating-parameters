defmodule TeacherWeb.Api.AlbumController do
  use TeacherWeb, :controller

  alias Teacher.Recordings
  alias Teacher.Recordings.AlbumSearch

  def index(conn, params) do
    changeset = AlbumSearch.from(params, with: &AlbumSearch.validator/2)

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
