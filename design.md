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
construct graph G where V is set of vertecies (in our case vertex is instruction)
and E is set of edges (in our case, edge between vertecies V1 and V2 represents
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
- COMPONENT 1:
    %tmp = alloca i32, align 4
    store i32 1, i32* %tmp, align 4
    %0 = load i32, i32* %tmp, align 4
    ret i32 %0
- COMPONENT 2:
    %call = call i32 (i8*, ...) @printf(i8* ...)
```

Having instructions within function separated into connected components comes
useful.
We can see that since call to `printf` is in the different component than other
instructions. If we were to remove this `printf` call, integrity of the
instructions in the other component would not be compromised.
We can take advantage of this when we know for sure that we are interested
about instructions in certain components and not in the others. We can proceed and
remove whole components and not compromise integrity.

The procedure describing how are we going to pick components for removal and remove
them will come later.


## Constructing Call Graph

- **what is call graph**

Call graph is a control flow graph **_[citation needed]_** that represents
relationship between program procedures in respect to control flow.
Lets have call graph `G = {V, E}`, where set of vertices `V` typically
represents functions and set of edges `E` represents calls from one function
in `V` to another.

- **why do we need callgraph**

We need call graph between IR functions because we want to know the possible
program execution flow path between source and target functions. We will use
this computed path to calculate dependencies that will not be removed.

- **call graph in our case**

In our case, set `V` contains IR functions and `E` contains IR call
instructions (although, implementation is different, conceptually this is
accurate):

- The following code sample:



## Path Finding

- **what is "path" in our situation**
 - **image of the path**

- **why do we need path**
 - what is source & target

- **what algo do we use to find it**
 - BFS
 - one vs multiple paths

## Removing Unneeded Stuff



## Extraction
``` Move to implementation ```

- **how do we extract remaining program**
 - adding to the path
 - removing non-path functions at the end
  - along with dependencies
 - **before and after code samples**
 - **before and after call graphs**
