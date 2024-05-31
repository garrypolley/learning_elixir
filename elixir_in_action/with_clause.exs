defmodule ExampleWith do
  def check_login(input) when is_map(input) do
    with {:ok, user} <- get_user(input),
         {:ok, _} <- validate_token(input) do
      {:ok, user}
    else
      {:error, reason} -> {:error, reason}
    end
  end

  def check_login(_) do
    {:error, "Invalid input"}
  end

  def check_login_filter(input) when is_map(input) do
    map_with_space = fn x -> ":" <> Atom.to_string(x) <> ", " end
    case Enum.filter(
           [:user, :token],
           &(not Map.has_key?(input, &1))
         ) do
      [] -> {:ok, input[:user]}
      missing_fields -> {:error, "Missing fields: #{Enum.map(missing_fields, map_with_space)}"}
    end
  end

  defp get_user(input) when is_map(input) do
    name = Map.get(input, :user, nil)
    if name !== nil, do: {:ok, name}, else: {:error, "Invalid username"}
  end

  defp validate_token(input) when is_map(input) do
    token = Map.get(input, :token, nil)
    if token !== nil, do: {:ok, token}, else: {:error, "Invalid token"}
  end
end
