; ModuleID = 'abort.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

; Function Attrs: noreturn nounwind ssp uwtable
define void @abort() #0 {
  tail call void @klee_abort() #2, !dbg !12
  unreachable, !dbg !12
}

; Function Attrs: noreturn
declare void @klee_abort() #1

attributes #0 = { noreturn nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #2 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!9, !10}
!llvm.ident = !{!11}

!0 = metadata !{i32 786449, metadata !1, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc//home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc/abort.c] [DW_LANG_C89]
!1 = metadata !{metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc/abort.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4}
!4 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"abort", metadata !"abort", metadata !"", i32 14, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void ()* @abort, null, null, metadata !2, i32 14} ; [ DW_TAG_subprogram ] [line 14] [def] [abort]
!5 = metadata !{metadata !"abort.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc"}
!6 = metadata !{i32 786473, metadata !5}          ; [ DW_TAG_file_type ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/klee-libc/abort.c]
!7 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null}
!9 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!10 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!11 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!12 = metadata !{i32 15, i32 0, metadata !4, null}
