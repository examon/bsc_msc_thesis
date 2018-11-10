# Implementation

```
References:

https://llvm.org/docs/WritingAnLLVMPass.html
https://github.com/examon/APEX
https://github.com/mchalupa/dg/
```

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

### Injecting Data Collect and Exit

We need to collect value from the target instruction. In order to do so,
we inject collector from `lib.c`.

Also, we do not care about anything after collector got its data, so we
insert `exit` from `lib.c`.
