{name, age} = {"Garry", 34}

IO.puts("Name: #{name}, Age: #{age}")

crazy = {name2, age2} = {"Garry", 34}

IO.puts("Name: #{name2}, Age: #{age2}")
IO.puts("crazy[0]: #{elem(crazy, 0)}, crazy[1]: #{elem(crazy, 1)}")

# Interactive Elixir (1.16.3) - press Ctrl+C to exit (type h() ENTER for help)
# iex(1)> 1 = 2
# ** (MatchError) no match of right hand side value: 2
#     (stdlib 5.2.3) erl_eval.erl:498: :erl_eval.expr/6
#     iex:1: (file)
# iex(1)> 1 = 1
# 1

person_match = {:person, "Garry", 34}

#  Uses the person atom to match against, which is why
# the first element of the tuple is "ignored"
{:person, name3, age3} = person_match

IO.puts("Name: #{name3}, Age: #{age3}")

# The ^ seems like a way to dynamically match against a variable
match_value = "Garry"
^match_value = name3
^match_value = "Garry"

# ^match_value = "not Garry"
# ** (MatchError) no match of right hand side value: "not Garry"
# pattern_matching.exs:30: (file)
# (elixir 1.16.3) lib/code.ex:1489: Code.require_file/2

IO.puts("Matched against #{match_value}")

# List example
[head | tail] = [1, 2, 3, 4, 5]

IO.puts("Head: #{head}, Tail: ")
IO.inspect(tail)

# Map example -- only care about the name
%{name: name4} = %{name: "Garry", age: 34}
IO.puts("Name: #{name4}")

# Example string match
"hello" <> rest = "hello, world"
IO.puts("Rest: #{rest}")

# Example without a string match
# "hello" <> rest = "goodbye, world"
# ** (MatchError) no match of right hand side value: "goodbye, world"
#     pattern_matching.exs:53: (file)
#     (elixir 1.16.3) lib/code.ex:1489: Code.require_file/2
