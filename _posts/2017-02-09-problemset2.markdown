---
layout: post
title:  "Problem Set 2"
date:   2017-02-09 15:17:00 +0900
categories: jekyll update
---

[Coq file][1]

#### Basics.v

- You'll learn what `destruct` tactic is.

```
Exercise: 2 stars (andb_true_elim2)
Exercise: 1 star (zero_nbeq_plus_1)
```

#### Induction.v

- Please read carefully how they solve `plus_n_O` first, using `induction` tactic. It would largely help you solve these problems.

```
Exercise: 2 stars, recommended (basic_induction)
Exercise: 2 stars (double_plus)
Exercise: 2 stars, optional (evenb_S)
Exercise: 3 stars, recommended (mult_comm)
Exercise: 2 stars, optional (beq_nat_refl)
Exercise: 2 stars, optional (plus_swap')
```

```
(* Additional problem *)

Fixpoint sum (n:nat): nat :=
  match n with
  | O => O
  | S m => n + (sum m)
  end.

Require Import Lia.

Lemma sum_spec: forall n, 2 * (sum n) = n * (n + 1).
Proof.
  intros. induction n; simpl.
  - lia.
  - lia.
Qed.
```

#### Tactics.v
```
Exercise: 2 stars, optional (silly_ex)
Exercise: 1 star (inversion_ex3)
Exercise: 2 stars (beq_nat_true)
```

[1]:{{ site.url }}/download/Lecture2.v
