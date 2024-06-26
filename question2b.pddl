(define (problem question2b)
  (:domain question2b)
  (:objects 
    Fridge1 Oven1 Sink1 - unit
    Item1 Item2 Item3 Tray1 Tray2 - obj
  )
  (:init
    (Fridge Fridge1)
    (Oven Oven1)
    (Sink Sink1)
    (Supplies Item1)
    (Supplies Item2)
    (Supplies Item3)
    (Expired Item1)
    (Expired Item2)
    (In Item1 Fridge1)
    (In Item2 Fridge1)
    (In Item3 Fridge1)
    (Tray Tray1)
    (Tray Tray2)
    (Dirty Tray1)
    (Dirty Tray2)
    (In Tray1 Oven1)
    (In Tray2 Oven1)
    (UnitClean Sink1)
    (IsEmpty Sink1)
    (IsEmpty Bin)
  )
  (:goal
    (and
      (forall (?u - unit)
              (or (= ?u cupboard)
                  (and (= ?u bin) (IsEmpty ?u))
                  (UnitClean ?u))
      )
    )
  )
)

; Planning.domains gave the following plan to solve the goal
; (cleanfridge fridge1)
; (emptybin )
; (cleanoven oven1 sink1)
; (washtrays sink1)
; (cleansink sink1)