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
+ In the availability matrix $AL[l][s]$ value $1$ means that the lecure $l$ is available at slot $s$.
+ In the availability matrix $AT[t][s]$ value $1$ means that the teacher $t$ is available at slot $s$.
+ In the availability matrix $AR[r][s]$ value $1$ means that the room $r$ is available at slot $s$. 

## Objective variables


## Constrains
