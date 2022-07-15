-- Source: http://learnyouahaskell.com/starting-out

-- `brew install haskell-stack` to install haskell-stack (which comes with ghc), you can also install the ghc directly
-- `stack ghci` (to open the REPL)
-- :l <file-name> (to load this file into ghci, then the functions defined here will be available to use)

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

-- else is mandatory
-- if else blocks are EXPRESSIONS
doubleSmallNumber x = if x > 100  
                        then x  
                        else x * 2 

-- paranthesis are important here. Without them the + 1 goes to the else branch
doubleSmallNumber' x = (if x > 100 then x else x * 2) + 1  

-- Note the ' at the end of the function name. That apostrophe doesn't have any special meaning in Haskell's syntax. 
-- It's a valid character to use in a function name. 
-- We usually use ' to either denote a strict version of a function (one that isn't lazy) or a slightly modified version of a function or a variable.

-- 1. Functions CAN'T begin with uppercase letters
-- 2. Note that THIS IS A FUNCTION, not a variable. This function doesn't take any parameters. When a function doesn't take any parameters, we usually say it's a definition (or a name). Because we can't change what names (and functions) mean once we've defined them, conanO'Brien and the string "It's a-me, Conan O'Brien!" can be used interchangeably. 
conanO'Brien = "It's a-me, Conan O'Brien!"


-------- LISTS --------
numbers = [4,8,15,16,23,42]  

-- Strings are just list of characters
-- "hello" is just syntactic sugar for ['h','e','l','l','o']
-- Because strings are lists, we can use list functions on them, which is really handy. 
hello = ['h','e','l','l','o']           -- "hello"

joinedList = [1,2,3,4] ++ [9,10,11,12]  -- [1,2,3,4,9,10,11,12]
joinedList2 = "hello" ++ " " ++ "world" -- "hello world"

-- Putting something at the beginning of a list using the : operator (also called the cons operator)
consList = 'a' : " small cat"           -- "a small cat"
consList2 = 2 : [1, 2, 3, 4, 5]         -- "[2,1,2,3,4,5]"

-- the ++ operator needs to iterate the left side, so its linear in time complexity
-- the : operator is instantaneous

-- [T] ++ [T] -> [T]
-- Char : [Char] -> [Char]

-- [1,2,3] is actually just syntactic sugar for 1:2:3:[]. [] is an empty list. 
-- If we prepend 3 to it, it becomes [3]. If we prepend 2 to that, it becomes [2,3], and so on.
notEmptyList = 1:2:3:[]     -- [1,2,3]
-- 1:2:3  error

-- Note: [], [[]] and [[],[],[]] are all different things. The first one is an empty list, the seconds one is a list that contains one empty list, the third one is a list that contains three empty lists.
emptyList = []
listContainingAnEmptyList = [[]]
listContaining3EmptyLists = [[],[],[]]

-- get an elemen out of a list by index, use !!
myChar = "Steve Buscemi" !! 6       -- 'B'
first = [10, 20, 30] !! 0           -- 10
second = [10, 20, 30] !! 1          -- 20
outOfBounds = [10, 20, 30] !! 4     -- During runtime: "*** Exception: Prelude.!!: index too large"

-- lists can be compared if the stuff they contain can be compared. 
-- When using <, <=, >, >=, ==, /= to compare lists, they are compared in lexicographical order.
-- First the heads are compared. If they are equal then the second elements are compared, etc.
--      [3,2,1] >  [2,1,0]       True
--      [3,2,1] >  [2,10,100]    True  
--      [3,4,2] >  [3,4]         True  
--      [3,4,2] >  [2,4]         True  
--      [3,4,2] == [3,4,2]       True 
--      [1,2]   < [1,2,3]        True
--      [1,2]   < [1,2,-3]       True


-- head -> returns the first element
headOfList = head [10, 20, 30]  -- 10

-- tail -> returns the rest of the list, without its head / first element
tailOfList = tail [10, 20, 30]  -- [20,30]

-- last -> returns the last element in the list
lastOfList = last [10, 20, 30]  -- 30

-- init -> returns the list except its last element
initOfList = init [10, 20, 30]  -- [10, 20]

-- When using head, tail, last and init, be careful NOT to use them on empty lists. This error CANNOT be caught at compile time so it's always good practice to take precautions against accidentally telling Haskell to give you some elements from an empty list. 

-- length
lengthOfList = length [10, 20, 30]  -- 3

-- null
isNotEmpty = null [1,2,3]   -- False
isEmpty    = null []        -- True

-- reverse
reversed = reverse [10,20,30]   -- [30,20,10]

-- take -> extract the first N elements of the list, as a list
takeTwo  = take 2 [10,20,30,40]  -- [10,20]
takeZero = take 0 [10,20,30,40]  -- []

-- drop -> drop the first N elements, get the rest of the list
dropTwo  = drop 2 [10,20,30,40]   -- [30,40]
dropAlot = drop 44 [10,20,30,40]  -- []

-- minimum  [10,20,30] -> 10
-- maximum  [10,20,30] -> 30
--          ["a","b"]  -> b

-- sum      [10,20,30] -> 60
--          ["a","b"]  -> error

-- product  [10,20,30] -> 6000
--          ["a","b"]  -> error

-- 4 `elem` [3,4]  -> True
-- 4 `elem` [3]    -> False

---------------- Ranges ----------------
-- We can use ranges to create lists of things which can be enumerated. Numbers, the alphabeth etc.
-- [1..20]          -> [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]  
-- ['a'..'z']       -> "abcdefghijklmnopqrstuvwxyz" 
-- ['K'..'Z']       -> "KLMNOPQRSTUVWXYZ"
-- [1..]            -> numbers from 1 to infinity
-- TODO ['a'..] ?

-- You can specify a step. Only one step is allowed
-- [2,4..20]    -> [2,4,6,8,10,12,14,16,18,20]  
-- [3,6..20]    -> [3,6,9,12,15,18] 
-- ['a','c'..'f']   -> "ace"

-- This WON'T work: [1,2,4,8,16..100] (only one step is allowed)
-- This WON'T work: [20..1], 
-- you have to do [20,19..1]
-- ['z','y'..'a']   -> "zyxwvutsrqponmlkjihgfedcba"

-- Watch out when using floating point numbers in ranges! (Just don't use floats in ranges)
-- Because they are not completely precise (by definition), their use in ranges can yield some pretty funky results.
-- [0.1, 0.3 .. 1]  -> [0.1,0.3,0.5,0.7,0.8999999999999999,1.0999999999999999]

-- Because Haskell is lazy, you can do something like this:
-- take 10 [0,5..]  -> [0,5,10,15,20,25,30,35,40,45]

-- Some functions which produce infinite lists:
-- cycle
-- cycle [1,2,3]            -> infinite [1,2,3,1,2,3,1,2,3,1,2,3...]
-- take 10 (cycle [1,2,3])  -> [1,2,3,1,2,3,1,2,3]

-- take 10 (repeat 5)       -> [5,5,5,5,5,5,5,5,5,5]

-- replicate 10 5           -> [5,5,5,5,5,5,5,5,5,5]


---------------- LIST COMPREHENSION ----------------

-- This is used in mathematics often to define a set of elements which have a certain criteria.
-- Set comprehension {x ∈ A | "statement about x"} denotes the subset of A whose elements satisfy "statement about x".
-- S = { 2.x | x ∈ N, x <= 5} 
--      The part before the pipe is called the output function, 
--      x is the variable, 
--      N is the input set 
--      and x <= 5 is the predicate.
-- In laymans terms, the right side says "get me all the elements which have these properties:" 
--      1. must be element of natural numbers 
--      2. and must be smaller or equal to 5
-- And then apply the function 2.x to all those elements and put the result in a set.
-- You apply 2.x to these elements {1, 2, 3, 4, 5} and you get: {2, 4, 6, 8, 10}

-- In Haskell we can use List Comprehensions to implement this
myset = [ x*2 | x <- [1..5]]                      -- [2,4,6,8,10]
myset2= [ x*2 | x <- [1..5], x*2 >= 6]            -- [6,8,10]
myset3= [ x   | x <- [50..100], x `mod` 5 == 0]   -- [50,55,60,65,70,75,80,85,90,95,100]

-- remember, the left side is an expression (output function)
oddOrEven      nums = [ if odd x then "ODD!" else "even!"           | x <- nums, x < 10]    -- ["ODD!","even!","ODD!","even!","ODD!"]
oddOrEvenTuple nums = [ if odd x then (x, "ODD!") else (x, "even!") | x <- nums, x < 10]    -- [(5,"ODD!"),(6,"even!"),(7,"ODD!"),(8,"even!"),(9,"ODD!")]

giveTuple x = if odd x then (x, "ODD!") else (x, "even!")   -- extracted it to a function
oddOrEvenTuple' nums  = [ giveTuple x | x <- nums, x < 10]                                   -- [(5,"ODD!"),(6,"even!"),(7,"ODD!"),(8,"even!"),(9,"ODD!")]
oddOrEvenTuple'' nums = [ giveTuple x | x <- nums, x < 10, x /= 5]                           -- [(6,"even!"),(7,"ODD!"),(8,"even!"),(9,"ODD!")]

-- Not only can we have multiple predicates in list comprehensions (an element must satisfy ALL the predicates to be included in the resulting list), 
-- we can also draw from several lists.
-- When drawing from several lists, comprehensions produce ALL COMBINATIONS of the given lists and then join them by the output function we supply.
-- Drawing from two lists of size 3 means 3x3 = 9, the resulting list will have 9 elements, if we don't filter them
allCombinations  = [(x,y) | x <- [1,2,3], y <- [5,5,5]]        -- [(1,5),(1,5),(1,5),(2,5),(2,5),(2,5),(3,5),(3,5),(3,5)]
allCombinations' = [(x,y) | x <- [1,2], y <- [5,5,5]]          -- [(1,5),(1,5),(1,5),(2,5),(2,5),(2,5)]

-- lets write our own leghth function:
-- xs -> this is a common naming pattern for lists. You can read the 's' as a suffix, so the name is essentially "plural of x" 
-- (in the book "Real World Haskell" http://book.realworldhaskell.org/read/types-and-functions.html)
length' xs = sum [1 | _ <- xs]

-- remember, strings are lists, we can use list comprehensions to process and produce strings. 
-- Here's a function that takes a string and removes everything except uppercase letters from it.
removeNonUppercase st = [ c | c <- st, c `elem` ['A'..'Z']]    -- "IdontLIKEFROGS" -> "ILIKEFROGS"

-- NESTED LIST COMPREHENSIONS are also possible if you're operating on lists that contain lists.
-- A list contains several lists of numbers. Let's remove all odd numbers without flattening the list.
-- (it's better to split longer list comprehensions across multiple lines, especially if they're nested)
removeOdds = [ [ x | x <- xs, even x ] | xs <- [[1,3,5,2],[1,2,3,4],[2,3,6]]]   -- [[2],[2,4],[2,6]]


---------------- TUPLES ----------------
-- In some ways, tuples are like lists — they are a way to store several values into a single value. However, there are a few fundamental differences.
-- A list of numbers is a list of numbers. That's its type and it doesn't matter if it has only one number in it or an infinite amount of numbers.
-- The tuples type depends on how many components it has and the types of the components.
-- A tuple can contain a combination of several types (unlike lists)

-- (1,2)    -> called a Pair
-- (1,2,3)  -> called a Triple
-- Both of these are called still a TUPLE! They just have more specific names depending on the number of elements inside them


-- For example:
--  (1,2)   is type      (Num, Num)
--  (1,2,3) is of type   (Num, Num, Num)
--  (1,'a') is of type   (Num, Char)
--  [(1,2), (2,3)]       [(Num, Num)], you cannot add (1,2,3) or (1,'a') to this list. It has to be a (Num, Num)

-- Use tuples when you know in advance how many components some piece of data should have.
-- Tuples are much more rigid because each different size of tuple is its own type, so you can't write a general function to append an element to a tuple — you'd have to write a function for appending to a pair, one function for appending to a triple, one function for appending to a 4-tuple, etc.

-- While there are singleton lists, there's no such thing as a singleton tuple. It doesn't really make much sense.

-- Like lists, tuples can be compared with each other if their components can be compared. Only you can't compare two tuples of different sizes, whereas you can compare two lists of different sizes. Two useful functions that operate on pairs:
first = fst (8,11)  -- 8
second = snd (8,11) -- 11
--  Note: these functions operate only on PAIRS. They WON'T work on triples, 4-tuples, 5-tuples, etc.

-- A cool function that produces a list of pairs: zip. It takes two lists and then zips them together into one list by joining the matching elements into pairs. It's a really simple function but it has loads of uses. It's especially useful for when you want to combine two lists in a way or traverse two lists simultaneously. 
zipped = zip [1,2,3,4] [5,5,5,5]                        -- [(1,5),(2,5),(3,5),(4,5)]
zipped'= zip [1 .. 4] ["one", "two", "three", "four"]   -- [(1,"one"),(2,"two"),(3,"three"),(4,"four")]
zipd  =  zip [1,2,3,4,5] [5,5]                          -- [(1,5),(2,5)]
zipd' =  zip [1..] ["apple", "orange", "cherry"]        -- [(1,"apple"),(2,"orange"),(3,"cherry")] because Haskell is LAZY

