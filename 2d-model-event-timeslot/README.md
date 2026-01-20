# Model 2D: Event-Timeslot

## Input parameters

+ $T$ - the set of teachers.
+ $L$ - the set of lectures.
+ $R$ - the set of rooms.
+ $S$ - the set of timeslots.
+ $LT[t] \subseteq L$ - the set of lectures being taught by the teacher $t \in T$.
+ $LR[r] \subseteq L$ - the set of lectures taking place in the room $r \in R$.
+ $AL : L \times S \mapsto \{ 0, 1 \}$ - the availability matrix for lectures. See variable $X$.
+ $AT : T \times S \mapsto \{ 0, 1 \}$ - the availability matrix for teachers. See variable $Y$.
+ $AR : R \times S \mapsto \{ 0, 1 \}$ - the availability matrix for rooms. See variable $Z$.



### Assumptions

+ Any lesson can be taught by one teacher: If $t_1, t_2 \in T$ and $t_1 \neq t_2$ then $LT[t_1] \cap LT[t_2] = \varnothing$
+ All lessons are taught: $\cup_{t \in T} LT[t] = L$
+ The lesson can take place in one room only: If $r_1, r_2 \in R$ and $r_1 \neq r_2$ then $LR[r_1] \cap LR[r_2] = \varnothing$
+ Each lesson is assigned to a specific room: $\cup_{r \in R} LR[r] = L$
+ In the availability matrix $AL[l][s]$ value $1$ means that the lecure $l \in L$ is available at slot $s \in S$.
+ In the availability matrix $AT[t][s]$ value $1$ means that the teacher $t \in T$ is available at slot $s \in S$.
+ In the availability matrix $AR[r][s]$ value $1$ means that the room $r \in R$ is available at slot $s \in S$. 

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
\forall_{L \in L} \forall_{s \in S} \qquad if AL[l][s] = 0 then X[l][s] = 0
$$

### The lesson must be conducted
$$
\forall_{l \in L} \qquad \sum_{s \in S} X[l][s] = 1
$$

### Only one teacher conducts the lesson
$$
\forall_{t \in T} \forall_{s \in S} \qquad \sum_{l \in LT[t]} X[l][s] <= AT[t][s]
$$

### Only one lesson is allowed in the room
$$
\forall_{r \in R} \forall_{s \in S} \qquad \sum_{l \in LR[r]} X[l][s] <= AR[r][s]
$$
