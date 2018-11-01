<!--
References:

-->

# Design

## Call Graph

- **what is call graph**
 - **code sample**
 - **image of the generic call graph generate from the code sample**

- **why do we need callgraph**

- **how is our call graph represented**
 - what type of graph it is
 - what are nodes and edges
 - **image of our call graph**

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
