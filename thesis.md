```
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
```

```
TODO?

- some summary of existing/simmilar solutions?
- move LLVM chapter into Implementation?

```

# Extracting Parts of Programs into Separate Binaries

## Contents

- [1. Introduction](introduction.md)

- [2. The LLVM Compiler Infrastructure](llvm.md)
  - LLVM
  - Intermediate Representation
  - Optimisations
  - clang

- [3. Design of the Method](design.md)
  - Call Graph
  - Path Finding
  - Dependeny Resolution
  - Extraction

- [4. Implementation](implementation.md)
  - LLVM Pass
  - APEXPass

- [5. Experiments](experiments.md)
  - UNIX PROGRAM #1
  - UNIX PROGRAM #2

- [6. Conclusion](conclusion.md)
  - Summary of the Results
  - Further Development and Research

- [Bibliography](bibliography.md)

- [A. Archive Structure and Compilation](archive.md)
  - Archive Structure
