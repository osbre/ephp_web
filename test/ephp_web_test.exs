defmodule EphpWebTest do
  use ExUnit.Case
  doctest EphpWeb

  test "greets the world" do
    assert EphpWeb.hello() == :world
  end
end
