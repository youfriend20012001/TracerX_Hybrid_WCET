; ModuleID = 'klee_init_env.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

@.str = private unnamed_addr constant [7 x i8] c"--help\00", align 1
@.str1 = private unnamed_addr constant [593 x i8] c"klee_init_env\0A\0Ausage: (klee_init_env) [options] [program arguments]\0A  -sym-arg <N>              - Replace by a symbolic argument with length N\0A  -sym-args <MIN> <MAX> <N> - Replace by at least MIN arguments and at most\0A                              MAX arguments, each with maximum length N\0A  -sym-files <NUM> <N>      - Make stdin and up to NUM symbolic files, each\0A                              with maximum size N.\0A  -sym-stdout               - Make stdout symbolic.\0A  -max-fail <N>             - Allow up to <N> injected failures\0A  -fd-fail                  - Shortcut for '-max-fail 1'\0A\0A\00", align 1
@.str2 = private unnamed_addr constant [10 x i8] c"--sym-arg\00", align 1
@.str3 = private unnamed_addr constant [9 x i8] c"-sym-arg\00", align 1
@.str4 = private unnamed_addr constant [48 x i8] c"--sym-arg expects an integer argument <max-len>\00", align 1
@.str5 = private unnamed_addr constant [11 x i8] c"--sym-args\00", align 1
@.str6 = private unnamed_addr constant [10 x i8] c"-sym-args\00", align 1
@.str7 = private unnamed_addr constant [77 x i8] c"--sym-args expects three integer arguments <min-argvs> <max-argvs> <max-len>\00", align 1
@.str8 = private unnamed_addr constant [7 x i8] c"n_args\00", align 1
@.str9 = private unnamed_addr constant [12 x i8] c"--sym-files\00", align 1
@.str10 = private unnamed_addr constant [11 x i8] c"-sym-files\00", align 1
@.str11 = private unnamed_addr constant [72 x i8] c"--sym-files expects two integer arguments <no-sym-files> <sym-file-len>\00", align 1
@.str12 = private unnamed_addr constant [13 x i8] c"--sym-stdout\00", align 1
@.str13 = private unnamed_addr constant [12 x i8] c"-sym-stdout\00", align 1
@.str14 = private unnamed_addr constant [18 x i8] c"--save-all-writes\00", align 1
@.str15 = private unnamed_addr constant [17 x i8] c"-save-all-writes\00", align 1
@.str16 = private unnamed_addr constant [10 x i8] c"--fd-fail\00", align 1
@.str17 = private unnamed_addr constant [9 x i8] c"-fd-fail\00", align 1
@.str18 = private unnamed_addr constant [11 x i8] c"--max-fail\00", align 1
@.str19 = private unnamed_addr constant [10 x i8] c"-max-fail\00", align 1
@.str20 = private unnamed_addr constant [54 x i8] c"--max-fail expects an integer argument <max-failures>\00", align 1
@.str21 = private unnamed_addr constant [37 x i8] c"too many arguments for klee_init_env\00", align 1
@.str22 = private unnamed_addr constant [16 x i8] c"klee_init_env.c\00", align 1
@.str23 = private unnamed_addr constant [9 x i8] c"user.err\00", align 1

; Function Attrs: nounwind ssp uwtable
define void @klee_init_env(i32* nocapture %argcPtr, i8*** nocapture %argvPtr) #0 {
  %new_argv = alloca [1024 x i8*], align 16
  %sym_arg_name = alloca [5 x i8], align 4
  call void @llvm.dbg.value(metadata !{i32* %argcPtr}, i64 0, metadata !16), !dbg !105
  call void @llvm.dbg.value(metadata !{i8*** %argvPtr}, i64 0, metadata !17), !dbg !105
  %1 = load i32* %argcPtr, align 4, !dbg !106, !tbaa !107
  call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !18), !dbg !106
  %2 = load i8*** %argvPtr, align 8, !dbg !111, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8** %2}, i64 0, metadata !19), !dbg !111
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !20), !dbg !114
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !20), !dbg !115
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !20), !dbg !116
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !20), !dbg !117
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !20), !dbg !118
  %3 = bitcast [1024 x i8*]* %new_argv to i8*, !dbg !119
  call void @llvm.lifetime.start(i64 8192, i8* %3) #2, !dbg !119
  call void @llvm.dbg.declare(metadata !{[1024 x i8*]* %new_argv}, metadata !22), !dbg !119
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !30), !dbg !120
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !31), !dbg !120
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !32), !dbg !121
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !33), !dbg !122
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !34), !dbg !123
  call void @llvm.dbg.declare(metadata !{[5 x i8]* %sym_arg_name}, metadata !36), !dbg !124
  %4 = getelementptr inbounds [5 x i8]* %sym_arg_name, i64 0, i64 0, !dbg !124
  %5 = bitcast [5 x i8]* %sym_arg_name to i32*, !dbg !124
  store i32 6779489, i32* %5, align 4, !dbg !124
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !40), !dbg !125
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !41), !dbg !126
  %6 = getelementptr inbounds [5 x i8]* %sym_arg_name, i64 0, i64 4, !dbg !127
  store i8 0, i8* %6, align 4, !dbg !127, !tbaa !128
  %7 = icmp eq i32 %1, 2, !dbg !129
  br i1 %7, label %8, label %__streq.exit.thread.preheader, !dbg !129

; <label>:8                                       ; preds = %0
  %9 = getelementptr inbounds i8** %2, i64 1, !dbg !129
  %10 = load i8** %9, align 8, !dbg !129, !tbaa !112
  tail call void @llvm.dbg.value(metadata !{i8* %10}, i64 0, metadata !131), !dbg !132
  tail call void @llvm.dbg.value(metadata !133, i64 0, metadata !134), !dbg !132
  %11 = load i8* %10, align 1, !dbg !135, !tbaa !128
  %12 = icmp eq i8 %11, 45, !dbg !135
  br i1 %12, label %.lr.ph.i, label %.lr.ph331, !dbg !135

.lr.ph.i:                                         ; preds = %8, %15
  %13 = phi i8 [ %18, %15 ], [ 45, %8 ]
  %.04.i = phi i8* [ %17, %15 ], [ getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0), %8 ]
  %.013.i = phi i8* [ %16, %15 ], [ %10, %8 ]
  %14 = icmp eq i8 %13, 0, !dbg !136
  br i1 %14, label %23, label %15, !dbg !136

; <label>:15                                      ; preds = %.lr.ph.i
  %16 = getelementptr inbounds i8* %.013.i, i64 1, !dbg !139
  tail call void @llvm.dbg.value(metadata !{i8* %16}, i64 0, metadata !131), !dbg !139
  %17 = getelementptr inbounds i8* %.04.i, i64 1, !dbg !140
  tail call void @llvm.dbg.value(metadata !{i8* %17}, i64 0, metadata !134), !dbg !140
  %18 = load i8* %16, align 1, !dbg !135, !tbaa !128
  %19 = load i8* %17, align 1, !dbg !135, !tbaa !128
  %20 = icmp eq i8 %18, %19, !dbg !135
  br i1 %20, label %.lr.ph.i, label %__streq.exit.thread.preheader, !dbg !135

__streq.exit.thread.preheader:                    ; preds = %15, %0
  %21 = icmp sgt i32 %1, 0, !dbg !141
  br i1 %21, label %.lr.ph331, label %__streq.exit.thread._crit_edge, !dbg !141

.lr.ph331:                                        ; preds = %8, %__streq.exit.thread.preheader
  %22 = getelementptr inbounds [5 x i8]* %sym_arg_name, i64 0, i64 3, !dbg !142
  br label %24, !dbg !141

; <label>:23                                      ; preds = %.lr.ph.i
  call fastcc void @__emit_error(i8* getelementptr inbounds ([593 x i8]* @.str1, i64 0, i64 0)), !dbg !143
  unreachable

; <label>:24                                      ; preds = %.lr.ph331, %__streq.exit.thread.backedge
  %sym_files.0324 = phi i32 [ 0, %.lr.ph331 ], [ %sym_files.0.be, %__streq.exit.thread.backedge ]
  %sym_file_len.0317 = phi i32 [ 0, %.lr.ph331 ], [ %sym_file_len.0.be, %__streq.exit.thread.backedge ]
  %sym_stdout_flag.0310 = phi i32 [ 0, %.lr.ph331 ], [ %sym_stdout_flag.0.be, %__streq.exit.thread.backedge ]
  %k.0302 = phi i32 [ 0, %.lr.ph331 ], [ %k.0.be, %__streq.exit.thread.backedge ]
  %sym_arg_num.0294 = phi i32 [ 0, %.lr.ph331 ], [ %sym_arg_num.0.be, %__streq.exit.thread.backedge ]
  %save_all_writes_flag.0287 = phi i32 [ 0, %.lr.ph331 ], [ %save_all_writes_flag.0.be, %__streq.exit.thread.backedge ]
  %fd_fail.0281 = phi i32 [ 0, %.lr.ph331 ], [ %fd_fail.0.be, %__streq.exit.thread.backedge ]
  %25 = phi i32 [ 0, %.lr.ph331 ], [ %.be, %__streq.exit.thread.backedge ]
  %26 = sext i32 %k.0302 to i64, !dbg !145
  %27 = getelementptr inbounds i8** %2, i64 %26, !dbg !145
  %28 = load i8** %27, align 8, !dbg !145, !tbaa !112
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !146), !dbg !147
  tail call void @llvm.dbg.value(metadata !148, i64 0, metadata !149), !dbg !147
  %29 = load i8* %28, align 1, !dbg !150, !tbaa !128
  %30 = icmp eq i8 %29, 45, !dbg !150
  br i1 %30, label %.lr.ph.i6, label %.loopexit141, !dbg !150

.lr.ph.i6:                                        ; preds = %24, %33
  %31 = phi i8 [ %36, %33 ], [ 45, %24 ]
  %.04.i4 = phi i8* [ %35, %33 ], [ getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0), %24 ]
  %.013.i5 = phi i8* [ %34, %33 ], [ %28, %24 ]
  %32 = icmp eq i8 %31, 0, !dbg !151
  br i1 %32, label %__streq.exit8.thread108, label %33, !dbg !151

; <label>:33                                      ; preds = %.lr.ph.i6
  %34 = getelementptr inbounds i8* %.013.i5, i64 1, !dbg !152
  tail call void @llvm.dbg.value(metadata !{i8* %34}, i64 0, metadata !146), !dbg !152
  %35 = getelementptr inbounds i8* %.04.i4, i64 1, !dbg !153
  tail call void @llvm.dbg.value(metadata !{i8* %35}, i64 0, metadata !149), !dbg !153
  %36 = load i8* %34, align 1, !dbg !150, !tbaa !128
  %37 = load i8* %35, align 1, !dbg !150, !tbaa !128
  %38 = icmp eq i8 %36, %37, !dbg !150
  br i1 %38, label %.lr.ph.i6, label %.loopexit, !dbg !150

.loopexit:                                        ; preds = %33
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !146), !dbg !147
  tail call void @llvm.dbg.value(metadata !154, i64 0, metadata !149), !dbg !147
  br i1 %30, label %.lr.ph.i12, label %.loopexit141, !dbg !150

.lr.ph.i12:                                       ; preds = %.loopexit, %41
  %39 = phi i8 [ %44, %41 ], [ 45, %.loopexit ]
  %.04.i10 = phi i8* [ %43, %41 ], [ getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0), %.loopexit ]
  %.013.i11 = phi i8* [ %42, %41 ], [ %28, %.loopexit ]
  %40 = icmp eq i8 %39, 0, !dbg !151
  br i1 %40, label %__streq.exit8.thread108, label %41, !dbg !151

; <label>:41                                      ; preds = %.lr.ph.i12
  %42 = getelementptr inbounds i8* %.013.i11, i64 1, !dbg !152
  tail call void @llvm.dbg.value(metadata !{i8* %42}, i64 0, metadata !146), !dbg !152
  %43 = getelementptr inbounds i8* %.04.i10, i64 1, !dbg !153
  tail call void @llvm.dbg.value(metadata !{i8* %43}, i64 0, metadata !149), !dbg !153
  %44 = load i8* %42, align 1, !dbg !150, !tbaa !128
  %45 = load i8* %43, align 1, !dbg !150, !tbaa !128
  %46 = icmp eq i8 %44, %45, !dbg !150
  br i1 %46, label %.lr.ph.i12, label %.loopexit123, !dbg !150

__streq.exit8.thread108:                          ; preds = %.lr.ph.i12, %.lr.ph.i6
  call void @llvm.dbg.value(metadata !155, i64 0, metadata !43), !dbg !156
  %47 = add nsw i32 %k.0302, 1, !dbg !157
  call void @llvm.dbg.value(metadata !{i32 %47}, i64 0, metadata !41), !dbg !157
  %48 = icmp eq i32 %47, %1, !dbg !157
  br i1 %48, label %49, label %50, !dbg !157

; <label>:49                                      ; preds = %__streq.exit8.thread108
  call fastcc void @__emit_error(i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0)), !dbg !159
  unreachable

; <label>:50                                      ; preds = %__streq.exit8.thread108
  %51 = add nsw i32 %k.0302, 2, !dbg !160
  call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !41), !dbg !160
  %52 = sext i32 %47 to i64, !dbg !160
  %53 = getelementptr inbounds i8** %2, i64 %52, !dbg !160
  %54 = load i8** %53, align 8, !dbg !160, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !161) #2, !dbg !162
  call void @llvm.dbg.value(metadata !163, i64 0, metadata !164) #2, !dbg !162
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !166) #2, !dbg !167
  %55 = load i8* %54, align 1, !dbg !168, !tbaa !128
  %56 = icmp eq i8 %55, 0, !dbg !168
  br i1 %56, label %57, label %.lr.ph.i18, !dbg !168

; <label>:57                                      ; preds = %50
  call fastcc void @__emit_error(i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0)) #2, !dbg !168
  unreachable

.lr.ph.i18:                                       ; preds = %50, %61
  %58 = phi i8 [ %66, %61 ], [ %55, %50 ]
  %s.pn.i15 = phi i8* [ %59, %61 ], [ %54, %50 ]
  %res.02.i16 = phi i64 [ %65, %61 ], [ 0, %50 ]
  %59 = getelementptr inbounds i8* %s.pn.i15, i64 1, !dbg !170
  %.off.i17 = add i8 %58, -48, !dbg !171
  %60 = icmp ult i8 %.off.i17, 10, !dbg !171
  br i1 %60, label %61, label %68, !dbg !171

; <label>:61                                      ; preds = %.lr.ph.i18
  %62 = sext i8 %58 to i64, !dbg !175
  %63 = mul nsw i64 %res.02.i16, 10, !dbg !176
  %64 = add i64 %62, -48, !dbg !176
  %65 = add i64 %64, %63, !dbg !176
  call void @llvm.dbg.value(metadata !{i64 %65}, i64 0, metadata !166) #2, !dbg !176
  call void @llvm.dbg.value(metadata !{i8* %59}, i64 0, metadata !161) #2, !dbg !170
  %66 = load i8* %59, align 1, !dbg !170, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %58}, i64 0, metadata !178) #2, !dbg !170
  %67 = icmp eq i8 %66, 0, !dbg !170
  br i1 %67, label %__str_to_int.exit19, label %.lr.ph.i18, !dbg !170

; <label>:68                                      ; preds = %.lr.ph.i18
  call fastcc void @__emit_error(i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0)) #2, !dbg !179
  unreachable

__str_to_int.exit19:                              ; preds = %61
  %69 = trunc i64 %65 to i32, !dbg !160
  call void @llvm.dbg.value(metadata !{i32 %69}, i64 0, metadata !26), !dbg !160
  call void @llvm.dbg.value(metadata !{i32 %75}, i64 0, metadata !40), !dbg !142
  %70 = add i32 %sym_arg_num.0294, 48, !dbg !142
  %71 = trunc i32 %70 to i8, !dbg !142
  store i8 %71, i8* %22, align 1, !dbg !142, !tbaa !128
  %72 = call fastcc i8* @__get_sym_str(i32 %69, i8* %4), !dbg !181
  call void @llvm.dbg.value(metadata !182, i64 0, metadata !183) #2, !dbg !185
  %73 = icmp eq i32 %25, 1024, !dbg !186
  br i1 %73, label %74, label %__add_arg.exit20, !dbg !186

; <label>:74                                      ; preds = %__str_to_int.exit19
  call fastcc void @__emit_error(i8* getelementptr inbounds ([37 x i8]* @.str21, i64 0, i64 0)) #2, !dbg !188
  unreachable

__add_arg.exit20:                                 ; preds = %__str_to_int.exit19
  %75 = add i32 %sym_arg_num.0294, 1, !dbg !142
  %76 = sext i32 %25 to i64, !dbg !190
  %77 = getelementptr inbounds [1024 x i8*]* %new_argv, i64 0, i64 %76, !dbg !190
  store i8* %72, i8** %77, align 8, !dbg !190, !tbaa !112
  %78 = add nsw i32 %25, 1, !dbg !192
  call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !20), !dbg !192
  call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !20), !dbg !115
  call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !20), !dbg !116
  call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !20), !dbg !117
  call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !20), !dbg !118
  br label %__streq.exit.thread.backedge, !dbg !193

.loopexit123:                                     ; preds = %41
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !194), !dbg !196
  tail call void @llvm.dbg.value(metadata !197, i64 0, metadata !198), !dbg !196
  br i1 %30, label %.lr.ph.i23, label %.loopexit141, !dbg !199

.lr.ph.i23:                                       ; preds = %.loopexit123, %81
  %79 = phi i8 [ %84, %81 ], [ 45, %.loopexit123 ]
  %.04.i21 = phi i8* [ %83, %81 ], [ getelementptr inbounds ([11 x i8]* @.str5, i64 0, i64 0), %.loopexit123 ]
  %.013.i22 = phi i8* [ %82, %81 ], [ %28, %.loopexit123 ]
  %80 = icmp eq i8 %79, 0, !dbg !200
  br i1 %80, label %__streq.exit25.thread110, label %81, !dbg !200

; <label>:81                                      ; preds = %.lr.ph.i23
  %82 = getelementptr inbounds i8* %.013.i22, i64 1, !dbg !201
  tail call void @llvm.dbg.value(metadata !{i8* %82}, i64 0, metadata !194), !dbg !201
  %83 = getelementptr inbounds i8* %.04.i21, i64 1, !dbg !202
  tail call void @llvm.dbg.value(metadata !{i8* %83}, i64 0, metadata !198), !dbg !202
  %84 = load i8* %82, align 1, !dbg !199, !tbaa !128
  %85 = load i8* %83, align 1, !dbg !199, !tbaa !128
  %86 = icmp eq i8 %84, %85, !dbg !199
  br i1 %86, label %.lr.ph.i23, label %.loopexit124, !dbg !199

.loopexit124:                                     ; preds = %81
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !194), !dbg !196
  tail call void @llvm.dbg.value(metadata !203, i64 0, metadata !198), !dbg !196
  br i1 %30, label %.lr.ph.i28, label %.loopexit141, !dbg !199

.lr.ph.i28:                                       ; preds = %.loopexit124, %89
  %87 = phi i8 [ %92, %89 ], [ 45, %.loopexit124 ]
  %.04.i26 = phi i8* [ %91, %89 ], [ getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0), %.loopexit124 ]
  %.013.i27 = phi i8* [ %90, %89 ], [ %28, %.loopexit124 ]
  %88 = icmp eq i8 %87, 0, !dbg !200
  br i1 %88, label %__streq.exit25.thread110, label %89, !dbg !200

; <label>:89                                      ; preds = %.lr.ph.i28
  %90 = getelementptr inbounds i8* %.013.i27, i64 1, !dbg !201
  tail call void @llvm.dbg.value(metadata !{i8* %90}, i64 0, metadata !194), !dbg !201
  %91 = getelementptr inbounds i8* %.04.i26, i64 1, !dbg !202
  tail call void @llvm.dbg.value(metadata !{i8* %91}, i64 0, metadata !198), !dbg !202
  %92 = load i8* %90, align 1, !dbg !199, !tbaa !128
  %93 = load i8* %91, align 1, !dbg !199, !tbaa !128
  %94 = icmp eq i8 %92, %93, !dbg !199
  br i1 %94, label %.lr.ph.i28, label %.loopexit126, !dbg !199

__streq.exit25.thread110:                         ; preds = %.lr.ph.i28, %.lr.ph.i23
  call void @llvm.dbg.value(metadata !204, i64 0, metadata !49), !dbg !205
  %95 = add nsw i32 %k.0302, 3, !dbg !206
  %96 = icmp slt i32 %95, %1, !dbg !206
  br i1 %96, label %98, label %97, !dbg !206

; <label>:97                                      ; preds = %__streq.exit25.thread110
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)), !dbg !208
  unreachable

; <label>:98                                      ; preds = %__streq.exit25.thread110
  %99 = add nsw i32 %k.0302, 1, !dbg !209
  call void @llvm.dbg.value(metadata !{i32 %99}, i64 0, metadata !41), !dbg !209
  %100 = add nsw i32 %k.0302, 2, !dbg !210
  call void @llvm.dbg.value(metadata !{i32 %100}, i64 0, metadata !41), !dbg !210
  %101 = sext i32 %99 to i64, !dbg !210
  %102 = getelementptr inbounds i8** %2, i64 %101, !dbg !210
  %103 = load i8** %102, align 8, !dbg !210, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %103}, i64 0, metadata !211) #2, !dbg !212
  call void @llvm.dbg.value(metadata !213, i64 0, metadata !214) #2, !dbg !212
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !215) #2, !dbg !216
  %104 = load i8* %103, align 1, !dbg !217, !tbaa !128
  %105 = icmp eq i8 %104, 0, !dbg !217
  br i1 %105, label %106, label %.lr.ph.i34, !dbg !217

; <label>:106                                     ; preds = %98
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !217
  unreachable

.lr.ph.i34:                                       ; preds = %98, %110
  %107 = phi i8 [ %115, %110 ], [ %104, %98 ]
  %s.pn.i31 = phi i8* [ %108, %110 ], [ %103, %98 ]
  %res.02.i32 = phi i64 [ %114, %110 ], [ 0, %98 ]
  %108 = getelementptr inbounds i8* %s.pn.i31, i64 1, !dbg !218
  %.off.i33 = add i8 %107, -48, !dbg !219
  %109 = icmp ult i8 %.off.i33, 10, !dbg !219
  br i1 %109, label %110, label %117, !dbg !219

; <label>:110                                     ; preds = %.lr.ph.i34
  %111 = sext i8 %107 to i64, !dbg !220
  %112 = mul nsw i64 %res.02.i32, 10, !dbg !221
  %113 = add i64 %111, -48, !dbg !221
  %114 = add i64 %113, %112, !dbg !221
  call void @llvm.dbg.value(metadata !{i64 %114}, i64 0, metadata !215) #2, !dbg !221
  call void @llvm.dbg.value(metadata !{i8* %108}, i64 0, metadata !211) #2, !dbg !218
  %115 = load i8* %108, align 1, !dbg !218, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %107}, i64 0, metadata !222) #2, !dbg !218
  %116 = icmp eq i8 %115, 0, !dbg !218
  br i1 %116, label %__str_to_int.exit35, label %.lr.ph.i34, !dbg !218

; <label>:117                                     ; preds = %.lr.ph.i34
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !223
  unreachable

__str_to_int.exit35:                              ; preds = %110
  %118 = trunc i64 %114 to i32, !dbg !210
  call void @llvm.dbg.value(metadata !{i32 %118}, i64 0, metadata !28), !dbg !210
  call void @llvm.dbg.value(metadata !{i32 %95}, i64 0, metadata !41), !dbg !224
  %119 = sext i32 %100 to i64, !dbg !224
  %120 = getelementptr inbounds i8** %2, i64 %119, !dbg !224
  %121 = load i8** %120, align 8, !dbg !224, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %121}, i64 0, metadata !225) #2, !dbg !226
  call void @llvm.dbg.value(metadata !213, i64 0, metadata !227) #2, !dbg !226
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !228) #2, !dbg !229
  %122 = load i8* %121, align 1, !dbg !230, !tbaa !128
  %123 = icmp eq i8 %122, 0, !dbg !230
  br i1 %123, label %124, label %.lr.ph.i39, !dbg !230

; <label>:124                                     ; preds = %__str_to_int.exit35
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !230
  unreachable

.lr.ph.i39:                                       ; preds = %__str_to_int.exit35, %128
  %125 = phi i8 [ %133, %128 ], [ %122, %__str_to_int.exit35 ]
  %s.pn.i36 = phi i8* [ %126, %128 ], [ %121, %__str_to_int.exit35 ]
  %res.02.i37 = phi i64 [ %132, %128 ], [ 0, %__str_to_int.exit35 ]
  %126 = getelementptr inbounds i8* %s.pn.i36, i64 1, !dbg !231
  %.off.i38 = add i8 %125, -48, !dbg !232
  %127 = icmp ult i8 %.off.i38, 10, !dbg !232
  br i1 %127, label %128, label %135, !dbg !232

; <label>:128                                     ; preds = %.lr.ph.i39
  %129 = sext i8 %125 to i64, !dbg !233
  %130 = mul nsw i64 %res.02.i37, 10, !dbg !234
  %131 = add i64 %129, -48, !dbg !234
  %132 = add i64 %131, %130, !dbg !234
  call void @llvm.dbg.value(metadata !{i64 %132}, i64 0, metadata !228) #2, !dbg !234
  call void @llvm.dbg.value(metadata !{i8* %126}, i64 0, metadata !225) #2, !dbg !231
  %133 = load i8* %126, align 1, !dbg !231, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %125}, i64 0, metadata !235) #2, !dbg !231
  %134 = icmp eq i8 %133, 0, !dbg !231
  br i1 %134, label %__str_to_int.exit40, label %.lr.ph.i39, !dbg !231

; <label>:135                                     ; preds = %.lr.ph.i39
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !236
  unreachable

__str_to_int.exit40:                              ; preds = %128
  %136 = trunc i64 %132 to i32, !dbg !224
  call void @llvm.dbg.value(metadata !{i32 %136}, i64 0, metadata !29), !dbg !224
  %137 = add nsw i32 %k.0302, 4, !dbg !237
  call void @llvm.dbg.value(metadata !{i32 %137}, i64 0, metadata !41), !dbg !237
  %138 = sext i32 %95 to i64, !dbg !237
  %139 = getelementptr inbounds i8** %2, i64 %138, !dbg !237
  %140 = load i8** %139, align 8, !dbg !237, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %140}, i64 0, metadata !238) #2, !dbg !239
  call void @llvm.dbg.value(metadata !213, i64 0, metadata !240) #2, !dbg !239
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !241) #2, !dbg !242
  %141 = load i8* %140, align 1, !dbg !243, !tbaa !128
  %142 = icmp eq i8 %141, 0, !dbg !243
  br i1 %142, label %143, label %.lr.ph.i44, !dbg !243

; <label>:143                                     ; preds = %__str_to_int.exit40
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !243
  unreachable

.lr.ph.i44:                                       ; preds = %__str_to_int.exit40, %147
  %144 = phi i8 [ %152, %147 ], [ %141, %__str_to_int.exit40 ]
  %s.pn.i41 = phi i8* [ %145, %147 ], [ %140, %__str_to_int.exit40 ]
  %res.02.i42 = phi i64 [ %151, %147 ], [ 0, %__str_to_int.exit40 ]
  %145 = getelementptr inbounds i8* %s.pn.i41, i64 1, !dbg !244
  %.off.i43 = add i8 %144, -48, !dbg !245
  %146 = icmp ult i8 %.off.i43, 10, !dbg !245
  br i1 %146, label %147, label %154, !dbg !245

; <label>:147                                     ; preds = %.lr.ph.i44
  %148 = sext i8 %144 to i64, !dbg !246
  %149 = mul nsw i64 %res.02.i42, 10, !dbg !247
  %150 = add i64 %148, -48, !dbg !247
  %151 = add i64 %150, %149, !dbg !247
  call void @llvm.dbg.value(metadata !{i64 %151}, i64 0, metadata !241) #2, !dbg !247
  call void @llvm.dbg.value(metadata !{i8* %145}, i64 0, metadata !238) #2, !dbg !244
  %152 = load i8* %145, align 1, !dbg !244, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %144}, i64 0, metadata !248) #2, !dbg !244
  %153 = icmp eq i8 %152, 0, !dbg !244
  br i1 %153, label %__str_to_int.exit45, label %.lr.ph.i44, !dbg !244

; <label>:154                                     ; preds = %.lr.ph.i44
  call fastcc void @__emit_error(i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)) #2, !dbg !249
  unreachable

__str_to_int.exit45:                              ; preds = %147
  %155 = trunc i64 %151 to i32, !dbg !237
  call void @llvm.dbg.value(metadata !{i32 %155}, i64 0, metadata !26), !dbg !237
  %156 = add i32 %136, 1, !dbg !250
  %157 = call i32 @klee_range(i32 %118, i32 %156, i8* getelementptr inbounds ([7 x i8]* @.str8, i64 0, i64 0)) #2, !dbg !250
  call void @llvm.dbg.value(metadata !{i32 %157}, i64 0, metadata !21), !dbg !250
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !42), !dbg !251
  %158 = icmp sgt i32 %157, 0, !dbg !251
  br i1 %158, label %.lr.ph, label %__streq.exit.thread.backedge, !dbg !251

.lr.ph:                                           ; preds = %__str_to_int.exit45
  %159 = sext i32 %25 to i64
  br label %160, !dbg !251

; <label>:160                                     ; preds = %.lr.ph, %__add_arg.exit46
  %indvars.iv = phi i64 [ %159, %.lr.ph ], [ %indvars.iv.next, %__add_arg.exit46 ]
  %i.0151 = phi i32 [ 0, %.lr.ph ], [ %171, %__add_arg.exit46 ]
  %sym_arg_num.1150 = phi i32 [ %sym_arg_num.0294, %.lr.ph ], [ %168, %__add_arg.exit46 ]
  %161 = phi i32 [ %25, %.lr.ph ], [ %170, %__add_arg.exit46 ]
  call void @llvm.dbg.value(metadata !{i32 %168}, i64 0, metadata !40), !dbg !253
  %162 = add i32 %sym_arg_num.1150, 48, !dbg !253
  %163 = trunc i32 %162 to i8, !dbg !253
  store i8 %163, i8* %22, align 1, !dbg !253, !tbaa !128
  %164 = call fastcc i8* @__get_sym_str(i32 %155, i8* %4), !dbg !255
  call void @llvm.dbg.value(metadata !182, i64 0, metadata !256) #2, !dbg !258
  %165 = trunc i64 %indvars.iv to i32, !dbg !259
  %166 = icmp eq i32 %165, 1024, !dbg !259
  br i1 %166, label %167, label %__add_arg.exit46, !dbg !259

; <label>:167                                     ; preds = %160
  call fastcc void @__emit_error(i8* getelementptr inbounds ([37 x i8]* @.str21, i64 0, i64 0)) #2, !dbg !260
  unreachable

__add_arg.exit46:                                 ; preds = %160
  %168 = add i32 %sym_arg_num.1150, 1, !dbg !253
  %169 = getelementptr inbounds [1024 x i8*]* %new_argv, i64 0, i64 %indvars.iv, !dbg !261
  store i8* %164, i8** %169, align 8, !dbg !261, !tbaa !112
  %indvars.iv.next = add nsw i64 %indvars.iv, 1, !dbg !251
  %170 = add nsw i32 %161, 1, !dbg !262
  call void @llvm.dbg.value(metadata !{i32 %170}, i64 0, metadata !20), !dbg !262
  call void @llvm.dbg.value(metadata !{i32 %170}, i64 0, metadata !20), !dbg !115
  call void @llvm.dbg.value(metadata !{i32 %170}, i64 0, metadata !20), !dbg !116
  call void @llvm.dbg.value(metadata !{i32 %170}, i64 0, metadata !20), !dbg !117
  call void @llvm.dbg.value(metadata !{i32 %170}, i64 0, metadata !20), !dbg !118
  %171 = add nsw i32 %i.0151, 1, !dbg !251
  call void @llvm.dbg.value(metadata !{i32 %171}, i64 0, metadata !42), !dbg !251
  %172 = icmp slt i32 %171, %157, !dbg !251
  br i1 %172, label %160, label %__streq.exit.thread.backedge, !dbg !251

.loopexit126:                                     ; preds = %89
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !263), !dbg !265
  tail call void @llvm.dbg.value(metadata !266, i64 0, metadata !267), !dbg !265
  br i1 %30, label %.lr.ph.i49, label %.loopexit141, !dbg !268

.lr.ph.i49:                                       ; preds = %.loopexit126, %175
  %173 = phi i8 [ %178, %175 ], [ 45, %.loopexit126 ]
  %.04.i47 = phi i8* [ %177, %175 ], [ getelementptr inbounds ([12 x i8]* @.str9, i64 0, i64 0), %.loopexit126 ]
  %.013.i48 = phi i8* [ %176, %175 ], [ %28, %.loopexit126 ]
  %174 = icmp eq i8 %173, 0, !dbg !269
  br i1 %174, label %__streq.exit51.thread112, label %175, !dbg !269

; <label>:175                                     ; preds = %.lr.ph.i49
  %176 = getelementptr inbounds i8* %.013.i48, i64 1, !dbg !270
  tail call void @llvm.dbg.value(metadata !{i8* %176}, i64 0, metadata !263), !dbg !270
  %177 = getelementptr inbounds i8* %.04.i47, i64 1, !dbg !271
  tail call void @llvm.dbg.value(metadata !{i8* %177}, i64 0, metadata !267), !dbg !271
  %178 = load i8* %176, align 1, !dbg !268, !tbaa !128
  %179 = load i8* %177, align 1, !dbg !268, !tbaa !128
  %180 = icmp eq i8 %178, %179, !dbg !268
  br i1 %180, label %.lr.ph.i49, label %.loopexit127, !dbg !268

.loopexit127:                                     ; preds = %175
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !263), !dbg !265
  tail call void @llvm.dbg.value(metadata !272, i64 0, metadata !267), !dbg !265
  br i1 %30, label %.lr.ph.i54, label %.loopexit141, !dbg !268

.lr.ph.i54:                                       ; preds = %.loopexit127, %183
  %181 = phi i8 [ %186, %183 ], [ 45, %.loopexit127 ]
  %.04.i52 = phi i8* [ %185, %183 ], [ getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0), %.loopexit127 ]
  %.013.i53 = phi i8* [ %184, %183 ], [ %28, %.loopexit127 ]
  %182 = icmp eq i8 %181, 0, !dbg !269
  br i1 %182, label %__streq.exit51.thread112, label %183, !dbg !269

; <label>:183                                     ; preds = %.lr.ph.i54
  %184 = getelementptr inbounds i8* %.013.i53, i64 1, !dbg !270
  tail call void @llvm.dbg.value(metadata !{i8* %184}, i64 0, metadata !263), !dbg !270
  %185 = getelementptr inbounds i8* %.04.i52, i64 1, !dbg !271
  tail call void @llvm.dbg.value(metadata !{i8* %185}, i64 0, metadata !267), !dbg !271
  %186 = load i8* %184, align 1, !dbg !268, !tbaa !128
  %187 = load i8* %185, align 1, !dbg !268, !tbaa !128
  %188 = icmp eq i8 %186, %187, !dbg !268
  br i1 %188, label %.lr.ph.i54, label %.loopexit129, !dbg !268

__streq.exit51.thread112:                         ; preds = %.lr.ph.i54, %.lr.ph.i49
  call void @llvm.dbg.value(metadata !273, i64 0, metadata !52), !dbg !274
  %189 = add nsw i32 %k.0302, 2, !dbg !275
  %190 = icmp slt i32 %189, %1, !dbg !275
  br i1 %190, label %192, label %191, !dbg !275

; <label>:191                                     ; preds = %__streq.exit51.thread112
  call fastcc void @__emit_error(i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)), !dbg !277
  unreachable

; <label>:192                                     ; preds = %__streq.exit51.thread112
  %193 = add nsw i32 %k.0302, 1, !dbg !278
  call void @llvm.dbg.value(metadata !{i32 %193}, i64 0, metadata !41), !dbg !278
  call void @llvm.dbg.value(metadata !{i32 %189}, i64 0, metadata !41), !dbg !279
  %194 = sext i32 %193 to i64, !dbg !279
  %195 = getelementptr inbounds i8** %2, i64 %194, !dbg !279
  %196 = load i8** %195, align 8, !dbg !279, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %196}, i64 0, metadata !280) #2, !dbg !281
  call void @llvm.dbg.value(metadata !282, i64 0, metadata !283) #2, !dbg !281
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !284) #2, !dbg !285
  %197 = load i8* %196, align 1, !dbg !286, !tbaa !128
  %198 = icmp eq i8 %197, 0, !dbg !286
  br i1 %198, label %199, label %.lr.ph.i60, !dbg !286

; <label>:199                                     ; preds = %192
  call fastcc void @__emit_error(i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)) #2, !dbg !286
  unreachable

.lr.ph.i60:                                       ; preds = %192, %203
  %200 = phi i8 [ %208, %203 ], [ %197, %192 ]
  %s.pn.i57 = phi i8* [ %201, %203 ], [ %196, %192 ]
  %res.02.i58 = phi i64 [ %207, %203 ], [ 0, %192 ]
  %201 = getelementptr inbounds i8* %s.pn.i57, i64 1, !dbg !287
  %.off.i59 = add i8 %200, -48, !dbg !288
  %202 = icmp ult i8 %.off.i59, 10, !dbg !288
  br i1 %202, label %203, label %210, !dbg !288

; <label>:203                                     ; preds = %.lr.ph.i60
  %204 = sext i8 %200 to i64, !dbg !289
  %205 = mul nsw i64 %res.02.i58, 10, !dbg !290
  %206 = add i64 %204, -48, !dbg !290
  %207 = add i64 %206, %205, !dbg !290
  call void @llvm.dbg.value(metadata !{i64 %207}, i64 0, metadata !284) #2, !dbg !290
  call void @llvm.dbg.value(metadata !{i8* %201}, i64 0, metadata !280) #2, !dbg !287
  %208 = load i8* %201, align 1, !dbg !287, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %200}, i64 0, metadata !291) #2, !dbg !287
  %209 = icmp eq i8 %208, 0, !dbg !287
  br i1 %209, label %__str_to_int.exit61, label %.lr.ph.i60, !dbg !287

; <label>:210                                     ; preds = %.lr.ph.i60
  call fastcc void @__emit_error(i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)) #2, !dbg !292
  unreachable

__str_to_int.exit61:                              ; preds = %203
  %211 = trunc i64 %207 to i32, !dbg !279
  call void @llvm.dbg.value(metadata !{i32 %211}, i64 0, metadata !30), !dbg !279
  %212 = add nsw i32 %k.0302, 3, !dbg !293
  call void @llvm.dbg.value(metadata !{i32 %212}, i64 0, metadata !41), !dbg !293
  %213 = sext i32 %189 to i64, !dbg !293
  %214 = getelementptr inbounds i8** %2, i64 %213, !dbg !293
  %215 = load i8** %214, align 8, !dbg !293, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %215}, i64 0, metadata !294) #2, !dbg !295
  call void @llvm.dbg.value(metadata !282, i64 0, metadata !296) #2, !dbg !295
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !297) #2, !dbg !298
  %216 = load i8* %215, align 1, !dbg !299, !tbaa !128
  %217 = icmp eq i8 %216, 0, !dbg !299
  br i1 %217, label %218, label %.lr.ph.i65, !dbg !299

; <label>:218                                     ; preds = %__str_to_int.exit61
  call fastcc void @__emit_error(i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)) #2, !dbg !299
  unreachable

.lr.ph.i65:                                       ; preds = %__str_to_int.exit61, %222
  %219 = phi i8 [ %227, %222 ], [ %216, %__str_to_int.exit61 ]
  %s.pn.i62 = phi i8* [ %220, %222 ], [ %215, %__str_to_int.exit61 ]
  %res.02.i63 = phi i64 [ %226, %222 ], [ 0, %__str_to_int.exit61 ]
  %220 = getelementptr inbounds i8* %s.pn.i62, i64 1, !dbg !300
  %.off.i64 = add i8 %219, -48, !dbg !301
  %221 = icmp ult i8 %.off.i64, 10, !dbg !301
  br i1 %221, label %222, label %229, !dbg !301

; <label>:222                                     ; preds = %.lr.ph.i65
  %223 = sext i8 %219 to i64, !dbg !302
  %224 = mul nsw i64 %res.02.i63, 10, !dbg !303
  %225 = add i64 %223, -48, !dbg !303
  %226 = add i64 %225, %224, !dbg !303
  call void @llvm.dbg.value(metadata !{i64 %226}, i64 0, metadata !297) #2, !dbg !303
  call void @llvm.dbg.value(metadata !{i8* %220}, i64 0, metadata !294) #2, !dbg !300
  %227 = load i8* %220, align 1, !dbg !300, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %219}, i64 0, metadata !304) #2, !dbg !300
  %228 = icmp eq i8 %227, 0, !dbg !300
  br i1 %228, label %__str_to_int.exit66, label %.lr.ph.i65, !dbg !300

; <label>:229                                     ; preds = %.lr.ph.i65
  call fastcc void @__emit_error(i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)) #2, !dbg !305
  unreachable

__str_to_int.exit66:                              ; preds = %222
  %230 = trunc i64 %226 to i32, !dbg !293
  call void @llvm.dbg.value(metadata !{i32 %230}, i64 0, metadata !31), !dbg !293
  br label %__streq.exit.thread.backedge, !dbg !306

.loopexit129:                                     ; preds = %183
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !307), !dbg !309
  tail call void @llvm.dbg.value(metadata !310, i64 0, metadata !311), !dbg !309
  br i1 %30, label %.lr.ph.i69, label %.loopexit141, !dbg !312

.lr.ph.i69:                                       ; preds = %.loopexit129, %233
  %231 = phi i8 [ %236, %233 ], [ 45, %.loopexit129 ]
  %.04.i67 = phi i8* [ %235, %233 ], [ getelementptr inbounds ([13 x i8]* @.str12, i64 0, i64 0), %.loopexit129 ]
  %.013.i68 = phi i8* [ %234, %233 ], [ %28, %.loopexit129 ]
  %232 = icmp eq i8 %231, 0, !dbg !313
  br i1 %232, label %__streq.exit71.thread114, label %233, !dbg !313

; <label>:233                                     ; preds = %.lr.ph.i69
  %234 = getelementptr inbounds i8* %.013.i68, i64 1, !dbg !314
  tail call void @llvm.dbg.value(metadata !{i8* %234}, i64 0, metadata !307), !dbg !314
  %235 = getelementptr inbounds i8* %.04.i67, i64 1, !dbg !315
  tail call void @llvm.dbg.value(metadata !{i8* %235}, i64 0, metadata !311), !dbg !315
  %236 = load i8* %234, align 1, !dbg !312, !tbaa !128
  %237 = load i8* %235, align 1, !dbg !312, !tbaa !128
  %238 = icmp eq i8 %236, %237, !dbg !312
  br i1 %238, label %.lr.ph.i69, label %.loopexit130, !dbg !312

.loopexit130:                                     ; preds = %233
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !307), !dbg !309
  tail call void @llvm.dbg.value(metadata !316, i64 0, metadata !311), !dbg !309
  br i1 %30, label %.lr.ph.i74, label %.loopexit141, !dbg !312

.lr.ph.i74:                                       ; preds = %.loopexit130, %241
  %239 = phi i8 [ %244, %241 ], [ 45, %.loopexit130 ]
  %.04.i72 = phi i8* [ %243, %241 ], [ getelementptr inbounds ([12 x i8]* @.str13, i64 0, i64 0), %.loopexit130 ]
  %.013.i73 = phi i8* [ %242, %241 ], [ %28, %.loopexit130 ]
  %240 = icmp eq i8 %239, 0, !dbg !313
  br i1 %240, label %__streq.exit71.thread114, label %241, !dbg !313

; <label>:241                                     ; preds = %.lr.ph.i74
  %242 = getelementptr inbounds i8* %.013.i73, i64 1, !dbg !314
  tail call void @llvm.dbg.value(metadata !{i8* %242}, i64 0, metadata !307), !dbg !314
  %243 = getelementptr inbounds i8* %.04.i72, i64 1, !dbg !315
  tail call void @llvm.dbg.value(metadata !{i8* %243}, i64 0, metadata !311), !dbg !315
  %244 = load i8* %242, align 1, !dbg !312, !tbaa !128
  %245 = load i8* %243, align 1, !dbg !312, !tbaa !128
  %246 = icmp eq i8 %244, %245, !dbg !312
  br i1 %246, label %.lr.ph.i74, label %.loopexit132, !dbg !312

__streq.exit71.thread114:                         ; preds = %.lr.ph.i74, %.lr.ph.i69
  call void @llvm.dbg.value(metadata !317, i64 0, metadata !32), !dbg !318
  %247 = add nsw i32 %k.0302, 1, !dbg !320
  call void @llvm.dbg.value(metadata !{i32 %247}, i64 0, metadata !41), !dbg !320
  br label %__streq.exit.thread.backedge, !dbg !321

__streq.exit.thread.backedge:                     ; preds = %__add_arg.exit46, %__str_to_int.exit45, %__streq.exit71.thread114, %__streq.exit106.thread118, %__add_arg.exit, %__str_to_int.exit, %__streq.exit81.thread116, %__str_to_int.exit66, %__add_arg.exit20
  %.be = phi i32 [ %78, %__add_arg.exit20 ], [ %25, %__str_to_int.exit66 ], [ %25, %__streq.exit71.thread114 ], [ %25, %__streq.exit81.thread116 ], [ %25, %__streq.exit106.thread118 ], [ %25, %__str_to_int.exit ], [ %327, %__add_arg.exit ], [ %25, %__str_to_int.exit45 ], [ %170, %__add_arg.exit46 ]
  %fd_fail.0.be = phi i32 [ %fd_fail.0281, %__add_arg.exit20 ], [ %fd_fail.0281, %__str_to_int.exit66 ], [ %fd_fail.0281, %__streq.exit71.thread114 ], [ %fd_fail.0281, %__streq.exit81.thread116 ], [ 1, %__streq.exit106.thread118 ], [ %321, %__str_to_int.exit ], [ %fd_fail.0281, %__add_arg.exit ], [ %fd_fail.0281, %__str_to_int.exit45 ], [ %fd_fail.0281, %__add_arg.exit46 ]
  %save_all_writes_flag.0.be = phi i32 [ %save_all_writes_flag.0287, %__add_arg.exit20 ], [ %save_all_writes_flag.0287, %__str_to_int.exit66 ], [ %save_all_writes_flag.0287, %__streq.exit71.thread114 ], [ 1, %__streq.exit81.thread116 ], [ %save_all_writes_flag.0287, %__streq.exit106.thread118 ], [ %save_all_writes_flag.0287, %__str_to_int.exit ], [ %save_all_writes_flag.0287, %__add_arg.exit ], [ %save_all_writes_flag.0287, %__str_to_int.exit45 ], [ %save_all_writes_flag.0287, %__add_arg.exit46 ]
  %sym_arg_num.0.be = phi i32 [ %75, %__add_arg.exit20 ], [ %sym_arg_num.0294, %__str_to_int.exit66 ], [ %sym_arg_num.0294, %__streq.exit71.thread114 ], [ %sym_arg_num.0294, %__streq.exit81.thread116 ], [ %sym_arg_num.0294, %__streq.exit106.thread118 ], [ %sym_arg_num.0294, %__str_to_int.exit ], [ %sym_arg_num.0294, %__add_arg.exit ], [ %sym_arg_num.0294, %__str_to_int.exit45 ], [ %168, %__add_arg.exit46 ]
  %k.0.be = phi i32 [ %51, %__add_arg.exit20 ], [ %212, %__str_to_int.exit66 ], [ %247, %__streq.exit71.thread114 ], [ %265, %__streq.exit81.thread116 ], [ %282, %__streq.exit106.thread118 ], [ %303, %__str_to_int.exit ], [ %324, %__add_arg.exit ], [ %137, %__str_to_int.exit45 ], [ %137, %__add_arg.exit46 ]
  %sym_stdout_flag.0.be = phi i32 [ %sym_stdout_flag.0310, %__add_arg.exit20 ], [ %sym_stdout_flag.0310, %__str_to_int.exit66 ], [ 1, %__streq.exit71.thread114 ], [ %sym_stdout_flag.0310, %__streq.exit81.thread116 ], [ %sym_stdout_flag.0310, %__streq.exit106.thread118 ], [ %sym_stdout_flag.0310, %__str_to_int.exit ], [ %sym_stdout_flag.0310, %__add_arg.exit ], [ %sym_stdout_flag.0310, %__str_to_int.exit45 ], [ %sym_stdout_flag.0310, %__add_arg.exit46 ]
  %sym_file_len.0.be = phi i32 [ %sym_file_len.0317, %__add_arg.exit20 ], [ %230, %__str_to_int.exit66 ], [ %sym_file_len.0317, %__streq.exit71.thread114 ], [ %sym_file_len.0317, %__streq.exit81.thread116 ], [ %sym_file_len.0317, %__streq.exit106.thread118 ], [ %sym_file_len.0317, %__str_to_int.exit ], [ %sym_file_len.0317, %__add_arg.exit ], [ %sym_file_len.0317, %__str_to_int.exit45 ], [ %sym_file_len.0317, %__add_arg.exit46 ]
  %sym_files.0.be = phi i32 [ %sym_files.0324, %__add_arg.exit20 ], [ %211, %__str_to_int.exit66 ], [ %sym_files.0324, %__streq.exit71.thread114 ], [ %sym_files.0324, %__streq.exit81.thread116 ], [ %sym_files.0324, %__streq.exit106.thread118 ], [ %sym_files.0324, %__str_to_int.exit ], [ %sym_files.0324, %__add_arg.exit ], [ %sym_files.0324, %__str_to_int.exit45 ], [ %sym_files.0324, %__add_arg.exit46 ]
  %248 = icmp slt i32 %k.0.be, %1, !dbg !141
  br i1 %248, label %24, label %__streq.exit.thread._crit_edge, !dbg !141

.loopexit132:                                     ; preds = %241
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !322), !dbg !324
  tail call void @llvm.dbg.value(metadata !325, i64 0, metadata !326), !dbg !324
  br i1 %30, label %.lr.ph.i79, label %.loopexit141, !dbg !327

.lr.ph.i79:                                       ; preds = %.loopexit132, %251
  %249 = phi i8 [ %254, %251 ], [ 45, %.loopexit132 ]
  %.04.i77 = phi i8* [ %253, %251 ], [ getelementptr inbounds ([18 x i8]* @.str14, i64 0, i64 0), %.loopexit132 ]
  %.013.i78 = phi i8* [ %252, %251 ], [ %28, %.loopexit132 ]
  %250 = icmp eq i8 %249, 0, !dbg !328
  br i1 %250, label %__streq.exit81.thread116, label %251, !dbg !328

; <label>:251                                     ; preds = %.lr.ph.i79
  %252 = getelementptr inbounds i8* %.013.i78, i64 1, !dbg !329
  tail call void @llvm.dbg.value(metadata !{i8* %252}, i64 0, metadata !322), !dbg !329
  %253 = getelementptr inbounds i8* %.04.i77, i64 1, !dbg !330
  tail call void @llvm.dbg.value(metadata !{i8* %253}, i64 0, metadata !326), !dbg !330
  %254 = load i8* %252, align 1, !dbg !327, !tbaa !128
  %255 = load i8* %253, align 1, !dbg !327, !tbaa !128
  %256 = icmp eq i8 %254, %255, !dbg !327
  br i1 %256, label %.lr.ph.i79, label %.loopexit133, !dbg !327

.loopexit133:                                     ; preds = %251
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !322), !dbg !324
  tail call void @llvm.dbg.value(metadata !331, i64 0, metadata !326), !dbg !324
  br i1 %30, label %.lr.ph.i84, label %.loopexit141, !dbg !327

.lr.ph.i84:                                       ; preds = %.loopexit133, %259
  %257 = phi i8 [ %262, %259 ], [ 45, %.loopexit133 ]
  %.04.i82 = phi i8* [ %261, %259 ], [ getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0), %.loopexit133 ]
  %.013.i83 = phi i8* [ %260, %259 ], [ %28, %.loopexit133 ]
  %258 = icmp eq i8 %257, 0, !dbg !328
  br i1 %258, label %__streq.exit81.thread116, label %259, !dbg !328

; <label>:259                                     ; preds = %.lr.ph.i84
  %260 = getelementptr inbounds i8* %.013.i83, i64 1, !dbg !329
  tail call void @llvm.dbg.value(metadata !{i8* %260}, i64 0, metadata !322), !dbg !329
  %261 = getelementptr inbounds i8* %.04.i82, i64 1, !dbg !330
  tail call void @llvm.dbg.value(metadata !{i8* %261}, i64 0, metadata !326), !dbg !330
  %262 = load i8* %260, align 1, !dbg !327, !tbaa !128
  %263 = load i8* %261, align 1, !dbg !327, !tbaa !128
  %264 = icmp eq i8 %262, %263, !dbg !327
  br i1 %264, label %.lr.ph.i84, label %.loopexit135, !dbg !327

__streq.exit81.thread116:                         ; preds = %.lr.ph.i84, %.lr.ph.i79
  call void @llvm.dbg.value(metadata !317, i64 0, metadata !33), !dbg !332
  %265 = add nsw i32 %k.0302, 1, !dbg !334
  call void @llvm.dbg.value(metadata !{i32 %265}, i64 0, metadata !41), !dbg !334
  br label %__streq.exit.thread.backedge, !dbg !335

.loopexit135:                                     ; preds = %259
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !336), !dbg !338
  tail call void @llvm.dbg.value(metadata !339, i64 0, metadata !340), !dbg !338
  br i1 %30, label %.lr.ph.i104, label %.loopexit141, !dbg !341

.lr.ph.i104:                                      ; preds = %.loopexit135, %268
  %266 = phi i8 [ %271, %268 ], [ 45, %.loopexit135 ]
  %.04.i102 = phi i8* [ %270, %268 ], [ getelementptr inbounds ([10 x i8]* @.str16, i64 0, i64 0), %.loopexit135 ]
  %.013.i103 = phi i8* [ %269, %268 ], [ %28, %.loopexit135 ]
  %267 = icmp eq i8 %266, 0, !dbg !342
  br i1 %267, label %__streq.exit106.thread118, label %268, !dbg !342

; <label>:268                                     ; preds = %.lr.ph.i104
  %269 = getelementptr inbounds i8* %.013.i103, i64 1, !dbg !343
  tail call void @llvm.dbg.value(metadata !{i8* %269}, i64 0, metadata !336), !dbg !343
  %270 = getelementptr inbounds i8* %.04.i102, i64 1, !dbg !344
  tail call void @llvm.dbg.value(metadata !{i8* %270}, i64 0, metadata !340), !dbg !344
  %271 = load i8* %269, align 1, !dbg !341, !tbaa !128
  %272 = load i8* %270, align 1, !dbg !341, !tbaa !128
  %273 = icmp eq i8 %271, %272, !dbg !341
  br i1 %273, label %.lr.ph.i104, label %.loopexit136, !dbg !341

.loopexit136:                                     ; preds = %268
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !336), !dbg !338
  tail call void @llvm.dbg.value(metadata !345, i64 0, metadata !340), !dbg !338
  br i1 %30, label %.lr.ph.i99, label %.loopexit141, !dbg !341

.lr.ph.i99:                                       ; preds = %.loopexit136, %276
  %274 = phi i8 [ %279, %276 ], [ 45, %.loopexit136 ]
  %.04.i97 = phi i8* [ %278, %276 ], [ getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0), %.loopexit136 ]
  %.013.i98 = phi i8* [ %277, %276 ], [ %28, %.loopexit136 ]
  %275 = icmp eq i8 %274, 0, !dbg !342
  br i1 %275, label %__streq.exit106.thread118, label %276, !dbg !342

; <label>:276                                     ; preds = %.lr.ph.i99
  %277 = getelementptr inbounds i8* %.013.i98, i64 1, !dbg !343
  tail call void @llvm.dbg.value(metadata !{i8* %277}, i64 0, metadata !336), !dbg !343
  %278 = getelementptr inbounds i8* %.04.i97, i64 1, !dbg !344
  tail call void @llvm.dbg.value(metadata !{i8* %278}, i64 0, metadata !340), !dbg !344
  %279 = load i8* %277, align 1, !dbg !341, !tbaa !128
  %280 = load i8* %278, align 1, !dbg !341, !tbaa !128
  %281 = icmp eq i8 %279, %280, !dbg !341
  br i1 %281, label %.lr.ph.i99, label %.loopexit138, !dbg !341

__streq.exit106.thread118:                        ; preds = %.lr.ph.i99, %.lr.ph.i104
  call void @llvm.dbg.value(metadata !317, i64 0, metadata !34), !dbg !346
  %282 = add nsw i32 %k.0302, 1, !dbg !348
  call void @llvm.dbg.value(metadata !{i32 %282}, i64 0, metadata !41), !dbg !348
  br label %__streq.exit.thread.backedge, !dbg !349

.loopexit138:                                     ; preds = %276
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !350), !dbg !352
  tail call void @llvm.dbg.value(metadata !353, i64 0, metadata !354), !dbg !352
  br i1 %30, label %.lr.ph.i94, label %.loopexit141, !dbg !355

.lr.ph.i94:                                       ; preds = %.loopexit138, %285
  %283 = phi i8 [ %288, %285 ], [ 45, %.loopexit138 ]
  %.04.i92 = phi i8* [ %287, %285 ], [ getelementptr inbounds ([11 x i8]* @.str18, i64 0, i64 0), %.loopexit138 ]
  %.013.i93 = phi i8* [ %286, %285 ], [ %28, %.loopexit138 ]
  %284 = icmp eq i8 %283, 0, !dbg !356
  br i1 %284, label %__streq.exit96.thread120, label %285, !dbg !356

; <label>:285                                     ; preds = %.lr.ph.i94
  %286 = getelementptr inbounds i8* %.013.i93, i64 1, !dbg !357
  tail call void @llvm.dbg.value(metadata !{i8* %286}, i64 0, metadata !350), !dbg !357
  %287 = getelementptr inbounds i8* %.04.i92, i64 1, !dbg !358
  tail call void @llvm.dbg.value(metadata !{i8* %287}, i64 0, metadata !354), !dbg !358
  %288 = load i8* %286, align 1, !dbg !355, !tbaa !128
  %289 = load i8* %287, align 1, !dbg !355, !tbaa !128
  %290 = icmp eq i8 %288, %289, !dbg !355
  br i1 %290, label %.lr.ph.i94, label %.loopexit139, !dbg !355

.loopexit139:                                     ; preds = %285
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !350), !dbg !352
  tail call void @llvm.dbg.value(metadata !359, i64 0, metadata !354), !dbg !352
  br i1 %30, label %.lr.ph.i89, label %.loopexit141, !dbg !355

.lr.ph.i89:                                       ; preds = %.loopexit139, %293
  %291 = phi i8 [ %296, %293 ], [ 45, %.loopexit139 ]
  %.04.i87 = phi i8* [ %295, %293 ], [ getelementptr inbounds ([10 x i8]* @.str19, i64 0, i64 0), %.loopexit139 ]
  %.013.i88 = phi i8* [ %294, %293 ], [ %28, %.loopexit139 ]
  %292 = icmp eq i8 %291, 0, !dbg !356
  br i1 %292, label %__streq.exit96.thread120, label %293, !dbg !356

; <label>:293                                     ; preds = %.lr.ph.i89
  %294 = getelementptr inbounds i8* %.013.i88, i64 1, !dbg !357
  tail call void @llvm.dbg.value(metadata !{i8* %294}, i64 0, metadata !350), !dbg !357
  %295 = getelementptr inbounds i8* %.04.i87, i64 1, !dbg !358
  tail call void @llvm.dbg.value(metadata !{i8* %295}, i64 0, metadata !354), !dbg !358
  %296 = load i8* %294, align 1, !dbg !355, !tbaa !128
  %297 = load i8* %295, align 1, !dbg !355, !tbaa !128
  %298 = icmp eq i8 %296, %297, !dbg !355
  br i1 %298, label %.lr.ph.i89, label %.loopexit141, !dbg !355

__streq.exit96.thread120:                         ; preds = %.lr.ph.i89, %.lr.ph.i94
  call void @llvm.dbg.value(metadata !360, i64 0, metadata !55), !dbg !361
  %299 = add nsw i32 %k.0302, 1, !dbg !362
  call void @llvm.dbg.value(metadata !{i32 %299}, i64 0, metadata !41), !dbg !362
  %300 = icmp eq i32 %299, %1, !dbg !362
  br i1 %300, label %301, label %302, !dbg !362

; <label>:301                                     ; preds = %__streq.exit96.thread120
  call fastcc void @__emit_error(i8* getelementptr inbounds ([54 x i8]* @.str20, i64 0, i64 0)), !dbg !364
  unreachable

; <label>:302                                     ; preds = %__streq.exit96.thread120
  %303 = add nsw i32 %k.0302, 2, !dbg !365
  call void @llvm.dbg.value(metadata !{i32 %303}, i64 0, metadata !41), !dbg !365
  %304 = sext i32 %299 to i64, !dbg !365
  %305 = getelementptr inbounds i8** %2, i64 %304, !dbg !365
  %306 = load i8** %305, align 8, !dbg !365, !tbaa !112
  call void @llvm.dbg.value(metadata !{i8* %306}, i64 0, metadata !366) #2, !dbg !367
  call void @llvm.dbg.value(metadata !368, i64 0, metadata !369) #2, !dbg !367
  call void @llvm.dbg.value(metadata !165, i64 0, metadata !370) #2, !dbg !371
  %307 = load i8* %306, align 1, !dbg !372, !tbaa !128
  %308 = icmp eq i8 %307, 0, !dbg !372
  br i1 %308, label %309, label %.lr.ph.i9, !dbg !372

; <label>:309                                     ; preds = %302
  call fastcc void @__emit_error(i8* getelementptr inbounds ([54 x i8]* @.str20, i64 0, i64 0)) #2, !dbg !372
  unreachable

.lr.ph.i9:                                        ; preds = %302, %313
  %310 = phi i8 [ %318, %313 ], [ %307, %302 ]
  %s.pn.i = phi i8* [ %311, %313 ], [ %306, %302 ]
  %res.02.i = phi i64 [ %317, %313 ], [ 0, %302 ]
  %311 = getelementptr inbounds i8* %s.pn.i, i64 1, !dbg !373
  %.off.i = add i8 %310, -48, !dbg !374
  %312 = icmp ult i8 %.off.i, 10, !dbg !374
  br i1 %312, label %313, label %320, !dbg !374

; <label>:313                                     ; preds = %.lr.ph.i9
  %314 = sext i8 %310 to i64, !dbg !375
  %315 = mul nsw i64 %res.02.i, 10, !dbg !376
  %316 = add i64 %314, -48, !dbg !376
  %317 = add i64 %316, %315, !dbg !376
  call void @llvm.dbg.value(metadata !{i64 %317}, i64 0, metadata !370) #2, !dbg !376
  call void @llvm.dbg.value(metadata !{i8* %311}, i64 0, metadata !366) #2, !dbg !373
  %318 = load i8* %311, align 1, !dbg !373, !tbaa !128
  call void @llvm.dbg.value(metadata !{i8 %310}, i64 0, metadata !377) #2, !dbg !373
  %319 = icmp eq i8 %318, 0, !dbg !373
  br i1 %319, label %__str_to_int.exit, label %.lr.ph.i9, !dbg !373

; <label>:320                                     ; preds = %.lr.ph.i9
  call fastcc void @__emit_error(i8* getelementptr inbounds ([54 x i8]* @.str20, i64 0, i64 0)) #2, !dbg !378
  unreachable

__str_to_int.exit:                                ; preds = %313
  %321 = trunc i64 %317 to i32, !dbg !365
  call void @llvm.dbg.value(metadata !{i32 %321}, i64 0, metadata !34), !dbg !365
  br label %__streq.exit.thread.backedge, !dbg !379

.loopexit141:                                     ; preds = %293, %.loopexit127, %.loopexit126, %.loopexit124, %.loopexit123, %.loopexit, %24, %.loopexit132, %.loopexit133, %.loopexit129, %.loopexit130, %.loopexit136, %.loopexit135, %.loopexit138, %.loopexit139
  call void @llvm.dbg.value(metadata !{i32 %324}, i64 0, metadata !41), !dbg !380
  call void @llvm.dbg.value(metadata !182, i64 0, metadata !382) #2, !dbg !383
  %322 = icmp eq i32 %25, 1024, !dbg !384
  br i1 %322, label %323, label %__add_arg.exit, !dbg !384

; <label>:323                                     ; preds = %.loopexit141
  call fastcc void @__emit_error(i8* getelementptr inbounds ([37 x i8]* @.str21, i64 0, i64 0)) #2, !dbg !385
  unreachable

__add_arg.exit:                                   ; preds = %.loopexit141
  %324 = add nsw i32 %k.0302, 1, !dbg !380
  %325 = sext i32 %25 to i64, !dbg !386
  %326 = getelementptr inbounds [1024 x i8*]* %new_argv, i64 0, i64 %325, !dbg !386
  store i8* %28, i8** %326, align 8, !dbg !386, !tbaa !112
  %327 = add nsw i32 %25, 1, !dbg !387
  call void @llvm.dbg.value(metadata !{i32 %327}, i64 0, metadata !20), !dbg !387
  call void @llvm.dbg.value(metadata !{i32 %327}, i64 0, metadata !20), !dbg !115
  call void @llvm.dbg.value(metadata !{i32 %327}, i64 0, metadata !20), !dbg !116
  call void @llvm.dbg.value(metadata !{i32 %327}, i64 0, metadata !20), !dbg !117
  call void @llvm.dbg.value(metadata !{i32 %327}, i64 0, metadata !20), !dbg !118
  br label %__streq.exit.thread.backedge

__streq.exit.thread._crit_edge:                   ; preds = %__streq.exit.thread.backedge, %__streq.exit.thread.preheader
  %sym_files.0.lcssa = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %sym_files.0.be, %__streq.exit.thread.backedge ]
  %sym_file_len.0.lcssa = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %sym_file_len.0.be, %__streq.exit.thread.backedge ]
  %sym_stdout_flag.0.lcssa = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %sym_stdout_flag.0.be, %__streq.exit.thread.backedge ]
  %save_all_writes_flag.0.lcssa = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %save_all_writes_flag.0.be, %__streq.exit.thread.backedge ]
  %fd_fail.0.lcssa = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %fd_fail.0.be, %__streq.exit.thread.backedge ]
  %.lcssa154 = phi i32 [ 0, %__streq.exit.thread.preheader ], [ %.be, %__streq.exit.thread.backedge ]
  %328 = add nsw i32 %.lcssa154, 1, !dbg !115
  %329 = sext i32 %328 to i64, !dbg !115
  %330 = shl nsw i64 %329, 3, !dbg !115
  %331 = call noalias i8* @malloc(i64 %330) #2, !dbg !115
  %332 = bitcast i8* %331 to i8**, !dbg !115
  call void @llvm.dbg.value(metadata !{i8** %332}, i64 0, metadata !35), !dbg !115
  call void @klee_mark_global(i8* %331) #2, !dbg !388
  %333 = sext i32 %.lcssa154 to i64, !dbg !116
  %334 = shl nsw i64 %333, 3, !dbg !116
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %331, i8* %3, i64 %334, i32 8, i1 false), !dbg !116
  %335 = getelementptr inbounds i8** %332, i64 %333, !dbg !117
  store i8* null, i8** %335, align 8, !dbg !117, !tbaa !112
  store i32 %.lcssa154, i32* %argcPtr, align 4, !dbg !118, !tbaa !107
  store i8** %332, i8*** %argvPtr, align 8, !dbg !389, !tbaa !112
  call void @klee_init_fds(i32 %sym_files.0.lcssa, i32 %sym_file_len.0.lcssa, i32 %sym_stdout_flag.0.lcssa, i32 %save_all_writes_flag.0.lcssa, i32 %fd_fail.0.lcssa) #2, !dbg !390
  call void @llvm.lifetime.end(i64 8192, i8* %3) #2, !dbg !391
  ret void, !dbg !391
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #2

; Function Attrs: noreturn nounwind ssp uwtable
define internal fastcc void @__emit_error(i8* %msg) #3 {
  tail call void @llvm.dbg.value(metadata !{i8* %msg}, i64 0, metadata !95), !dbg !392
  tail call void @klee_report_error(i8* getelementptr inbounds ([16 x i8]* @.str22, i64 0, i64 0), i32 24, i8* %msg, i8* getelementptr inbounds ([9 x i8]* @.str23, i64 0, i64 0)) #7, !dbg !393
  unreachable, !dbg !393
}

; Function Attrs: nounwind ssp uwtable
define internal fastcc i8* @__get_sym_str(i32 %numChars, i8* %name) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %numChars}, i64 0, metadata !65), !dbg !394
  tail call void @llvm.dbg.value(metadata !{i8* %name}, i64 0, metadata !66), !dbg !394
  %1 = add nsw i32 %numChars, 1, !dbg !395
  %2 = sext i32 %1 to i64, !dbg !395
  %3 = tail call noalias i8* @malloc(i64 %2) #2, !dbg !395
  tail call void @llvm.dbg.value(metadata !{i8* %3}, i64 0, metadata !68), !dbg !395
  tail call void @klee_mark_global(i8* %3) #2, !dbg !396
  tail call void @klee_make_symbolic(i8* %3, i64 %2, i8* %name) #2, !dbg !397
  tail call void @llvm.dbg.value(metadata !2, i64 0, metadata !67), !dbg !398
  %4 = icmp sgt i32 %numChars, 0, !dbg !398
  br i1 %4, label %.lr.ph, label %._crit_edge, !dbg !398

.lr.ph:                                           ; preds = %0, %.lr.ph
  %indvars.iv = phi i64 [ %indvars.iv.next, %.lr.ph ], [ 0, %0 ]
  %5 = getelementptr inbounds i8* %3, i64 %indvars.iv, !dbg !400
  %6 = load i8* %5, align 1, !dbg !400, !tbaa !128
  tail call void @llvm.dbg.value(metadata !{i8 %6}, i64 0, metadata !401), !dbg !402
  %7 = icmp sgt i8 %6, 31, !dbg !403
  %8 = icmp ne i8 %6, 127, !dbg !403
  %..i = and i1 %7, %8, !dbg !403
  %9 = zext i1 %..i to i64, !dbg !400
  tail call void @klee_posix_prefer_cex(i8* %3, i64 %9) #2, !dbg !400
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !398
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32, !dbg !398
  %exitcond = icmp eq i32 %lftr.wideiv, %numChars, !dbg !398
  br i1 %exitcond, label %._crit_edge, label %.lr.ph, !dbg !398

._crit_edge:                                      ; preds = %.lr.ph, %0
  %10 = sext i32 %numChars to i64, !dbg !404
  %11 = getelementptr inbounds i8* %3, i64 %10, !dbg !404
  store i8 0, i8* %11, align 1, !dbg !404, !tbaa !128
  ret i8* %3, !dbg !405
}

declare i32 @klee_range(i32, i32, i8*) #4

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #5

declare void @klee_mark_global(i8*) #4

declare void @klee_init_fds(i32, i32, i32, i32, i32) #4

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

declare void @klee_make_symbolic(i8*, i64, i8*) #4

declare void @klee_posix_prefer_cex(i8*, i64) #4

; Function Attrs: noreturn
declare void @klee_report_error(i8*, i32, i8*, i8*) #6

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }
attributes #3 = { noreturn nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #6 = { noreturn "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!102, !103}
!llvm.ident = !{!104}

!0 = metadata !{i32 786449, metadata !1, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX//home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c] [DW_LANG_C89]
!1 = metadata !{metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !61, metadata !69, metadata !74, metadata !82, metadata !91, metadata !96}
!4 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"klee_init_env", metadata !"klee_init_env", metadata !"", i32 85, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i32*, i8***)* @klee_init_env, null, null, metadata !15, i32 85} ; [ DW_TAG_subprogram ] [line 85] [def] [klee_init_env]
!5 = metadata !{metadata !"klee_init_env.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!6 = metadata !{i32 786473, metadata !5}          ; [ DW_TAG_file_type ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!7 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{null, metadata !9, metadata !11}
!9 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !10} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!10 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!11 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !12} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!12 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !13} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!13 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !14} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!14 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!15 = metadata !{metadata !16, metadata !17, metadata !18, metadata !19, metadata !20, metadata !21, metadata !22, metadata !26, metadata !28, metadata !29, metadata !30, metadata !31, metadata !32, metadata !33, metadata !34, metadata !35, metadata !36, metadata !40, metadata !41, metadata !42, metadata !43, metadata !49, metadata !52, metadata !55}
!16 = metadata !{i32 786689, metadata !4, metadata !"argcPtr", metadata !6, i32 16777301, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argcPtr] [line 85]
!17 = metadata !{i32 786689, metadata !4, metadata !"argvPtr", metadata !6, i32 33554517, metadata !11, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argvPtr] [line 85]
!18 = metadata !{i32 786688, metadata !4, metadata !"argc", metadata !6, i32 86, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [argc] [line 86]
!19 = metadata !{i32 786688, metadata !4, metadata !"argv", metadata !6, i32 87, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [argv] [line 87]
!20 = metadata !{i32 786688, metadata !4, metadata !"new_argc", metadata !6, i32 89, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [new_argc] [line 89]
!21 = metadata !{i32 786688, metadata !4, metadata !"n_args", metadata !6, i32 89, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [n_args] [line 89]
!22 = metadata !{i32 786688, metadata !4, metadata !"new_argv", metadata !6, i32 90, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [new_argv] [line 90]
!23 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 65536, i64 64, i32 0, i32 0, metadata !13, metadata !24, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 65536, align 64, offset 0] [from ]
!24 = metadata !{metadata !25}
!25 = metadata !{i32 786465, i64 0, i64 1024}     ; [ DW_TAG_subrange_type ] [0, 1023]
!26 = metadata !{i32 786688, metadata !4, metadata !"max_len", metadata !6, i32 91, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [max_len] [line 91]
!27 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!28 = metadata !{i32 786688, metadata !4, metadata !"min_argvs", metadata !6, i32 91, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [min_argvs] [line 91]
!29 = metadata !{i32 786688, metadata !4, metadata !"max_argvs", metadata !6, i32 91, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [max_argvs] [line 91]
!30 = metadata !{i32 786688, metadata !4, metadata !"sym_files", metadata !6, i32 92, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sym_files] [line 92]
!31 = metadata !{i32 786688, metadata !4, metadata !"sym_file_len", metadata !6, i32 92, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sym_file_len] [line 92]
!32 = metadata !{i32 786688, metadata !4, metadata !"sym_stdout_flag", metadata !6, i32 93, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sym_stdout_flag] [line 93]
!33 = metadata !{i32 786688, metadata !4, metadata !"save_all_writes_flag", metadata !6, i32 94, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [save_all_writes_flag] [line 94]
!34 = metadata !{i32 786688, metadata !4, metadata !"fd_fail", metadata !6, i32 95, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fd_fail] [line 95]
!35 = metadata !{i32 786688, metadata !4, metadata !"final_argv", metadata !6, i32 96, metadata !12, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [final_argv] [line 96]
!36 = metadata !{i32 786688, metadata !4, metadata !"sym_arg_name", metadata !6, i32 97, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sym_arg_name] [line 97]
!37 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 40, i64 8, i32 0, i32 0, metadata !14, metadata !38, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 40, align 8, offset 0] [from char]
!38 = metadata !{metadata !39}
!39 = metadata !{i32 786465, i64 0, i64 5}        ; [ DW_TAG_subrange_type ] [0, 4]
!40 = metadata !{i32 786688, metadata !4, metadata !"sym_arg_num", metadata !6, i32 98, metadata !27, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sym_arg_num] [line 98]
!41 = metadata !{i32 786688, metadata !4, metadata !"k", metadata !6, i32 99, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [k] [line 99]
!42 = metadata !{i32 786688, metadata !4, metadata !"i", metadata !6, i32 99, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 99]
!43 = metadata !{i32 786688, metadata !44, metadata !"msg", metadata !6, i32 119, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [msg] [line 119]
!44 = metadata !{i32 786443, metadata !5, metadata !45, i32 118, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!45 = metadata !{i32 786443, metadata !5, metadata !46, i32 118, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!46 = metadata !{i32 786443, metadata !5, metadata !4, i32 117, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!47 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !48} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!48 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !14} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!49 = metadata !{i32 786688, metadata !50, metadata !"msg", metadata !6, i32 130, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [msg] [line 130]
!50 = metadata !{i32 786443, metadata !5, metadata !51, i32 129, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!51 = metadata !{i32 786443, metadata !5, metadata !45, i32 129, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!52 = metadata !{i32 786688, metadata !53, metadata !"msg", metadata !6, i32 150, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [msg] [line 150]
!53 = metadata !{i32 786443, metadata !5, metadata !54, i32 149, i32 0, i32 12} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!54 = metadata !{i32 786443, metadata !5, metadata !51, i32 149, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!55 = metadata !{i32 786688, metadata !56, metadata !"msg", metadata !6, i32 173, metadata !47, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [msg] [line 173]
!56 = metadata !{i32 786443, metadata !5, metadata !57, i32 172, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!57 = metadata !{i32 786443, metadata !5, metadata !58, i32 172, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!58 = metadata !{i32 786443, metadata !5, metadata !59, i32 168, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!59 = metadata !{i32 786443, metadata !5, metadata !60, i32 164, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!60 = metadata !{i32 786443, metadata !5, metadata !54, i32 160, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!61 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__get_sym_str", metadata !"__get_sym_str", metadata !"", i32 63, metadata !62, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i32, i8*)* @__get_sym_str, null, null, metadata !64, i32 63} ; [ DW_TAG_subprogram ] [line 63] [local] [def] [__get_sym_str]
!62 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !63, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!63 = metadata !{metadata !13, metadata !10, metadata !13}
!64 = metadata !{metadata !65, metadata !66, metadata !67, metadata !68}
!65 = metadata !{i32 786689, metadata !61, metadata !"numChars", metadata !6, i32 16777279, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [numChars] [line 63]
!66 = metadata !{i32 786689, metadata !61, metadata !"name", metadata !6, i32 33554495, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [name] [line 63]
!67 = metadata !{i32 786688, metadata !61, metadata !"i", metadata !6, i32 64, metadata !10, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 64]
!68 = metadata !{i32 786688, metadata !61, metadata !"s", metadata !6, i32 65, metadata !13, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s] [line 65]
!69 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__isprint", metadata !"__isprint", metadata !"", i32 48, metadata !70, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !72, i32 48} ; [ DW_TAG_subprogram ] [line 48] [local] [def] [__isprint]
!70 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !71, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!71 = metadata !{metadata !10, metadata !48}
!72 = metadata !{metadata !73}
!73 = metadata !{i32 786689, metadata !69, metadata !"c", metadata !6, i32 16777264, metadata !48, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [c] [line 48]
!74 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__add_arg", metadata !"__add_arg", metadata !"", i32 76, metadata !75, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !77, i32 76} ; [ DW_TAG_subprogram ] [line 76] [local] [def] [__add_arg]
!75 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !76, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!76 = metadata !{null, metadata !9, metadata !12, metadata !13, metadata !10}
!77 = metadata !{metadata !78, metadata !79, metadata !80, metadata !81}
!78 = metadata !{i32 786689, metadata !74, metadata !"argc", metadata !6, i32 16777292, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argc] [line 76]
!79 = metadata !{i32 786689, metadata !74, metadata !"argv", metadata !6, i32 33554508, metadata !12, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argv] [line 76]
!80 = metadata !{i32 786689, metadata !74, metadata !"arg", metadata !6, i32 50331724, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [arg] [line 76]
!81 = metadata !{i32 786689, metadata !74, metadata !"argcMax", metadata !6, i32 67108940, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [argcMax] [line 76]
!82 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__str_to_int", metadata !"__str_to_int", metadata !"", i32 30, metadata !83, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !86, i32 30} ; [ DW_TAG_subprogram ] [line 30] [local] [def] [__str_to_int]
!83 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !84, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!84 = metadata !{metadata !85, metadata !13, metadata !47}
!85 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!86 = metadata !{metadata !87, metadata !88, metadata !89, metadata !90}
!87 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 30]
!88 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!89 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 31]
!90 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 32]
!91 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__emit_error", metadata !"__emit_error", metadata !"", i32 23, metadata !92, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, void (i8*)* @__emit_error, null, null, metadata !94, i32 23} ; [ DW_TAG_subprogram ] [line 23] [local] [def] [__emit_error]
!92 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !93, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!93 = metadata !{null, metadata !47}
!94 = metadata !{metadata !95}
!95 = metadata !{i32 786689, metadata !91, metadata !"msg", metadata !6, i32 16777239, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [msg] [line 23]
!96 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__streq", metadata !"__streq", metadata !"", i32 53, metadata !97, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !99, i32 53} ; [ DW_TAG_subprogram ] [line 53] [local] [def] [__streq]
!97 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !98, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!98 = metadata !{metadata !10, metadata !47, metadata !47}
!99 = metadata !{metadata !100, metadata !101}
!100 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 53]
!101 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 53]
!102 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!103 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!104 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!105 = metadata !{i32 85, i32 0, metadata !4, null}
!106 = metadata !{i32 86, i32 0, metadata !4, null}
!107 = metadata !{metadata !108, metadata !108, i64 0}
!108 = metadata !{metadata !"int", metadata !109, i64 0}
!109 = metadata !{metadata !"omnipotent char", metadata !110, i64 0}
!110 = metadata !{metadata !"Simple C/C++ TBAA"}
!111 = metadata !{i32 87, i32 0, metadata !4, null}
!112 = metadata !{metadata !113, metadata !113, i64 0}
!113 = metadata !{metadata !"any pointer", metadata !109, i64 0}
!114 = metadata !{i32 89, i32 0, metadata !4, null}
!115 = metadata !{i32 185, i32 0, metadata !4, null}
!116 = metadata !{i32 187, i32 0, metadata !4, null}
!117 = metadata !{i32 188, i32 0, metadata !4, null}
!118 = metadata !{i32 190, i32 0, metadata !4, null}
!119 = metadata !{i32 90, i32 0, metadata !4, null}
!120 = metadata !{i32 92, i32 0, metadata !4, null}
!121 = metadata !{i32 93, i32 0, metadata !4, null}
!122 = metadata !{i32 94, i32 0, metadata !4, null}
!123 = metadata !{i32 95, i32 0, metadata !4, null}
!124 = metadata !{i32 97, i32 0, metadata !4, null}
!125 = metadata !{i32 98, i32 0, metadata !4, null}
!126 = metadata !{i32 99, i32 0, metadata !4, null}
!127 = metadata !{i32 101, i32 0, metadata !4, null}
!128 = metadata !{metadata !109, metadata !109, i64 0}
!129 = metadata !{i32 104, i32 0, metadata !130, null}
!130 = metadata !{i32 786443, metadata !5, metadata !4, i32 104, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!131 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !129} ; [ DW_TAG_arg_variable ] [a] [line 53]
!132 = metadata !{i32 53, i32 0, metadata !96, metadata !129}
!133 = metadata !{i8* getelementptr inbounds ([7 x i8]* @.str, i64 0, i64 0)}
!134 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !129} ; [ DW_TAG_arg_variable ] [b] [line 53]
!135 = metadata !{i32 54, i32 0, metadata !96, metadata !129}
!136 = metadata !{i32 55, i32 0, metadata !137, metadata !129}
!137 = metadata !{i32 786443, metadata !5, metadata !138, i32 55, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!138 = metadata !{i32 786443, metadata !5, metadata !96, i32 54, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!139 = metadata !{i32 57, i32 0, metadata !138, metadata !129}
!140 = metadata !{i32 58, i32 0, metadata !138, metadata !129} ; [ DW_TAG_imported_module ]
!141 = metadata !{i32 117, i32 0, metadata !4, null}
!142 = metadata !{i32 124, i32 0, metadata !44, null}
!143 = metadata !{i32 105, i32 0, metadata !144, null}
!144 = metadata !{i32 786443, metadata !5, metadata !130, i32 104, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!145 = metadata !{i32 118, i32 0, metadata !45, null}
!146 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !145} ; [ DW_TAG_arg_variable ] [a] [line 53]
!147 = metadata !{i32 53, i32 0, metadata !96, metadata !145}
!148 = metadata !{i8* getelementptr inbounds ([10 x i8]* @.str2, i64 0, i64 0)}
!149 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !145} ; [ DW_TAG_arg_variable ] [b] [line 53]
!150 = metadata !{i32 54, i32 0, metadata !96, metadata !145}
!151 = metadata !{i32 55, i32 0, metadata !137, metadata !145}
!152 = metadata !{i32 57, i32 0, metadata !138, metadata !145}
!153 = metadata !{i32 58, i32 0, metadata !138, metadata !145} ; [ DW_TAG_imported_module ]
!154 = metadata !{i8* getelementptr inbounds ([9 x i8]* @.str3, i64 0, i64 0)}
!155 = metadata !{null}
!156 = metadata !{i32 119, i32 0, metadata !44, null}
!157 = metadata !{i32 120, i32 0, metadata !158, null}
!158 = metadata !{i32 786443, metadata !5, metadata !44, i32 120, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!159 = metadata !{i32 121, i32 0, metadata !158, null}
!160 = metadata !{i32 123, i32 0, metadata !44, null}
!161 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !160} ; [ DW_TAG_arg_variable ] [s] [line 30]
!162 = metadata !{i32 30, i32 0, metadata !82, metadata !160}
!163 = metadata !{i8* getelementptr inbounds ([48 x i8]* @.str4, i64 0, i64 0)}
!164 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !160} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!165 = metadata !{i64 0}
!166 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !160} ; [ DW_TAG_auto_variable ] [res] [line 31]
!167 = metadata !{i32 31, i32 0, metadata !82, metadata !160}
!168 = metadata !{i32 34, i32 0, metadata !169, metadata !160}
!169 = metadata !{i32 786443, metadata !5, metadata !82, i32 34, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!170 = metadata !{i32 36, i32 0, metadata !82, metadata !160}
!171 = metadata !{i32 39, i32 0, metadata !172, metadata !160}
!172 = metadata !{i32 786443, metadata !5, metadata !173, i32 39, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!173 = metadata !{i32 786443, metadata !5, metadata !174, i32 37, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!174 = metadata !{i32 786443, metadata !5, metadata !82, i32 36, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!175 = metadata !{i32 37, i32 0, metadata !173, metadata !160}
!176 = metadata !{i32 40, i32 0, metadata !177, metadata !160}
!177 = metadata !{i32 786443, metadata !5, metadata !172, i32 39, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!178 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !160} ; [ DW_TAG_auto_variable ] [c] [line 32]
!179 = metadata !{i32 42, i32 0, metadata !180, metadata !160}
!180 = metadata !{i32 786443, metadata !5, metadata !172, i32 41, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!181 = metadata !{i32 126, i32 0, metadata !44, null}
!182 = metadata !{i32 1024}
!183 = metadata !{i32 786689, metadata !74, metadata !"argcMax", metadata !6, i32 67108940, metadata !10, i32 0, metadata !184} ; [ DW_TAG_arg_variable ] [argcMax] [line 76]
!184 = metadata !{i32 125, i32 0, metadata !44, null}
!185 = metadata !{i32 76, i32 0, metadata !74, metadata !184}
!186 = metadata !{i32 77, i32 0, metadata !187, metadata !184}
!187 = metadata !{i32 786443, metadata !5, metadata !74, i32 77, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!188 = metadata !{i32 78, i32 0, metadata !189, metadata !184}
!189 = metadata !{i32 786443, metadata !5, metadata !187, i32 77, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!190 = metadata !{i32 80, i32 0, metadata !191, metadata !184}
!191 = metadata !{i32 786443, metadata !5, metadata !187, i32 79, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!192 = metadata !{i32 81, i32 0, metadata !191, metadata !184}
!193 = metadata !{i32 128, i32 0, metadata !44, null}
!194 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !195} ; [ DW_TAG_arg_variable ] [a] [line 53]
!195 = metadata !{i32 129, i32 0, metadata !51, null}
!196 = metadata !{i32 53, i32 0, metadata !96, metadata !195}
!197 = metadata !{i8* getelementptr inbounds ([11 x i8]* @.str5, i64 0, i64 0)}
!198 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !195} ; [ DW_TAG_arg_variable ] [b] [line 53]
!199 = metadata !{i32 54, i32 0, metadata !96, metadata !195}
!200 = metadata !{i32 55, i32 0, metadata !137, metadata !195}
!201 = metadata !{i32 57, i32 0, metadata !138, metadata !195}
!202 = metadata !{i32 58, i32 0, metadata !138, metadata !195} ; [ DW_TAG_imported_module ]
!203 = metadata !{i8* getelementptr inbounds ([10 x i8]* @.str6, i64 0, i64 0)}
!204 = metadata !{null}
!205 = metadata !{i32 130, i32 0, metadata !50, null}
!206 = metadata !{i32 133, i32 0, metadata !207, null}
!207 = metadata !{i32 786443, metadata !5, metadata !50, i32 133, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!208 = metadata !{i32 134, i32 0, metadata !207, null}
!209 = metadata !{i32 136, i32 0, metadata !50, null}
!210 = metadata !{i32 137, i32 0, metadata !50, null}
!211 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !210} ; [ DW_TAG_arg_variable ] [s] [line 30]
!212 = metadata !{i32 30, i32 0, metadata !82, metadata !210}
!213 = metadata !{i8* getelementptr inbounds ([77 x i8]* @.str7, i64 0, i64 0)}
!214 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !210} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!215 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !210} ; [ DW_TAG_auto_variable ] [res] [line 31]
!216 = metadata !{i32 31, i32 0, metadata !82, metadata !210}
!217 = metadata !{i32 34, i32 0, metadata !169, metadata !210}
!218 = metadata !{i32 36, i32 0, metadata !82, metadata !210}
!219 = metadata !{i32 39, i32 0, metadata !172, metadata !210}
!220 = metadata !{i32 37, i32 0, metadata !173, metadata !210}
!221 = metadata !{i32 40, i32 0, metadata !177, metadata !210}
!222 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !210} ; [ DW_TAG_auto_variable ] [c] [line 32]
!223 = metadata !{i32 42, i32 0, metadata !180, metadata !210}
!224 = metadata !{i32 138, i32 0, metadata !50, null}
!225 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !224} ; [ DW_TAG_arg_variable ] [s] [line 30]
!226 = metadata !{i32 30, i32 0, metadata !82, metadata !224}
!227 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !224} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!228 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !224} ; [ DW_TAG_auto_variable ] [res] [line 31]
!229 = metadata !{i32 31, i32 0, metadata !82, metadata !224}
!230 = metadata !{i32 34, i32 0, metadata !169, metadata !224}
!231 = metadata !{i32 36, i32 0, metadata !82, metadata !224}
!232 = metadata !{i32 39, i32 0, metadata !172, metadata !224}
!233 = metadata !{i32 37, i32 0, metadata !173, metadata !224}
!234 = metadata !{i32 40, i32 0, metadata !177, metadata !224}
!235 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !224} ; [ DW_TAG_auto_variable ] [c] [line 32]
!236 = metadata !{i32 42, i32 0, metadata !180, metadata !224}
!237 = metadata !{i32 139, i32 0, metadata !50, null}
!238 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !237} ; [ DW_TAG_arg_variable ] [s] [line 30]
!239 = metadata !{i32 30, i32 0, metadata !82, metadata !237}
!240 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !237} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!241 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !237} ; [ DW_TAG_auto_variable ] [res] [line 31]
!242 = metadata !{i32 31, i32 0, metadata !82, metadata !237}
!243 = metadata !{i32 34, i32 0, metadata !169, metadata !237}
!244 = metadata !{i32 36, i32 0, metadata !82, metadata !237}
!245 = metadata !{i32 39, i32 0, metadata !172, metadata !237}
!246 = metadata !{i32 37, i32 0, metadata !173, metadata !237}
!247 = metadata !{i32 40, i32 0, metadata !177, metadata !237}
!248 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !237} ; [ DW_TAG_auto_variable ] [c] [line 32]
!249 = metadata !{i32 42, i32 0, metadata !180, metadata !237}
!250 = metadata !{i32 141, i32 0, metadata !50, null}
!251 = metadata !{i32 142, i32 0, metadata !252, null}
!252 = metadata !{i32 786443, metadata !5, metadata !50, i32 142, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!253 = metadata !{i32 143, i32 0, metadata !254, null}
!254 = metadata !{i32 786443, metadata !5, metadata !252, i32 142, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!255 = metadata !{i32 145, i32 0, metadata !254, null}
!256 = metadata !{i32 786689, metadata !74, metadata !"argcMax", metadata !6, i32 67108940, metadata !10, i32 0, metadata !257} ; [ DW_TAG_arg_variable ] [argcMax] [line 76]
!257 = metadata !{i32 144, i32 0, metadata !254, null}
!258 = metadata !{i32 76, i32 0, metadata !74, metadata !257}
!259 = metadata !{i32 77, i32 0, metadata !187, metadata !257}
!260 = metadata !{i32 78, i32 0, metadata !189, metadata !257}
!261 = metadata !{i32 80, i32 0, metadata !191, metadata !257}
!262 = metadata !{i32 81, i32 0, metadata !191, metadata !257}
!263 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !264} ; [ DW_TAG_arg_variable ] [a] [line 53]
!264 = metadata !{i32 149, i32 0, metadata !54, null}
!265 = metadata !{i32 53, i32 0, metadata !96, metadata !264}
!266 = metadata !{i8* getelementptr inbounds ([12 x i8]* @.str9, i64 0, i64 0)}
!267 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !264} ; [ DW_TAG_arg_variable ] [b] [line 53]
!268 = metadata !{i32 54, i32 0, metadata !96, metadata !264}
!269 = metadata !{i32 55, i32 0, metadata !137, metadata !264}
!270 = metadata !{i32 57, i32 0, metadata !138, metadata !264}
!271 = metadata !{i32 58, i32 0, metadata !138, metadata !264} ; [ DW_TAG_imported_module ]
!272 = metadata !{i8* getelementptr inbounds ([11 x i8]* @.str10, i64 0, i64 0)}
!273 = metadata !{null}
!274 = metadata !{i32 150, i32 0, metadata !53, null}
!275 = metadata !{i32 152, i32 0, metadata !276, null}
!276 = metadata !{i32 786443, metadata !5, metadata !53, i32 152, i32 0, i32 13} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!277 = metadata !{i32 153, i32 0, metadata !276, null}
!278 = metadata !{i32 155, i32 0, metadata !53, null}
!279 = metadata !{i32 156, i32 0, metadata !53, null}
!280 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !279} ; [ DW_TAG_arg_variable ] [s] [line 30]
!281 = metadata !{i32 30, i32 0, metadata !82, metadata !279}
!282 = metadata !{i8* getelementptr inbounds ([72 x i8]* @.str11, i64 0, i64 0)}
!283 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !279} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!284 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !279} ; [ DW_TAG_auto_variable ] [res] [line 31]
!285 = metadata !{i32 31, i32 0, metadata !82, metadata !279}
!286 = metadata !{i32 34, i32 0, metadata !169, metadata !279}
!287 = metadata !{i32 36, i32 0, metadata !82, metadata !279}
!288 = metadata !{i32 39, i32 0, metadata !172, metadata !279}
!289 = metadata !{i32 37, i32 0, metadata !173, metadata !279}
!290 = metadata !{i32 40, i32 0, metadata !177, metadata !279}
!291 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !279} ; [ DW_TAG_auto_variable ] [c] [line 32]
!292 = metadata !{i32 42, i32 0, metadata !180, metadata !279}
!293 = metadata !{i32 157, i32 0, metadata !53, null}
!294 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !293} ; [ DW_TAG_arg_variable ] [s] [line 30]
!295 = metadata !{i32 30, i32 0, metadata !82, metadata !293}
!296 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !293} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!297 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !293} ; [ DW_TAG_auto_variable ] [res] [line 31]
!298 = metadata !{i32 31, i32 0, metadata !82, metadata !293}
!299 = metadata !{i32 34, i32 0, metadata !169, metadata !293}
!300 = metadata !{i32 36, i32 0, metadata !82, metadata !293}
!301 = metadata !{i32 39, i32 0, metadata !172, metadata !293}
!302 = metadata !{i32 37, i32 0, metadata !173, metadata !293}
!303 = metadata !{i32 40, i32 0, metadata !177, metadata !293}
!304 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !293} ; [ DW_TAG_auto_variable ] [c] [line 32]
!305 = metadata !{i32 42, i32 0, metadata !180, metadata !293}
!306 = metadata !{i32 159, i32 0, metadata !53, null}
!307 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !308} ; [ DW_TAG_arg_variable ] [a] [line 53]
!308 = metadata !{i32 160, i32 0, metadata !60, null}
!309 = metadata !{i32 53, i32 0, metadata !96, metadata !308}
!310 = metadata !{i8* getelementptr inbounds ([13 x i8]* @.str12, i64 0, i64 0)}
!311 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !308} ; [ DW_TAG_arg_variable ] [b] [line 53]
!312 = metadata !{i32 54, i32 0, metadata !96, metadata !308}
!313 = metadata !{i32 55, i32 0, metadata !137, metadata !308}
!314 = metadata !{i32 57, i32 0, metadata !138, metadata !308}
!315 = metadata !{i32 58, i32 0, metadata !138, metadata !308} ; [ DW_TAG_imported_module ]
!316 = metadata !{i8* getelementptr inbounds ([12 x i8]* @.str13, i64 0, i64 0)}
!317 = metadata !{i32 1}
!318 = metadata !{i32 161, i32 0, metadata !319, null}
!319 = metadata !{i32 786443, metadata !5, metadata !60, i32 160, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!320 = metadata !{i32 162, i32 0, metadata !319, null}
!321 = metadata !{i32 163, i32 0, metadata !319, null}
!322 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !323} ; [ DW_TAG_arg_variable ] [a] [line 53]
!323 = metadata !{i32 164, i32 0, metadata !59, null}
!324 = metadata !{i32 53, i32 0, metadata !96, metadata !323}
!325 = metadata !{i8* getelementptr inbounds ([18 x i8]* @.str14, i64 0, i64 0)}
!326 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !323} ; [ DW_TAG_arg_variable ] [b] [line 53]
!327 = metadata !{i32 54, i32 0, metadata !96, metadata !323}
!328 = metadata !{i32 55, i32 0, metadata !137, metadata !323}
!329 = metadata !{i32 57, i32 0, metadata !138, metadata !323}
!330 = metadata !{i32 58, i32 0, metadata !138, metadata !323} ; [ DW_TAG_imported_module ]
!331 = metadata !{i8* getelementptr inbounds ([17 x i8]* @.str15, i64 0, i64 0)}
!332 = metadata !{i32 165, i32 0, metadata !333, null}
!333 = metadata !{i32 786443, metadata !5, metadata !59, i32 164, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!334 = metadata !{i32 166, i32 0, metadata !333, null}
!335 = metadata !{i32 167, i32 0, metadata !333, null}
!336 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !337} ; [ DW_TAG_arg_variable ] [a] [line 53]
!337 = metadata !{i32 168, i32 0, metadata !58, null}
!338 = metadata !{i32 53, i32 0, metadata !96, metadata !337}
!339 = metadata !{i8* getelementptr inbounds ([10 x i8]* @.str16, i64 0, i64 0)}
!340 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !337} ; [ DW_TAG_arg_variable ] [b] [line 53]
!341 = metadata !{i32 54, i32 0, metadata !96, metadata !337}
!342 = metadata !{i32 55, i32 0, metadata !137, metadata !337}
!343 = metadata !{i32 57, i32 0, metadata !138, metadata !337}
!344 = metadata !{i32 58, i32 0, metadata !138, metadata !337} ; [ DW_TAG_imported_module ]
!345 = metadata !{i8* getelementptr inbounds ([9 x i8]* @.str17, i64 0, i64 0)}
!346 = metadata !{i32 169, i32 0, metadata !347, null}
!347 = metadata !{i32 786443, metadata !5, metadata !58, i32 168, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!348 = metadata !{i32 170, i32 0, metadata !347, null}
!349 = metadata !{i32 171, i32 0, metadata !347, null}
!350 = metadata !{i32 786689, metadata !96, metadata !"a", metadata !6, i32 16777269, metadata !47, i32 0, metadata !351} ; [ DW_TAG_arg_variable ] [a] [line 53]
!351 = metadata !{i32 172, i32 0, metadata !57, null}
!352 = metadata !{i32 53, i32 0, metadata !96, metadata !351}
!353 = metadata !{i8* getelementptr inbounds ([11 x i8]* @.str18, i64 0, i64 0)}
!354 = metadata !{i32 786689, metadata !96, metadata !"b", metadata !6, i32 33554485, metadata !47, i32 0, metadata !351} ; [ DW_TAG_arg_variable ] [b] [line 53]
!355 = metadata !{i32 54, i32 0, metadata !96, metadata !351}
!356 = metadata !{i32 55, i32 0, metadata !137, metadata !351}
!357 = metadata !{i32 57, i32 0, metadata !138, metadata !351}
!358 = metadata !{i32 58, i32 0, metadata !138, metadata !351} ; [ DW_TAG_imported_module ]
!359 = metadata !{i8* getelementptr inbounds ([10 x i8]* @.str19, i64 0, i64 0)}
!360 = metadata !{null}
!361 = metadata !{i32 173, i32 0, metadata !56, null}
!362 = metadata !{i32 174, i32 0, metadata !363, null}
!363 = metadata !{i32 786443, metadata !5, metadata !56, i32 174, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!364 = metadata !{i32 175, i32 0, metadata !363, null}
!365 = metadata !{i32 177, i32 0, metadata !56, null}
!366 = metadata !{i32 786689, metadata !82, metadata !"s", metadata !6, i32 16777246, metadata !13, i32 0, metadata !365} ; [ DW_TAG_arg_variable ] [s] [line 30]
!367 = metadata !{i32 30, i32 0, metadata !82, metadata !365}
!368 = metadata !{i8* getelementptr inbounds ([54 x i8]* @.str20, i64 0, i64 0)}
!369 = metadata !{i32 786689, metadata !82, metadata !"error_msg", metadata !6, i32 33554462, metadata !47, i32 0, metadata !365} ; [ DW_TAG_arg_variable ] [error_msg] [line 30]
!370 = metadata !{i32 786688, metadata !82, metadata !"res", metadata !6, i32 31, metadata !85, i32 0, metadata !365} ; [ DW_TAG_auto_variable ] [res] [line 31]
!371 = metadata !{i32 31, i32 0, metadata !82, metadata !365}
!372 = metadata !{i32 34, i32 0, metadata !169, metadata !365}
!373 = metadata !{i32 36, i32 0, metadata !82, metadata !365}
!374 = metadata !{i32 39, i32 0, metadata !172, metadata !365}
!375 = metadata !{i32 37, i32 0, metadata !173, metadata !365}
!376 = metadata !{i32 40, i32 0, metadata !177, metadata !365}
!377 = metadata !{i32 786688, metadata !82, metadata !"c", metadata !6, i32 32, metadata !14, i32 0, metadata !365} ; [ DW_TAG_auto_variable ] [c] [line 32]
!378 = metadata !{i32 42, i32 0, metadata !180, metadata !365}
!379 = metadata !{i32 178, i32 0, metadata !56, null}
!380 = metadata !{i32 181, i32 0, metadata !381, null}
!381 = metadata !{i32 786443, metadata !5, metadata !57, i32 179, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!382 = metadata !{i32 786689, metadata !74, metadata !"argcMax", metadata !6, i32 67108940, metadata !10, i32 0, metadata !380} ; [ DW_TAG_arg_variable ] [argcMax] [line 76]
!383 = metadata !{i32 76, i32 0, metadata !74, metadata !380}
!384 = metadata !{i32 77, i32 0, metadata !187, metadata !380}
!385 = metadata !{i32 78, i32 0, metadata !189, metadata !380}
!386 = metadata !{i32 80, i32 0, metadata !191, metadata !380}
!387 = metadata !{i32 81, i32 0, metadata !191, metadata !380}
!388 = metadata !{i32 186, i32 0, metadata !4, null}
!389 = metadata !{i32 191, i32 0, metadata !4, null}
!390 = metadata !{i32 193, i32 0, metadata !4, null}
!391 = metadata !{i32 196, i32 0, metadata !4, null}
!392 = metadata !{i32 23, i32 0, metadata !91, null}
!393 = metadata !{i32 24, i32 0, metadata !91, null}
!394 = metadata !{i32 63, i32 0, metadata !61, null}
!395 = metadata !{i32 65, i32 0, metadata !61, null}
!396 = metadata !{i32 66, i32 0, metadata !61, null}
!397 = metadata !{i32 67, i32 0, metadata !61, null}
!398 = metadata !{i32 69, i32 0, metadata !399, null}
!399 = metadata !{i32 786443, metadata !5, metadata !61, i32 69, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/klee_init_env.c]
!400 = metadata !{i32 70, i32 0, metadata !399, null}
!401 = metadata !{i32 786689, metadata !69, metadata !"c", metadata !6, i32 16777264, metadata !48, i32 0, metadata !400} ; [ DW_TAG_arg_variable ] [c] [line 48]
!402 = metadata !{i32 48, i32 0, metadata !69, metadata !400}
!403 = metadata !{i32 50, i32 0, metadata !69, metadata !400}
!404 = metadata !{i32 72, i32 0, metadata !61, null}
!405 = metadata !{i32 73, i32 0, metadata !61, null}
