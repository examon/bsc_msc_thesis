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

- **what do we mean by "dependency" in our situation**
 - control vs data dependencies
 - **code sample**
 - **image of the dependencies, with arrows and stuff**

- **how do we resolve dependencies**
 - dg
 - **image using some dg export tools**

## Finding Connected Components Between Data Dependnecies

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

## Removing Unneeded Stuff



## Extraction
``` Move to implementation ```

- **how do we extract remaining program**
 - adding to the path
 - removing non-path functions at the end
  - along with dependencies
 - **before and after code samples**
 - **before and after call graphs**
