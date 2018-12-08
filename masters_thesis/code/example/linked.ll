; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@.str = private unnamed_addr constant [3 x i8] c"%d\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_exit(i32 %exit_code) #0 !dbg !9 {
entry:
  %exit_code.addr = alloca i32, align 4
  store i32 %exit_code, i32* %exit_code.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %exit_code.addr, metadata !13, metadata !14), !dbg !15
  %0 = load i32, i32* %exit_code.addr, align 4, !dbg !16
  call void @exit(i32 %0) #4, !dbg !17
  unreachable, !dbg !17

return:                                           ; No predecessors!
  ret void, !dbg !18
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_extract_int(i32 %i) #0 !dbg !19 {
entry:
  %i.addr = alloca i32, align 4
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !20, metadata !14), !dbg !21
  %0 = load i32, i32* %i.addr, align 4, !dbg !22
  %call = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str, i32 0, i32 0), i32 %0), !dbg !23
  ret void, !dbg !24
}

declare i32 @printf(i8*, ...) #3

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n) #0 !dbg !25 {
entry:
  %n.addr = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !28, metadata !14), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %x, metadata !30, metadata !14), !dbg !31
  %0 = load i32, i32* %n.addr, align 4, !dbg !32
  %add = add nsw i32 %0, 10, !dbg !33
  store i32 %add, i32* %x, align 4, !dbg !31
  %1 = load i32, i32* %x, align 4, !dbg !34
  ret i32 %1, !dbg !35
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @bar() #0 !dbg !36 {
entry:
  %y = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %y, metadata !39, metadata !14), !dbg !40
  store i32 42, i32* %y, align 4, !dbg !40
  %0 = load i32, i32* %y, align 4, !dbg !41
  ret i32 %0, !dbg !42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !43 {
entry:
  %retval = alloca i32, align 4
  %some_int = alloca i32, align 4
  %foo_result = alloca i32, align 4
  %bar_result = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %some_int, metadata !44, metadata !14), !dbg !45
  store i32 10, i32* %some_int, align 4, !dbg !45
  call void @llvm.dbg.declare(metadata i32* %foo_result, metadata !46, metadata !14), !dbg !47
  %0 = load i32, i32* %some_int, align 4, !dbg !48
  %call = call i32 @foo(i32 %0), !dbg !49
  store i32 %call, i32* %foo_result, align 4, !dbg !47
  call void @llvm.dbg.declare(metadata i32* %bar_result, metadata !50, metadata !14), !dbg !51
  %call1 = call i32 @bar(), !dbg !52
  store i32 %call1, i32* %bar_result, align 4, !dbg !51
  ret i32 0, !dbg !53
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn nounwind }

!llvm.dbg.cu = !{!0, !3}
!llvm.ident = !{!5, !5}
!llvm.module.flags = !{!6, !7, !8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "src/apex/apexlib.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!2 = !{}
!3 = distinct !DICompileUnit(language: DW_LANG_C99, file: !4, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!4 = !DIFile(filename: "example.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/examples/example")
!5 = !{!"clang version 5.0.1 (tags/RELEASE_500/final)"}
!6 = !{i32 2, !"Dwarf Version", i32 4}
!7 = !{i32 2, !"Debug Info Version", i32 3}
!8 = !{i32 1, !"wchar_size", i32 4}
!9 = distinct !DISubprogram(name: "_apex_exit", scope: !1, file: !1, line: 6, type: !10, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "exit_code", arg: 1, scope: !9, file: !1, line: 6, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 6, column: 21, scope: !9)
!16 = !DILocation(line: 7, column: 8, scope: !9)
!17 = !DILocation(line: 7, column: 3, scope: !9)
!18 = !DILocation(line: 8, column: 1, scope: !9)
!19 = distinct !DISubprogram(name: "_apex_extract_int", scope: !1, file: !1, line: 11, type: !10, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!20 = !DILocalVariable(name: "i", arg: 1, scope: !19, file: !1, line: 11, type: !12)
!21 = !DILocation(line: 11, column: 28, scope: !19)
!22 = !DILocation(line: 12, column: 16, scope: !19)
!23 = !DILocation(line: 12, column: 3, scope: !19)
!24 = !DILocation(line: 13, column: 1, scope: !19)
!25 = distinct !DISubprogram(name: "foo", scope: !4, file: !4, line: 1, type: !26, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !3, variables: !2)
!26 = !DISubroutineType(types: !27)
!27 = !{!12, !12}
!28 = !DILocalVariable(name: "n", arg: 1, scope: !25, file: !4, line: 1, type: !12)
!29 = !DILocation(line: 1, column: 13, scope: !25)
!30 = !DILocalVariable(name: "x", scope: !25, file: !4, line: 2, type: !12)
!31 = !DILocation(line: 2, column: 9, scope: !25)
!32 = !DILocation(line: 2, column: 13, scope: !25)
!33 = !DILocation(line: 2, column: 15, scope: !25)
!34 = !DILocation(line: 3, column: 12, scope: !25)
!35 = !DILocation(line: 3, column: 5, scope: !25)
!36 = distinct !DISubprogram(name: "bar", scope: !4, file: !4, line: 6, type: !37, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !3, variables: !2)
!37 = !DISubroutineType(types: !38)
!38 = !{!12}
!39 = !DILocalVariable(name: "y", scope: !36, file: !4, line: 7, type: !12)
!40 = !DILocation(line: 7, column: 9, scope: !36)
!41 = !DILocation(line: 8, column: 12, scope: !36)
!42 = !DILocation(line: 8, column: 5, scope: !36)
!43 = distinct !DISubprogram(name: "main", scope: !4, file: !4, line: 11, type: !37, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !3, variables: !2)
!44 = !DILocalVariable(name: "some_int", scope: !43, file: !4, line: 12, type: !12)
!45 = !DILocation(line: 12, column: 9, scope: !43)
!46 = !DILocalVariable(name: "foo_result", scope: !43, file: !4, line: 13, type: !12)
!47 = !DILocation(line: 13, column: 9, scope: !43)
!48 = !DILocation(line: 13, column: 26, scope: !43)
!49 = !DILocation(line: 13, column: 22, scope: !43)
!50 = !DILocalVariable(name: "bar_result", scope: !43, file: !4, line: 14, type: !12)
!51 = !DILocation(line: 14, column: 9, scope: !43)
!52 = !DILocation(line: 14, column: 22, scope: !43)
!53 = !DILocation(line: 16, column: 5, scope: !43)
