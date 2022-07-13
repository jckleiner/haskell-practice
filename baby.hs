-- Source: http://learnyouahaskell.com/starting-out

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
-- 2. this function doesn't take any parameters. When a function doesn't take any parameters, we usually say it's a definition (or a name). Because we can't change what names (and functions) mean once we've defined them, conanO'Brien and the string "It's a-me, Conan O'Brien!" can be used interchangeably. 
conanO'Brien = "It's a-me, Conan O'Brien!"


-------- LISTS --------