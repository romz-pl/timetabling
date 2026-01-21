#
# The AMPL implementation of 2D Lecture-Timeslot model.
#
#
#
# Author: Zbigniew Romanowski
#

# The set of lectures.
set L;
check: card(L) > 0;

# The set of timeslots.
set S;
check: card(S) > 0;

# The set of teachers.
set T;
check: card(T) > 0;

# The set of rooms.
set R;
check: card(R) > 0;



