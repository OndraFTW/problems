Code.require_file "../../lib/problems.ex", __FILE__
ExUnit.start

defmodule ProblemsTest do
  use ExUnit.Case
  import Problems

  # miscellaneous functions tests

  test "5 to the power of 0", do: assert pow(5, 0)==1
  test "5 to the power of one", do: assert pow(5, 1)==5
  test "5 to the power of two", do: assert pow(5, 2)==25

  test "map empty list", do: assert map([], fn(a)-> a end)==[]
  test "double every element in list", do: assert map([1,2,3], &1*2)==[2,4,6]

  test "conmap empty list", do: assert conmap([], fn(a)-> a end)==[]
  test "conmap lists", do: assert conmap([1,2,3], [&1])==[1,2,3]

  test "empty list", do: assert len([])==0
  test "non-empty list", do: assert len([1])==1

  test "sort empty list", do: assert sort([])==[]
  test "sort nonempty list", do: assert sort([3,1,2])==[1,2,3]
  test "sort with function", do: assert sort([3,1,2], &1<&2)==[1,2,3]
  test "sort backwards", do: assert sort([2,1,3], &1>&2)==[3,2,1]

  test "filter empty list", do: assert filter([], &1>1)==[]
  test "filter above 1", do: assert filter([1,2,3], &1>1)==[2,3]
  test "filter all", do: assert filter([0,0,0], &1==1)==[]

  test "is 0 even", do: assert is_even(0)
  test "is 4 even", do: assert is_even(4)
  test "is -2 even", do: assert is_even(-2)
  test "is 1 even", do: assert not is_even(1)

  test "last of one", do: assert last([1])==1
  test "last of list", do: assert last([1,2,3])==3

  test "last but one of two", do: assert but_last([1,2])==1
  test "last but one of list", do: assert but_last([1,2,3,5,6])==5

  test "0th element", do: assert kth([1],0)
  test "2nd element", do: assert kth([1,2,3,4,5],2)

  test "length of empty list", do: assert len([])==0
  test "lengrh of non-empty list", do: assert len([1,2,3])==3

end
