
defmodule Problems do

    # miscellaneous functions

    # get a raised to the power of b
    def pow(a, b) when b<0, do: 1/pow(a, -b, 1)
    def pow(a, b), do: pow(a, b, 1)
    defp pow(_, 0, result), do: result
    defp pow(a, b, result), do: pow(a, b-1, result*a)

    # aplies function func on every element in list and returns list of returned values
    def map(list, func), do: map(list, func, [])
    defp map([], _, result), do: reverse(result)
    defp map([head|tail], func, result), do: map(tail, func, [func.(head)|result])

    # aplies function func on every element in list and returns concatenated returned values
    def conmap(list, func), do: conmap(list, func, [])
    defp conmap([], _, result), do: reverse(result)
    defp conmap([head|tail], func, result), do: conmap(tail, func, func.(head)++result)

    # sorts list
    def sort(list), do: sort(list, fn(a, b)-> a<b end)
    def sort([], _), do: []
    def sort([pivot|list], func),
        do: sort(filter(list, fn(e)->func.(e, pivot)end), func)++
            [pivot|sort(filter(list, fn(e)->not func.(e, pivot)end), func)]

    # applies function func on every element in list and returns list of elements, for whom function func returned true
    def filter(list, func), do: filter(list, func, [])
    defp filter([], _, result), do: reverse result
    defp filter([head|tail], func, result) do
        if func.(head) do
            filter(tail, func, [head|result])
        else
            filter(tail, func, result)
        end
    end

    # determines whether n is even
    defmacro is_even(n) do
        quote do: rem(unquote(n), 2)==0
    end

    # determines if two lists are equal
    def list_equals([],[]), do: true
    def list_equals([_|_],[]), do: false
    def list_equals([],[_|_]), do: false
    def list_equals([head1|tail1],[head2|tail2]), do: head1==head2 and list_equals(tail1, tail2)

    def list_of_lists_equals([],[]), do: true
    def list_of_lists_equals([_|_],[]), do: false
    def list_of_lists_equals([],[_|_]), do: false
    def list_of_lists_equals([head1|tail1],[head2|tail2]), do: list_equals(head1,head2) and list_of_lists_equals(tail1, tail2)

    # determines if two lists are equal, ignores order of itema in lists
    def list_equals_ignore_order(list1,list2), do: list_equals(sort(list1), sort(list2))

    # remove duplicate items from given list, the first occurence is retained
    def remove_duplicates(list), do: remove_duplicates(list, fn(a,b)-> a==b end)
    def remove_duplicates([], _func), do: []
    def remove_duplicates([head|tail], func) do
        tail=remove_duplicates(head, tail, func)
        [head|remove_duplicates(tail, func)]
    end

    defp remove_duplicates(_item, [], _func), do: []
    defp remove_duplicates(item, [head|tail], func), do: if func.(item, head), do: remove_duplicates(item, tail, func), else: [head|remove_duplicates(item, tail, func)]

    # 01 get last element of list
    def last([head]), do: head
    def last([_|tail]), do: last(tail)

    # 02 get one but last element of list
    def but_last([first, _]), do: first
    def but_last([_|tail]), do: but_last(tail)

    # 03 get kth element of list
    def kth([head|_], 0), do: head
    def kth([_|tail], k) when k>0, do: kth(tail, k-1)

    # 04 get list length
    def len(list), do: len(list, 0)
    defp len([], result), do: result
    defp len([_|tail], result), do: len(tail, result+1)

    # 05 reverse list
    def reverse(list), do: reverse(list, [])
    defp reverse([], result), do: result
    defp reverse([head|tail], result), do: reverse(tail, [head|result])

    # 06 find out whether is list palindrom
    def is_palindrom(list), do: is_palindrom([], list)
    defp is_palindrom(left, right) when length(left)==length(right), do: left==right
    defp is_palindrom(left, [_|right]) when length(left)==length(right), do: left==right
    defp is_palindrom(left, [middle|right]), do: is_palindrom([middle|left], right)

    # 07 flatten list
    def flatten([]), do: []
    def flatten([head|tail]) when is_list(head), do: flatten(head)++flatten(tail)
    def flatten([head|tail]), do: [head|flatten(tail)]

    # 08 delete consecutive repeating elements
    def delete_repetition(list), do: delete_repetition(list, [])
    defp delete_repetition([], result), do: reverse(result)
    defp delete_repetition([head], result), do: reverse ([head|result])
    defp delete_repetition([first, first|tail], result), do: delete_repetition([first|tail], result)
    defp delete_repetition([first, second|tail], result), do: delete_repetition([second|tail], [first|result])

    # 09 pack consecutive repeating elements into sublists
    def pack(list), do: pack(list, [], [])
    defp pack([], [], []), do: []
    defp pack([], repetition, result), do: reverse([repetition|result])
    defp pack([head|tail], [], result),  do: pack(tail, [head], result)
    defp pack([head|tail], [repetition_head|repetition_tail], result) when head==repetition_head,
        do: pack(tail, [head, repetition_head|repetition_tail], result)
    defp pack([head|tail], [repetition_head|repetition_tail], result),
        do: pack(tail, [head], [[repetition_head|repetition_tail]|result])

    # 10 compress repeating elements into tuples {element, repetition}
    def compress_pack(list), do: map(pack(list), fn([head|tail])-> {head, length(tail)+1} end)

    # 11 compress repeating elements into tuples {element, repetition}, except for repetition 1
    def compress_pack2(list), do: map(pack(list), fn([head|tail])-> compress_element(head, length(tail)+1) end)

    # 12 compress repeating elements into tuples {element, repetition}, except for repetition 1,
    # withou use of function pack/1
    def compress(list), do: compress(list, 0, [])
    defp compress([],0,[]), do: []
    defp compress([head], number_of_repetitions, result),
        do: reverse([compress_element(head, number_of_repetitions+1)|result])
    defp compress([first, first|tail], number_of_repetitions, result),
        do: compress([first|tail], number_of_repetitions+1, result)
    defp compress([first, second|tail], number_of_repetitions, result),
        do: compress([second|tail], 0, [compress_element(first, number_of_repetitions+1)|result])

    defp compress_element(element, 1), do: element
    defp compress_element(element, number_of_repetitions), do: {element, number_of_repetitions}

    # 13 decompress repeating elements (see 10-12)
    def decompress(list), do: decompress(list, [])
    defp decompress([], result), do: result
    defp decompress([head|tail], result), do: decompress(tail, result++decompress_element(head))

    defp decompress_element({element, number}), do: decompress_element({element, number}, [])
    defp decompress_element(element), do: [element]
    defp decompress_element({element, 1}, result), do: [element|result]
    defp decompress_element({element, number}, result), do: decompress_element({element, number-1}, [element|result])

    # 14 duplicate every element in list
    def duplicate(list), do: duplicate(list, [])
    defp duplicate([], result), do: reverse(result)
    defp duplicate([head|tail], result), do: duplicate(tail, [head, head|result])

    # 15 replicate every element in list number-times
    def replicate(_, 0), do: []
    def replicate(list, number), do: replicate(list, number, number, [])
    defp replicate([], _, _, result), do: reverse(result)
    defp replicate([head|tail], 1, number, result), do: replicate(tail, number, number, [head|result])
    defp replicate([head|tail], repeat_head, number, result),
        do: replicate([head|tail], repeat_head-1, number, [head|result])

    # 16 drop every number-th element in list
    def drop(list, number) when number>=1, do: drop(list, number, number, [])
    defp drop([], _, _, result), do: reverse (result)
    defp drop([_|tail], 1, number, result), do: drop(tail, number, number, result)
    defp drop([head|tail], to_drop, number, result), do: drop(tail, to_drop-1, number, [head|result])

    # 17 split list into two, len is length of first one
    def split(list, len) when length(list)>=len, do: split([], list, len)
    defp split(left, right, 0), do: {reverse(left), right}
    defp split(left, [middle|right], len), do: split([middle|left], right, len-1)

    # 18 get slice from list, a is index of first element of slice and b index of last plus one
    def slice(list, a, b) when a<=b and a>=0 and b<=length(list), do: slice(list, a, b, [])
    defp slice(_, _, 0,  result), do: reverse(result)
    defp slice([head|tail], a, b, result) when a<=0, do: slice(tail, a-1, b-1, [head|result])
    defp slice([_|tail], a, b, result), do: slice(tail, a-1, b-1, result)

    # 19 rotate list left number-times
    def rotate(list, 0), do: list
    def rotate([], _), do: []
    def rotate(list, number) do
        number_adjusted=rem(number, length(list))
        {left, right}=split(list, number_adjusted)
        right++left
    end

    # 20 remove number-th element
    def remove(list, number) when number>=0, do: remove([], list, number)
    defp remove(left, [_|right], 0), do: reverse(left)++right
    defp remove(left, [head|right], number), do: remove([head|left], right, number-1)

    # 21 insert element into list at position number
    def insert(list, element, number) when number >=0, do: insert(element, list, number, [])
    defp insert(element, right, 0, left), do: reverse(left)++[element|right]
    defp insert(element, [head|right], number, left), do: insert(element, right, number-1, [head|left])

    # 22 generate list of integers from a to b-1
    def range(a, b) when a<=b, do: range(a, b, [])
    defp range(b, b, result), do: reverse(result)
    defp range(a, b, result), do: range(a+1, b, [a|result])

    # 23 randomly select number of elements from list
    def random_select(list, number) when length(list)>=number and number>=0, do: random_select(list, number, [])
    defp random_select(_, 0, result), do: result
    defp random_select(list, number, result) do
        index=Kernel.round(:rand.uniform()*(len(list)-1))
        random_select(remove(list, index), number-1, [kth(list, index)|result])
    end

    # 24 select n numbers from range 0 to max_value-1, without repetition
    def lotto_select(max_value, n) when n<=max_value, do: random_select(range(0, max_value), n)

    # 25 get random permutation of list
    def random_permutation(list), do: random_select(list, length(list))

    # 26 get all combinations of elements from list, every combination has length len
    def combinations(_list, 0), do: [[]]
    def combinations(list, len) when len>0 and len<=length(list), do: comb([], list, len)

    defp comb([], list, 1), do: map(list, fn(e)-> [e] end)
    defp comb(object, list, 1), do: map(list, fn(e)-> [e|object] end)
    defp comb([], list, len), do: conmap(list, fn(e)-> comb([e], List.delete(list, e), len-1) end)
    defp comb(object, list, len), do: conmap(list, fn(e)-> comb([e|object], List.delete(list, e), len-1) end)

    # 27 divide people into groups of 2, 3 and 4
    def group234(people) when length(people)==9, do: map(all_permutations(people), fn(e)-> groupify(e, [2,3,4]) end)

    # 28 divide people into groups
    def group(people, groups) do
        groups=map(all_permutations(people), fn(e)-> groupify(e, groups) end)
        remove_duplicates(groups, &list_of_lists_equals/2)
    end

    defp groupify(people, groups), do: groupify(people, groups, [])
    defp groupify([], [], result), do: reverse(result)
    defp groupify(people, [head|tail], result) do
        {group, others}=split(people, head)
        groupify(others, tail, [sort(group)|result])
    end

    defp all_permutations(list), do: all_permutations([], list)
    defp all_permutations(object, []), do: [object]
    defp all_permutations(object, list), do: conmap(list, fn(e)-> all_permutations([e|object], List.delete(list, e)) end)

    # 29 sort list of lists according to their length
    def lsort(list), do: sort(list, fn(a, b)-> length(a)<length(b) end)

    # 30 sort list of lists according to their length frequency
    def lfsort(list), do:  sort(list, fn(a, b)-> length_frequency(list, length(a))<length_frequency(list, length(b)) end)

    defp length_frequency(list, e), do: length_frequency(list, e, 0)
    defp length_frequency([], _, result), do: result
    defp length_frequency([head|tail], e, result) when length(head)==e, do: length_frequency(tail, e, result+1)
    defp length_frequency([_|tail], e, result), do: length_frequency(tail, e, result)

    # 31 determine whether number is prime
    def is_prime(number) when number<=1, do: false
    def is_prime(number), do: number==last(sieve_of_eratosthenes(number))

    defp sieve_of_eratosthenes(number) when number<=1, do: []
    defp sieve_of_eratosthenes(number), do: sieve_of_eratosthenes(range(2, number+1), [])
    defp sieve_of_eratosthenes([], result), do: reverse(result)
    defp sieve_of_eratosthenes([head|tail], result),
        do: sieve_of_eratosthenes(filter(tail, fn(e)-> rem(e, head)!=0 end), [head|result])

    # 32 get greatest common divisor of integers a and b
    def gcd(a, 0), do: a
    def gcd(a, b), do: gcd(b, rem(a, b))

    # 33 determine whether numbers a and b are coprimes
    def coprimes(a, b), do: gcd(a, b)==1

    # 34 implement Euler's totient function
    def totient_phi(1), do: 1
    def totient_phi(number) when number>1, do: totient_phi(range(0, number), number, 0)
    defp totient_phi([], _, result), do: result
    defp totient_phi([head|tail], number, result) do
        if coprimes(head, number) do
            totient_phi(tail, number, result+1)
        else
            totient_phi(tail, number, result)
        end
    end

    # 35 get prime factors of number
    def prime_factors(1), do: [1]
    def prime_factors(number) when number>1,
      do: prime_factors(sieve_of_eratosthenes(number), number, [])
    defp prime_factors([], _, result), do: reverse(result)
    defp prime_factors([head|tail], number, result) do
        if rem(number, head)==0 do
            prime_factors([head|tail], div(number, head), [head|result])
        else
            prime_factors(tail, number, result)
        end
    end

    # 36 get prime factors of number and their multiplicity
    def prime_factors_mult(1), do: [{1, 1}]
    def prime_factors_mult(number) when number>1,
      do: prime_factors_mult(sieve_of_eratosthenes(number), number, 0, [])
    defp prime_factors_mult([], _, 0, result), do: reverse(result)
    defp prime_factors_mult([head|tail], number, multiplicity, result) do
        cond do
            rem(number, head)==0 ->
                prime_factors_mult([head|tail], div(number, head), multiplicity+1, result)
            multiplicity==0 ->
                prime_factors_mult(tail, number, 0, result)
            true->
                prime_factors_mult(tail, number, 0, [{multiplicity, head}|result])
        end
    end

    # 37 same as 34
    def totient_phi2(1), do: 1
    def totient_phi2(number) when number>1,
      do: totient_phi2(prime_factors_mult(number), 1)
    defp totient_phi2([], result), do: result
    defp totient_phi2([{m, p}|tail], result), do: totient_phi2(tail, result*(p-1)*pow(p, (m-1)))

    # 38 compare 34 and 37
    # skipped

    # 39 get prime numbers greater or equal than a and lesser or equal than b
    def primes_range(a, b) when a<=b, do: filter(sieve_of_eratosthenes(b), fn(x)-> x>=a end)

    # 40 for even number get {a, b} where a and b are primes and a+b=number (goldbach conjecture)
    def goldbach(number) when rem(number, 2)==0 and number>2 do
        primes=sieve_of_eratosthenes(number)
        number_half=number/2
        left=filter primes, fn(x)-> x<=number_half end
        right=filter primes, fn(x)-> x>=number_half end
        goldbach left, 0, right, length(right)-1, number
    end
    defp goldbach(left, a, right, -1, number), do: goldbach(left, a+1, right, length(right)-1, number)
    defp goldbach(left, a, right, b, number) do
        if kth(left, a)+kth(right, b)==number do
            {kth(left, a), kth(right, b)}
        else
            goldbach left, a, right, b-1, number
        end
    end

    # 41 get goldbach conjecture (see 40) for every even number greater or equal than a and lesser or equal than b
    def goldbach_range(a, b) when a<=b and a>2 do
        numbers=range_even(a, b)
        primes=sieve_of_eratosthenes(b)
        goldbach_range numbers, primes, []
    end
    defp goldbach_range([], _, result), do: reverse result
    defp goldbach_range([head|tail], primes, result) do
        head_half=head/2
        left=filter primes, fn(x)-> x<=head_half end
        right=filter primes, fn(e)->e>=head_half and e<head end
        head_result=goldbach left, 0, right, length(right)-1, head
        goldbach_range tail, primes, [head_result|result]
    end

    defp range_even(a, b) when a<=b, do: range_even(a+rem(a, 2), b-rem(b, 2), [])
    defp range_even(b, b, result), do: reverse([b|result])
    defp range_even(a, b, result), do: range_even(a+2, b, [a|result])

    # 46 get truth table to given function func
    def truth_table(func) do
        [{true, true, func.(true, true)},
        {true, false, func.(true, false)},
        {false, true, func.(false, true)},
        {false, false, func.(false, false)}]
    end

    # 47, 48
    # skipped

    # 49 get n-ary Gray code - list of binary numbers (n bits long), where two succesive values differ in one bit
    def gray(1), do: ["0", "1"]
    def gray(n) when n>1 do
        left=gray n-1
        right=reverse left
        map(left, fn(x)-> "0"<>x end)++map(right, fn(x)-> "1"<>x end)
    end

    # 50 skipped

    # 53 is tree
    def is_tree(nil), do: true
    def is_tree({_, left, right}), do: is_tree(left) and is_tree(right)
    def is_tree(_), do: false

    #tail-call recursive
    def is_tree2(tree), do: is_tree22 [tree]
    defp is_tree22([]), do: true
    defp is_tree22([nil|tail]), do: is_tree22 tail
    defp is_tree22([{_, left, right}|tail]), do: is_tree22 [left, right|tail]
    defp is_tree22(_), do: false

    # 54 height of tree
    def tree_height(nil), do: 0
    def tree_height({_data, nil, nil}), do: 0
    def tree_height({_data, left, right}), do: max(tree_height(left), tree_height(right))+1

    # 55 construct all completely balanced trees with n nodes
    def cbal_trees(0), do: [nil]
    def cbal_trees(1), do: [{:x, nil, nil}]
    def cbal_trees(n) when n>1 do
        if is_even(n-1) do
            trees=cbal_trees(div(n-1,2))
            construct_trees(trees, trees)
        else
            trees0=cbal_trees(div(n-1,2))
            trees1=cbal_trees(div(n-1,2)+1)
            construct_trees(trees0, trees1)++construct_trees(trees1, trees0)
        end
    end

    # constructs all trees with left subtree from left_subtrees and right subtree from right_subtrees
    defp construct_trees(left_subtrees, right_subtrees),
        do: conmap(left_subtrees, fn(left)-> map(right_subtrees, fn(x)-> {:x, left, x}end) end)

    # 56 determine whether tree is symetric
    def is_symetric(nil), do: true
    def is_symetric({_, left, right}), do: mirror(left, right)
    defp mirror(nil, nil), do: true
    defp mirror({_, left1, right1}, {_, left2, right2}), do: mirror(left1, right2) and mirror(right1, left2)
    defp mirror(_, _), do: false

    #tail-call recursive
    def is_symetric2(nil), do: true
    def is_symetric2({_, left, right}), do: mirror2([left], [right])
    defp mirror2([], []), do: true
    defp mirror2([nil|left_tail], [nil|right_tail]), do: mirror2(left_tail, right_tail)
    defp mirror2([{_, left1, left2}|left_tail],[{_, right1, right2}|right_tail]),
        do: mirror2([left1, left2|left_tail], [right2, right1|right_tail])
    defp mirror2(_, _), do: false

    # 57 construct binary search tree from list
    def construct_bin_search([]), do: nil
    def construct_bin_search([head|tail]), do: construct_bin_search(tail, {head, nil, nil})
    defp construct_bin_search([], tree), do: tree
    defp construct_bin_search([head|tail], tree), do: construct_bin_search(tail, add_node_to_tree(tree, head))

    defp add_node_to_tree(nil, node), do: {node, nil, nil}
    defp add_node_to_tree({n, left, right}, node) when node<=n, do: {n, add_node_to_tree(left, node), right}
    defp add_node_to_tree({n, left, right}, node), do: {n, left, add_node_to_tree(right, node)}

    # 58 generate all symetric completely balanced trees with n nodes
    def sym_cbal_trees(n), do: filter(cbal_trees(n), fn(x)->is_symetric(x)end)

    # 59 generate all height balanced trees with heiht h
    def hbal_trees(h), do: filter(height_trees(h), fn(x)->is_height_balanced(x)end)

    # determines whether tree is height balanced
    defp is_height_balanced(nil), do: true
    defp is_height_balanced(tree) do
        try do
            balance(tree)
            true
        catch
            :isnt_balanced->false
        end
    end

    # returns height of tree if tree is balanced otherwise throws :isnt_balanced
    defp balance(nil), do: 0
    defp balance({_, left, right}) do
        left_balance=balance(left)
        right_balance=balance(right)
        if abs(left_balance-right_balance)>1 do
            throw :isnt_balanced
        else
            max(right_balance, left_balance)+1
        end
    end

    # returns all trees with height n
    defp height_trees(n) do
        {result, _}=height_trees_helper(n)
        result
    end
    defp height_trees_helper(0), do: {[{:x, nil, nil}], [nil]}
    defp height_trees_helper(n) when n>0 do
        {subtrees_e, subtrees_l}=height_trees_helper(n-1)
        {construct_trees(subtrees_e, subtrees_l)++construct_trees(subtrees_l, subtrees_e)++construct_trees(subtrees_e, subtrees_e), subtrees_l++construct_trees(subtrees_l, subtrees_l)}
    end

    # 60 generate all height balanced trees with n nodes
    def hbal_trees_nodes(0), do: [nil]
    def hbal_trees_nodes(n) do
        min=min_height(n)
        max=max_height(n)
        filter(conmap(range(min, max+1), fn(h)-> hbal_trees(h) end), fn(e)->number_of_nodes(e)==n end)
    end

    # return number of nodes in tree
    defp number_of_nodes(nil), do: 0
    defp number_of_nodes({_, left, right}), do: number_of_nodes(left)+number_of_nodes(right)+1

    # returns minimum number of nodes needed to construct hight balanced tree with height h
    defp min_nodes(0), do: 1
    defp min_nodes(1), do: 2
    defp min_nodes(h) when h>1, do: min_nodes(h-1)+min_nodes(h-2)+1

    # returns maximum height of height balanced tree with n nodes
    defp max_height(n), do: max_height(n, 0)
    defp max_height(1, _), do: 0
    defp max_height(n, h) do
        nodes=min_nodes(h)
        cond do
            nodes>n->h-1
            nodes==n->h
            nodes<n->max_height(n, h+1)
        end
    end

    # returns maximum number of nodes needed to construct hight balanced tree with height h
    defp max_nodes(h), do: pow(2, h+1)-1

    # return minimum height of height balanced tree with n nodes
    defp min_height(n), do: min_height(n, 0)
    defp min_height(n, h) do
        nodes=max_nodes(h)
        if nodes<n do
            min_height(n, h+1)
        else
            h
        end
    end

    # 61 compute number of leaves
    def number_of_leaves(nil), do: 0
    def number_of_leaves({_, nil, nil}), do: 1
    def number_of_leaves({_, left, right}), do: number_of_leaves(left)+number_of_leaves(right)

    #tail-call recursive
    def number_of_leaves2(tree), do: number_of_leaves2([tree], 0)
    defp number_of_leaves2([], result), do: result
    defp number_of_leaves2([nil|tail], result), do: number_of_leaves2(tail, result)
    defp number_of_leaves2([{_, nil, nil}|tail], result), do: number_of_leaves2(tail, result+1)
    defp number_of_leaves2([{_, left, right}|tail], result), do: number_of_leaves2([left,right|tail], result)

    # 62 collect all leaves
    def leaves(nil), do: []
    def leaves({data, nil, nil}), do: [data]
    def leaves({_, left, right}), do: leaves(left)++leaves(right)

    # tail-call recursive
    def leaves2(tree), do: reverse(leaves2([tree], []))
    defp leaves2([], result), do: result
    defp leaves2([nil|tail], result), do: leaves2(tail, result)
    defp leaves2([{data, nil, nil}|tail], result), do: leaves2(tail, [data|result])
    defp leaves2([{_, left, right}|tail], result), do: leaves2([left,right|tail], result)

    # 63 collect all internal nodes
    def internals(nil), do: []
    def internals({_data, nil, nil}), do: []
    def internals({data, left, right}), do: [data|internals(left)++internals(right)]

    # tail-call recursive
    def internals2(tree), do: reverse(internals2([tree], []))
    defp internals2([], result), do: result
    defp internals2([nil|tail], result), do: internals2(tail, result)
    defp internals2([{_data, nil, nil}|tail], result), do: internals2(tail, result)
    defp internals2([{data, left, right}|tail], result), do: internals2([left, right|tail], [data|result])

    # 64 collect all nodes at level
    def at_level(nil, _n), do: []
    def at_level({data, _, _}, 0), do: [data]
    def at_level({_data, left, right}, n) when n>0, do: at_level(left, n-1)++at_level(right, n-1)

    # tail-call recursive
    def at_level2(tree, n), do: reverse(at_level22([{tree, n}], []))
    defp at_level22([], result), do: result
    defp at_level22([{nil, _n}|tail], result), do: at_level22(tail, result)
    defp at_level22([{{data, _, _}, 0}|tail], result), do: at_level22(tail, [data|result])
    defp at_level22([{{_data, left, right}, n}|tail], result), do: at_level22([{left, n-1}, {right, n-1}|tail], result)

    # 65 construct complete binary tree with n nodes
    def complete_tree(0), do: nil
    def complete_tree(n) do
        {left, right}=split_number_of_nodes(n-1)
        {:x, complete_tree(left), complete_tree(right)}
    end

    # returns number of nodes of left and right subtree of complete tree
    # n is sum of numbers of nodes in these subtrees
    defp split_number_of_nodes(n), do: split_number_of_nodes(n, 0, {0, 0})
    defp split_number_of_nodes(n, i, {a, b})do
        c=pow(2, i)
        cond do
            2*c<n->
                split_number_of_nodes(n-2*c, i+1, {a+c, b+c})
            c<n->
                {a+c, b+(n-c)}
            true->
                {a+n, b}
        end
    end

    # 66 add layout to binary tree
    # x coordinate is number of node in inorder traversal
    # y coordinate is distance from root
    # tree: {:a, {:b, nil, nil}, {:c, {:d, nil, nil}, nil}}
    # return: {:a, {1, 0}, {:b, {0, 1}, nil, nil}, {:c, {3, 1}, {:d, {2, 2}, nil, nil}, nil}}
    # picture:
    #   0 1 2 3
    # 0   a
    #    /  \
    # 1 b     c
    #        /
    # 2     d
    def layout(tree) do
        {tree, _x}=layout(tree, 0, 0)
        tree
    end
    defp layout(nil, x, _y), do: {nil, x}
    defp layout({data, left, right}, x, y)do
        {left, x}=layout(left, x, y+1);
        this_x=x
        x=x+1
        {right, x}=layout(right, x, y+1)
        {{data, {this_x, y}, left, right}, x}
    end

    # 67 add layout to binary tree
    # picture:
    #   0 1 2 3 4 5 6
    # 0       a
    #       /   \
    # 1   b       c
    #            /
    # 2         d
    def layout2(tree) do
        w=tree_width(tree_height(tree))
        layout2(tree, 0, w, 0)
    end
    defp layout2(nil, _x_offfset, _x, _y), do: nil
    defp layout2({data, left, right}, x_offset, x, y) do
        this_x=div(x, 2)
        left=layout2(left, x_offset, this_x, y+1)
        right=layout2(right, x_offset+this_x+1, this_x, y+1)
        {data, {x_offset+this_x, y}, left, right}
    end

    defp tree_width(height), do: tree_width(height, 1)
    defp tree_width(0, n), do: n
    defp tree_width(h, n), do: tree_width(h-1, n+pow(2, h))

    # 74 generate all binary trees with n nodes
    def all_trees(0), do: [nil]
    def all_trees(n) when n>0 do
        uconmap(all_trees(n-1), fn(x)->get_one_node_plus_trees(x)end)
    end

    # returns all trees created by adding one node to tree
    def get_one_node_plus_trees(tree),
        do: map(get_new_nodes_paths(tree), fn(path)-> apply_new_node_path_on_tree(tree, path) end)

    # add node to tree according to new node path
    def apply_new_node_path_on_tree(nil, []), do: {:x, nil, nil}
    def apply_new_node_path_on_tree({a, left, right}, [head|tail]) do
        if head == :l do
            {a, apply_new_node_path_on_tree(left, tail), right}
        else
            {a, left, apply_new_node_path_on_tree(right, tail)}
        end
    end

    # aplies function func on every element in list and returns concatenated returned values,
    # repeating values are eliminated
    def uconmap(list, func), do: uconmap(list, func, [])
    def uconmap([], _, result), do: result
    def uconmap([head|tail], func, result), do: uconmap(tail, func, unique_concatenation(result, func.(head)))

    # returns all new node paths - paths to potentional new nodes
    def get_new_nodes_paths(tree), do: get_new_nodes_paths(tree, [], [])
    def get_new_nodes_paths(nil, path, result), do: [reverse(path)|result]
    def get_new_nodes_paths({_, left, right}, path, result) do
        result2=get_new_nodes_paths left, [:l|path], result
        get_new_nodes_paths right, [:r|path], result2
    end

    # concatenates two lists and eliminates values that are in both lists
    def unique_concatenation(list1, []), do: list1
    def unique_concatenation(list1, [head|tail]), do: unique_concatenation(add_if_unique(list1, head), tail)

    # adds item into list if item isn't in this list
    def add_if_unique([], item), do: [item]
    def add_if_unique([head|tail], item) when head==item, do: [head|tail]
    def add_if_unique([head|tail], item), do: [head|add_if_unique(tail, item)]

end
