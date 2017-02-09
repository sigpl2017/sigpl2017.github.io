(*
Inductive bool : Type :=
| true : bool
| false : bool
.
*)

(*
 true -> 100
 false -> true
*)

Definition btype 
  (b: bool) : Type :=
  match b with
  | true => nat
  | false => bool
  end.

Check btype.

Compute (btype true).

Compute (btype false).

(*
Definition foo (b: bool) 
  : btype b 
:=
  match b with
  | true => 100
  | false => true
  end.
*)

(*
e1 : Type
e2 : Type
=========
forall (x:e1), e2 : Type
*)

(* foo: bool -> nat + bool *)

(* foo: forall (b: bool), btype b *)

(*   forall (n: nat), vector n *)

(*   nat -> list *)

Definition foo (b: bool) 
  : btype b
:=
  match b with
  | true => 100
  | false => true
  end.

Check foo.

Compute foo true.
Compute foo false.

Check foo.

Check btype.

Definition bar (b: bool) 
  : Type
:=
  match b with
  | true => nat
  | false => bool
  end.

(*
forall b : bool, btype b

forall b : bool, Type
*)









(*
   9 Feb 2017
 *)

(*
Inductive TrueT : Type :=
| TT : TrueT
.

Inductive FalseT: Type :=
.

Definition istrue (b: bool) : Type :=
  match b with
  | true => TrueT
  | false => FalseT
  end.

Compute istrue true .

Compute istrue false.



Check (TT: istrue true).

Definition true_is_true : istrue true 
:= TT.

(* Definition false_is_true : istrue false := ???. *)

Definition false_is_not_true : 
 istrue false -> FalseT 
:=
  fun x : istrue false =>
    match x with
    end : FalseT
.

(*
  P -> Q     P
  ------------
       Q


  e: P -> Q          e1 : P
 --------------------------
   e e1 : Q
*)




(*
Fixpoint evenb (n: nat) : bool :=
  match n with
  | 0 => true
  | S n' => match n' with
           | 0 => false
           | S n'' => evenb n''
           end
  end.
*)

Fixpoint evenb (n: nat) : bool :=
  match n with
  | 0 => true
  | 1 => false
  | S (S m) => evenb m
  end.

Definition two_plus_even_is_even :
  forall n:nat, istrue (evenb n) -> istrue (evenb (2 + n))
:=
  fun n:nat => fun pf: istrue (evenb n) => pf.







Definition even_plus_two_is_even :
  forall n:nat, istrue (evenb n) -> istrue (evenb (n+2)) 
  :=
  fix even_plus_two_is_even n :=
    match n return istrue (evenb n) -> istrue (evenb (n+2)) with
    | 0 => fun x => x  
    | 1 => fun x => x
    | S (S m) => fun x => even_plus_two_is_even m x
    end.




Inductive even: nat -> Type :=
| zero_is_even : even 0
| succ_succ_even (n: nat) (pf: even n) : even (S (S n))
.

Check even.

Check (even: nat -> Type).



(*
* zero_is_even : even 0

* succ_succ_even 0 zero_is_even : even (S (S 0))

* succ_succ_even (S(S 0)) (succ_succ_even 0 zero_is_even) : even (S (S (S (S 0)))
*)

(*
Definition even' (n: nat) : Type :=
  exists m, n = 2 * m.
*)

(*
  e : vector (1 + n)    e: vector (S(n))

    e : T  S===T
   -------------
       e : S
*)















Definition two_plus_even_is_even' :
  forall n:nat, even n -> even (2+n)
  :=
  fun n:nat => fun pf: even n => succ_succ_even n (pf).

Definition even_plus_two_is_even' :
  forall n:nat, even n -> even (n+2)
  :=
  fix even_plus_two_is_even n :=
    match n return even n -> even (n+2) with
    | 0 | 1 => fun x => succ_succ_even _ x
    | S (S m) => fun pf : even (S (S m)) => 
      succ_succ_even (m+2) (
      even_plus_two_is_even m
      match pf in even k 
        return match k with 0 | 1 => TrueT | S(S l) => even l end 
      with
      | zero_is_even => TT
      | succ_succ_even m pf => pf
      end)
    end.

(* Compute (even_plus_two_is_even' 0 zero_is_even). *)

Definition even_plus_two_is_even'': 
  forall n:nat, even n -> even (n+2).
Proof.
  fix 1.
  intros. destruct n.
  - simpl. apply succ_succ_even. 
    assumption.
  - destruct n.
    + apply succ_succ_even. 
      assumption.
    + inversion H. subst. simpl. 
      apply succ_succ_even.
      apply even_plus_two_is_even''. 
      assumption.
Defined.

Compute (even_plus_two_is_even'' 0 zero_is_even).









Definition induction_for_nat: 
forall P : nat -> Type,
  P 0 -> 
  (forall n : nat, P n -> P (S n)) -> 
forall n : nat, P n 
:=
  fun P => fun (base: P 0) => 
  fun (step: forall n : nat, P n -> P (S n)) =>
  fix ind n :=
    match n return P n with
    | 0 => base
    | S m => step m (ind m)
    end.








Inductive EqT (A: Type) : A -> A -> Type :=
| eqrefl (x: A) : EqT A x x
.

Check eqrefl.










Definition succ_is_not_0: 
  forall n: nat, EqT nat (S n) 0 -> FalseT
:=
  fun n => fun (pf: EqT nat (S n) 0) =>
    match pf in EqT _ x y 
             return match x with 
                    | 0   => match y with | 0 => TrueT | S _ => FalseT end
                    | S _ => match y with | 0 => FalseT | S _ => TrueT end
                    end
    with
    | eqrefl _ z => match z with
                    | 0 => TT
                    | S _ => TT
                    end
    end : FalseT.




Definition succ_is_not_0': 
  forall n: nat, EqT nat (S n) 0 -> FalseT.
Proof.
  intros. inversion H.
Defined.





(*
Inductive EqT (A: Type) (x: A) : A -> Type :=
| eqrefl : EqT A x x
.

Definition succ_is_not_0: 
  forall n: nat, EqT nat (S n) 0 -> FalseT
:=
  fun n => fun (pf: EqT nat (S n) 0) =>
    match pf in EqT _ _ y 
             return match y with 0 => FalseT | S _ => TrueT end with
    | eqrefl _ _ => TT
    end.

Definition succ_is_not_0': 
  forall n: nat, EqT nat (S n) 0 -> FalseT.
Proof.
intros. inversion H.
Defined.
*)


(*
  forall P: Prop (x y: P), x = y
*)

*)






(*
   9 Feb 2017 : Proposition
 *)

Definition istrue (b: bool) : Prop :=
  match b with
  | true => True
  | false => False
  end.

Compute istrue true .

Compute istrue false.



Check (I: istrue true).

Definition true_is_true : istrue true 
:= I.

(* Definition false_is_true : istrue false := ???. *)

Definition false_is_not_true : 
 istrue false -> False 
:=
  fun x : istrue false =>
    match x with
    end : False
.

(*
  P -> Q     P
  ------------
       Q


  e: P -> Q          e1 : P
 --------------------------
   e e1 : Q
*)




(*
Fixpoint evenb (n: nat) : bool :=
  match n with
  | 0 => true
  | S n' => match n' with
           | 0 => false
           | S n'' => evenb n''
           end
  end.
*)

Fixpoint evenb (n: nat) : bool :=
  match n with
  | 0 => true
  | 1 => false
  | S (S m) => evenb m
  end.

Definition two_plus_even_is_even :
  forall n:nat, istrue (evenb n) -> istrue (evenb (2 + n))
:=
  fun n:nat => fun pf: istrue (evenb n) => pf.







Definition even_plus_two_is_even :
  forall n:nat, istrue (evenb n) -> istrue (evenb (n+2)) 
  :=
  fix even_plus_two_is_even n :=
    match n return istrue (evenb n) -> istrue (evenb (n+2)) with
    | 0 => fun x => x  
    | 1 => fun x => x
    | S (S m) => fun x => even_plus_two_is_even m x
    end.




Inductive even: nat -> Prop :=
| zero_is_even : even 0
| succ_succ_even (n: nat) (pf: even n) : even (S (S n))
.

Check even.

Check (even: nat -> Type).



(*
* zero_is_even : even 0

* succ_succ_even 0 zero_is_even : even (S (S 0))

* succ_succ_even (S(S 0)) (succ_succ_even 0 zero_is_even) : even (S (S (S (S 0)))
*)

(*
Definition even' (n: nat) : Type :=
  exists m, n = 2 * m.
*)

(*
  e : vector (1 + n)    e: vector (S(n))

    e : T  S===T
   -------------
       e : S
*)















Definition two_plus_even_is_even' :
  forall n:nat, even n -> even (2+n)
  :=
  fun n:nat => fun pf: even n => succ_succ_even n (pf).

Definition even_plus_two_is_even' :
  forall n:nat, even n -> even (n+2)
  :=
  fix even_plus_two_is_even n :=
    match n return even n -> even (n+2) with
    | 0 | 1 => fun x => succ_succ_even _ x
    | S (S m) => fun pf : even (S (S m)) => 
      succ_succ_even (m+2) (
      even_plus_two_is_even m
      match pf in even k 
        return (match k with 0 | 1 => True | S(S l) => even l end) : Prop 
      with
      | zero_is_even => I
      | succ_succ_even m pf => pf
      end)
    end.

(* Compute (even_plus_two_is_even' 0 zero_is_even). *)

Definition even_plus_two_is_even'': 
  forall n:nat, even n -> even (n+2).
Proof.
  fix 1.
  intros. destruct n.
  - simpl. apply succ_succ_even. 
    assumption.
  - destruct n.
    + apply succ_succ_even. 
      assumption.
    + inversion H. subst. simpl. 
      apply succ_succ_even.
      apply even_plus_two_is_even''. 
      assumption.
Defined.

Compute (even_plus_two_is_even'' 0 zero_is_even).









Definition induction_for_nat: 
forall P : nat -> Prop,
  P 0 -> 
  (forall n : nat, P n -> P (S n)) -> 
forall n : nat, P n 
:=
  fun P => fun (base: P 0) => 
  fun (step: forall n : nat, P n -> P (S n)) =>
  fix ind n :=
    match n return P n with
    | 0 => base
    | S m => step m (ind m)
    end.






Print eq.

Check (eq 0 0).

(* Inductive EqT (A: Type) : A -> A -> Prop := *)
(* | eqrefl (x: A) : EqT A x x *)
(* . *)

(* Check eqrefl. *)







(*

Definition succ_is_not_0: 
  forall n: nat, S n = 0 -> False
:=
  fun n => fun (pf: S n = 0) =>
    match pf in x = y 
             return match x with 
                    | 0   => match y with | 0 => TrueT | S _ => FalseT end
                    | S _ => match y with | 0 => FalseT | S _ => TrueT end
                    end
    with
    | eqrefl _ z => match z with
                    | 0 => TT
                    | S _ => TT
                    end
    end : FalseT.




Definition succ_is_not_0': 
  forall n: nat, EqT nat (S n) 0 -> FalseT.
Proof.
  intros. inversion H.
Defined.

*)


(* Inductive EqT (A: Type) : A -> A -> Prop := *)
(* | eqrefl (x: A) : EqT A x x *)
(* . *)


(*
Inductive EqT (A: Type) (x: A) : A -> Prop :=
| eqrefl : EqT A x x
.
*)


Definition succ_is_not_0: 
  forall n: nat, S n = 0 -> False
:=
  fun n => fun (pf: S n = 0) =>
    match pf in _ = y 
             return match y with 0 => False | S _ => True end with
    | eq_refl _ => I
    end.

Print eq.
Definition succ_is_not_0': 
  forall n: nat, S n = 0 -> False.
Proof.
  intros. inversion H.
Defined.



(*
  forall P: Prop (x y: P), x = y
*)


