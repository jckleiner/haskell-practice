-- Source: http://learnyouahaskell.com/types-and-typeclasses

-- Haskell has a static type system. The type of every expression is known at compile time, which leads to safer code.
-- Unlike Java or Pascal, Haskell has type inference. If we write a number, we don't have to tell Haskell it's a number. It can infer that on its own.

-- you can you the :t command in GHCI to examine the type of an expression
-- :t 'c'           ->  'a'  :: Char 
-- :t True          ->  True :: Bool
-- :t "hi"          ->  "hi" :: String, synonymous with [Char]
-- :t (True, 'a')   ->  (True, 'a') :: (Bool, Char)
-- :t ('a','a','a') ->  ('a','a','a') :: (Char, Char, Char)
-- :t 4 == 5        ->  4 == 5 :: Bool

-- :t ('a',2)       ->  ('a',2) :: Num b => (Char, b) -- TODO
-- :t (2,'a')       ->  (2,'a') :: Num a => (a, Char) -- TODO

-- Explicit types are always denoted with the first letter in capital case.
-- Functions also have types. It is generally considered to be good practice to write out the function types explicitly, unless when writing very short functions


-- The parameters are separated with -> and there's no special distinction between the parameters and the return type. 
-- The return type is the last item in the declaration and the parameters are the first three.
-- Later on we'll see why they're all just separated with -> instead of having some more explicit distinction 
-- between the return types and the parameters like Int, Int, Int -> Int or something. 
addThreeInts :: Int -> Int -> Int -> Int
--             (1,      2      3) -> return type
addThreeInts    x       y       z  = x + y + z 

-- If you want to give your function a type declaration but are unsure as to what it should be, you can always just write the function without it and then check it with :t. Functions are expressions too, so :t works on them without a problem.

---------------- TYPES ----------------

-- Int      -- whole numbers, bounded, which means that it has a minimum and a maximum value. 
            -- Usually on 32-bit machines the maximum possible Int is 2147483647 and the minimum is -2147483648. 

-- Integer  -- The main difference to Int is that it's not bounded so it can be used to represent really really big numbers. 
            -- I mean like really big. Int, however, is more efficient.

-- Float    -- is a real floating point with single precision.

-- Double   -- is a real floating point with double the precision!

-- Bool     -- is a boolean type. It can have only two values: True and False.

-- Char     -- represents a character. It's denoted by single quotes. A list of characters is a string. 

-- Tuples are types but they are dependent on their length as well as the types of their components, so there is theoretically an infinite number of tuple types, which is too many to cover in this tutorial. Note that the empty tuple () is also a type which can only have a single value: ()


---------------- TYPE VARIABLES ----------------
-- What do you think is the type of the head function? Because head takes a list of any type and returns the first element, so what could it be? Let's check! 
-- :t head        head :: [a] -> a

-- a is not a type since it is not capital. It's actually a type variable. That means that a can be of any type. This is much like generics in other languages,
-- only in Haskell it's much more powerful because it allows us to easily write very general functions if they don't use any specific behavior of the types in them.

-- Functions that have type variables are called POLYMORPHIC FUNCTIONS.
-- The type declaration of head states that it takes a list of any type and returns one element of that type.

-- Although type variables can have names longer than one character, we usually give them names of a, b, c, d …

-- We see that fst takes a tuple which contains two types and returns an element which is of the same type as the pair's first component.
-- That's why we can use fst on a pair that contains any two types. 
--      fst :: (a, b) -> a

-- Note that just because a and b are different type variables, they DON'T HAVE TO BE different types. They could also be the same type.


---------------- TYPECLASSES ----------------

-- A typeclass is a sort of interface that defines some behavior. If a type is a part of a typeclass, that means that it supports and implements the behavior the typeclass describes.
-- A lot of people coming from OOP get confused by typeclasses because they think they are like classes in object oriented languages.
-- Well, they're NOT. You can think of them kind of as Java interfaces, only better. 

-- What's the type signature of the == function?
--      :t (==)      (==) :: (Eq a) => a -> a -> Bool

-- [NOTE]: the equality operator, == is a function. So are +, *, -, / and pretty much all operators. If a function is comprised only of special characters, it's considered an infix function by default. If we want to examine its type, pass it to another function or call it as a prefix function, we have to surround it in parentheses.

-- Interesting. We see a new thing here, the => symbol. Everything before the => symbol is called a CLASS CONSTRAINT.
-- We can read the previous type declaration like this: the equality function takes any two values that are of the same type and returns a Bool. 
-- The type of those two values must be a member of the Eq class (this was the class constraint).

-- The Eq typeclass provides an interface for testing for equality. Any type where it makes sense to test for equality between two values of that type should be a member of the Eq class. All standard Haskell types except for IO (the type for dealing with input and output) and functions are a part of the Eq typeclass.

-- The elem function has a type of (Eq a) => a -> [a] -> Bool because it uses == over a list to check whether some value we're looking for is in it.


------- Some basic typeclasses:

-- Eq    -- is used for types that support equality testing. The functions its members implement are == and /=. So if there's an Eq class constraint for a type
         -- variable in a function, it uses == or /= somewhere inside its definition. All the types we mentioned previously except for functions are part of Eq, 
         -- so they can be tested for equality.

-- Ord   -- is for types that have an ordering.
         -- All the types we covered so far except for functions are part of Ord. Ord covers all the standard comparing functions such as >, <, >= and <=.
         -- The compare function takes two Ord members of the same type and returns an ordering. Ordering is a type that can be GT, LT or EQ, meaning greater than, lesser than and equal, respectively. 
         -- :t (>)     (>) :: (Ord a) => a -> a -> Bool

-- Show  -- Members of Show can be presented as strings. All types covered so far except for functions are a part of Show. 
         -- The most used function that deals with the Show typeclass is 'show'. It takes a value whose type is a member of Show and presents it to us as a string.
s1 = show (1,2)    --  "(1,2)"

-- Read  -- is sort of the opposite typeclass of Show. The read function takes a string and returns a type which is a member of Read. 
t1 = read "True" || False       -- True  
t2 = read "8.2" + 3.8           -- 12.0
t3 = read "5" - 2               -- 3  
t4 = read "[1,2,3,4]" ++ [3]    -- [1,2,3,4,3]  

         -- But what happens if we try to do just read "4"? What GHCI is telling us here is that it doesn't know what we want in return. Notice that in the previous uses of read we did something with the result afterwards. That way, GHCI could infer what kind of result we wanted out of our read. If we used it as a boolean, it knew it had to return a Bool. But now, it knows we want some type that is part of the Read class, it just doesn't know which one. Let's take a look at the type signature of read.
         -- :t read     read :: (Read a) => String -> a
         -- See? It returns a type that's part of Read but if we don't try to use it in some way later, it has no way of knowing which type. That's why we can use explicit type annotations. Type annotations are a way of explicitly saying what the type of an expression should be. We do that by adding :: at the end of the expression and then specifying a type. 
t5 = read "5" :: Int                -- 5
t6 = read "5" :: Float              -- 5.0
t7 = read "[1,2,3,4]" :: [Int]      -- [1,2,3,4]
t8 = read "[1,2,3,4]" :: [Float]    -- [1.0,2.0,3.0,4.0]
t9 = read "(3, 'a')" :: (Int, Char) -- (3,'a')

-- Enum  -- Enum members are sequentially ordered types — they can be enumerated. 
         -- The main advantage of the Enum typeclass is that we can use its types in LIST RANGES. They also have defined successors and predecesors, 
         -- which you can get with the succ and pred functions.
         -- Types in this class: (), Bool, Char, Ordering, Int, Integer, Float and Double.
e1 = [LT .. GT]     -- [LT,EQ,GT]
e2 = succ False     -- True
e3 = succ 'B'       -- 'B'
e4 = succ 10.12345  -- 11.12345

-- Bounded  -- Bounded members have an upper and a lower bound.
b1 = minBound :: Int    -- -9223372036854775808     (64 bits / 8 bytes in this case?)
b1 = maxBound :: Char   -- '\1114111'

-- Num      -- Num is a numeric typeclass. Its members have the property of being able to act like numbers. Let's examine the type of a number.
            -- :t 20        20 :: Num p => p
            -- It appears that whole numbers are also polymorphic constants. They can act like any type that's a member of the Num typeclass.
            -- 20 :: Int            20  
            -- 20 :: Integer        20  
            -- 20 :: Float          20.0  
            -- 20 :: Double         20.0  
            -- Those are types that are in the Num typeclass. 
            
            -- If we examine the type of *, we'll see that it accepts ALL NUMBERS.
            -- :t (*)           (*) :: Num a => a -> a -> a
            -- It takes two numbers of the ** SAME TYPE ** and returns a number of that type. That's why (5 :: Int) * (6 :: Integer) will result in a type error 
            -- whereas 5 * (6 :: Integer) will work just fine and produce an Integer because 5 can act like an Integer or an Int. 

            -- To join Num, a type must already be friends with Show and Eq.

-- Integral  -- Integral is also a numeric typeclass. Num includes all numbers, including real numbers and integral numbers, 
             -- Integral includes only integral (whole) numbers. In this typeclass are Int and Integer.

-- Floating  -- Floating includes only floating point numbers, so Float and Double.
             -- A very useful function for dealing with numbers is fromIntegral. 
             -- It has a type declaration of fromIntegral :: (Num b, Integral a) => a -> b. 
             -- From its type signature we see that it takes an integral number and turns it into a more general number. That's useful when you want integral and floating point types to work together nicely. 
             -- For instance, the length function has a type declaration of length :: [a] -> Int instead of having a more general type of (Num b) => length :: [a] -> b. I think that's there for historical reasons or something, although in my opinion, it's pretty stupid. Anyway, if we try to get a length of a list and then add it to 3.2, we'll get an error because we tried to add together an Int and a floating point number. So to get around this, we do fromIntegral (length [1,2,3,4]) + 3.2 and it all works out.
f1 = length [1,2,3,4] + 3.2                         -- error, because length :: [a] -> Int and when we do Int + Float, it does not like it.
f2 = fromIntegral (length [1,2,3,4]) + 3.2          -- 7.2

            -- Notice that fromIntegral has several class constraints in its type signature. That's completely valid and as you can see, the class constraints are separated by commas inside the parentheses.
            -- :t fromIntegral          fromIntegral :: (Integral a, Num b) => a -> b