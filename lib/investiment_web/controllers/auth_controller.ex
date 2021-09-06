defmodule InvestimentWeb.AuthController do
  use InvestimentWeb, :controller

  alias Investiment.User
  alias Investiment.Repo

  def request(conn, _params) do
    oauth_github_url = ElixirAuthGithub.login_url(%{scopes: ["user:email"]})
    redirect(conn, external: oauth_github_url)
  end

  @spec callback(Plug.Conn.t(), any) :: Plug.Conn.t()
  def callback(conn, %{"code" => code}) do
    {:ok, profile} = ElixirAuthGithub.github_auth(code)
    user_params = %{email: profile.email}
    changeset = Investiment.User.changeset(%User{}, user_params)
    signin(conn, changeset)
  end

  @spec signout(Plug.Conn.t(), any) :: Plug.Conn.t()
  def signout(conn, _params) do
    conn
    |> configure_session(drop: true)
    |> redirect(to: Routes.page_path(conn, :index))
  end

  @spec signin(Plug.Conn.t(), any) :: Plug.Conn.t()
  defp signin(conn, changeset) do
    case insert_or_update(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Welcome back #{user.email}")
        |> put_session(:user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _reason} ->
        conn
        |> put_flash(:error, "Error signin")
        |> redirect(to: Routes.page_path(conn, :index))
    end

  end

  defp insert_or_update(changeset) do
    case Repo.get_by(User, email: changeset.changes.email) do
      nil ->
        Repo.insert(changeset)
      user ->
        {:ok, user}
    end
  end

end
