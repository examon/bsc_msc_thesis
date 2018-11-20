# Design

```
This should be in implementation
- we compile the C source code into IR using clang and get single IR module
- using debug symbols, we locate target instructions
```

- calculate data dependencies between instructions
- compute connected components out of data dependencies between instructions
inside every function
- compute callgraph, mapping between connected components and functions they are calling
- find path from source (main) and target instructions in callgraph
- remove functions and other connected components that do not depend on the path

```
This should be in implementation
- inject extraction function call for the target instruction
- inject exit function call after extraction
- strip debug symbols and recompile modified code into separate binary
```


## Calculating Data Dependencies

```
References:
https://is.muni.cz/auth/th/vik1f/?fakulta=1433;obdobi=7403;studium=763581
```

In order to identify what parts of the IR we need to remove, we need to compute dependencies
between instructions.

We recognize two types of dependencies between IR instructions: control and data.
Terminology comes from the Mareks work.

- control dependence: "Control dependence explicitly states what nodes are controlled by
which predicate."
- data dependence: "A data dependence edge is between nodes n and m iff n
defines a variable that m uses and there is no intervening definition of that
variable on some path between n and m.  In other words, the definitions from n
reach uses in m"

The crucial information comes from data dependencies. We need to make
sure that the IR integrity will remain intact after we are done with our transformation.
We have to know which instructions depend which.
We cannot afford to remove blindly any instruction, because it may happen that
this removed instruction is needed by some other instruction.

The above rationale can be demonstrated on the example below:

```
%call3 = call i32 @flag()
store i32 %call3, i32* %f, align 4
%0 = load i32, i32* %f, align 4
```

We have tree instructions. We call function `flag`, capture return value into
variable `call3`, store value from `call3` into variable `f` and finally load
value from `f` into `0`.

We can see that if we would remove instruction `%call3 = call i32 @flag()`
it would mean that `call3` is going to be undefined and instruction
`store i32 %call3, i32* %f, align 4` would work with undefined variable.
This would break integrity of the IR as the later computation dependent on the
`store i32 %call3, i32* %f, align 4` would fail.

We need to make sure we do not corrupt IR with undefined variables.

## Finding Connected Components Between Data Dependnecies

```
References:
https://is.muni.cz/auth/th/vik1f/?fakulta=1433;obdobi=7403;studium=763581

TODO:
- put definition of connected component somewhere
```

Since we know that there are data dependencies between instructions, we can
construct graph G where V is set of vertices (in our case vertex is instruction)
and E is set of edges (in our case, edge between vertices V1 and V2 represents
data dependency between instruction V1 and V2).


Let us demonstrate on the following example.
Lets take this simple C function:

``` C
int z(void) {
  printf("hello from z\n");
  int tmp = 1;
  return tmp;
}
```

Above C code corresponds to the following IR:

```
define i32 @z() #0 {
entry:
  %tmp = alloca i32, align 4
  %call = call i32 (i8*, ...) @printf(i8* ...)
  store i32 1, i32* %tmp, align 4
  %0 = load i32, i32* %tmp, align 4
  ret i32 %0
}
```

Graph G would look like (in the adjacency list form):

```
  [%tmp = alloca i32, align 4] -> [store i32 1, i32* %tmp, align 4]
  [%call = call i32 (i8*, ...) @printf(i8* ...)] -> []
  [store i32 1, i32* %tmp, align 4] -> [%0 = load i32, i32* %tmp, align 4]
  [%0 = load i32, i32* %tmp, align 4] -> [ret i32 %0]
  [ret i32 %0] -> []

```

Now, we can find connected components in G easily by traversing graph using BFS.

```
FUNCTION: z
- COMPONENT:
    %tmp = alloca i32, align 4
    store i32 1, i32* %tmp, align 4
    %0 = load i32, i32* %tmp, align 4
    ret i32 %0
- COMPONENT:
    %call = call i32 (i8*, ...) @printf(i8* ...)
```

Having instructions within function separated into connected components comes
useful. We can see that since call to `printf` is in the different component
than other instructions. If we were to remove this `printf` call, integrity of
the instructions in the other component would not be compromised. We can take
advantage of this when we know for sure that we are interested about
instructions in certain components and not in the others. We can proceed and
remove whole components and not compromise integrity.

The procedure describing how are we going to pick components for removal and
remove them will come later.


## Constructing Call Graph

```
References:
- call graph definition

TODO:

```

**Call graph in general**

`citation needed & improve this, add definition of CFG` Call graph is a control
flow graph that represents relationship between program procedures in respect
to control flow.  Lets have call graph `G = {V, E}`, where set of vertices `V`
typically represents functions and set of edges `E` represents calls from one
function in `V` to another.

**Call graph in our case**

In our case, call graph represents relationship between individual function
connected components and functions that these components call, more
specifically instruction from component calls.

To demonstrate more clearly what exactly is callgraph in our context, lets take
the following C program:

``` C
int y(void) {
  return 2;
}

int x(void) {
  return 1;
}

int main(void) {
  int x_ret = x();
  int y_ret = y();
  return 0;
}
```

Classic callgraph would look like:

```
[main] -> [x, y]
[x] -> []
[y] -> []
```

`main` calls `x` and `y` while both `x` and `y` do not call anything.

The IR representation of the above program:

```
define i32 @y() #0 {
entry:
  ret i32 2
}

define i32 @x() #0 {
entry:
  ret i32 1
}

define i32 @main() #0 {
entry:
  %retval = alloca i32, align 4
  %x_ret = alloca i32, align 4
  %y_ret = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @x()
  store i32 %call, i32* %x_ret, align 4
  %call1 = call i32 @y()
  store i32 %call1, i32* %y_ret, align 4
  ret i32 0
}
```

After applying approach from the previous chapter, we get these connected
components:

```
FUNCTION: y
- COMPONENT: y:1
    ret i32 2

FUNCTION: x
- COMPONENT: x:1
    ret i32 1

FUNCTION: main
- COMPONENT: main:1
    %retval = alloca i32, align 4
    store i32 0, i32* %retval, align 4
- COMPONENT: main:2
    %x_ret = alloca i32, align 4
    %call = call i32 @x()
    store i32 %call, i32* %x_ret, align 4
- COMPONENT: main:3
    %y_ret = alloca i32, align 4
    %call1 = call i32 @y()
    store i32 %call1, i32* %y_ret, align 4
- COMPONENT: main:4
    ret i32 0
```

As was written above, call graph in our situation is mapping between individual
components and functions that are being called within these components. That
gives us the following structure:

```
[y:1] -> []
[x:1] -> []
[main:1] -> []
[main:2] -> [x]
[main:3] -> [y]
[main:4] -> []
```

Having call graph represented in the structure above is beneficial for finding
program execution flow path between specific instructions within the program in
relation to their dependencies.


## Finding Path from Source to Target

```
References:
- Find some solid def of path, not from wiki, it is lame.

TODO:
- some path code/picture example?
```

`from wiki, citation needed dude` "In graph theory, a path in a graph is a
finite or infinite sequence of edges which connect a sequence of vertices
which, by most definitions, are all distinct from one another."

In our case, sequence of vertices is  sequence of connected components and
sequence of edges which connect these connected components are function calls
(from one component to another component within called function).

The reason why we constructed our special call graph from the connected components
is the following: We want to find path from the source to target and in doing so,
know which connected components are part of this path or not.

Source in our case is entry point to the program, `main` functions.
Target is supplied by the user and consists of the pair `filename, line number`.
This pair represents specific instruction (or set of instructions when compiled
into IR).

This means that we are finding execution path from `main` function to the target
fine of code. Potentially, there may exist infinite number of such paths.
From the optimization standpoint, it would be fitting to find all (or at least
as many as we can) paths from source to target and pick some path according to
selected optimization criteria (shortest path, path with smallest connected
components, etc.).

However, for our purposes, it will be sufficient to find any path.
We will use breadth first search to find any path and work with this path in
the later stages (see chapter "removing unneeded stuff").


## Removing Unneeded Stuff

```
References:

TODO:

```

The simplest and seemingly correct way would be to remove every connected
component that is not part of the path that we calculated in the earlier chapter.

This approach would unfortunately produce inconsistent IR. It not enough to
remove only components in the path. We need to include every other component
that is dependent on any other component that is already part of the path.



## Extraction
``` Move to implementation ```

- **how do we extract remaining program**
 - adding to the path
 - removing non-path functions at the end
  - along with dependencies
 - **before and after code samples**
 - **before and after call graphs**
