defmodule Issues.GithubIssues do
  @moduledoc """
  Takes a user name and project into a data structure containing the
  projects issues
  """

  @user_agent [ {"User-agent", "Elixir dave@pragprog.com"} ]

  def fetch(user, project) do
    issues_url(user, project)
    |> HTTPoison.get(@user_agent)
    |> handle_response
  end

  def issues_url(user, project) do
    "https://api.github.com/repos/#{user}/#{project}/issues"
  end

  def handle_response({ :ok, %{status_code: 200, body: body}}) do
    { :ok, body }
  end

  def handle_response({ _, %{status_code: _, body: body}}) do
    { :error, body }
  end
end
