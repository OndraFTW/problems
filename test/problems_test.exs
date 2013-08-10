Code.require_file "../../lib/problems.ex", __FILE__
ExUnit.start

defmodule ProblemsTest do
  use ExUnit.Case
  import Problems

  # miscellaneous functions tests

  test "5 to the power of 0", do: assert pow(5, 0)==1
  test "5 to the power of one", do: assert pow(5, 1)==5
  test "5 to the power of two", do: assert pow(5, 2)==25
  test "3 to the power of minus one", do: assert pow(3, -1)==1/3
  test "3 to the power of minus two", do: assert pow(3, -2)==1/9

  test "map empty list", do: assert map([], fn(a)-> a end)==[]
  test "double every element in list", do: assert map([1,2,3], fn(x)-> x*2 end)==[2,4,6]

  test "conmap empty list", do: assert conmap([], fn(a)-> a end)==[]
  test "conmap list of empty lists", do: assert conmap([[],[],[]], fn(x)-> x end)==[]
  test "conmap lists", do: assert conmap([1,2,3], fn(x)-> [x] end)==[1,2,3]

  test "empty list", do: assert len([])==0
  test "nonempty list", do: assert len([1])==1
  test "longer nonempty list", do: assert len([1,2,3])==3

  test "sort empty list", do: assert sort([])==[]
  test "sort nonempty list", do: assert sort([3,1,2])==[1,2,3]
  test "sort with function", do: assert sort([3,1,2], fn(a, b)-> a<b end)==[1,2,3]
  test "sort backwards", do: assert sort([2,1,3], fn(a, b)-> a>b end)==[3,2,1]

  test "filter empty list", do: assert filter([], fn(x)-> x>1 end)==[]
  test "filter above 1", do: assert filter([1,2,3], fn(x)-> x>1 end)==[2,3]
  test "filter all", do: assert filter([0,0,0], fn(x)-> x==1 end)==[]

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
  test "length of non-empty list", do: assert len([1,2,3])==3

  test "reverse empty list", do: assert reverse([])==[]
  test "reverse non-empty list", do: assert reverse([1,2,3])==[3,2,1]

  test "is empty list palindrom", do: assert is_palindrom([])
  test "is odd list palindrom", do: assert is_palindrom([1,2,1])
  test "is even list palindrom", do: assert is_palindrom([1,2,2,1])
  test "isnt palindrom", do: assert not is_palindrom([1,2,3])

  test "flatten empty list", do: assert flatten([])==[]
  test "flatten first element", do: assert flatten([[1,2],3])==[1,2,3]
  test "flatten last element", do: assert flatten([1,2,3,[4,5]])==[1,2,3,4,5]
  test "flatten inside", do: assert flatten([1,2,[3,4,5],6])==[1,2,3,4,5,6]
  test "flatten more layers", do: assert flatten([1,[2,[3,4]],5,6])

  test "delete repetition in empty list", do: assert delete_repetition([])==[]
  test "delete repetition in list with one element", do: assert delete_repetition([1])==[1]
  test "delete repetition in list of two repeating elements", do: assert delete_repetition([1,1])==[1]
  test "delete repetition in list of nonrepeating elements", do: assert delete_repetition([1,2,3])==[1,2,3]
  test "delete multiple repetition in list", do: assert delete_repetition([1,1,1,1])==[1]
  test "delete repetition in the beggining of list", do: assert delete_repetition([1,1,2,3])==[1,2,3]
  test "delete repetition in the middle of list", do: assert delete_repetition([1,2,2,3])==[1,2,3]
  test "delete repetition in the end of list", do: assert delete_repetition([1,2,3,3])==[1,2,3]
  test "delete two repetition in one list", do: assert delete_repetition([1,1,2,2])==[1,2]

  test "pack repetition in empty list", do: assert pack([])==[]
  test "pack repetition in list with one element", do: assert pack([1])==[[1]]
  test "pack repetition in list of two repeating elements", do: assert pack([1,1])==[[1,1]]
  test "pack repetition in list of nonrepeating elements", do: assert pack([1,2,3])==[[1],[2],[3]]
  test "pack multiple repetition in list", do: assert pack([1,1,1,1])==[[1,1,1,1]]
  test "pack repetition in the beggining of list", do: assert pack([1,1,2,3])==[[1,1],[2],[3]]
  test "pack repetition in the middle of list", do: assert pack([1,2,2,3])==[[1],[2,2],[3]]
  test "pack repetition in the end of list", do: assert pack([1,2,3,3])==[[1],[2],[3,3]]
  test "pack two repetition in one list", do: assert pack([1,1,2,2])==[[1,1],[2,2]]

  test "compress repetition in empty list", do: assert compress_pack([])==[]
  test "compress repetition in list with one element", do: assert compress_pack([1])==[{1,1}]
  test "compress repetition in list of two repeating elements", do: assert compress_pack([1,1])==[{1,2}]
  test "compress repetition in list of nonrepeating elements", do: assert compress_pack([1,2,3])==[{1,1},{2,1},{3,1}]
  test "compress multiple repetition in list", do: assert compress_pack([1,1,1,1])==[{1,4}]
  test "compress repetition in the beggining of list", do: assert compress_pack([1,1,2,3])==[{1,2},{2,1},{3,1}]
  test "compress repetition in the middle of list", do: assert compress_pack([1,2,2,3])==[{1,1}, {2,2},{3,1}]
  test "compress repetition in the end of list", do: assert compress_pack([1,2,3,3])==[{1,1},{2,1},{3,2}]
  test "compress two repetition in one list", do: assert compress_pack([1,1,2,2])==[{1,2},{2,2}]

  test "compress repetition (except for 1) in empty list", do: assert compress_pack2([])==[]
  test "compress repetition (except for 1) in list with one element", do: assert compress_pack2([1])==[1]
  test "compress repetition (except for 1) in list of two repeating elements", do: assert compress_pack2([1,1])==[{1,2}]
  test "compress repetition (except for 1) in list of nonrepeating elements", do: assert compress_pack2([1,2,3])==[1,2,3]
  test "compress multiple repetition (except for 1) in list", do: assert compress_pack2([1,1,1,1])==[{1,4}]
  test "compress repetition (except for 1) in the beggining of list", do: assert compress_pack2([1,1,2,3])==[{1,2},2,3]
  test "compress repetition (except for 1) in the middle of list", do: assert compress_pack2([1,2,2,3])==[1,{2,2},3]
  test "compress repetition (except for 1) in the end of list", do: assert compress_pack2([1,2,3,3])==[1,2,{3,2}]
  test "compress two repetition (except for 1) in one list", do: assert compress_pack2([1,1,2,2])==[{1,2},{2,2}]

  test "compress repetition (except for 1, without use of pack/1) in empty list", do: assert compress([])==[]
  test "compress repetition (except for 1, without use of pack/1) in list with one element", do: assert compress([1])==[1]
  test "compress repetition (except for 1, without use of pack/1) in list of two repeating elements", do: assert compress([1,1])==[{1,2}]
  test "compress repetition (except for 1, without use of pack/1) in list of nonrepeating elements", do: assert compress([1,2,3])==[1,2,3]
  test "compress multiple repetition (except for 1, without use of pack/1) in list", do: assert compress([1,1,1,1])==[{1,4}]
  test "compress repetition (except for 1, without use of pack/1) in the beggining of list", do: assert compress([1,1,2,3])==[{1,2},2,3]
  test "compress repetition (except for 1, without use of pack/1) in the middle of list", do: assert compress([1,2,2,3])==[1,{2,2},3]
  test "compress repetition (except for 1, without use of pack/1) in the end of list", do: assert compress([1,2,3,3])==[1,2,{3,2}]
  test "compress two repetition (except for 1, without use of pack/1) in one list", do: assert compress([1,1,2,2])==[{1,2},{2,2}]

  test "decompress repetition in empty list", do: assert decompress([])==[]
  test "decompress repetition in list with one element", do: assert decompress([1])==[1]
  test "decompress repetition in list of two repeating elements", do: assert decompress([{1,2}])==[1,1]
  test "decompress repetition  in list of nonrepeating elements", do: assert decompress([1,2,3])==[1,2,3]
  test "decompress multiple repetition in list", do: assert decompress([{1,4}])==[1,1,1,1]
  test "decompress repetition in the beggining of list", do: assert decompress([{1,2},2,3])==[1,1,2,3]
  test "decompress repetition in the middle of list", do: assert decompress([1,{2,2},3])==[1,2,2,3]
  test "decompress repetition in the end of list", do: assert decompress([1,2,{3,2}])==[1,2,3,3]
  test "decompress two repetition in one list", do: assert decompress([{1,2},{2,2}])==[1,1,2,2]

  test "duplicate empty list", do: assert duplicate([])==[]
  test "duplicate list with one element", do: assert duplicate([1])==[1,1]
  test "duplicate list with two elements", do: assert duplicate([1,2])==[1,1,2,2]
  test "duplicate list with two equal elements", do: assert duplicate([1,1])==[1,1,1,1]
  test "duplicate list with three equal elements", do: assert duplicate([1,1,1])==[1,1,1,1,1,1]

  test "replicate empty list", do: assert replicate([], 1)==[]
  test "replicate empty list zero-times", do: assert replicate([], 0)==[]
  test "replicate nonempty list zero-times", do: assert replicate([1,1], 0)==[]
  test "replicate nonempty list once", do: assert replicate([1,2], 1)==[1,2]
  test "replicate nonempty list twice", do: assert replicate([1,2], 2)==[1,1,2,2]
  test "replicate nonempty list with repeating elements", do: assert replicate([1,1,1], 3)==[1,1,1,1,1,1,1,1,1]
  
  test "drop from empty list", do: assert drop([], 2)==[]
  test "drop from empty list every zeroth element", do: assert catch_error(drop([], 0))==:function_clause
  test "drop from nonempty list every minus first element", do: assert catch_error(drop([1,2,3,4,5,6], -1))==:function_clause
  test "drop from nonempty list every zeroth element", do: assert catch_error(drop([1,2,3,4,5,6], 0))==:function_clause
  test "drop from nonempty list every first element", do: assert drop([1,2,3,4,5,6], 1)==[]
  test "drop from nonempty list every second element", do: assert drop([1,2,3,4,5,6], 2)==[1,3,5]
  test "drop from nonempty list every third element", do: assert drop([1,2,3,4,5,6], 3)==[1,2,4,5]

  test "split empty list into empty lists", do: assert split([], 0)=={[], []}
  test "split empty list into nonempty lists", do: assert catch_error(split([], 1))==:function_clause
  test "split empty list into negative length list", do: assert catch_error(split([], -1))==:function_clause
  test "split nonempty list into empty list", do: assert split([1,2], 0)=={[], [1,2]}
  test "split nonempty list into longer list", do: assert catch_error(split([1,2], 3))==:function_clause
  test "split nonempty list into negative length list", do: assert catch_error(split([1,2], -1))==:function_clause


end
