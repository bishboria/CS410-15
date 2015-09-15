module CS410-Prelude where

open import Agda.Primitive


----------------------------------------------------------------------------
-- Zero -- the empty type (logically, a false proposition)
----------------------------------------------------------------------------

data Zero : Set where

magic : forall {l}{A : Set l} -> Zero -> A
magic ()


----------------------------------------------------------------------------
-- One -- the type with one value (logically, a true proposition)
----------------------------------------------------------------------------

record One : Set where
  constructor <>
open One public


----------------------------------------------------------------------------
-- Two -- the type of Boolean values
----------------------------------------------------------------------------

data Two : Set where tt ff : Two

-- nondependent conditional with traditional syntax
if_then_else_ : {l : Level}{X : Set l} -> Two -> X -> X -> X
if tt then t else e = t
if ff then t else e = e

-- dependent conditional cooked for partial application
_<?>_ : forall {l}{P : Two -> Set l} -> P tt -> P ff -> (b : Two) -> P b
(t <?> f) tt = t
(t <?> f) ff = f


----------------------------------------------------------------------------
-- "Sigma" -- the type of dependent pairs, giving binary products and sums
----------------------------------------------------------------------------

record Sg {l : Level}(S : Set l)(T : S -> Set l) : Set l where
  constructor _,_
  field
    fst : S
    snd : T fst
open Sg public
_*_ : {l : Level} -> Set l -> Set l -> Set l
S * T = Sg S \ _ -> T
infixr 4 _,_ _*_

_+_ : Set -> Set -> Set
S + T = Sg Two (S <?> T)

pattern inl s = tt , s
pattern inr t = ff , t


----------------------------------------------------------------------------
-- "Equality" -- the type of evidence that things are the same
----------------------------------------------------------------------------

data _==_ {l}{X : Set l}(x : X) : X -> Set l where
  refl : x == x
infix 1 _==_
{-# BUILTIN EQUALITY _==_ #-}
{-# BUILTIN REFL refl #-}

