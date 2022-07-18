-- Source: http://learnyouahaskell.com/syntax-in-functions

---------------- PATTERN MATCHING ----------------

-- Pattern matching consists of specifying patterns to which some data should conform and then checking to see if it does and deconstructing the data according to those patterns.

-- When defining functions, you can define SEPARATE FUNCTION BODIES FOR DIFFERENT PATTERNS. This leads to really neat code that's simple and readable. You can pattern match on any data type — numbers, characters, lists, tuples, etc. Let's make a really trivial function that checks if the number we supplied to it is a seven or not.

lucky :: (Integral a) => a -> String  
lucky 7 = "LUCKY NUMBER SEVEN!"  
lucky x = "Sorry, you're out of luck, pal!"

-- When you call lucky, the patterns will be checked from TOP to BOTTOM and when it conforms to a pattern, the corresponding function body will be used. The only way a number can conform to the first pattern here is if it is 7. If it's not, it falls through to the second pattern, which matches anything and binds it to x. This function could have also been implemented by using an if statement. But what if we wanted a function that says the numbers from 1 to 5 and says "Not between 1 and 5" for any other number? Without pattern matching, we'd have to make a pretty convoluted if-else tree. However, with it:

sayMe :: (Integral a) => a -> String  
sayMe 1 = "One!"  
sayMe 2 = "Two!"  
sayMe 3 = "Three!"  
sayMe 4 = "Four!"  
sayMe 5 = "Five!"  
sayMe x = "Not between 1 and 5" 

-- NOTE: if we moved the last pattern (the catch-all one) to the top, it would always say "Not between 1 and 5", because it would CATCH ALL the numbers and they wouldn't have a chance to fall through and be checked for any other patterns.

-- NOTE: You can only define the second implementation/pattern of the method right after the first one. New lines in between are allowed but if you put a different statement in between the compiler will tell you Multiple declarations of 'lucky'

-- Remember the factorial function we implemented previously? We defined the factorial of a number n as product [1..n]. We can also define a factorial function recursively, the way it is usually defined in mathematics. We start by saying that the factorial of 0 is 1. Then we state that the factorial of any positive integer is that integer multiplied by the factorial of its predecessor. Here's how that looks like translated in Haskell terms.
factorial :: (Integral a) => a -> a  
factorial 0 = 1  
factorial n = n * factorial (n - 1)

-- Pattern matching can also fail. If we define a function like this: 
charName :: Char -> String  
charName 'a' = "Albert"  
charName 'b' = "Broseph"  
charName 'c' = "Cecil"
-- charName 'd'         "*** Error ... Non-exhaustive patterns in function charName"

-- When making patterns, we should ALWAYS include a CATCH-ALL PATTERN so that our program doesn't crash if we get some unexpected input. 

-- Pattern matching can also be used on tuples. 
addVectors :: (Num a) => (a, a) -> (a, a) -> (a, a)  
addVectors a b = (fst a + fst b, snd a + snd b)

-- Well, that works, but there's a better way to do it. Let's modify the function so that it uses pattern matching.
addVectorsBetter :: (Num a) => (a, a) -> (a, a) -> (a, a)  
addVectorsBetter (x1, y1) (x2, y2) = (x1 + x2, y1 + y2) 

-- fst and snd extract the components of pairs. But what about triples? Well, there are no provided functions that do that but we can make our own.
first :: (a, b, c) -> a
first (x, _, _) = x

second :: (a, b, c) -> b
second (_, y, _) = y

third :: (a, b, c) -> c  
third (_, _, z) = z 

-- the _ means that we really don't care what kind of argument it is and we won't use it

-- You can also pattern match in list comprehensions. Should a pattern match fail, it will just move on to the next element. 
-- TODO did no understand?
lc = [a+b | (a,b) <- [(1,3), (4,3), (2,4), (5,3), (5,6), (3,1)]]    -- [4,7,6,8,11,4] 

-- ___COOL___ Lists themselves can also be used in pattern matching. You can match with the empty list [] or any pattern that involves : and the empty list. But since [1,2,3] is just syntactic sugar for 1:2:3:[], you can also use the former pattern. A pattern like x:xs will bind the head of the list to x and the rest of it to xs, even if there's only one element so xs ends up being an empty list. 

-- Note: The x:xs pattern is used a lot, especially with recursive functions. But patterns that have : in them only match against lists of length 1 or more.

-- If you want to bind, say, the first three elements to variables and the rest of the list to another variable, you can use something like x:y:z:zs. It will only match against lists that have three elements or more.

-- Now that we know how to pattern match against list, let's make our own implementation of the head function.
head' :: [a] -> a  
head' [] = error "Can't call head on an empty list, dummy!"     -- notice, we used the error function. It causes the program to CRASH
head' (x:_) = x

-- Nice! Notice that if you want to bind to several variables (even if one of them is just _ and doesn't actually bind at all), we have to surround them in parentheses. Also notice the error function that we used. It takes a string and generates a runtime error, using that string as information about what kind of error occurred. It causes the program to crash, so it's not good to use it too much. But calling head on an empty list doesn't make sense. 

-- Let's make a trivial function that tells us some of the first elements of the list in (in)convenient English form.
tell :: (Show a) => [a] -> String
tell [] = "The list is empty"
tell (x:[]) = "The list has one element: " ++ show x
tell (x:y:[]) = "The list has two elements: " ++ show x ++ " and " ++ show y
tell (x:y:rest) = "The list is long. The first two elements are: " ++ show x ++ " and " ++ show y ++ " and the rest: " ++ show rest
-- tell [1, 2, 3, 4, 5]     --- "The list is long. The first two elements are: 1 and 2 and the rest: [3,4,5]"

-- This function is safe because it takes care of the empty list, a singleton list, a list with two elements and a list with more than two elements. Note that (x:[]) and (x:y:[]) could be rewriten as [x] and [x,y] (because its syntatic sugar, we don't need the parentheses). We can't rewrite (x:y:_) with square brackets because it matches any list of length 2 or more.

-- We already implemented our own length function using list comprehension. Now we'll do it by using pattern matching and a little recursion:
length' :: (Num b) => [a] -> b  
length' [] = 0  
length' (_:xs) = 1 + length' xs 

-- Let's see what happens if we call length' on "ham". First, it will check if it's an empty list. Because it isn't, it falls through to the second pattern. It matches on the second pattern and there it says that the length is 1 + length' "am", because we broke it into a head and a tail and discarded the head. O-kay. The length' of "am" is, similarly, 1 + length' "m". So right now we have 1 + (1 + length' "m"). length' "m" is 1 + length' "" (could also be written as 1 + length' []). And we've defined length' [] to be 0. So in the end we have 1 + (1 + (1 + 0)).

sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- There's also a thing called AS PATTERNS. Those are a handy way of breaking something up according to a pattern and binding it to names whilst still keeping a reference to the whole thing. You do that by putting a name and an @ in front of a pattern. For instance, the pattern xs@(x:y:ys). This pattern will match exactly the same thing as x:y:ys but you can easily get the whole list via xs instead of repeating yourself by typing out x:y:ys in the function body again. Here's a quick and dirty example:

capital :: String -> String  
capital "" = "Empty string, whoops!"  
capital all@(x:xs) = "The first letter of " ++ all ++ " is " ++ [x] 
-- Normally we use as patterns to avoid repeating ourselves when matching against a bigger pattern when we have to use the whole thing again in the function body.

-- One more thing — you can't use ++ in pattern matches. If you tried to pattern match against (xs ++ ys), what would be in the first and what would be in the second list? It doesn't make much sense. It would make sense to match stuff against (xs ++ [x,y,z]) or just (xs ++ [x]), but because of the nature of lists, you can't do that.


---------------- GUARDS! ----------------

-- Whereas patterns are a way of making sure a value conforms to some form and deconstructing it, guards are a way of testing whether some property of a value (or several of them) are true or false. That sounds a lot like an if statement and it's very similar. The thing is that guards are a lot more readable when you have several conditions and they play really nicely with patterns.

-- We're going to make a simple function that berates you differently depending on your BMI (body mass index). Your BMI equals your weight divided by your height squared.

bmiTell :: (RealFloat a) => a -> String
bmiTell bmi
      | bmi <= 18.5 = "underweight"   -- if
      | bmi <= 25.0 = "normal"        -- else if
      | bmi <= 30.5 = "fat"           -- else if
      | otherwise = "..."             -- else

-- Guards are indicated by pipes that follow a function's name and its parameters. Usually, they're indented a bit to the right and lined up. A guard is basically a BOOLEAN EXPRESSION. If it evaluates to True, then the corresponding function body is used. If it evaluates to False, checking drops through to the next guard and so on.

-- Many times, the last guard is otherwise. otherwise is defined simply as otherwise = True and catches everything. This is very similar to patterns, only they check if the input satisfies a pattern but guards check for boolean conditions. If all the guards of a function evaluate to False (and we haven't provided an otherwise catch-all guard), evaluation falls through to the next pattern. That's how patterns and guards play nicely together. If no suitable guards or patterns are found, an error is thrown.

-- Note that there's no = right after the function name and its parameters, before the first guard. Many newbies get syntax errors because they sometimes put it there.

max' :: (Ord a) => a -> a -> a
max' a b
    | a > b = a
    | otherwise = b

-- Guards can also be written inline, although I'd advise against that because it's less readable, even for very short functions.

compare' :: (Ord a) => a -> a -> Ordering
a `compare'` b
    | a > b      = GT
    | a == b     = EQ
    | otherwise  = LT

-- 3 `compare'` 2       GT

-- Note: Not only can we call functions as infix with backticks, we can also define them using backticks. Sometimes it's easier to read that way.


---------------- WHERE!? ----------------

bmiTell' :: (RealFloat a) => a -> a -> String  
bmiTell' weight height  
    | weight / height ^ 2 <= 18.5 = "You're underweight, you emo, you!"  
    | weight / height ^ 2 <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | weight / height ^ 2 <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise                   = "You're a whale, congratulations!" 

-- Notice that we repeat ourselves here three times. We repeat ourselves three times. Since we repeat the same expression three times, it would be ideal if we could calculate it once, bind it to a name and then use that name instead of the expression. Well, we can modify our function like this:

bmiTell'' :: (RealFloat a) => a -> a -> String  
bmiTell'' weight height  
    | bmi <= 18.5 = "You're underweight, you emo, you!"
    | bmi <= 25.0 = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= 30.0 = "You're fat! Lose some weight, fatty!"  
    | otherwise   = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2

-- We put the keyword where after the guards (usually it's best to indent it as much as the pipes are indented) and then we define several names or functions. These names are visible across the guards and give us the advantage of not having to repeat ourselves. If we decide that we want to calculate BMI a bit differently, we only have to change it once. It also improves readability by giving names to things and can make our programs faster since stuff like our bmi variable here is calculated only once. We could go a bit overboard and present our function like this:

bmiTell''' :: (RealFloat a) => a -> a -> String  
bmiTell''' weight height  
    | bmi <= skinny = "You're underweight, you emo, you!"  
    | bmi <= normal = "You're supposedly normal. Pffft, I bet you're ugly!"  
    | bmi <= fat    = "You're fat! Lose some weight, fatty!"  
    | otherwise     = "You're a whale, congratulations!"  
    where bmi = weight / height ^ 2  
          skinny = 18.5  
          normal = 25.0  
          fat = 30.0

-- The names we define in the where section of a function are only visible to that function, so we don't have to worry about them polluting the namespace of other functions. Notice that all the names are aligned at a single column. If we don't align them nice and proper, Haskell gets confused because then it doesn't know they're all part of the same block.

-- `where` bindings CAN BE ACCESSED from anywhere in the same function declaration (under the same =)
-- `where` bindings ARE NOT SHARED across function bodies of different patterns. Meaning if you define the same name like: `myFunc ... =` multiple times. If you want several patterns of one function to access some shared name, you have to define it globally.

-- You can also use where bindings to PATTERN MATCH! We could have rewritten the where section of our previous function as:
--      ...
--      where bmi = weight / height ^ 2  
--          (skinny, normal, fat) = (18.5, 25.0, 30.0)  

-- Let's make another fairly trivial function where we get a first and a last name and give someone back their initials.
initials :: String -> String -> String  
initials firstname lastname = [f] ++ ". " ++ [l] ++ "."  
    where (f:_) = firstname  
          (l:_) = lastname

-- NOTE: we used where to pattern matched and did not use any guards. That's why we also have a = to define the function body

-- Just like we've defined constants in where blocks, you can also define functions. Staying true to our healthy programming theme, let's make a function that takes a list of weight-height pairs and returns a list of BMIs.
calcBmis :: (RealFloat a) => [(a, a)] -> [a]  
calcBmis xs = [bmi w h | (w, h) <- xs]
    where bmi weight height = weight / height ^ 2  

-- `where` bindings can also be nested. It's a common idiom to make a function and define some helper function in its where clause and then to give those functions helper functions as well, each with its own where clause.


---------------- LET IT BE ----------------

-- Very similar to where bindings are let bindings. Where bindings are a syntactic construct that let you bind to variables at the end of a function and the whole function can see them, including all the guards. Let bindings let you bind to variables anywhere and are expressions themselves, but are very local, so they don't span across guards. Just like any construct in Haskell that is used to bind values to names, let bindings can be used for pattern matching. Let's see them in action! This is how we could define a function that gives us a cylinder's surface area based on its height and radius: 

cylinder :: (RealFloat a) => a -> a -> a  
cylinder r h = 
    let sideArea = 2 * pi * r * h  
        topArea = pi * r ^2  
    in  sideArea + 2 * topArea 