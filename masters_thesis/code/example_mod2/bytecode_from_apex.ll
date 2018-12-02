; ModuleID = 'build/bytecode_from_apex.bc'
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
define void @_apex_exit(i32 %exit_code) #0 {
entry:
  %exit_code.addr = alloca i32, align 4
  store i32 %exit_code, i32* %exit_code.addr, align 4
  %0 = load i32, i32* %exit_code.addr, align 4
  call void @exit(i32 %0) #7
  unreachable

return:                                           ; No predecessors!
  ret void
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noreturn nounwind
declare void @exit(i32) #2

; Function Attrs: noinline nounwind optnone uwtable
define void @_apex_extract_int(i32 %i) #0 {
entry:
  %i.addr = alloca i32, align 4
  %i_digits = alloca i32, align 4
  %saved_stack = alloca i8*, align 8
  %status = alloca i32, align 4
  %f = alloca %struct._IO_FILE*, align 8
  store i32 %i, i32* %i.addr, align 4
  store i32 0, i32* %i_digits, align 4
  %0 = load i32, i32* %i.addr, align 4
  %cmp = icmp eq i32 %0, 0
  br i1 %cmp, label %if.then, label %if.else

if.then:                                          ; preds = %entry
  store i32 1, i32* %i_digits, align 4
  br label %if.end

if.else:                                          ; preds = %entry
  %1 = load i32, i32* %i.addr, align 4
  %call = call i32 @abs(i32 %1) #8
  %conv = sitofp i32 %call to double
  %call1 = call double @log10(double %conv) #5
  %call2 = call double @floor(double %call1) #8
  %add = fadd double %call2, 1.000000e+00
  %conv3 = fptosi double %add to i32
  store i32 %conv3, i32* %i_digits, align 4
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  %2 = load i32, i32* %i_digits, align 4
  %add4 = add nsw i32 %2, 2
  %3 = zext i32 %add4 to i64
  %4 = call i8* @llvm.stacksave()
  store i8* %4, i8** %saved_stack, align 8
  %vla = alloca i8, i64 %3, align 16
  %5 = load i32, i32* %i.addr, align 4
  %call5 = call i32 (i8*, i8*, ...) @sprintf(i8* %vla, i8* getelementptr inbounds ([4 x i8], [4 x i8]* @.str, i32 0, i32 0), i32 %5) #5
  store i32 0, i32* %status, align 4
  %call6 = call %struct._IO_FILE* @fopen(i8* getelementptr inbounds ([9 x i8], [9 x i8]* @.str.1, i32 0, i32 0), i8* getelementptr inbounds ([3 x i8], [3 x i8]* @.str.2, i32 0, i32 0))
  store %struct._IO_FILE* %call6, %struct._IO_FILE** %f, align 8
  %6 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8
  %cmp7 = icmp ne %struct._IO_FILE* %6, null
  br i1 %cmp7, label %if.then9, label %if.end16

if.then9:                                         ; preds = %if.end
  %7 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8
  %call10 = call i32 @fputs(i8* %vla, %struct._IO_FILE* %7)
  %cmp11 = icmp ne i32 %call10, -1
  br i1 %cmp11, label %if.then13, label %if.end14

if.then13:                                        ; preds = %if.then9
  store i32 1, i32* %status, align 4
  br label %if.end14

if.end14:                                         ; preds = %if.then13, %if.then9
  %8 = load %struct._IO_FILE*, %struct._IO_FILE** %f, align 8
  %call15 = call i32 @fclose(%struct._IO_FILE* %8)
  br label %if.end16

if.end16:                                         ; preds = %if.end14, %if.end
  %9 = load i32, i32* %status, align 4
  %cmp17 = icmp ne i32 %9, 1
  br i1 %cmp17, label %if.then19, label %if.end21

if.then19:                                        ; preds = %if.end16
  %call20 = call i32 (i8*, ...) @printf(i8* getelementptr inbounds ([32 x i8], [32 x i8]* @.str.3, i32 0, i32 0))
  br label %if.end21

if.end21:                                         ; preds = %if.then19, %if.end16
  %10 = load i8*, i8** %saved_stack, align 8
  call void @llvm.stackrestore(i8* %10)
  ret void
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
define i32 @qux() #0 {
entry:
  ret i32 42
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @bar() #0 {
entry:
  %y = alloca i32, align 4
  %call = call i32 @qux()
  store i32 %call, i32* %y, align 4
  %_apex_extract_int_arg = load i32, i32* %y
  call void @_apex_extract_int(i32 %_apex_extract_int_arg)
  call void @_apex_exit(i32 0)
  %0 = load i32, i32* %y, align 4
  ret i32 %0
}

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 {
entry:
  %n = alloca i32, align 4
  %bar_result = alloca i32, align 4
  store i32 10, i32* %n, align 4
  %0 = load i32, i32* %n, align 4
  %cmp = icmp slt i32 %0, 42
  br i1 %cmp, label %if.then, label %if.end

if.then:                                          ; preds = %entry
  %call1 = call i32 @bar()
  store i32 %call1, i32* %bar_result, align 4
  br label %if.end

if.end:                                           ; preds = %if.then, %entry
  ret i32 0
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
