# Implementation

```
References:

https://llvm.org/docs/WritingAnLLVMPass.html
https://github.com/examon/APEX
https://github.com/mchalupa/dg/


TODO:
```

** TODO: reasons why are we implementing APEX as a pass in LLVM and not as a standalone
program**

## LLVM

`Introduction to the LLVM infra, IR, Passes and Optimizations`

[LLVM](llvm.md)


## APEX

```
This should be in implementation
- we compile the C source code into IR using clang and get single IR module
- using debug symbols, we locate target instructions
```

```
This should be in implementation
- inject extraction function call for the target instruction
- inject exit function call after extraction
- strip debug symbols and recompile modified code into separate binary
```

**Implementing tool as a standalone app vs llvm plugin (pass)**

The procedure described in the chapter [Design](design.md) is implemented
as LLVM Pass. Since this pass will modify code, it may be considered transform
pass.

### dg

APEXPass uses dg in order to get data dependencies between instructions.
We use this in APEXPass to compute dependency blocks and later decide which
functions and instructions can be safely deleted.

### APEXPass

- APEX = Active code Path EXtractor
- structure of the APEXPass:
 - cmd line args parsing
 - finding target instructions
 - init dg
 - create apex_dg
 - create call graph
 - find path in call graph
 - compute function dependency blocks
 - resolve dependencies
 - inject data collecting function & exit
 - remove everything not needed

### Injecting Exit and Extractor

We need to collect value from the target instruction. In order to do so,
we inject collector from `lib.c`.

Also, we do not care about anything after collector got its data, so we
insert `exit` from `lib.c`.


