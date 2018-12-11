; ModuleID = 'domainname.bc'
source_filename = "domainname.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [11 x i8] c"domainname\00", align 1
@__progname = global i8* getelementptr inbounds ([11 x i8], [11 x i8]* @.str, i32 0, i32 0), align 8, !dbg !0
@.str.1 = private unnamed_addr constant [1 x i8] zeroinitializer, align 1
@optind = external global i32, align 4
@.str.2 = private unnamed_addr constant [14 x i8] c"setdomainname\00", align 1
@.str.3 = private unnamed_addr constant [14 x i8] c"getdomainname\00", align 1
@.str.4 = private unnamed_addr constant [4 x i8] c"%s\0A\00", align 1
@stderr = external global %struct._IO_FILE*, align 8
@.str.5 = private unnamed_addr constant [28 x i8] c"usage: %s [name-of-domain]\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main(i32 %argc, i8** %argv) #0 !dbg !12 {
entry:
  %retval = alloca i32, align 4
  %argc.addr = alloca i32, align 4
  %argv.addr = alloca i8**, align 8
  %ch = alloca i32, align 4
  %domainname = alloca [65 x i8], align 16
  store i32 0, i32* %retval, align 4
  store i32 %argc, i32* %argc.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %argc.addr, metadata !17, metadata !18), !dbg !19
  store i8** %argv, i8*** %argv.addr, align 8
  call void @llvm.dbg.declare(metadata i8*** %argv.addr, metadata !20, metadata !18), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %ch, metadata !22, metadata !18), !dbg !23
  call void @llvm.dbg.declare(metadata [65 x i8]* %domainname, metadata !24, metadata !18), !dbg !28
  br label %while.cond, !dbg !29

while.cond:                                       ; preds = %sw.epilog, %entry
  %0 = load i32, i32* %argc.addr, align 4, !dbg !30
  %1 = load i8**, i8*** %argv.addr, align 8, !dbg !31
  %call = call i32 @getopt(i32 %0, i8** %1, i8* getelementptr inbounds ([1 x i8], [1 x i8]* @.str.1, i32 0, i32 0)) #7, !dbg !32
  store i32 %call, i32* %ch, align 4, !dbg !33
  %cmp = icmp ne i32 %call, -1, !dbg !34
  br i1 %cmp, label %while.body, label %while.end, !dbg !29

while.body:                                       ; preds = %while.cond
  %2 = load i32, i32* %ch, align 4, !dbg !35
  switch i32 %2, label %sw.default [
  ], !dbg !36

sw.default:                                       ; preds = %while.body
  call void @usage(), !dbg !37
  br label %sw.epilog, !dbg !39

sw.epilog:                                        ; preds = %sw.default
  br label %while.cond, !dbg !29, !llvm.loop !40

while.end:                                        ; preds = %while.cond
  %3 = load i32, i32* @optind, align 4, !dbg !42
  %4 = load i32, i32* %argc.addr, align 4, !dbg !43
  %sub = sub nsw i32 %4, %3, !dbg !43
  store i32 %sub, i32* %argc.addr, align 4, !dbg !43
  %5 = load i32, i32* @optind, align 4, !dbg !44
  %6 = load i8**, i8*** %argv.addr, align 8, !dbg !45
  %idx.ext = sext i32 %5 to i64, !dbg !45
  %add.ptr = getelementptr inbounds i8*, i8** %6, i64 %idx.ext, !dbg !45
  store i8** %add.ptr, i8*** %argv.addr, align 8, !dbg !45
  %7 = load i32, i32* %argc.addr, align 4, !dbg !46
  %cmp1 = icmp sgt i32 %7, 1, !dbg !48
  br i1 %cmp1, label %if.then, label %if.end, !dbg !49

if.then:                                          ; preds = %while.end
  call void @usage(), !dbg !50
  br label %if.end, !dbg !50

if.end:                                           ; preds = %if.then, %while.end
  %8 = load i8**, i8*** %argv.addr, align 8, !dbg !51
  %9 = load i8*, i8** %8, align 8, !dbg !53
  %tobool = icmp ne i8* %9, null, !dbg !53
  br i1 %tobool, label %if.then2, label %if.else, !dbg !54

if.then2:                                         ; preds = %if.end
  %10 = load i8**, i8*** %argv.addr, align 8, !dbg !55
  %11 = load i8*, i8** %10, align 8, !dbg !58
  %12 = load i8**, i8*** %argv.addr, align 8, !dbg !59
  %13 = load i8*, i8** %12, align 8, !dbg !60
  %call3 = call i64 @strlen(i8* %13) #8, !dbg !61
  %call4 = call i32 @setdomainname(i8* %11, i64 %call3) #7, !dbg !62
  %tobool5 = icmp ne i32 %call4, 0, !dbg !62
  br i1 %tobool5, label %if.then6, label %if.end7, !dbg !63

if.then6:                                         ; preds = %if.then2
  call void (i32, i8*, ...) @err(i32 1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.2, i32 0, i32 0)) #9, !dbg !64
  unreachable, !dbg !64

if.end7:                                          ; preds = %if.then2
  br label %if.end14, !dbg !65

if.else:                                          ; preds = %if.end
  %arraydecay = getelementptr inbounds [65 x i8], [65 x i8]* %domainname, i32 0, i32 0, !dbg !66
  %call8 = call i32 @getdomainname(i8* %arraydecay, i64 65) #7, !dbg !69
  %tobool9 = icmp ne i32 %call8, 0, !dbg !69
  br i1 %tobool9, label %if.then10, label %if.end11, !dbg !70

if.then10:                                        ; preds = %if.else
  call void (i32, i8*, ...) @err(i32 1, i8* getelementptr inbounds ([14 x i8], [14 x i8]* @.str.3, i32 0, i32 0)) #9, !dbg !71
  unreachable, !dbg !71

if.end11:                                         ; preds = %if.else
  %arraydecay12 = getelementptr inbounds [65 x i8], [65 x i8]* %domainname, i32 0, i32 0, !dbg !72
  %call13 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str.4, i32 0, i32 0), i8* %arraydecay12), !dbg !73
  br label %if.end14

if.end14:                                         ; preds = %if.end11, %if.end7
  ret i32 0, !dbg !74
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: nounwind
declare i32 @getopt(i32, i8**, i8*) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @usage() #0 !dbg !75 {
entry:
  %0 = load %struct._IO_FILE*, %struct._IO_FILE** @stderr, align 8, !dbg !78
  %1 = load i8*, i8** @__progname, align 8, !dbg !79
  %call = call i32 (%struct._IO_FILE*, i8*, ...) @fprintf(%struct._IO_FILE* %0, i8* getelementptr inbounds ([28 x i8], [28 x i8]* @.str.5, i32 0, i32 0), i8* %1), !dbg !80
  call void @exit(i32 1) #10, !dbg !81
  unreachable, !dbg !81

return:                                           ; No predecessors!
  ret void, !dbg !82
}

; Function Attrs: nounwind
declare i32 @setdomainname(i8*, i64) #2

; Function Attrs: nounwind readonly
declare i64 @strlen(i8*) #3

; Function Attrs: noreturn
declare void @err(i32, i8*, ...) #4

; Function Attrs: nounwind
declare i32 @getdomainname(i8*, i64) #2

declare i32 @printf(i8*, ...) #5

declare i32 @fprintf(%struct._IO_FILE*, i8*, ...) #5

; Function Attrs: noreturn nounwind
declare void @exit(i32) #6

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readonly "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { noreturn "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { nounwind }
attributes #8 = { nounwind readonly }
attributes #9 = { noreturn }
attributes #10 = { noreturn nounwind }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!8, !9, !10}
!llvm.ident = !{!11}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "__progname", scope: !2, file: !3, line: 40, type: !6, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, globals: !5)
!3 = !DIFile(filename: "domainname.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/examples/experiments/domainname")
!4 = !{}
!5 = !{!0}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = !{!"clang version 5.0.1 (tags/RELEASE_500/final)"}
!12 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 44, type: !13, isLocal: false, isDefinition: true, scopeLine: 45, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!13 = !DISubroutineType(types: !14)
!14 = !{!15, !15, !16}
!15 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !6, size: 64)
!17 = !DILocalVariable(name: "argc", arg: 1, scope: !12, file: !3, line: 44, type: !15)
!18 = !DIExpression()
!19 = !DILocation(line: 44, column: 10, scope: !12)
!20 = !DILocalVariable(name: "argv", arg: 2, scope: !12, file: !3, line: 44, type: !16)
!21 = !DILocation(line: 44, column: 22, scope: !12)
!22 = !DILocalVariable(name: "ch", scope: !12, file: !3, line: 46, type: !15)
!23 = !DILocation(line: 46, column: 6, scope: !12)
!24 = !DILocalVariable(name: "domainname", scope: !12, file: !3, line: 47, type: !25)
!25 = !DICompositeType(tag: DW_TAG_array_type, baseType: !7, size: 520, elements: !26)
!26 = !{!27}
!27 = !DISubrange(count: 65)
!28 = !DILocation(line: 47, column: 7, scope: !12)
!29 = !DILocation(line: 49, column: 2, scope: !12)
!30 = !DILocation(line: 49, column: 22, scope: !12)
!31 = !DILocation(line: 49, column: 28, scope: !12)
!32 = !DILocation(line: 49, column: 15, scope: !12)
!33 = !DILocation(line: 49, column: 13, scope: !12)
!34 = !DILocation(line: 49, column: 39, scope: !12)
!35 = !DILocation(line: 50, column: 11, scope: !12)
!36 = !DILocation(line: 50, column: 3, scope: !12)
!37 = !DILocation(line: 52, column: 4, scope: !38)
!38 = distinct !DILexicalBlock(scope: !12, file: !3, line: 50, column: 15)
!39 = !DILocation(line: 53, column: 3, scope: !38)
!40 = distinct !{!40, !29, !41}
!41 = !DILocation(line: 53, column: 3, scope: !12)
!42 = !DILocation(line: 54, column: 10, scope: !12)
!43 = !DILocation(line: 54, column: 7, scope: !12)
!44 = !DILocation(line: 55, column: 10, scope: !12)
!45 = !DILocation(line: 55, column: 7, scope: !12)
!46 = !DILocation(line: 57, column: 6, scope: !47)
!47 = distinct !DILexicalBlock(scope: !12, file: !3, line: 57, column: 6)
!48 = !DILocation(line: 57, column: 11, scope: !47)
!49 = !DILocation(line: 57, column: 6, scope: !12)
!50 = !DILocation(line: 58, column: 3, scope: !47)
!51 = !DILocation(line: 60, column: 7, scope: !52)
!52 = distinct !DILexicalBlock(scope: !12, file: !3, line: 60, column: 6)
!53 = !DILocation(line: 60, column: 6, scope: !52)
!54 = !DILocation(line: 60, column: 6, scope: !12)
!55 = !DILocation(line: 61, column: 22, scope: !56)
!56 = distinct !DILexicalBlock(scope: !57, file: !3, line: 61, column: 7)
!57 = distinct !DILexicalBlock(scope: !52, file: !3, line: 60, column: 13)
!58 = !DILocation(line: 61, column: 21, scope: !56)
!59 = !DILocation(line: 61, column: 36, scope: !56)
!60 = !DILocation(line: 61, column: 35, scope: !56)
!61 = !DILocation(line: 61, column: 28, scope: !56)
!62 = !DILocation(line: 61, column: 7, scope: !56)
!63 = !DILocation(line: 61, column: 7, scope: !57)
!64 = !DILocation(line: 62, column: 4, scope: !56)
!65 = !DILocation(line: 63, column: 2, scope: !57)
!66 = !DILocation(line: 64, column: 21, scope: !67)
!67 = distinct !DILexicalBlock(scope: !68, file: !3, line: 64, column: 7)
!68 = distinct !DILexicalBlock(scope: !52, file: !3, line: 63, column: 9)
!69 = !DILocation(line: 64, column: 7, scope: !67)
!70 = !DILocation(line: 64, column: 7, scope: !68)
!71 = !DILocation(line: 65, column: 4, scope: !67)
!72 = !DILocation(line: 66, column: 24, scope: !68)
!73 = !DILocation(line: 66, column: 9, scope: !68)
!74 = !DILocation(line: 68, column: 2, scope: !12)
!75 = distinct !DISubprogram(name: "usage", scope: !3, file: !3, line: 72, type: !76, isLocal: false, isDefinition: true, scopeLine: 73, flags: DIFlagPrototyped, isOptimized: false, unit: !2, variables: !4)
!76 = !DISubroutineType(types: !77)
!77 = !{null}
!78 = !DILocation(line: 74, column: 16, scope: !75)
!79 = !DILocation(line: 74, column: 56, scope: !75)
!80 = !DILocation(line: 74, column: 8, scope: !75)
!81 = !DILocation(line: 75, column: 2, scope: !75)
!82 = !DILocation(line: 76, column: 1, scope: !75)
