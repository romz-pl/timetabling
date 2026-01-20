# Model 2D: Event-Timeslot

## Input parameters

### Sets
+ $T$ - the set of teachers.
+ $L$ - the set of lectures.
+ $R$ - the set of rooms.
+ $S$ - the set of timeslots.

### Sequence of sets LT
+ $\forall_{t \in T} \quad LT[t] \subseteq L$ - the set of lectures being taught by the teacher $t \in T$.
+ Any lesson can be taught by one teacher, hence: If $t_1, t_2 \in T$ and $t_1 \neq t_2$ then $LT[t_1] \cap LT[t_2] = \varnothing$
+ All lessons are taught, hence: $\cup_{t \in T} LT[t] = L$

### Sequence of sets LR
+ $\forall_{r \in R} \quad LR[r] \subseteq L$ - the set of lectures taking place in the room $r \in R$.
+ The lesson can take place in one room only, hence: If $r_1, r_2 \in R$ and $r_1 \neq r_2$ then $LR[r_1] \cap LR[r_2] = \varnothing$
+ Each lesson is assigned to a specific room, hence: $\cup_{r \in R} LR[r] = L$

### Availability matrix AL
+ $AL : L \times S \mapsto \{ 0, 1 \}$ - the availability matrix for lectures. See variable $X$.
+ In the availability matrix $AL[l][s]$ value $1$ means that the lecture $l \in L$ is available at slot $s \in S$.

### Availability matrix AT
+ $AT : T \times S \mapsto \{ 0, 1 \}$ - the availability matrix for teachers. See variable $Y$.
+ In the availability matrix $AT[t][s]$ value $1$ means that the teacher $t \in T$ is available at slot $s \in S$.

### Availability matrix AR
+ $AR : R \times S \mapsto \{ 0, 1 \}$ - the availability matrix for rooms. See variable $Z$.
+ In the availability matrix $AR[r][s]$ value $1$ means that the room $r \in R$ is available at slot $s \in S$.


### Day function, SD
Function $SD : S \mapsto \mathbb{N}$ returns the day corresponding to timeslot $s \in S$. 
In the most general way, the value of the function $SD$ can be provided for each $s \in S$.

If $S$ is the set of consecutive natural numbers starting from zero and each day consists of the same number of time slots, then $SD[s] = \text{floor}(s / N_h)$, where $N_h$ is th enumber of hours per day.


### Timeslot numer in the day function, SI
Function $SI : S \mapsto \mathbb{N}$ returns timeslot number in the day corresponding to timeslot $s \in S$.
In the most general way, the value of the function $SI$ can be provided for each $s \in S$.

If $S$ is the set of consecutive natural numbers starting from zero and each day consists of the same number of time slots, then $SI[s] = s \text{ mod } N_h$, where $N_h$ is th enumber of hours per day.


## Variables

### Matrix X
$X : L \times S \mapsto \{ 0, 1 \}$

The value $X[l][s] = 1$ means the lecture $l \in L$ takes place during the designated time slot $s \in S$.

### Matrix Y
$Y : T \times S \mapsto \{ 0, 1 \}$ 

The value $Y[t][s] = 1$ means the teacher $t \in T$ conducts the lesson during the designated time slot $s \in S$.

### Matrix Z
$Z : R \times S \mapsto \{ 0, 1 \}$

The value $Z[r][s] = 1$ means in the room $r \in R$ the lesson is conducted during the designated time slot $s \in S$.


## Constrains


### Enforce when lessons are unavailable
$$
\forall_{L \in L} \forall_{s \in S} \qquad \text{if } AL[l][s] = 0 \text{ then } X[l][s] = 0
$$

### The lesson must be conducted
$$
\forall_{l \in L} \qquad \sum_{s \in S} X[l][s] = 1
$$

### Only one teacher conducts the lesson
$$
\forall_{t \in T} \forall_{s \in S} \qquad \sum_{l \in LT[t]} X[l][s] \leq AT[t][s]
$$

### Only one lesson is allowed in the room
$$
\forall_{r \in R} \forall_{s \in S} \qquad \sum_{l \in LR[r]} X[l][s] \leq AR[r][s]
$$

### Reletion between matrix X and matrix Y
$$
\forall_{t \in T} \forall_{s \in S} \qquad Y[t][s] = \sum_{l \in LT[t]} X[l][s]
$$

### Reletion between matrix X and matrix Z
$$
\forall_{r \in R} \forall_{s \in S} \qquad Z[r][s] = \sum_{l \in LR[r]} X[l][s]
$$
