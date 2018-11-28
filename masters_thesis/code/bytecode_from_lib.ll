; ModuleID = 'build/bytecode_from_lib.bc'
source_filename = "c-code/lib.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct._IO_FILE = type { i32, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, i8*, %struct._IO_marker*, %struct._IO_FILE*, i32, i32, i64, i16, i8, [1 x i8], i8*, i64, i8*, i8*, i8*, i8*, i64, i32, [20 x i8] }
%struct._IO_marker = type { %struct._IO_marker*, %struct._IO_FILE*, i32 }

@.str = private unnamed_addr constant [4 x i8] c"%d\0A\00", align 1
@.str.1 = private unnamed_addr constant [9 x i8] c"apex.out\00", align 1
@.str.2 = private unnamed_addr constant [3 x i8] c"w+\00", align 1
@.str.3 = private unnamed_addr constant [32 x i8] c"Error: Could not save to file!\0A\00", align 1

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_exit(i32 %exit_code) #0 !dbg !9 {
entry:
  %exit_code.addr = alloca i32, align 4
  store i32 %exit_code, i32* %exit_code.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %exit_code.addr, metadata !13, metadata !14), !dbg !15
  %0 = load i32, i32* %exit_code.addr, align 4, !dbg !16
  call void @exit(i32 %0) #7, !dbg !17
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
  %i_digits = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %status = alloca i32, align 4
  %f = alloca %struct._IO_FILE*, align 8
  store i32 %i, i32* %i.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %i.addr, metadata !20, metadata !14), !dbg !21
  call void @llvm.dbg.declare(metadata i32* %i_digits, metadata !22, metadata !14), !dbg !23
  store i32 0, i32* %i_digits, align 4, !dbg !23
  %0 = load i32, i32* %i.addr, align 4, !dbg !24
  %cmp = icmp eq i32 %0, 0, !dbg !26
  br i1 %cmp, label %if.then, label %if.else, !dbg !27

if.then:                                          ; preds = %entry
  store i32 1, i32* %i_digits, align 4, !dbg !28
  br label %if.end, !dbg !30

if.else:                                          ; preds = %entry
  %1 = load i32, i32* %i.addr, align 4, !dbg !31
  %call = call i32 @abs(i32 %1) #8, !dbg !33
  %conv = sitofp i32 %call to double, !dbg !33
  %call1 = call double @log10(double %conv) #5, !dbg !34
  %call2 = call double @floor(double %call1) #8, !dbg !35
  %add = fadd double %call2, 1.000000e+00, !dbg !36
  %conv3 = fptosi double %add to i32, !dbg !35
  store i32 %conv3, i32* %i_digits, align 4, !dbg !37
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %2 = load i32, i32* %i_digits, align 4, !dbg !38
  %add4 = add nsw i32 %2, 2, !dbg !39
  %3 = zext i32 %add4 to i64, !dbg !40
  %4 = call i8* @llvm.stacksave(), !dbg !40
  store i8* %4, i8** %saved_stack, align 8, !dbg !40
  %vla = alloca i8, i64 %3, align 16, !dbg !40
  call void @llvm.dbg.declare(metadata i8* %vla, metadata !41, metadata !14), !dbg !46
  %5 = load i32, i32* %i.addr, align 4, !dbg !47
  %call5 = call i32 (i8*, i8*, ...) @sprintf(i8* %vla, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %5) #5, !dbg !48
  call void @llvm.dbg.declare(metadata i32* %status, metadata !49, metadata !14), !dbg !50
  store i32 0, i32* %status, align 4, !dbg !50
  call void @llvm.dbg.declare(metadata %struct._IO_FILE** %f, metadata !51, metadata !14), !dbg !112
  %call6 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0)), !dbg !113
  store %struct._IO_FILE* %call6, %struct._IO_FILE** %f, align 8, !dbg !112
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !114
  %cmp7 = icmp ne %struct._IO_FILE* %6, null, !dbg !116
  br i1 %cmp7, label %if.then9, label %if.end16, !dbg !117

if.then9:                                         ; preds = %if.end
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !118
  %call10 = call i32 @fputs(i8* %vla, %struct._IO_FILE* %7), !dbg !121
  %cmp11 = icmp ne i32 %call10, -1, !dbg !122
  br i1 %cmp11, label %if.then13, label %if.end14, !dbg !123

if.then13:                                        ; preds = %if.then9
  store i32 1, i32* %status, align 4, !dbg !124
  br label %if.end14, !dbg !126

if.end14:                                         ; preds = %if.then13, %if.then9
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8, !dbg !127
  %call15 = call i32 @fclose(%struct._IO_FILE* %8), !dbg !128
  br label %if.end16, !dbg !129

if.end16:                                         ; preds = %if.end14, %if.end
  %9 = load i32, i32* %status, align 4, !dbg !130
  %cmp17 = icmp ne i32 %9, 1, !dbg !132
  br i1 %cmp17, label %if.then19, label %if.end21, !dbg !133

if.then19:                                        ; preds = %if.end16
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.3, i32 0, i32 0)), !dbg !134
  br label %if.end21, !dbg !136

if.end21:                                         ; preds = %if.then19, %if.end16
  %10 = load i8*, i8** %saved_stack, align 8, !dbg !137
  call void @llvm.stackrestore(i8* %10), !dbg !137
  ret void, !dbg !137
}

; Function Attrs: nounwind readnone
declare double @floor(double) #3

; Function Attrs: nounwind
declare double @log10(double) #4

; Function Attrs: nounwind readnone
declare i32 @abs(i32) #3

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

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { noreturn nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { nounwind readnone "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind }
attributes #8 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_500/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "c-code/lib.c", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!2 = !{}
!3 = !{!4}
!4 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_500/final)"}
!9 = distinct !DISubprogram(name: "_apex_exit", scope: !1, file: !1, line: 8, type: !10, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{null, !12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "exit_code", arg: 1, scope: !9, file: !1, line: 8, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 8, column: 21, scope: !9)
!16 = !DILocation(line: 9, column: 8, scope: !9)
!17 = !DILocation(line: 9, column: 3, scope: !9)
!18 = !DILocation(line: 10, column: 1, scope: !9)
!19 = distinct !DISubprogram(name: "_apex_extract_int", scope: !1, file: !1, line: 13, type: !10, isLocal: false, isDefinition: true, scopeLine: 13, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!20 = !DILocalVariable(name: "i", arg: 1, scope: !19, file: !1, line: 13, type: !12)
!21 = !DILocation(line: 13, column: 28, scope: !19)
!22 = !DILocalVariable(name: "i_digits", scope: !19, file: !1, line: 16, type: !12)
!23 = !DILocation(line: 16, column: 7, scope: !19)
!24 = !DILocation(line: 17, column: 7, scope: !25)
!25 = distinct !DILexicalBlock(scope: !19, file: !1, line: 17, column: 7)
!26 = !DILocation(line: 17, column: 9, scope: !25)
!27 = !DILocation(line: 17, column: 7, scope: !19)
!28 = !DILocation(line: 18, column: 14, scope: !29)
!29 = distinct !DILexicalBlock(scope: !25, file: !1, line: 17, column: 15)
!30 = !DILocation(line: 19, column: 3, scope: !29)
!31 = !DILocation(line: 20, column: 32, scope: !32)
!32 = distinct !DILexicalBlock(scope: !25, file: !1, line: 19, column: 10)
!33 = !DILocation(line: 20, column: 28, scope: !32)
!34 = !DILocation(line: 20, column: 22, scope: !32)
!35 = !DILocation(line: 20, column: 16, scope: !32)
!36 = !DILocation(line: 20, column: 36, scope: !32)
!37 = !DILocation(line: 20, column: 14, scope: !32)
!38 = !DILocation(line: 23, column: 17, scope: !19)
!39 = !DILocation(line: 23, column: 25, scope: !19)
!40 = !DILocation(line: 23, column: 3, scope: !19)
!41 = !DILocalVariable(name: "i_string", scope: !19, file: !1, line: 23, type: !42)
!42 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, elements: !44)
!43 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!44 = !{!45}
!45 = !DISubrange(count: -1)
!46 = !DILocation(line: 23, column: 8, scope: !19)
!47 = !DILocation(line: 24, column: 29, scope: !19)
!48 = !DILocation(line: 24, column: 3, scope: !19)
!49 = !DILocalVariable(name: "status", scope: !19, file: !1, line: 27, type: !12)
!50 = !DILocation(line: 27, column: 7, scope: !19)
!51 = !DILocalVariable(name: "f", scope: !19, file: !1, line: 28, type: !52)
!52 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !53, size: 64)
!53 = !DIDerivedType(tag: DW_TAG_typedef, name: "FILE", file: !54, line: 48, baseType: !55)
!54 = !DIFile(filename: "/usr/include/stdio.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!55 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_FILE", file: !56, line: 241, size: 1728, elements: !57)
!56 = !DIFile(filename: "/usr/include/libio.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!57 = !{!58, !59, !61, !62, !63, !64, !65, !66, !67, !68, !69, !70, !71, !79, !80, !81, !82, !86, !88, !90, !94, !97, !99, !100, !101, !102, !103, !107, !108}
!58 = !DIDerivedType(tag: DW_TAG_member, name: "_flags", scope: !55, file: !56, line: 242, baseType: !12, size: 32)
!59 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_ptr", scope: !55, file: !56, line: 247, baseType: !60, size: 64, offset: 64)
!60 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !43, size: 64)
!61 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_end", scope: !55, file: !56, line: 248, baseType: !60, size: 64, offset: 128)
!62 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_read_base", scope: !55, file: !56, line: 249, baseType: !60, size: 64, offset: 192)
!63 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_base", scope: !55, file: !56, line: 250, baseType: !60, size: 64, offset: 256)
!64 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_ptr", scope: !55, file: !56, line: 251, baseType: !60, size: 64, offset: 320)
!65 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_write_end", scope: !55, file: !56, line: 252, baseType: !60, size: 64, offset: 384)
!66 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_base", scope: !55, file: !56, line: 253, baseType: !60, size: 64, offset: 448)
!67 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_buf_end", scope: !55, file: !56, line: 254, baseType: !60, size: 64, offset: 512)
!68 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_base", scope: !55, file: !56, line: 256, baseType: !60, size: 64, offset: 576)
!69 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_backup_base", scope: !55, file: !56, line: 257, baseType: !60, size: 64, offset: 640)
!70 = !DIDerivedType(tag: DW_TAG_member, name: "_IO_save_end", scope: !55, file: !56, line: 258, baseType: !60, size: 64, offset: 704)
!71 = !DIDerivedType(tag: DW_TAG_member, name: "_markers", scope: !55, file: !56, line: 260, baseType: !72, size: 64, offset: 768)
!72 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !73, size: 64)
!73 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "_IO_marker", file: !56, line: 156, size: 192, elements: !74)
!74 = !{!75, !76, !78}
!75 = !DIDerivedType(tag: DW_TAG_member, name: "_next", scope: !73, file: !56, line: 157, baseType: !72, size: 64)
!76 = !DIDerivedType(tag: DW_TAG_member, name: "_sbuf", scope: !73, file: !56, line: 158, baseType: !77, size: 64, offset: 64)
!77 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !55, size: 64)
!78 = !DIDerivedType(tag: DW_TAG_member, name: "_pos", scope: !73, file: !56, line: 162, baseType: !12, size: 32, offset: 128)
!79 = !DIDerivedType(tag: DW_TAG_member, name: "_chain", scope: !55, file: !56, line: 262, baseType: !77, size: 64, offset: 832)
!80 = !DIDerivedType(tag: DW_TAG_member, name: "_fileno", scope: !55, file: !56, line: 264, baseType: !12, size: 32, offset: 896)
!81 = !DIDerivedType(tag: DW_TAG_member, name: "_flags2", scope: !55, file: !56, line: 268, baseType: !12, size: 32, offset: 928)
!82 = !DIDerivedType(tag: DW_TAG_member, name: "_old_offset", scope: !55, file: !56, line: 270, baseType: !83, size: 64, offset: 960)
!83 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off_t", file: !84, line: 131, baseType: !85)
!84 = !DIFile(filename: "/usr/include/bits/types.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!85 = !DIBasicType(name: "long int", size: 64, encoding: DW_ATE_signed)
!86 = !DIDerivedType(tag: DW_TAG_member, name: "_cur_column", scope: !55, file: !56, line: 274, baseType: !87, size: 16, offset: 1024)
!87 = !DIBasicType(name: "unsigned short", size: 16, encoding: DW_ATE_unsigned)
!88 = !DIDerivedType(tag: DW_TAG_member, name: "_vtable_offset", scope: !55, file: !56, line: 275, baseType: !89, size: 8, offset: 1040)
!89 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!90 = !DIDerivedType(tag: DW_TAG_member, name: "_shortbuf", scope: !55, file: !56, line: 276, baseType: !91, size: 8, offset: 1048)
!91 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 8, elements: !92)
!92 = !{!93}
!93 = !DISubrange(count: 1)
!94 = !DIDerivedType(tag: DW_TAG_member, name: "_lock", scope: !55, file: !56, line: 280, baseType: !95, size: 64, offset: 1088)
!95 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !96, size: 64)
!96 = !DIDerivedType(tag: DW_TAG_typedef, name: "_IO_lock_t", file: !56, line: 150, baseType: null)
!97 = !DIDerivedType(tag: DW_TAG_member, name: "_offset", scope: !55, file: !56, line: 289, baseType: !98, size: 64, offset: 1152)
!98 = !DIDerivedType(tag: DW_TAG_typedef, name: "__off64_t", file: !84, line: 132, baseType: !85)
!99 = !DIDerivedType(tag: DW_TAG_member, name: "__pad1", scope: !55, file: !56, line: 297, baseType: !4, size: 64, offset: 1216)
!100 = !DIDerivedType(tag: DW_TAG_member, name: "__pad2", scope: !55, file: !56, line: 298, baseType: !4, size: 64, offset: 1280)
!101 = !DIDerivedType(tag: DW_TAG_member, name: "__pad3", scope: !55, file: !56, line: 299, baseType: !4, size: 64, offset: 1344)
!102 = !DIDerivedType(tag: DW_TAG_member, name: "__pad4", scope: !55, file: !56, line: 300, baseType: !4, size: 64, offset: 1408)
!103 = !DIDerivedType(tag: DW_TAG_member, name: "__pad5", scope: !55, file: !56, line: 302, baseType: !104, size: 64, offset: 1472)
!104 = !DIDerivedType(tag: DW_TAG_typedef, name: "size_t", file: !105, line: 62, baseType: !106)
!105 = !DIFile(filename: "/usr/local/lib/clang/5.0.1/include/stddef.h", directory: "/mnt/Documents/work/university/muni/msc/thesis/APEX")
!106 = !DIBasicType(name: "long unsigned int", size: 64, encoding: DW_ATE_unsigned)
!107 = !DIDerivedType(tag: DW_TAG_member, name: "_mode", scope: !55, file: !56, line: 303, baseType: !12, size: 32, offset: 1536)
!108 = !DIDerivedType(tag: DW_TAG_member, name: "_unused2", scope: !55, file: !56, line: 305, baseType: !109, size: 160, offset: 1568)
!109 = !DICompositeType(tag: DW_TAG_array_type, baseType: !43, size: 160, elements: !110)
!110 = !{!111}
!111 = !DISubrange(count: 20)
!112 = !DILocation(line: 28, column: 9, scope: !19)
!113 = !DILocation(line: 28, column: 13, scope: !19)
!114 = !DILocation(line: 29, column: 7, scope: !115)
!115 = distinct !DILexicalBlock(scope: !19, file: !1, line: 29, column: 7)
!116 = !DILocation(line: 29, column: 9, scope: !115)
!117 = !DILocation(line: 29, column: 7, scope: !19)
!118 = !DILocation(line: 30, column: 25, scope: !119)
!119 = distinct !DILexicalBlock(scope: !120, file: !1, line: 30, column: 9)
!120 = distinct !DILexicalBlock(scope: !115, file: !1, line: 29, column: 18)
!121 = !DILocation(line: 30, column: 9, scope: !119)
!122 = !DILocation(line: 30, column: 28, scope: !119)
!123 = !DILocation(line: 30, column: 9, scope: !120)
!124 = !DILocation(line: 31, column: 14, scope: !125)
!125 = distinct !DILexicalBlock(scope: !119, file: !1, line: 30, column: 36)
!126 = !DILocation(line: 32, column: 5, scope: !125)
!127 = !DILocation(line: 33, column: 12, scope: !120)
!128 = !DILocation(line: 33, column: 5, scope: !120)
!129 = !DILocation(line: 34, column: 3, scope: !120)
!130 = !DILocation(line: 35, column: 7, scope: !131)
!131 = distinct !DILexicalBlock(scope: !19, file: !1, line: 35, column: 7)
!132 = !DILocation(line: 35, column: 14, scope: !131)
!133 = !DILocation(line: 35, column: 7, scope: !19)
!134 = !DILocation(line: 36, column: 5, scope: !135)
!135 = distinct !DILexicalBlock(scope: !131, file: !1, line: 35, column: 20)
!136 = !DILocation(line: 37, column: 3, scope: !135)
!137 = !DILocation(line: 38, column: 1, scope: !19)
