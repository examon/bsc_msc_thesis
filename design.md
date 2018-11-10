# Design

- we compile the C source code into IR using clang and get single IR module
- using `APEXPass`, we do the following:
 - parse cmd line arguments and get entry point and target instruction/line
 - init dg and use dg data to build `apex_dg` graph of data & control
 dependencies between IR instructions
 - create call graph between module functions
 - find path in call graph from entry function to function hosting target
 instruction
 - calculate which functions and instructions we want to keep in the final
 executable and remove everything else
 - inject collecting instructions that will extract data from the target
 instruction
 - compile this modified IR into separate binary


## Call Graph

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

``` C
void y(void) {}

void x(void) {
  y();
}

int main(void) {
  x();
  return 0;
}
```

will generate the following call graph:
** TODO: make this image **

```
main -> x
x -> y
y -> [External/Nothing]
```



## Path Finding

- **what is "path" in our situation**
 - **image of the path**

- **why do we need path**
 - what is source & target

- **what algo do we use to find it**
 - BFS
 - one vs multiple paths

## Dependency Resolution

- **what do we mean by "dependency" in our situation**
 - control vs data dependencies
 - **code sample**
 - **image of the dependencies, with arrows and stuff**

- **how do we resolve dependencies**
 - dg
 - **image using some dg export tools**

## Extraction

- **how do we extract remaining program**
 - adding to the path
 - removing non-path functions at the end
  - along with dependencies
 - **before and after code samples**
 - **before and after call graphs**
