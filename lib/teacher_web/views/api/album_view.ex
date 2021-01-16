defmodule TeacherWeb.Api.AlbumView do
  use TeacherWeb, :view

  def render("index.json", %{albums: albums}) do
    Enum.map(albums, &Map.take(&1, [:title, :year, :summary]))
  end

  def render("error.json", %{errors: errors}) do
    %{error: errors}
  end

end
