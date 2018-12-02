; ModuleID = 'llvm-link'
source_filename = "llvm-link"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"apex.out\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@.str.3 = private unnamed_addr constant [32 x i8] c"Error: Could not save to file!\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_exit(i32 %exit_code) #0 !dbg !11 {
entry:
  %exit_code.addr = alloca i32, align 4
  store i32 %exit_code, i32* %exit_code.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %exit_code.addr, metadata !15, metadata !16), !dbg !17
  %0 = load i32, i32* %exit_code.addr, align 4, !dbg !18
  call void @exit(i32 %0) #7, !dbg !19
  unreachable, !dbg !19

return:                                           ; No predecessors!
  ret void, !dbg !20
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_extract_int(i32 %i) #0 !dbg !21 {
entry:
  %i.addr = alloca i32, align 4
  %i_digits = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %status = alloca i32, align 4
  %f = alloca %struct._IO_FILE*, align 8
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !22, metadata !16), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %i_digits, metadata !24, metadata !16), !dbg !25
  store i32 0, i32* %i_digits, align 4, !dbg !25
  %0 = load i32, i32* %i.addr, align 4, !dbg !26
  %cmp = icmp eq i32 %0, 0, !dbg !28
  br i1 %cmp, label %if.then, label %if.else, !dbg !29

if.then:                                          ; preds = %entry
  store i32 1, i32* %i_digits, align 4, !dbg !30
  br label %if.end, !dbg !32

if.else:                                          ; preds = %entry
  %1 = load i32, i32* %i.addr, align 4, !dbg !33
  %call = call i32 @abs(i32 %1) #8, !dbg !35
  %conv = sitofp i32 %call to double, !dbg !35
  %call1 = call double @log10(double %conv) #5, !dbg !36
  %call2 = call double @floor(double %call1) #8, !dbg !37
  %add = fadd double %call2, 1.000000e+00, !dbg !38
  %conv3 = fptosi double %add to i32, !dbg !37
  store i32 %conv3, i32* %i_digits, align 4, !dbg !39
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %2 = load i32, i32* %i_digits, align 4, !dbg !40
  %add4 = add nsw i32 %2, 2, !dbg !41
  %3 = zext i32 %add4 to i64, !dbg !42
  %4 = call i8* @llvm.stacksave(), !dbg !42
  store i8* %4, i8** %saved_stack, align 8, !dbg !42
  %vla = alloca i8, i64 %3, align 16, !dbg !42
  call void @llvm.dbg.declare(metadata i8* %vla, metadata !43, metadata !16), !dbg !48
  %5 = load i32, i32* %i.addr, align 4, !dbg !49
  %call5 = call i32 (i8*, i8*, ...) @sprintf(i8* %vla, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %5) #5, !dbg !50
  call void @llvm.dbg.declare(metadata i32* %status, metadata !51, metadata !16), !dbg !52
  store i32 0, i32* %status, align 4, !dbg !52
  call void @llvm.dbg.declare(metadata %struct._IO_FILE** %f, metadata !53, metadata !16), !dbg !114
  %call6 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0)), !dbg !115
  store %struct._IO_FILE* %call6, %struct._IO_FILE** %f, align 8, !dbg !114
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !116
  %cmp7 = icmp ne %struct._IO_FILE* %6, null, !dbg !118
  br i1 %cmp7, label %if.then9, label %if.end16, !dbg !119

if.then9:                                         ; preds = %if.end
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !120
  %call10 = call i32 @fputs(i8* %vla, %struct._IO_FILE* %7), !dbg !123
  %cmp11 = icmp ne i32 %call10, -1, !dbg !124
  br i1 %cmp11, label %if.then13, label %if.end14, !dbg !125

if.then13:                                        ; preds = %if.then9
  store i32 1, i32* %status, align 4, !dbg !126
  br label %if.end14, !dbg !128

if.end14:                                         ; preds = %if.then13, %if.then9
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !129
  %call15 = call i32 @fclose(%struct._IO_FILE* %8), !dbg !130
  br label %if.end16, !dbg !131

if.end16:                                         ; preds = %if.end14, %if.end
  %9 = load i32, i32* %status, align 4, !dbg !132
  %cmp17 = icmp ne i32 %9, 1, !dbg !134
  br i1 %cmp17, label %if.then19, label %if.end21, !dbg !135

if.then19:                                        ; preds = %if.end16
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.3, i32 0, i32 0)), !dbg !136
  br label %if.end21, !dbg !138

if.end21:                                         ; preds = %if.then19, %if.end16
  %10 = load i8*, i8** %saved_stack, align 8, !dbg !139
  call void @llvm.stackrestore(i8* %10), !dbg !139
  ret void, !dbg !139
}

; Function Attrs: nounwind readnone
declare i32 @abs(i32) #3

; Function Attrs: nounwind
declare double @log10(double) #4

; Function Attrs: nounwind readnone
declare double @floor(double) #3

; Function Attrs: nounwind
declare i8* @llvm.stacksave() #5

; Function Attrs: nounwind
declare i32 @sprintf(i8*, i8*, ...) #4

declare %struct._IO_FILE* @fopen(i8*, i8*) #6

declare i32 @fputs(i8*, %struct._IO_FILE*) #6

declare i32 @fclose(%struct._IO_FILE*) #6

declare i32 @printf(i8*, ...) #6

; Function Attrs: nounwind
declare void @llvm.stackrestore(i8*) #5

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i32 %n) #0 !dbg !140 {
entry:
  %n.addr = alloca i32, align 4
  %x = alloca i32, align 4
  store i32 %n, i32* %n.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %n.addr, metadata !143, metadata !16), !dbg !144
  call void @llvm.dbg.declare(metadata i32* %x, metadata !145, metadata !16), !dbg !146
  %0 = load i32, i32* %n.addr, align 4, !dbg !147
  %add = add nsw i32 %0, 10, !dbg !148
  store i32 %add, i32* %x, align 4, !dbg !146
  %1 = load i32, i32* %x, align 4, !dbg !149
  ret i32 %1, !dbg !150
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @qux() #0 !dbg !151 {
entry:
  ret i32 42, !dbg !154
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @bar() #0 !dbg !155 {
entry:
  %y = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %y, metadata !156, metadata !16), !dbg !157
  %call = call i32 @qux(), !dbg !158
  store i32 %call, i32* %y, align 4, !dbg !157
  %0 = load i32, i32* %y, align 4, !dbg !159
  ret i32 %0, !dbg !160
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !161 {
entry:
  %retval = alloca i32, align 4
  %some_int = alloca i32, align 4
  %foo_result = alloca i32, align 4
  %n = alloca i32, align 4
  %bar_result = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %some_int, metadata !162, metadata !16), !dbg !163
  store i32 10, i32* %some_int, align 4, !dbg !163
  call void @llvm.dbg.declare(metadata i32* %foo_result, metadata !164, metadata !16), !dbg !165
  %0 = load i32, i32* %some_int, align 4, !dbg !166
  %call = call i32 @foo(i32 %0), !dbg !167
  store i32 %call, i32* %foo_result, align 4, !dbg !165
  call void @llvm.dbg.declare(metadata i32* %n, metadata !168, metadata !16), !dbg !169
  store i32 10, i32* %n, align 4, !dbg !169
  %1 = load i32, i32* %n, align 4, !dbg !170
  %cmp = icmp slt i32 %1, 42, !dbg !172
  br i1 %cmp, label %if.then, label %if.end, !dbg !173

if.then:                                          ; preds = %entry
  call void @llvm.dbg.declare(metadata i32* %bar_result, metadata !174, metadata !16), !dbg !176
  %call1 = call i32 @bar(), !dbg !177
  store i32 %call1, i32* %bar_result, align 4, !dbg !176
  br label %if.end, !dbg !178

if.end:                                           ; preds = %if.then, %entry
  ret i32 0, !dbg !179
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind readnone }

!llvm.dbg.cu = !{!0, !5}
!llvm.ident = !{!7, !7}
!llvm.module.flags = !{!8, !9, !10}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "apex/apexlib.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = distinct !DICompileUnit(language: DW_LANG_C99, file: !6, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!6 = !DIFile(filename: "c-code/example_mod2.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!7 = !{!"clang version 5.0.1 (tags/RELEASE_500/final)"}
!8 = !{i32 2, !"Dwarf Version", i32 4}
!9 = !{i32 2, !"Debug Info Version", i32 3}
!10 = !{i32 1, !"wchar_size", i32 4}
!11 = distinct !DISubprogram(name: "_apex_exit", scope: !1, file: !1, line: 8, type: !12, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!12 = !DISubroutineType(types: !13)
!13 = !{null, !14}
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DILocalVariable(name: "exit_code", arg: 1, scope: !11, file: !1, line: 8, type: !14)
!16 = !DIExpression()
!17 = !DILocation(line: 8, column: 21, scope: !11)
!18 = !DILocation(line: 9, column: 8, scope: !11)
!19 = !DILocation(line: 9, column: 3, scope: !11)
!20 = !DILocation(line: 10, column: 1, scope: !11)
!21 = distinct !DISubprogram(name: "_apex_extract_int", scope: !1, file: !1, line: 13, type: !12, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!22 = !DILocalVariable(name: "i", arg: 1, scope: !21, file: !1, line: 13, type: !14)
!23 = !DILocation(line: 13, column: 28, scope: !21)
!24 = !DILocalVariable(name: "i_digits", scope: !21, file: !1, line: 16, type: !14)
!25 = !DILocation(line: 16, column: 7, scope: !21)
!26 = !DILocation(line: 17, column: 7, scope: !27)
!27 = distinct !DILexicalBlock(scope: !21, file: !1, line: 17, column: 7)
!28 = !DILocation(line: 17, column: 9, scope: !27)
!29 = !DILocation(line: 17, column: 7, scope: !21)
!30 = !DILocation(line: 18, column: 14, scope: !31)
!31 = distinct !DILexicalBlock(scope: !27, file: !1, line: 17, column: 15)
!32 = !DILocation(line: 19, column: 3, scope: !31)
!33 = !DILocation(line: 20, column: 32, scope: !34)
!34 = distinct !DILexicalBlock(scope: !27, file: !1, line: 19, column: 10)
!35 = !DILocation(line: 20, column: 28, scope: !34)
!36 = !DILocation(line: 20, column: 22, scope: !34)
!37 = !DILocation(line: 20, column: 16, scope: !34)
!38 = !DILocation(line: 20, column: 36, scope: !34)
!39 = !DILocation(line: 20, column: 14, scope: !34)
!40 = !DILocation(line: 23, column: 17, scope: !21)
!41 = !DILocation(line: 23, column: 25, scope: !21)
!42 = !DILocation(line: 23, column: 3, scope: !21)
!43 = !DILocalVariable(name: "i_string", scope: !21, file: !1, line: 23, type: !44)
!44 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, elements: !46)
!45 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!46 = !{!47}
!47 = !DISubrange(count: -1)
!48 = !DILocation(line: 23, column: 8, scope: !21)
!49 = !DILocation(line: 24, column: 29, scope: !21)
!50 = !DILocation(line: 24, column: 3, scope: !21)
!51 = !DILocalVariable(name: "status", scope: !21, file: !1, line: 27, type: !14)
!52 = !DILocation(line: 27, column: 7, scope: !21)
!53 = !DILocalVariable(name: "f", scope: !21, file: !1, line: 28, type: !54)
!54 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!55 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !56, line: 48, baseType: !57)
!56 = !DIFile(filename: "/usr/include/stdio.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!57 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !58, line: 241, size: 1728, elements: !59)
!58 = !DIFile(filename: "/usr/include/libio.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!59 = !{!60, !61, !63, !64, !65, !66, !67, !68, !69, !70, !71, !72, !73, !81, !82, !83, !84, !88, !90, !92, !96, !99, !101, !102, !103, !104, !105, !109, !110}
!60 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !57, file: !58, line: 242, baseType: !14, size: 32)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !57, file: !58, line: 247, baseType: !62, size: 64, offset: 64)
!62 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !45, size: 64)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !57, file: !58, line: 248, baseType: !62, size: 64, offset: 128)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !57, file: !58, line: 249, baseType: !62, size: 64, offset: 192)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !57, file: !58, line: 250, baseType: !62, size: 64, offset: 256)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !57, file: !58, line: 251, baseType: !62, size: 64, offset: 320)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !57, file: !58, line: 252, baseType: !62, size: 64, offset: 384)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !57, file: !58, line: 253, baseType: !62, size: 64, offset: 448)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !57, file: !58, line: 254, baseType: !62, size: 64, offset: 512)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !57, file: !58, line: 256, baseType: !62, size: 64, offset: 576)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !57, file: !58, line: 257, baseType: !62, size: 64, offset: 640)
!72 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !57, file: !58, line: 258, baseType: !62, size: 64, offset: 704)
!73 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !57, file: !58, line: 260, baseType: !74, size: 64, offset: 768)
!74 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !75, size: 64)
!75 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !58, line: 156, size: 192, elements: !76)
!76 = !{!77, !78, !80}
!77 = !DIDerivedType(tag: DW_TAG_member, name: "_next", scope: !75, file: !58, line: 157, baseType: !74, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "_sbuf", scope: !75, file: !58, line: 158, baseType: !79, size: 64, offset: 64)
!79 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !57, size: 64)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "_pos", scope: !75, file: !58, line: 162, baseType: !14, size: 32, offset: 128)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !57, file: !58, line: 262, baseType: !79, size: 64, offset: 832)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !57, file: !58, line: 264, baseType: !14, size: 32, offset: 896)
!83 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !57, file: !58, line: 268, baseType: !14, size: 32, offset: 928)
!84 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !57, file: !58, line: 270, baseType: !85, size: 64, offset: 960)
!85 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !86, line: 131, baseType: !87)
!86 = !DIFile(filename: "/usr/include/bits/types.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!87 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !57, file: !58, line: 274, baseType: !89, size: 16, offset: 1024)
!89 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !57, file: !58, line: 275, baseType: !91, size: 8, offset: 1040)
!91 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!92 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !57, file: !58, line: 276, baseType: !93, size: 8, offset: 1048)
!93 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 8, elements: !94)
!94 = !{!95}
!95 = !DISubrange(count: 1)
!96 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !57, file: !58, line: 280, baseType: !97, size: 64, offset: 1088)
!97 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !98, size: 64)
!98 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !58, line: 150, baseType: null)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !57, file: !58, line: 289, baseType: !100, size: 64, offset: 1152)
!100 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !86, line: 132, baseType: !87)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !57, file: !58, line: 297, baseType: !4, size: 64, offset: 1216)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !57, file: !58, line: 298, baseType: !4, size: 64, offset: 1280)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "__pad3", scope: !57, file: !58, line: 299, baseType: !4, size: 64, offset: 1344)
!104 = !DIDerivedType(tag: DW_TAG_member, name: "__pad4", scope: !57, file: !58, line: 300, baseType: !4, size: 64, offset: 1408)
!105 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !57, file: !58, line: 302, baseType: !106, size: 64, offset: 1472)
!106 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !107, line: 62, baseType: !108)
!107 = !DIFile(filename: "/usr/local/lib/clang/5.0.1/include/stddef.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX/src")
!108 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!109 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !57, file: !58, line: 303, baseType: !14, size: 32, offset: 1536)
!110 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !57, file: !58, line: 305, baseType: !111, size: 160, offset: 1568)
!111 = !DICompositeType(tag: DW_TAG_array_type, baseType: !45, size: 160, elements: !112)
!112 = !{!113}
!113 = !DISubrange(count: 20)
!114 = !DILocation(line: 28, column: 9, scope: !21)
!115 = !DILocation(line: 28, column: 13, scope: !21)
!116 = !DILocation(line: 29, column: 7, scope: !117)
!117 = distinct !DILexicalBlock(scope: !21, file: !1, line: 29, column: 7)
!118 = !DILocation(line: 29, column: 9, scope: !117)
!119 = !DILocation(line: 29, column: 7, scope: !21)
!120 = !DILocation(line: 30, column: 25, scope: !121)
!121 = distinct !DILexicalBlock(scope: !122, file: !1, line: 30, column: 9)
!122 = distinct !DILexicalBlock(scope: !117, file: !1, line: 29, column: 18)
!123 = !DILocation(line: 30, column: 9, scope: !121)
!124 = !DILocation(line: 30, column: 28, scope: !121)
!125 = !DILocation(line: 30, column: 9, scope: !122)
!126 = !DILocation(line: 31, column: 14, scope: !127)
!127 = distinct !DILexicalBlock(scope: !121, file: !1, line: 30, column: 36)
!128 = !DILocation(line: 32, column: 5, scope: !127)
!129 = !DILocation(line: 33, column: 12, scope: !122)
!130 = !DILocation(line: 33, column: 5, scope: !122)
!131 = !DILocation(line: 34, column: 3, scope: !122)
!132 = !DILocation(line: 35, column: 7, scope: !133)
!133 = distinct !DILexicalBlock(scope: !21, file: !1, line: 35, column: 7)
!134 = !DILocation(line: 35, column: 14, scope: !133)
!135 = !DILocation(line: 35, column: 7, scope: !21)
!136 = !DILocation(line: 36, column: 5, scope: !137)
!137 = distinct !DILexicalBlock(scope: !133, file: !1, line: 35, column: 20)
!138 = !DILocation(line: 37, column: 3, scope: !137)
!139 = !DILocation(line: 38, column: 1, scope: !21)
!140 = distinct !DISubprogram(name: "foo", scope: !6, file: !6, line: 1, type: !141, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !5, variables: !2)
!141 = !DISubroutineType(types: !142)
!142 = !{!14, !14}
!143 = !DILocalVariable(name: "n", arg: 1, scope: !140, file: !6, line: 1, type: !14)
!144 = !DILocation(line: 1, column: 13, scope: !140)
!145 = !DILocalVariable(name: "x", scope: !140, file: !6, line: 2, type: !14)
!146 = !DILocation(line: 2, column: 9, scope: !140)
!147 = !DILocation(line: 2, column: 13, scope: !140)
!148 = !DILocation(line: 2, column: 15, scope: !140)
!149 = !DILocation(line: 3, column: 12, scope: !140)
!150 = !DILocation(line: 3, column: 5, scope: !140)
!151 = distinct !DISubprogram(name: "qux", scope: !6, file: !6, line: 6, type: !152, isLocal: false, isDefinition: true, scopeLine: 6, flags: DIFlagPrototyped, isOptimized: false, unit: !5, variables: !2)
!152 = !DISubroutineType(types: !153)
!153 = !{!14}
!154 = !DILocation(line: 7, column: 2, scope: !151)
!155 = distinct !DISubprogram(name: "bar", scope: !6, file: !6, line: 10, type: !152, isLocal: false, isDefinition: true, scopeLine: 10, flags: DIFlagPrototyped, isOptimized: false, unit: !5, variables: !2)
!156 = !DILocalVariable(name: "y", scope: !155, file: !6, line: 11, type: !14)
!157 = !DILocation(line: 11, column: 9, scope: !155)
!158 = !DILocation(line: 11, column: 13, scope: !155)
!159 = !DILocation(line: 12, column: 12, scope: !155)
!160 = !DILocation(line: 12, column: 5, scope: !155)
!161 = distinct !DISubprogram(name: "main", scope: !6, file: !6, line: 15, type: !152, isLocal: false, isDefinition: true, scopeLine: 15, flags: DIFlagPrototyped, isOptimized: false, unit: !5, variables: !2)
!162 = !DILocalVariable(name: "some_int", scope: !161, file: !6, line: 16, type: !14)
!163 = !DILocation(line: 16, column: 7, scope: !161)
!164 = !DILocalVariable(name: "foo_result", scope: !161, file: !6, line: 17, type: !14)
!165 = !DILocation(line: 17, column: 7, scope: !161)
!166 = !DILocation(line: 17, column: 24, scope: !161)
!167 = !DILocation(line: 17, column: 20, scope: !161)
!168 = !DILocalVariable(name: "n", scope: !161, file: !6, line: 18, type: !14)
!169 = !DILocation(line: 18, column: 7, scope: !161)
!170 = !DILocation(line: 19, column: 7, scope: !171)
!171 = distinct !DILexicalBlock(scope: !161, file: !6, line: 19, column: 7)
!172 = !DILocation(line: 19, column: 9, scope: !171)
!173 = !DILocation(line: 19, column: 7, scope: !161)
!174 = !DILocalVariable(name: "bar_result", scope: !175, file: !6, line: 20, type: !14)
!175 = distinct !DILexicalBlock(scope: !171, file: !6, line: 19, column: 15)
!176 = !DILocation(line: 20, column: 7, scope: !175)
!177 = !DILocation(line: 20, column: 20, scope: !175)
!178 = !DILocation(line: 21, column: 2, scope: !175)
!179 = !DILocation(line: 22, column: 5, scope: !161)
