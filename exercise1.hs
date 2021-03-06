{-
ex1
-}
atLeastTrueIn n xs = length (filter (==True) xs) >= n
atMostTrueIn n xs = length (filter (==True) xs) <= n
moreTrueIn n xs = length (filter (==True) xs) > n
lessTrueIn n xs = length (filter (==True) xs) < n
notTrueIn n xs = length (filter (==True) xs) /= n
exactlyFalseIn n xs = length (filter (==False) xs) == n

exactlyGivenIn n b xs = length (filter (==b) xs) == n
{-
ex2
-}
There are many ways to solve these problems. The answers below detail a straightforward way. If you have something different which nevertheless gives the correct answer, then that is okay.

Exercise 1
filter even [1..10]
filter odd [1..50]

Exercise 2
The key thing to remember is that the list we pass is the domain of discourse, so we have to construct that properly.

forAllMapFilter isPrime [5..10] evaluates to False
thereExistsMapFilter isPrime [5..10] evaluates to True
forAllMapFilter odd (filter isPrime [1..10]) evaluates to False

Exercise 3
[x | x <- [30..50], odd x] 
[x | x <- [40..80], odd x, isPrime x]
(Remember that the comma stands for "and", so you can just keep giving more and more restrictions for x separated by commas)

Exercise 4
thereExistsListComprehension (=='e') "So no-one told you life was gonna be this way." evaulates to True
forAllListComprehension even [10,20..190] evaluates to True 
(Note the ambiguity of natural language: the question says "less than" which can either be interpreted as "less than or equal to" or "strictly less than".

Exercise 5
map (subtract 1) (filter even [1..50]) 
(ADVANCED ANSWER: filter (not.even) [1..50]. If you don't understand this notation, wait a few weeks)

Exercise 6
map (subtract 1) [x | x <- [1..50], even x]
OR
[x | x <- [1..50], not (even x)]. Technically, this doesn't use map, so you wouldn't have fully answered the question.

Exercise 7
head (filter isPrime [100..200])
(You could also, if you didn't know where the prime may be, use the notation [100..] which is the infinite list starting at 100. Since you are looking for the head of the list, that it uses an infinite input doesn't cause any problems.)

head [x | x <- [100..], isPrime x]

Exercise 8
last (filter isPrime [1..200])
last [x | x <- [1..200], isPrime x]

Exercise 9
map (*2) [5..10]
OR
[2*x | x <- [5..10]]

forAllMapFilter even (map (*2) [5..10]) or something like that.

Exercise 10
map (^2) [1..20]
[x*x | x <- [1..20]]
{-
ex3
-}
sumUpTo :: Int -> Int 
sumUpTo 0 = 0
sumUpTo n = n + sumUpTo (n-1)

fac :: Int -> Int
fac 0 = 1
fac n = n * fac (n-1)

myLength :: [a] -> Int
myLength [] = 0
myLength (x:xs) = 1 + myLength xs

mySum :: [Int] -> Int
mySum [] = 0
mySum (x:xs) = x + mySum xs

myProduct :: [Int] -> Int
myProduct [] = 1
myProduct (x:xs) = x * myProduct xs

flipSign :: [Int] -> [Int]
flipSign [] = []
flipSign (x:xs) = (0-x) : flipSign xs

addAtEnd :: a -> [a] -> [a]
addAtEnd x [] = [x]
addAtEnd x (y:ys) = y : addAtEnd x ys 

append :: [a] -> [a] -> [a]
append [] ys = ys
append (x:xs) ys = append xs (addAtEnd x ys)

myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = addAtEnd x (myReverse xs)

uniqueList :: (Eq a) => [a] -> [a]
uniqueList [] = []
uniqueList (x:xs)
        | elem x xs = uniqueList xs
        | otherwise = x : uniqueList xs

subset :: (Eq a) => [a] -> [a] -> Bool
subset [] ys = True 
subset (x:xs) ys
        | elem x ys = subset xs ys
        | otherwise = False

setEquality :: (Eq a) => [a] -> [a] -> Bool
setEquality xs ys = subset xs ys && subset ys xs

myIntersection' :: (Eq a) => [a] -> [a] -> [a]
myIntersection' [] ys = []
myIntersection' (x:xs) ys 
        | elem x ys = x : myIntersection' xs ys 
        | otherwise = myIntersection' xs ys

myIntersection :: (Eq a) => [a] -> [a] -> [a]
myIntersection xs ys = uniqueList (myIntersection' xs ys)

union :: (Eq a) => [a] -> [a] -> [a]
union xs ys = uniqueList (xs ++ ys)

intersection :: (Eq a) => [a] -> [a] -> [a]
intersection xs ys = [z | z <- xs, elem z ys]

{-
ex4
-}
{- Extra functions needed -}
subset :: (Eq a) => [a] -> [a] -> Bool
subset [] _ = True
subset (x:xs) ys 
        | elem x ys = subset xs ys
        | otherwise = False

setEqual2 :: (Eq a) => [a] -> [a] -> Bool
setEqual2 xs ys = subset xs ys && subset ys xs

duplicateFree :: (Eq a) => [a] -> [a]
duplicateFree [] = []
duplicateFree (x:xs)
        | elem x xs = duplicateFree xs
        | otherwise = x : duplicateFree xs 


elemAt :: Int -> [a] -> a
elemAt n [] = error "Not enough in list"
elemAt 1 (x:xs) = x
elemAt n (x:xs) = elemAt (n-1) xs

insertAt2 :: Int -> a -> [a] -> [a] -- possibly unsafe
insertAt2 1 x ys = x:ys
insertAt2 n x (y:ys) = y : insertAt2 (n-1) x ys

deleteAt :: Int -> [a] -> [a]
deleteAt _ [] = []
deleteAt 1 (x:xs) = xs
deleteAt n (x:xs) = x : deleteAt (n-1) xs

takeUpTo :: Int -> [a] -> [a]
takeUpTo _ [] = []
takeUpTo 1 (x:xs) = [x]
takeUpTo n (x:xs) = x : takeUpTo (n-1) xs

takeAfter :: Int -> [a] -> [a]
takeAfter _ [] = []
takeAfter 1 (x:xs) = xs
takeAfter n (x:xs) = takeAfter (n-1) xs

takeBetween :: Int -> Int -> [a] -> [a]
takeBetween n m xs = takeAfter (m-n-1) (takeUpTo m xs)

takeBetween2 :: Int -> Int -> [a] -> [a]
takeBetween2 _ _ [] = []
takeBetween2 1 m xs = takeUpTo m xs
takeBetween2 n m (x:xs) = takeBetween2 (n-1) (m-1) xs

takeBetween3 :: Int -> Int -> [a] -> [a]
takeBetween3 _ _ [] = []
takeBetween3 0 1 (x:xs) = [x]
takeBetween3 1 m (x:xs) = x : takeBetween3 0 (m-1) xs
takeBetween3 0 m (x:xs) = x : takeBetween3 0 (m-1) xs
takeBetween3 n m (x:xs) = takeBetween3 (n-1) (m-1) xs







allFst :: [(a,b)] -> [a]
allFst [] = []
allFst (x:xs) = fst x : allFst xs


allSnd :: [(a,b)] -> [b]
allSnd [] = []
allSnd (x:xs) = snd x : allSnd xs

allFstMap :: [(a,b)] -> [a]
allFstMap = map fst

allSndMap :: [(a,b)] -> [b]
allSndMap = map snd



allDifferent :: (Eq a) => [a] -> Bool
allDifferent [] = True
allDifferent (x:xs)
        | elem x xs = False 
        | otherwise = allDifferent xs



isFn :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
isFn fs xs ys = setEqual2 xs (allFst fs) && allDifferent (allFst (duplicateFree fs))  && subset (allSnd fs) ys 


mapTo :: (Eq a, Eq b) => [(a,b)] -> b -> [a]
mapTo [] y = []
mapTo (x:xs) y 
        | y == snd x = fst x : mapTo xs y 
        | otherwise = mapTo xs y

forAllMapFilter :: (a -> Bool) -> [a] -> Bool -- from week 2, used below. Any forAll would work.
forAllMapFilter f xs = length (filter (==True) (map f xs)) == length xs

isInjection :: (Eq a,Eq b) => [(a,b)] -> [a] -> [b] -> Bool
isInjection fs xs ys = forAllMapFilter (<=1) (map length (map duplicateFree (map (mapTo fs) ys)))

 
isSurjection :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
isSurjection fs xs ys = subset ys (allSnd fs) -- is the codomain a subset of the things mapped to?

 
isBijection :: (Eq a, Eq b) => [(a,b)] -> [a] -> [b] -> Bool
isBijection fs xs ys = isInjection fs xs ys && isSurjection fs xs ys

f0 = [(1,2),(2,3),(3,4),(4,3)]
x0 = [1..4]
y0 = [1..4]


f1 = [(1,'t'),(2,'h'),(3,'e'),(4,' '),(5,'w'),(6,'o'),(7,'r'),(8,'l'),(9,'d'),(10,' ')]
x1 = [1..10]
y1 = " abcdefghijklmnopqrstuvwxyz"

f2 = [('l','t'),('o','h'),('v','e'),('e','i'),('i','m'),('n','p'),('t','o'),('h','r'),('e','t'),('t','a'),('i','n'),('m','c'),('e','e'),('o','o'),('f','f'),('c','b'),('h','e'),('o','i'),('l','n'),('e','g'),('r','e'),('a','a')]
x2 = "vntimfcholera"
y2 = "abcdefghijklmnopqrstuvwxyz"

f3 = [(1,3),(3,7),(5,11),(7,15),(9,19),(11,23),(13,27),(15,31),(17,35),(19,39),(21,43),(23,47),(25,51),(27,55),(29,59),(31,63),(33,67),(35,71),(37,75),(39,79),(41,83),(43,87),(45,91),(47,95),(49,99)]
x3 = [1,3..50]
y3 = [3,7..100]

f4 = [(1,1),(2,2),(3,3),(4,4),(5,5),(6,6),(7,7),(8,8),(9,9),(10,10),(11,11),(12,1),(13,2),(1,3),(2,4),(3,5),(4,6),(5,7),(6,8),(7,9),(8,10),(9,11),(10,1),(11,2),(12,3),(13,4),(1,5),(2,6),(3,7),(4,8),(5,9),(6,10),(7,11),(8,1),(9,2),(10,3),(11,4),(12,5),(13,6),(1,7),(2,8),(3,9),(4,10),(5,11),(6,1),(7,2),(8,3),(9,4),(10,5),(11,6),(12,7),(13,8),(1,9),(2,10),(3,11),(4,1),(5,2),(6,3),(7,4),(8,5),(9,6),(10,7),(11,8),(12,9),(13,10),(1,11),(2,1),(3,2),(4,3),(5,4),(6,5),(7,6),(8,7),(9,8),(10,9),(11,10),(12,11),(13,1),(1,2),(2,3),(3,4),(4,5),(5,6),(6,7),(7,8),(8,9),(9,10),(10,11),(11,1),(12,2),(13,3),(1,4),(2,5),(3,6),(4,7),(5,8),(6,9),(7,10),(8,11),(9,1)]
x4 = [1..15]
y4 = [1..100]

f5 = [(1,1),(2,2),(3,3),(4,5),(5,8),(6,13),(7,21),(8,34),(9,55),(10,89),(11,144),(12,233),(13,377),(14,610),(15,987),(16,1597),(17,2584),(18,4181),(19,6765),(20,10946),(21,17711),(22,28657),(23,46368),(24,75025),(25,121393),(26,196418),(27,317811),(28,514229),(29,832040),(30,1346269)]
x5 = [1..30]
y5 = [1..1346270]

f6 = [(-10,101),(-9,82),(-8,65),(-7,50),(-6,37),(-5,26),(-4,17),(-3,10),(-2,5),(-1,2),(0,1),(1,2),(2,5),(3,10),(4,17),(5,26),(6,37),(7,50),(8,65),(9,82),(10,101)]
x6 = [-10..10]
y6 = [1..101]

f7 = [(0,0),(1,64),(2,61),(3,58),(4,55),(5,52),(6,49),(7,46),(8,43),(9,40),(10,37),(11,34),(12,31),(13,28),(14,25),(15,22),(16,19),(17,16),(18,13),(19,10),(20,7),(21,4),(22,1),(23,65),(24,62),(25,59),(26,56),(27,53),(28,50),(29,47),(30,44),(31,41),(32,38),(33,35),(34,32),(35,29),(36,26),(37,23),(38,20),(39,17),(40,14),(41,11),(42,8),(43,5),(44,2),(45,66),(46,63),(47,60),(48,57),(49,54),(50,51),(51,48),(52,45),(53,42),(54,39),(55,36),(56,33),(57,30),(58,27),(59,24),(60,21),(61,18),(62,15),(63,12),(64,9),(65,6),(66,3)]
x7 = [0..66]
y7 = [0..66]

f8 = [(100,10),(99,9),(98,9),(97,9),(96,9),(95,9),(94,9),(93,9),(92,9),(91,9),(90,9),(89,9),(88,9),(87,9),(86,9),(85,9),(84,9),(83,9),(82,9),(81,9),(80,8),(79,8),(78,8),(77,8),(76,8),(75,8),(74,8),(73,8),(72,8),(71,8),(70,8),(69,8),(68,8),(67,8),(66,8),(65,8),(64,8),(63,7),(62,7),(61,7),(60,7),(59,7),(58,7),(57,7),(56,7),(55,7),(54,7),(53,7),(52,7),(51,7),(50,7),(49,7),(48,6),(47,6),(46,6),(45,6),(44,6),(43,6),(42,6),(41,6),(40,6),(39,6),(38,6),(37,6),(36,6),(35,5),(34,5),(33,5),(32,5),(31,5),(30,5),(29,5),(28,5),(27,5),(26,5),(25,5),(24,4),(23,4),(22,4),(21,4),(20,4),(19,4),(18,4),(17,4),(16,4),(15,3),(14,3),(13,3),(12,3),(11,3),(10,3),(9,3),(8,2),(7,2),(6,2),(5,2),(4,2),(3,1),(2,1),(1,1)]
x8 = [1..100]
y8 = [1..10]

f9 = [(True, True), (False,False)]
x9 = [True,False]
y9 = [True, False]

f10 = [('1',-37),('2',-36),('3',-35),('4',-34),('5',-33),('6',-32),('7',-31),('8',-30),('9',-29),(':',-28),(';',-27),('<',-26),('=',-25),('>',-24),('?',-23),('@',-22),('A',-21),('B',-20),('C',-19),('D',-18),('E',-17),('F',-16),('G',-15),('H',-14),('I',-13),('J',-12),('K',-11),('L',-10),('M',-9),('N',-8),('O',-7),('P',-6),('Q',-5),('R',-4),('S',-3),('T',-2),('U',-1),('V',0),('W',1),('X',2),('Y',3),('Z',4),('[',5),('\\',6),(']',7),('^',8),('_',9),('`',10),('a',11),('b',12),('c',13),('d',14),('e',15),('f',16),('g',17),('h',18),('i',19),('j',20),('k',21),('l',22),('m',23),('n',24),('o',25),('p',26),('q',27),('r',28),('s',29),('t',30),('u',31),('v',32),('w',33),('x',34),('y',35),('z',36)]
x10 = ['1'..'z']
y10 = [-37..37]


{- Information about the functions:
f0: function, not injection, not surjection, (not bijection)
f1: function, not injection, not surjection, (not bijection)
f2: not function
f3: function, injection, surjection, bijection
f4: not function
f5: function, injection, not surjection, (not bijection)
f6: function, not injection, not surjection, (not bijection)
f7: function, injection, surjection, bijection
f8: function, not injection, surjection, (not bijection)
f9: function, injection, surjection, bijection
f10: function, injection, not surjeciton, (not bijection)
-}


{-
ex5
-}
{-
ex6
-}