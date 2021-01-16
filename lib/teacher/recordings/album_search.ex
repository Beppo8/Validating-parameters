defmodule Teacher.Recordings.AlbumSearch do
  use Params.Schema, %{title: :string, year: :integer, artist!: :string}
  import Ecto.Changeset

  def validator(changeset, params) do
    changeset
    |> cast(params, [:title, :year, :artist])
    |> validate_length(:title, min: 3)
    |> validate_required([:artists])
  end

end
