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


# ===== LT BEGIN =====
# The set of lectures being taught by the teacher $t \in T$
set LT{T} within L;
#
# Every set LT must be not empty
check {t in T}: card(LT[t]) > 0;
#
# The union of all LT sets must be equal to set of lectures L.
# However, the following check with equality sign (=)
#     check: L = union {t in T} LT[t];
# leads to syntax error: L  >>> =  <<< union {t in T} LT[t];
# Therefore, I used [within] keyword to define L must we the subset.
check: L within (union {t in T} LT[t]);
#
# Every lecture must be assigned the the execty one teacher.
# Therefore, the two different LT sets must not intersect.
check {t1 in T, t2 in T: t1 != t2}: card(LT[t1] inter LT[t2]) = 0;
# ===== LT END =====



# ===== LR BEGIN =====
# The set of lectures taking place in the room $r \in R$.
set LR{R} within L;
#
# Every set LR must be not empty
check {r in R}: card(LR[r]) > 0;
#
# The union of all LR sets must be equal to set of lectures L.
# However, the following check with equality sign (=)
#     check: L = union {r in R} LR[r];
# leads to syntax error: L  >>> =  <<< union {r in R} LR[r];
# Therefore, I used [within] keyword to define L must we the subset.
check: L within (union {r in R} LR[r]);
#
# Every lecture must be assigned the the execty one room.
# Therefore, the two different LR sets must not intersect.
check {r1 in R, r2 in R: r1 != r2}: card(LR[r1] inter LR[r2]) = 0;
# ===== LR END =====


# Availability matrix for lectures
param AL{L, S} binary, default 1;


# Availability matrix for teachers
param AT{T, S} binary, default 1;


# Availability matrix for rooms
param AR{R, S} binary, default 1;

# Matrix WX
param WX{L, S} >= 0, default 0;


# Matrix WY
# param WY{T, S} >= 0, default 0;


# Matrix WZ
# param WZ{R, S} >= 0, default 0;


# Matrix X
# The value $X[l][s] = 1$ means the lecture $l \in L$ takes place during the designated time slot $s \in S$.
var X{L, S} binary;


# Weighted sum of X matrix
var FX;


# Weighted sum of Y matrix
# var FY;


# Weighted sum of Z matrix
# var FZ;


# FX value
subject to fx_value:
    FX = sum{l in L, s in S} WX[l, s] * X[l, s];


# FY value
# subject to fy_value:
#    FY = sum{t in T, s in S} WY[t, s] * (sum{l in LT[t]} X[l, s]);


# FZ value
# subject to fz_value:
#    FZ = sum{r in R, s in S} WZ[r, s] * (sum{l in LR[r]} X[l, s]); 


# The lesson must be conducted
subject to lesson_must {l in L}:
    sum{s in S} X[l, s] = 1;


# Only one teacher conducts the lesson
subject to one_teacher {t in T, s in S}:
    sum{l in LT[t]} X[l, s] <= AT[t, s];


# Only one lesson is allowed in the room
subject to one_room {r in R, s in S}:
    sum{l in LR[r]} X[l, s] <= AR[r, s];


#
# The objective function is the linear function of matrices X, Y, Z
#
minimize objective_function:
    FX;
#     FX + FY + FZ;

