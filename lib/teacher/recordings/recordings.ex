defmodule Teacher.Recordings do
  @moduledoc """
  The Recordings context.
  """

  import Ecto.Query, warn: false
  alias Teacher.Repo

  alias Teacher.Recordings.{Category, Album}

  def album_search(attrs) do
    title = get_in(attrs, [:title])
    year = get_in(attrs, [:year])
    name = get_in(attrs, [:artist])

    Album
    |> Album.by_title(title)
    |> Album.by_year(year)
    |> Album.by_artist_name(name)
    |> Repo.all()
  end

  @doc """
  Returns the list of albums.

  ## Examples

      iex> list_albums()
      [%Album{}, ...]

  """
  def list_albums do
    Album
    |> Repo.all()
    |> Repo.preload(:category)
  end

  @doc """
  Gets a single album.

  Raises `Ecto.NoResultsError` if the Album does not exist.

  ## Examples

      iex> get_album!(123)
      %Album{}

      iex> get_album!(456)
      ** (Ecto.NoResultsError)

  """
  def get_album!(id) do
    Album
    |> Repo.get!(id)
    |> Repo.preload(:category)
  end

  @doc """
  Creates a album.

  ## Examples

      iex> create_album(%{field: value})
      {:ok, %Album{}}

      iex> create_album(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_album(attrs \\ %{}) do
    %Album{}
    |> Album.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a album.

  ## Examples

      iex> update_album(album, %{field: new_value})
      {:ok, %Album{}}

      iex> update_album(album, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_album(%Album{} = album, attrs) do
    album
    |> Album.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Album.

  ## Examples

      iex> delete_album(album)
      {:ok, %Album{}}

      iex> delete_album(album)
      {:error, %Ecto.Changeset{}}

  """
  def delete_album(%Album{} = album) do
    Repo.delete(album)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking album changes.

  ## Examples

      iex> change_album(album)
      %Ecto.Changeset{source: %Album{}}

  """
  def change_album(%Album{} = album) do
    Album.changeset(album, %{})
  end

  @doc """
  Creates a category.

  ## Examples

      iex> create_category(%{field: value})
      {:ok, %Album{}}

      iex> create_category(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_category(attrs \\ %{}) do
    %Category{}
    |> Category.changeset(attrs)
    |> Repo.insert()
  end

  def get_category(id), do: Repo.get(Category, id)

  def list_categories do
    Category
    |> Repo.all()
  end

end
