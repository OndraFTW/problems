
defmodule ProblemsTest do
  use ExUnit.Case, async: true
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

  test "last of empty list", do: assert catch_error(last([]))==:function_clause
  test "last of one", do: assert last([1])==1
  test "last of list", do: assert last([1,2,3])==3

  test "last but one of empty list", do: assert catch_error(but_last([]))==:function_clause
  test "last but one of list with one element", do: assert catch_error(but_last([1]))==:function_clause
  test "last but one of two", do: assert but_last([1,2])==1
  test "last but one of list", do: assert but_last([1,2,3,5,6])==5

  test "minus first element", do: assert catch_error(kth([1,2,3], -1))==:function_clause
  test "element after end of list", do: assert catch_error(kth([1,2,3], 3))==:function_clause
  test "0th element", do: assert kth([1],0)
  test "2nd element", do: assert kth([1,2,3,4,5],2)

  test "length of empty list", do: assert len([])==0
  test "length of non-empty list", do: assert len([1,2,3])==3

  test "reverse empty list", do: assert reverse([])==[]
  test "reverse non-empty list", do: assert reverse([1,2,3])==[3,2,1]

  test "is empty list palindrom", do: assert is_palindrom([])
  test "is list with one alement palindrom", do: assert is_palindrom([1])
  test "is odd list palindrom", do: assert is_palindrom([1,2,1])
  test "is even list palindrom", do: assert is_palindrom([1,2,2,1])
  test "isnt palindrom", do: assert not is_palindrom([1,2,3])

  test "flatten empty list", do: assert flatten([])==[]
  test "flatten list with one lement", do: assert flatten([1])==[1]
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

  test "slice empty list", do: assert slice([],0,0)==[]
  test "slice list with negative first index", do: assert catch_error(slice([1],-1,1))==:function_clause
  test "slice list with negative second index", do: assert catch_error(slice([1],1,-1))==:function_clause
  test "slice list with negative indexes", do: assert catch_error(slice([1],-1,-1))==:function_clause
  test "slice list with first index higher tahan second one", do: assert catch_error(slice([1,2],1,0))==:function_clause
  test "slice list with out-of-range second index", do: assert catch_error(slice([1],0,3))==:function_clause
  test "slice list with out-of-range indexes", do: assert catch_error(slice([1,2],3,4))==:function_clause
  test "slice empty list in the beginning of nonempty list", do: assert slice([1,2,3],0,0)==[]
  test "slice empty list in the end of nonempty list", do: assert slice([1,2,3],1,1)==[]
  test "slice empty list in the middle of nonempty list", do: assert slice([1,2,3],2,2)==[]
  test "slice in the beggining of list", do: assert slice([1,2,3,4,5,6],0,4)==[1,2,3,4]
  test "slice in the middle of list", do: assert slice([1,2,3,4,5,6],1,5)==[2,3,4,5]
  test "slice in the end of list", do: assert slice([1,2,3,4,5,6],2,6)==[3,4,5,6]

  test "rotate empty list", do: assert rotate([], 1)==[]
  test "rotate zero-times", do: assert rotate([1,2,3],0)==[1,2,3]
  test "rotate once", do: assert rotate([1,2,3], 1)==[2,3,1]
  test "rotate length(list) times", do: assert rotate([1,2,3],3)==[1,2,3]
  test "rotate more times than length(list)", do: assert rotate([1,2,3],4)==[2,3,1]
  test "rotate negative times", do: assert catch_error(rotate([1,2,3],-1))==:function_clause

  test "remove element from empty list", do: assert catch_error(remove([], 1))==:function_clause
  test "remove element with negative index", do: assert catch_error(remove([1,2,3], -1))==:function_clause
  test "remove out-of-range element", do: assert catch_error(remove([1,2,3], 3))==:function_clause
  test "remove first element", do: assert remove([1,2,3], 0)==[2,3]
  test "remove middle element", do: assert remove([1,2,3], 1)==[1,3]
  test "remove last element", do: assert remove([1,2,3], 2)==[1,2]

  test "insert element into empty list", do: assert insert([], :a, 0)==[:a]
  test "insert element into empty list on second position", do: assert catch_error(insert([], :a, 1))==:function_clause
  test "insert element on negative index", do: assert catch_error(insert([1,2,3], :a,-1))==:function_clause
  test "insert into out-of-range index", do: assert catch_error(insert([1,2,3], :a, 4))==:function_clause
  test "insert first element", do: assert insert([1,2,3], :a, 0)==[:a,1,2,3]
  test "insert middle element", do: assert insert([1,2,3], :a, 1)==[1,:a,2,3]
  test "insert last element", do: assert insert([1,2,3], :a, 3)==[1,2,3,:a]

  test "zero number range", do: assert range(1, 1)==[]
  test "one numbers range", do: assert range(1, 2)==[1]
  test "two numbers range", do: assert range(1, 3)==[1,2]
  test "negative numbers range", do: assert range(-5, -2)==[-5, -4, -3]

  test "select zero elements from empty list", do: assert random_select([], 0)==[]
  test "select one element from empty list", do: assert catch_error(random_select([], 1))==:function_clause
  test "select all elements from list", do: assert sort(random_select([1,2,3,4,5], 5))==[1,2,3,4,5]
  test "select more elements than is in the list", do: assert catch_error(random_select([1,2,3],4))==:function_clause
  test "select negative number of elements", do: assert catch_error(random_select([1,2,3],-2))==:function_clause

  test "select no numbers", do: assert lotto_select(5, 0)==[]
  test "select one integer from interval <0, 1)", do: assert lotto_select(1, 1)==[0]
  test "select two integers from interval <0, 2)", do: assert lotto_select(2, 2)in[[0,1], [1,0]]
  test "select more numbers than is in interval", do: assert catch_error(lotto_select(3,4))==:function_clause
  test "select negative number of nubers", do: assert catch_error(lotto_select(2, -1))==:function_clause
  test "select numbers from impossible interval", do: assert catch_error(lotto_select(-1, 1))==:function_clause

  test "random permutation of empty list", do: assert random_permutation([])==[]
  test "random permutation of list with one element", do: assert random_permutation([1])==[1]
  test "random permutation of list with two elements", do: assert random_permutation([1,2]) in [[1,2], [2,1]]

  test "all combinations of length 0", do: assert combinations([1,2,3], 0)==[[]]
  test "all combinations of length 1", do: assert sort(combinations([1,2,3],1))==[[1],[2],[3]]
  test "all combinations of length 2", do: assert sort(combinations([1,2,3],2))==[[1,2],[1,3],[2,1],[2,3],[3,1],[3,2]]
  test "all combinations of length -1", do: assert catch_error(combinations([1,2,3],-1))==:function_clause
  test "all combinations of length 1 from empty list", do: assert catch_error(combinations([], 1))==:function_clause

  test "sort empty list of lists according to length", do: assert lsort([])==[]
  test "sort list of one empty list according to length", do: assert lsort([[]])==[[]]
  test "sort list of one list according to length", do: assert lsort([[0]])==[[0]]
  test "sort list of two same lists according to length", do: assert lsort([[0],[0]])==[[0],[0]]
  test "sort list of lists according to length 1", do: assert lsort([[0,1,2],[0,1],[0]])==[[0],[0,1],[0,1,2]]
  test "sort list of lists according to length 2", do: assert lsort([[0,1],[0,1],[0]])==[[0],[0,1],[0,1]]
  
  test "sort empty list of lists according to length frequency", do: assert lfsort([])==[]
  test "sort list of one empty list according to length frequency", do: assert lfsort([[]])==[[]]
  test "sort list of one list according to length frequency", do: assert lfsort([[0]])==[[0]]
  test "sort list of two same lists according to length frequency", do: assert lfsort([[0],[0]])==[[0],[0]]
  test "sort list of lists according to length frequency 1", do: assert lfsort([[0,1],[0,1],[0]])==[[0],[0,1],[0,1]]
  test "sort list of lists according to length  frequency 2", do: assert lfsort([[0,1],[0],[0]])==[[0,1],[0],[0]]
  test "sort list of lists according to length  frequency 3", do: assert lfsort([[0,1,2],[0,1],[0],[0]])==[[0,1,2],[0,1],[0],[0]]

  test "is -1 prime", do: assert is_prime(-1)==false
  test "is 0 prime", do: assert is_prime(0)==false
  test "is 1 prime", do: assert is_prime(1)==false
  test "is 2 prime", do: assert is_prime(2)==true
  test "is 3 prime", do: assert is_prime(3)==true
  test "is 4 prime", do: assert is_prime(4)==false
  test "is 5 prime", do: assert is_prime(5)==true
  test "is 59 prime", do: assert is_prime(59)==true
  test "is 60 prime", do: assert is_prime(60)==false
  
  test "greatest common divisor of 1 and 1", do: assert gcd(1,1)==1
  test "greatest common divisor of 2 and 2", do: assert gcd(2,2)==2
  test "greatest common divisor of 2 and 3", do: assert gcd(2,3)==1
  test "greatest common divisor of 55 and 66", do: assert gcd(55,66)==11
  test "greatest common divisor of 55 and 67", do: assert gcd(55,67)==1
  
  test "are 1 and 1 coprimes", do: assert coprimes(1,1)==true
  test "are 1 and 2 coprimes", do: assert coprimes(1,2)==true
  test "are 2 and 2 coprimes", do: assert coprimes(2,2)==false
  test "are 5 and 7 coprimes", do: assert coprimes(5,7)==true
  test "are 55 and 60 coprimes", do: assert coprimes(55,60)==false
  test "are 60 and 59 coprimes", do: assert coprimes(60,59)==true
  
  test "eulers totient function of 0", do: assert catch_error(totient_phi(0))==:function_clause
  test "eulers totient function of 1", do: assert totient_phi(1)==1
  test "eulers totient function of 3", do: assert totient_phi(3)==2
  test "eulers totient function of 5", do: assert totient_phi(5)==4
  test "eulers totient function of 55", do: assert totient_phi(55)==40
  
  test "prime factors of 0", do: assert catch_error(prime_factors(0))==:function_clause
  test "prime factors of 1", do: assert prime_factors(1)==[1]
  test "prime factors of 4", do: assert prime_factors(4)==[2,2]
  test "prime factors of 12", do: assert prime_factors(12)==[2,2,3]
  test "prime factors of 55", do: assert prime_factors(55)==[5,11]
  
  test "prime factors with multiplicity of 0", do: assert catch_error(prime_factors_mult(0))==:function_clause
  test "prime factors with multiplicity of 1", do: assert prime_factors_mult(1)==[{1,1}]
  test "prime factors with multiplicity of 4", do: assert prime_factors_mult(4)==[{2,2}]
  test "prime factors with multiplicity of 12", do: assert prime_factors_mult(12)==[{2,2},{1,3}]
  test "prime factors with multiplicity of 55", do: assert prime_factors_mult(55)==[{1,5},{1,11}]
  
  test "eulers totient function 2 of 0", do: assert catch_error(totient_phi2(0))==:function_clause
  test "eulers totient function 2 of 1", do: assert totient_phi2(1)==1
  test "eulers totient function 2 of 3", do: assert totient_phi2(3)==2
  test "eulers totient function 2 of 5", do: assert totient_phi2(5)==4
  test "eulers totient function 2 of 55", do: assert totient_phi2(55)==40

  test "all primes in range -5 to -1", do: assert primes_range(-5,-1)==[]
  test "all primes in range -5 to 5", do: assert primes_range(-5,5)==[2,3,5]
  test "all primes in range 5 to 10", do: assert primes_range(5,10)==[5,7]
  test "all primes in range 100 to 110", do: assert primes_range(100,110)==[101,103,107,109]
  
  test "goldbach conjecture of -1", do: assert catch_error(goldbach(-1))==:function_clause
  test "goldbach conjecture of 0", do: assert catch_error(goldbach(0))==:function_clause
  test "goldbach conjecture of 3", do: assert catch_error(goldbach(0))==:function_clause
  test "goldbach conjecture of 6" do
    r=goldbach(6)
    assert Enum.any?([{3,3}], fn(a)-> a==r end)
  end
  test "goldbach conjecture of 10" do
    r=goldbach(10)
    assert Enum.any?([{3,7},{7,3},{5,5}], fn(a)-> a==r end)
  end
  test "goldbach conjecture of 12" do
    r=goldbach(12)
    assert Enum.any?([{5,7},{7,5}], fn(a)-> a==r end)
  end
  
end
