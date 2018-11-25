# Introduction

`Some motivational backstory & Outline of the problem`

User wants to know the value of some variable in the program. He/she can run
debugger of choice, set breakpoint at the selected variable location and let
debugger execute input program step by step until it reaches the selected
variable.  Finally, debugger steps on the targeted variable and thus can
extract its value and provide it back to the user.

The procedure described above is usually part of the standard standard approach
when user want to get value of some selected variable during the program
execution.  Unfortunately, this approach is cumbersome in case when user want
to execute above procedure many times. Procedure consists of many manual steps
which is time consuming to perform. Ideally, there could be script that takes
line of code (or variable name) as an input and produces output with the value
of the selected target

Normally, this method would require to use debugger with the scripting support and
write scripts that would instruct debugger what exactly to do, basically
replicating the manual approach.

Instead of scripting debugger to do the extraction, we could write tool that would
accept the same user input as the approach above (line of code/variable name), run
analysis on where the execution flow in the program would occur to get to the
target instruction and transplant subset of the input program into separate
binary.

This way, user will have separate, executable that upon running would produce
value of the targeted instruction, without having to manually step thought or
script debugger.

`aim of the thesis`

This thesis aims to devise method and implement this method in a tool for
statically transplanting a subset of a C program. Using the devised method, the
selected program subset should be extracted from the original program provided
by the user and synthesized as an independent, executable binary.

Proposed solution should be implemented in a tool having appropriate form, either
as a standalone application or an LLVM plugin. It should easily accept user to
provide their own input programs.

Finally, tool should be used to test at least two real-world open-source C
programs in order to find where the room for improvements is and what could
be improved in the future.


- **Outline of chapters**


