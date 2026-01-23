# Model 2D: Lecture-Timeslot

## Input parameters

### Primary Sets
+ $L$ - the set of lectures.
+ $S$ - the set of timeslots.
+ $T$ - the set of teachers.
+ $R$ - the set of rooms.
+ $G$ - the set names of grups of lectures.
+ $D$ - the set of days.
+ $C$ - the set of courses;


### Sequence of sets LT
+ $\forall_{t \in T} \quad LT[t] \subseteq L$ - the set of lectures being taught by the teacher $t \in T$.
+ Any lecture can be taught by one teacher, hence: If $t_1, t_2 \in T$ and $t_1 \neq t_2$ then $LT[t_1] \cap LT[t_2] = \varnothing$
+ All lectures are taught, hence: $\cup_{t \in T} LT[t] = L$

### Sequence of sets LR
+ $\forall_{r \in R} \quad LR[r] \subseteq L$ - the set of lectures taking place in the room $r \in R$.
+ The lecture can take place in one room only, hence: If $r_1, r_2 \in R$ and $r_1 \neq r_2$ then $LR[r_1] \cap LR[r_2] = \varnothing$
+ Each lecture is assigned to a specific room, hence: $\cup_{r \in R} LR[r] = L$

### Sequence of sets LG
+ $\forall_{g \in G} \quad LG[g] \subseteq L$ - the set of lectures belonging to group $g \in G$.
+ The lecture can belong to one grup only, hence: If $g_1, g_2 \in G$ and $g_1 \neq g_2$ then $LG[g_1] \cap LG[g_2] = \varnothing$
+ Each lecture belongs to a specific group, hence: $\cup_{g \in G} LG[g] = L$

### Sequence of sets LC
+ $\forall_{c \in C} \quad LC[c] \subseteq L$ - the set of lectures belonging to course $c \in C$.
+ The lecture can belong to one course only, hence: If $c_1, c_2 \in C$ and $c_1 \neq c_2$ then $LC[c_1] \cap LC[c_2] = \varnothing$
+ Each lecture belongs to a specific course, hence: $\cup_{c \in C} LC[g] = L$

### Sequence of sets SD
+ $\forall_{d \in D} \quad SD[d] \subseteq S$ - the set of timeslots belonging to day $d \in D$.
+ The timeslot can belong to one day only, hence: If $d_1, d_2 \in D$ and $d_1 \neq d_2$ then $SD[d_1] \cap SD[d_2] = \varnothing$
+ Each timeslot belongs to a specific day, hence: $\cup_{d \in D} SD[d] = S$

### Availability matrix for lectures
+ $AL : L \times S \mapsto \{ 0, 1 \}$ - the availability matrix for lectures. See variable $X$.
+ In the availability matrix $AL[l][s]$ value $1$ means that the lecture $l \in L$ is available at timeslot $s \in S$.

### Availability matrix for teachers
+ $AT : T \times S \mapsto \{ 0, 1 \}$ - the availability matrix for teachers. See matrix $AT$.
+ In the availability matrix $AT[t][s]$ value $1$ means that the teacher $t \in T$ is available at slot $s \in S$.

### Availability matrix for rooms
+ $AR : R \times S \mapsto \{ 0, 1 \}$ - the availability matrix for rooms. See matrix $XR$.
+ In the availability matrix $AR[r][s]$ value $1$ means that the room $r \in R$ is available at slot $s \in S$.

### Availability matrix for groups
+ $AG : G \times S \mapsto \{ 0, 1 \}$ - the availability matrix for groups. See matrix $XG$.
+ In the availability matrix $AG[g][s]$ value $1$ means that the group $g \in G$ is available at slot $s \in S$.

### Availability matrix for courses
+ $AC : C \times D \mapsto \mathbb{N}^+$ - the availability matrix for courses. See matrix $XC$.
+ The value of the element of the matrix $AC[c][d]$ determines the maximum number of lectures from course $c \in C$ on day $d \in D$.

### Matrix of fixed lectures
+ $FL : L \times S \mapsto \{ 0, 1 \}$ - the matrix of fixed lectures.
+ The value of the element of the matrix $FL[l][s] =1$ means that the lecture $l \in L$ is fixed at timeslot $s \in S$ and it is excluded from the optimization process.


### Day function
Function $QD : S \mapsto \mathbb{N}$ returns the day corresponding to timeslot $s \in S$.
In the most general way, the value of the function $QD$ can be provided for each $s \in S$.

If $S$ is the set of consecutive natural numbers starting from zero and each day consists of the same number of time slots, then $QD[s] = \text{floor}(s / N_h)$, where $N_h$ is th enumber of hours per day.


### Timeslot numer in the day function
Function $QI : S \mapsto \mathbb{N}$ returns timeslot number in the day corresponding to timeslot $s \in S$.
In the most general way, the value of the function $SI$ can be provided for each $s \in S$.

If $S$ is the set of consecutive natural numbers starting from zero and each day consists of the same number of time slots, then $QI[s] = s \text{ mod } N_h$, where $N_h$ is th enumber of hours per day.


## Variables of the model

The variables of the model is the the binary matrix

$$
X : L \times S \mapsto \{ 0, 1 \}
$$

Therefore, the number of variables in the model is equal to the product of the cardinality sets: $|L| \cdot |S|$.
The value $X[l][s] = 1$ means the lecture $l \in L$ takes place during the designated time slot $s \in S$.
The value $X[l][s] = 0$ means the lecture $l \in L$ does not take place during the designated time slot $s \in S$.

## Auxiliary matrices

The matrices $XG$, $XT$, and $XR$ help grasp the idea behind the 2D Lecture-Timeslot model. Therefore, they deserve their own definitions and explanations.


### Relation between matrix X and matrix XG
The matrix $XG : G \times S$.
The value $XG[r][s] = 1$ means in group $g \in G$ the lesson is conducted during the designated time slot $s \in S$.
The value of the elements of matrix $XG$ is the sum of the selected columns representing lectures belonging to group $g \in G$ at time slot $s \in S$:

$$
\forall_{g \in G} \forall_{s \in S} \qquad
XG[g][s] = \sum_{l \in LG[r]} X[l][s]
$$


### Relation between matrix X and matrix XT
The matrix $XT : T \times S$.
The value $XT[t][s] = 1$ means the teacher $t \in T$ conducts the lesson during the designated time slot $s \in S$.
The value of the elements of matrix $XT$ is the sum of the selected columns representing the lectures being taught by teacher $t \in T$ at time slot $s \in S$:

$$
\forall_{t \in T} \forall_{s \in S} \qquad
XT[t][s] = \sum_{l \in LT[t]} X[l][s]
$$


### Relation between matrix X and matrix XR
The matrix $XR : R \times S$.
The value $XR[r][s] = 1$ means in the room $r \in R$ the lesson is conducted during the designated time slot $s \in S$.
The value of the elements of matrix $XR$ is the sum of the selected columns representing lectures in room $r \in R$ at time slot $s \in S$:

$$
\forall_{r \in R} \forall_{s \in S} \qquad
XR[r][s] = \sum_{l \in LR[r]} X[l][s]
$$


### Relation between matrix X and matrix XC
The matrix $XC : C \times D$.
The value of the elements of matrix $XC$ is the sum of the selected columns representing course $c \in C$ on day $d \in D$:

$$
\forall_{c \in C} \forall_{d \in D} \qquad
XC[c][d] = \sum_{l \in LC[c]} \sum_{s \in SD[d]} X[l][s]
$$



## Constrains

### The lesson must be conducted
The most fundamental constraint is that any lecture must be conducted exactly once:

$$
\forall_{l \in L} \qquad \sum_{s \in S} X[l][s] = 1
$$

### Enforce when lecture are unavailable
If the element of the matrix, $AL[l][s]$ is zero, then lecture $l \in L$ cannot occur in timeslot $s \in S$:

$$
\forall_{L \in L} \forall_{s \in S} \qquad X[l][s] \leq AL[l][s]
$$

### Only one teacher conducts the lecture
The second fundamental constraint is that any teacher $t \in T$ can teach exactly one lecture at a given time slot $s \in S$.
If the element of the matrix $AT[t][s]$ is zero, then teacher $r \in R$ is unavailable in timeslot $s \in S$:

$$
\forall_{t \in T} \forall_{s \in S} \qquad \sum_{l \in LT[t]} X[l][s] \leq AT[t][s]
$$

### Only one lecture is allowed in the room
The third fundamental constraint is that only one lecture can be conducted in room $r \in R$ at time slot $s \in S$.
If the element of the matrix $AR[r][s]$ is zero, then room $r \in R$ is unavailable in timeslot $s \in S$:

$$
\forall_{r \in R} \forall_{s \in S} \qquad \sum_{l \in LR[r]} X[l][s] \leq AR[r][s]
$$


### Only one lecture is allowed in the group
The fourth fundamental constraint is that only one lecture can belongs to group $g \in G$ at time slot $s \in S$.
If the element of the matrix $AG[g][s]$ is zero, then group $g \in G$ is unavailable in timeslot $s \in S$:

$$
\forall_{g \in G} \forall_{s \in S} \qquad \sum_{l \in LG[g]} X[l][s] \leq AG[g][s]
$$

### Limit the number of lectures in the course per day

$$
\forall_{c \in C} \forall_{d \in D} \qquad \sum_{l \in LC[c]} \sum_{s \in SD[d]} X[l][s] \leq AC[c][d]
$$


### Two lectures at the same timeslot
If lectures $l_1, l_2 \in L$ must take place in the same timeslot $s \in S$, then we have the constraint:

$$
X[l_1][s] = X[l_2][s]
$$

### Two lectures one after another
Let the function $\text{next}(s)$ returns the timeslot that comes right after timeslot $s \in S$. Then, if lectures $l_1, l_2 \in L$ must take place one after another, then we have the constraint:

$$
X[l_1][s] = X[l_2][\text{next}(s)]
$$




## Objective function

Let assume, there are three matrices:
+ $W_G : G \times S \mapsto \mathbb{R}^+$,
+ $W_T : T \times S \mapsto \mathbb{R}^+$,
+ $W_R : R \times S \mapsto \mathbb{R}^+$.

Then, the objective function is the weighted linear combination of
the group's timetable, represented by the matrix $XG$, and
the teacher's timetable, represented by the matrix $XT$ and
the room's timetable, represented by the matrix $XR$:

$$
\min_{X} \quad F_G + F_T + F_R
$$

where

$$
F_G = \sum_{g \in G} \sum_{s \in S} W_G[g][s] \cdot XG[g][s]
$$

and

$$
F_T = \sum_{t \in T} \sum_{s \in S} W_T[t][s] \cdot XT[t][s]
$$

and

$$
F_R = \sum_{r \in R} \sum_{s \in S} W_R[r][s] \cdot XR[r][s]
$$

The position of 1 in the matrices is not affected when the values of the matrix elements $W_G$, $W_T$, and $W_R$ are the same. However, adjusting these values affects the generated timetable.

### Questions
+ What are the optimal values for the matrix elements $W_G$, $W_T$, $W_R$?
+ How can we formulate an evaluation of the matrices $W_G$, $W_T$, $W_R$ as an optimization problem? 


## Objective function - specific version


The objective function is the linear function of the student's timetable, represented by the matrix $X$, and the teacher's timetable, represented by the matrix $Y$:

$$
\min_{X} \quad F_G + F_T
$$

where

$$
F_G = w_G \sum_{g \in G} \sum_{s \in S} (1 + H[s])^{q_G} XG[g][s]
$$

and

$$
F_T = w_T \sum_{t \in T} \sum_{s \in S} (1 + H[s])^{q_T} Y[t][s]
$$

where $q_G, q_t \in \mathbb{R}^+$ and coefficients $w_G, w_T \in \mathbb{R}^+$ fulfill the condition $w_G + w_T = 1$. 
The recommended range for $q \in \mathbb{R}$ is $1/3 \leq q \leq 3$. However, the value of $q$ within this range has minimal impact on the speed of convergence.

The coefficient $(1 + H[s])^q$ in the above equation enforces the timetable for small values of $H[s]$. Therefore, the consequences are as follows: 
+ Lectures start in the morning.
+ Timetables with an equal number of lectures during the day each week are preferred.
+ Free slots are penalized.

### Questions
+ How to choose the values of $q_G, q_T, w_G, w_T$?
+ What is the relationship between the values of $q_G, q_T, w_G, w_T$ and the quality of the requested timetable?
+ Is the proposed objective function sufficient for generating high-quality timetables?
+ What are some other possible objective functions?



