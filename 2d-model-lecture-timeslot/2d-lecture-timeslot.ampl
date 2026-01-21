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

# Every set LT must be not empty
check {t in T}: card(LT[t]) > 0;

# The union of all LT set must be equal to set of lectures L.
# However, the following check with equality sign (=)
#     check: L = union {t in T} LT[t];
# leads to syntax error: L  >>> =  <<< union {t in T} LT[t];
# Therefore, I used [within] keyword to define L must we the subset.
check: L within (union {t in T} LT[t]);

# Every lecture must be assigned the the execty one teacher.
# Therefore, the two different LT sets must not intersect.
check {t1 in T, t2 in T: t1 != t2}: card(LT[t1] inter LT[t2]) = 0;


