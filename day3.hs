import System.IO
import Data.Bifunctor

split :: String -> [String]
split [] = [""]
split ['\n'] = [""]
split (x:tl)
  | x == '\n' = "":rest
  | otherwise = (x : head rest) : tail rest
  where
    rest = split tl

add2 :: (Num a, Num b) => ((a, b), (a, b)) -> (a, b)
add2 ((a,b), (c,d)) = (a+c, b+d)

addA :: (Num a, Num b) => [Char] -> [(a, b)]
addA (x:tl)
  | x == '1'  = (1,0):rest
  | x == '0'  = (0,1):rest
  | otherwise = rest
  where
    rest = addA tl
addA [] = []

getCnt :: (Num a, Num b) => [[Char]] -> [(a, b)]
getCnt [x] = addA x
getCnt (hd:tl) = do
  let x = getCnt tl
  let y = addA hd
  let z = zip x y
  map add2 z
getCnt [] = []

invert :: [Char] -> [Char]
invert (x:tl)
  | x == '1'  = '0':rest
  | x == '0'  = '1':rest
  | otherwise = rest
  where rest = invert tl
invert [] = []

getc :: Ord a => (a, a) -> Char
getc (a,b)
  | a > b = '1'
  | otherwise = '0'

b2i :: Num p => Char -> p
b2i x
  | x == '1' = 1
  | x == '0' = 0
  | otherwise = -1

parse2 :: [Char] -> Int
parse2 = foldl (\acc x -> acc * 2 + b2i x) 0

part1 :: [[Char]] -> Int
part1 list = do
  let l = getCnt list
  let x = map getc l
  parse2 x * parse2 (invert x)

getCommon :: [(String, String)] -> Int
getCommon ((hd:_, _):tl) = b2i hd + getCommon tl
getCommon _ = 0

part2 :: [(String, String)] -> (Float -> Float -> Bool) -> Int
part2 [(_,x)] _ = parse2 x
part2 mc fun = do
  let x = fun (fromIntegral (getCommon mc)) (fromIntegral (length mc) / 2.0)
  part2 (map (first tail) (filter (\(a1, a2) -> (head a1 == '1') == x) mc)) fun

main :: IO ()
main = do
  contents <- readFile "input/day3"
  let lines = split contents
  let x = part1 lines
  print x
  let part2Input = map (\x -> (x,x)) lines
  let y1 = part2 part2Input (>=)
  let y2 = part2 part2Input (<)
  print (y1 * y2)