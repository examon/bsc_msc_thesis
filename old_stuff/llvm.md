<!--

References:

[1] https://llvm.org/
[2] https://llvm.org/docs/LangRef.html
[3] https://llvm.org/docs/Passes.html
[4] https://clang.llvm.org/
[5] https://clang.llvm.org/docs/IntroductionToTheClangAST.html
[6] http://www.aosabook.org/en/llvm.html

-->

# Introduction


## LLVM

- "The LLVM (**FOOTNOTE:The name "LLVM" itself is not an acronym; it is the
full name of the project.**) Project is a collection of modular and reusable
compiler and toolchain technologies." [1]

- "an umbrella project that hosts and develops a set of close-knit low-level
toolchain components (e.g., assemblers, compilers, debuggers, etc.), which are
designed to be compatible with existing tools typically used on Unix systems"
- "the main thing that sets LLVM apart from other compilers is its internal
architecture."
[6]


- Primary subprojects:
 - LLVM core
 - clang
 - ...

- Strengths: "A major strength of LLVM is its versatility, flexibility, and
reusability"

## Intermediate Representation

### Introduction

- IR AKA LLVM assembly language AKA LLVM

- "LLVM is a Static Single Assignment (SSA) based representation that provides
type safety, low-level operations, flexibility, and the capability of
representing ‘all’ high-level languages cleanly. It is the common code
representation used throughout all phases of the LLVM compilation strategy." [2]

- Aims:
 - "The LLVM representation aims to be light-weight and low-level while being
 expressive, typed, and extensible at the same time."

- Representations of IR:
 - as an in-memory compiler IR
 - as an on-disk bitcode representation (suitable for fast loading by a
 Just-In-Time compiler)
 - as a human readable assembly language representation


**Example of the IR**

We have the following `C` function `add`

``` C
int add(int a, int b) {
    return a+b;
}
```

When using `clang` compiler with `-emit-llvm` flag, we get the following
representation in `IR`:

``` IR
define i32 @add(i32 %a, i32 %b) #0 {
entry:
  %a.addr = alloca i32, align 4
  %b.addr = alloca i32, align 4
  store i32 %a, i32* %a.addr, align 4
  store i32 %b, i32* %b.addr, align 4
  %0 = load i32, i32* %a.addr, align 4
  %1 = load i32, i32* %b.addr, align 4
  %add = add nsw i32 %0, %1
  ret i32 %add
}
```

### High Level Structure

- Module structure:
 - functions
 - global variables
 - symbol table entries

- using LLVM linked for module combination
 - we will use this in practice

- Functions:
 - "A function definition contains a list of basic blocks, forming the CFG
 (Control Flow Graph) for the function."
 - PHI nodes


## Optimisations

```
References:
https://llvm.org/docs/Passes.html
https://llvm.org/docs/WritingAnLLVMPass.html
https://llvm.org/docs/CommandGuide/opt.html
```

LLVM uses the concept of Passes for the optimisations. Concrete optimisations
are implemented as Passes that work with some portion of program code (e.g.
Module, Function, Loop, etc.) to collect or transform this portion of the code.

There are the following types of passes:

### Analysis passes

Analysis passes collect information from the IR and feed it into the other
passes.
They can be also used for the debugging purposes, for example pass that counts
number of functions in the module.

Examples:
- basiccg: Basic CallGraph Construction
- dot-callgraph: Print Call Graph to “dot” file
- instcount: Counts the various types of Instructions

### Transform passes

Transform passes change the program in some way. They can use some analysis pass
that has been ran before and produced some information.

Examples:
- dce: Dead Code Elimination
- loop-deletion: Delete dead loops
- loop-unroll: Unroll loops

###  Utility passes

Utility passes do not fit into analysis passes or transform passes categories.

Examples:
- verify: Module Verifier
- view-cfg: View CFG of function
- instnamer: Assign names to anonymous instructions

### PassManager

Since user can specify to run multiple passes, LLVM uses `PassManager` class
that takes care of scheduling passes. Scheduling is done in order to compute
dependencies between passes and calcualte prerequisites.

`PassManager` also tries to improve performance by:
- sharing analysis results
 - **TODO: more info?**
- pipelining execution of the passes in order to get better cache performance
 - **TODO: more info?**

### opt

- **TODO: what is opt**
- **TODO: examples of running passes via opt**


# clang

- "The Clang project provides a language front-end and tooling infrastructure
for languages in the C language family" [4]

- Features and Goals (**some overview of clang**):
 - End-User Features
 - Utility and Applications
 - Internal Design and Implementation

- AST
 - **what is AST**
 - **AST in clang**
 - **Differences between clang AST and other compilers ASTs**
 - We will not use clangs AST, we will work directly with IR, it better suits
 this project
