#
# The AMPL implementation of 2D Lecture-Timeslot model.
#
# Author: Zbigniew Romanowski
#

# The set of lectures.
set L;
check: card(L) > 0;


# The set of timeslots.
set S ordered;
check: card(S) > 0;


# The set of teachers.
set T;
check: card(T) > 0;


# The set of rooms.
set R;
check: card(R) > 0;


# The set of lectures being taught by the teacher $t \in T$
set LT{T} within L;
check {t in T}: card(LT[t]) > 0;
check: ((union {t in T} LT[t]) within L) and (L within (union {t in T} LT[t]));
check {t1 in T, t2 in T: t1 != t2}: card(LT[t1] inter LT[t2]) = 0;

# check: L = union {t in T} LT[t]; This check lears to syntax error: L  >>> =  <<< union {t in T} LT[t];
