# Quick test data for UserExtraction2
# user = %{"email" => "javalos@test.com", "login" => "javalos", "password" => "1234pass"}
# missing_login = %{"email" => "", "password" => "1234pass"}\
# missing_email = %{"login" => "javalos", "password" => "1234pass"}
# missing_password = %{"login" => "javalos", "email" => ""}

defmodule UserExtraction2 do
  @required_fields ["login", "email", "password"]

  def extract_user(user) do
    case Enum.filter(@required_fields, &(not Map.has_key?(user, &1))) do

      # No fields are missing: convert string keys to atoms and return {:ok, map}
      [] -> {:ok, Enum.into(user, %{}, fn {k, v} -> {String.to_atom(k), v} end)}

      # Some fields are missing: return an error tuple with all of them
      missing_fields -> {:error, "Missing required fields: #{Enum.join(missing_fields, ", ")}"}

    end
  end

end
