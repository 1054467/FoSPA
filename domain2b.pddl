(define (domain question2b)
  (:requirements :typing :action-costs :equality :conditional-effects :negative-preconditions :disjunctive-preconditions)
  (:types
    unit obj
  )
  (:constants bin cupboard - unit
  )
  (:predicates
    (Oven ?u - unit)
    (Fridge ?u - unit)
    (Sink ?u - unit)
    (Supplies ?s - obj)
    (Expired ?s - obj)
    (Tray ?t - obj)
    (UnitClean ?u - unit)
    (IsEmpty ?u - unit)
    (In ?o - object ?l - unit)
    (Dirty ?o)
  )
  (:action cleanFridge
      :parameters (?u - unit)
      :precondition (and (not (UnitClean ?u))
                         (Fridge ?u))
      :effect (and (UnitClean ?u)
                   (forall (?s - obj)
                           (when (and (Supplies ?s)
                                      (Expired ?s)
                                      (In ?s ?u))
                                  (and (not (In ?s ?u))
                                       (In ?s bin)
                                       (not (IsEmpty bin))))))
  )
  (:action cleanOven
      :parameters (?u1 ?u2 - unit)
      :precondition (and (not (UnitClean ?u1))
                         (IsEmpty ?u2)
                         (Oven ?u1)
                         (Sink ?u2))
      :effect (and (UnitClean ?u1)
                   (forall (?t - obj)
                           (when (and (Tray ?t)
                                      (Dirty ?t)
                                      (In ?t ?u1))
                                 (and (not (In ?t ?u1))
                                      (In ?t ?u2)
                                      (not (IsEmpty ?u2))
                                      (not (UnitClean ?u2))))))
  )
  (:action cleanSink
      :parameters (?u - unit)
      :precondition (and (not (UnitClean ?u))
                         (IsEmpty ?u)
                         (Sink ?u))
      :effect (and (UnitClean ?u))
  )
  (:action washTrays
      :parameters (?u - unit)
      :precondition (and (exists (?t - obj) (and (Tray ?t)
                                                 (In ?t ?u)))
                         (Sink ?u))
      :effect (and (when (not (exists (?p - obj)
                                      (and (Supplies ?p)
                                           (In ?p ?u))))
                         (IsEmpty ?u))
                   (forall (?t - obj) 
                            (when (and (Tray ?t)
                                       (In ?t ?u))
                                  (and (not (In ?t ?u))
                                       (In ?t cupboard)
                                       (not (Dirty ?t))))))
  )
  (:action emptyBin
      :parameters ()
      :precondition (not (IsEmpty bin))
      :effect (and (IsEmpty bin)
                   (forall (?s - obj)
                           (when (In ?s bin)
                                 (not (In ?s bin)))))
  )  
)
