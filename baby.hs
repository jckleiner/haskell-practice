-- Source: http://learnyouahaskell.com/starting-out

-- brew install haskell-stack
-- stack ghci (to open the REPL)
-- :l baby (to load this file into ghci, then the functions defined here will be available to use)

doubleMe x = x + x

doubleUs x y = doubleMe x + doubleMe y

-- else is mandatory
-- if else blocks are expressions
doubleSmallNumber x = if x > 100  
                        then x  
                        else x*2 

-- paranthesis are important here. Without them the +1 goes to the else branch
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1  

-- Note the ' at the end of the function name. That apostrophe doesn't have any special meaning in Haskell's syntax. 
-- It's a valid character to use in a function name. 
-- We usually use ' to either denote a strict version of a function (one that isn't lazy) or a slightly modified version of a function or a variable.

-- 1. Functions CAN'T begin with uppercase letters
-- 2. Note that THIS IS A FUNCTION, not a variable. This function doesn't take any parameters. When a function doesn't take any parameters, we usually say it's a definition (or a name). Because we can't change what names (and functions) mean once we've defined them, conanO'Brien and the string "It's a-me, Conan O'Brien!" can be used interchangeably. 
conanO'Brien = "It's a-me, Conan O'Brien!"


-------- LISTS --------
lostNumbers = [4,8,15,16,23,42]  

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

-- List<T> ++ List<T> -> List<T>
-- Char : [Char] -> [Char]

-- [1,2,3] is actually just syntactic sugar for 1:2:3:[]. [] is an empty list. 
-- If we prepend 3 to it, it becomes [3]. If we prepend 2 to that, it becomes [2,3], and so on.
notEmptyList = 1:2:3:[]     -- [1,2,3]

-- Note: [], [[]] and[[],[],[]] are all different things. The first one is an empty list, the seconds one is a list that contains one empty list, the third one is a list that contains three empty lists.
emptyList = []
listContainingAnEmptyList = [[]]
listContaining3EmptyLists = [[],[],[]]

-- get elemen out of a list by index, use !!
myChar = "Steve Buscemi" !! 6       -- 'B'
first = [10, 20, 30] !! 0           -- 10
second = [10, 20, 30] !! 1          -- 20
outOfBounds = [10, 20, 30] !! 4     -- During runtime: "*** Exception: Prelude.!!: index too large"

-- lists can be compared if the stuff they contain can be compared. 
-- When using <, <=, > and >= to compare lists, they are compared in lexicographical order.
-- First the heads are compared. If they are equal then the second elements are compared, etc.
--      [3,2,1] >  [2,1,0]       True
--      [3,2,1] >  [2,10,100]    True  
--      [3,4,2] >  [3,4]         True  
--      [3,4,2] >  [2,4]         True  
--      [3,4,2] == [3,4,2]       True 

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

-- take -> extract the first N elements of the list
takeTwo  = take 2 [10,20,30,40]  -- [10,20]
takeZero = take 0 [10,20,30,40]  -- []

-- drop -> drop the first N elements, get the rest of the list
dropTwo  = drop 2 [10,20,30,40]   -- [30,40]
dropAlot = drop 44 [10,20,30,40]  -- []

-- minimum  [10,20,30] -> 10
-- maximum  [10,20,30] -> 30
-- sum      [10,20,30] -> 60
-- product  [10,20,30] -> 6000

-- 4 `elem` [1,2,3,4]  -> True
-- 4 `elem` [1,2,3]    -> False

-- ------------- Ranges -------------
-- [1..20]      -> [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20]  
-- ['a'..'z']   -> "abcdefghijklmnopqrstuvwxyz" 
-- ['K'..'Z']   -> "KLMNOPQRSTUVWXYZ"

-- You can specify a step, and only one step
-- [2,4..20]    -> [2,4,6,8,10,12,14,16,18,20]  
-- [3,6..20]    -> [3,6,9,12,15,18]   

-- This WON'T work: [1,2,4,8,16..100]
-- This WON'T work: [20..1], 
-- you have to do [20,19..1]

-- Watch out when using floating point numbers in ranges! Because they are not completely precise (by definition), their use in ranges can yield some pretty funky results.
-- [0.1, 0.3 .. 1]  -> [0.1,0.3,0.5,0.7,0.8999999999999999,1.0999999999999999]