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

- **image of the pipeline would be good here**

- "high level summary of the optimization features that LLVM provides" [4]

- **how to run optimizations?**


## clang

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
