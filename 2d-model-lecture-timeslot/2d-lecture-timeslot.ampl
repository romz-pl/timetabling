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


# The set names of grups of lectures.
set G;
check: card(G) > 0;


# The set of days.
set D ordered;
check: card(D) > 0;


# The set of courses.
set C;
check: card(C) > 0;


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
check: L within (union {r in R} LR[r]);
#
# Every lecture must be assigned the the execty one room.
# Therefore, the two different LR sets must not intersect.
check {r1 in R, r2 in R: r1 != r2}: card(LR[r1] inter LR[r2]) = 0;
# ===== LR END =====



# ===== LG BEGIN =====
# The set of lectures belonging to group $g \in G$.
set LG{G} within L;
#
# Every set LG must be not empty
check {g in G}: card(LG[g]) > 0;
#
# The union of all LG sets must be equal to set of lectures L.
check: L within (union {g in G} LG[g]);
#
# Every lecture must be assigned the the execty one group.
# Therefore, the two different LG sets must not intersect.
check {g1 in G, g2 in G: g1 != g2}: card(LG[g1] inter LG[g2]) = 0;
# ===== LG END =====



# ===== SD BEGIN =====
# The set of timeslots belonging to day $d \in D$.
set SD{D} ordered, within S;
#
# Every set SD must be not empty
check {d in D}: card(SD[d]) > 0;
#
# The union of all SD sets must be equal to set of timeslots S.
check: S within (union {d in D} SD[d]);
#
# Every lecture must be assigned the the execty one group.
# Therefore, the two different LG sets must not intersect.
check {d1 in D, d2 in D: d1 != d2}: card(SD[d1] inter SD[d2]) = 0;
# ===== SD END =====



# ===== LC BEGIN =====
# The set of lectures belonging to course $c \in C$.
set LC{C} within L;
#
# Every set LC must be not empty
check {c in C}: card(LC[c]) > 0;
#
# The union of all LC sets must be equal to set of lectures L.
check: L within (union {c in C} LC[c]);
#
# Every lecture must be assigned the the execty one course.
# Therefore, the two different LC sets must not intersect.
check {c1 in C, c2 in C: c1 != c2}: card(LC[c1] inter LC[c2]) = 0;
# ===== SC END =====


# Availability matrix for lectures
param AL{L, S} binary, default 1;


# Availability matrix for teachers
param AT{T, S} binary, default 1;


# Availability matrix for rooms
param AR{R, S} binary, default 1;


# Availability matrix for groups
param AG{G, S} binary, default 1;


# Availability matrix for courses
param AC{C, D} integer, default 1, >=0;


# Matrix of fixed lectures
param FL{L, S} binary, default 0;


# Weight matrix for Groups
param WG{G, S} >= 0;


# Weight matrix for Teachers
# param WT{T, S} >= 0;


# Weight matrix for Rooms
# param WR{R, S} >= 0;


# Matrix X
# The value $X[l][s] = 1$ means the lecture $l \in L$ takes place during the designated time slot $s \in S$.
var X{L, S} binary;


# Weighted sum of Group timetable
var FG;


# Weighted sum of Teachers timetable
# var FR;


# Weighted sum of Room timetable
# var FR;


# Value of FG
subject to fg_value:
    FG = sum{g in G, s in S} WG[g, s] * (sum{l in LG[g]} X[l, s]);


# Value of FT
# subject to fy_value:
#    FT = sum{t in T, s in S} WT[t, s] * (sum{l in LT[t]} X[l, s]);


# Value of FR
# subject to fz_value:
#    FR = sum{r in R, s in S} WR[r, s] * (sum{l in LR[r]} X[l, s]); 


# The lecture must be conducted
subject to lecture_must {l in L}:
    sum{s in S} X[l, s] = 1;


# Enforce when lectures are unavailable
subject to available_lecture {l in L, s in S}:
    AL[l, s] = 0 ==> X[l, s] = 0;


# Matrix of fixed lectures
subject to fixed_lectures {l in L, s in S}:
    FL[l, s] = 1 ==> X[l, s] = 1;


# Only one teacher conducts the lecture
subject to one_teacher {t in T, s in S}:
    sum{l in LT[t]} X[l, s] <= AT[t, s];


# Only one lecture is allowed in the room
subject to one_room {r in R, s in S}:
    sum{l in LR[r]} X[l, s] <= AR[r, s];


# Only one lecture is allowed to belong to the group
subject to one_group {g in G, s in S}:
    sum{l in LG[g]} X[l, s] <= AG[g, s];


# Limit the number of lectures in the course per day
subject to lectures_day {c in C, d in D}:
    sum{l in LC[c], s in SD[d]} X[l, s] <= AC[c, d];


#
# The objective function is the linear function of matrices X, Y, Z
#
minimize objective_function:
    FG;
#     FG + FT + FR;

