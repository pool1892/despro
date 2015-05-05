
module Main where
import Prelude

{-
wert1 :: Int -> Either ([Int],Bool) Bool
wert1 n | n==0 =  Right False
        | otherwise =  Left ([1..n], True)

wert2 :: Integer->Integer -> Either ([Integer],Bool) Bool
wert2 n m | n `mod` m ==0 = Right False
          | otherwise =Left ( n:m:(n `mod` m ):[] , True)


factor :: Int -> [Int]
factor  n = [x | x<- [1..n], n `mod` x==0]

wert3 :: Int-> Either ([Int],Bool) Bool
wert3 n | factor n == [1,n] = Right True
        | otherwise = Left (factor n, False)


wert4 :: Int-> (Maybe Bool, Either (Maybe Bool, Int) (Int, Maybe Int))
wert4 n | n==0      = (Nothing, Left (Nothing, 0))
        | n==1      = (Just False, Right (1, Just(1)))
        | otherwise = (Just True , Right (n, Just n))

wert5 :: Int -> Maybe (Either (Int,Maybe Int) (Maybe Bool, Int))
wert5 n | n ==0     = Nothing
        | otherwise = Just(Left(n, Just (n*n)))

wert6 :: Int -> Maybe (Either (Int,Maybe Int) (Maybe Bool, Int))
wert6 n = Nothing
-}

wert1 :: Either ([Int],Bool) Bool
wert1 = Right True

wert2 :: Either ([Int],Bool) Bool
wert2 = Left ([1,2],False)

wert3 :: Either ([Int],Bool) Bool
wert3 = Right False

wert4 :: (Maybe Bool, Either (Maybe Bool, Int) (Int, Maybe Int))
wert4 = (Nothing, Left (Nothing, 1))

wert5 :: Maybe (Either (Int,Maybe Int) (Maybe Bool, Int))
wert5 = Nothing

wert6 :: Maybe (Either (Int,Maybe Int) (Maybe Bool, Int))
wert6 = Just (Right (Just True, 15))