<!---
Extracting Parts of Programs into Separate Binaries

- Get acquainted with means of compilation of C programs using the LLVM
compiler infrastructure - clang, LLVM Internal Representation, AST, LLVM
optimisations.

- Propose a solution to statically transplant a subset of a C program. This
subset should be extracted from the original program and synthesised as an
independent binary.

- Design and implement the proposed solution in a tool having an appropriate
form (a standalone application or an LLVM plugin).

- Test the implemented tool on at least 2 real-world open-source C programs.
-->

# Extracting Parts of Programs into Separate Binaries

## Contents

- [Introduction](introduction.md)
  - LLVM
  - Intermediate Representation
  - Optimisations
  - clang
  - AST

- Design
  - Call Graph
  - Path Finding
  - Dependeny Resolution
  - Extraction

- Implementation
  - APEXPass
    - dg
    - json dump


- Experiments
  - UNIX PROGRAM #1
  - UNIX PROGRAM #2

- Conclusion

- Further development



