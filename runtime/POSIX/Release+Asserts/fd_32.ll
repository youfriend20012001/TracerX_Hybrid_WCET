; ModuleID = 'fd_32.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.dirent = type { i64, i64, i16, i8, [256 x i8] }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }
%struct.stat64 = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.statfs = type { i64, i64, i64, i64, i64, i64, i64, %struct.__fsid_t, i64, i64, i64, [4 x i64] }
%struct.__fsid_t = type { [2 x i32] }
%struct.dirent64 = type { i64, i64, i16, i8, [256 x i8] }

@__getdents = alias bitcast (i64 (i32, %struct.dirent*, i64)* @getdents to i32 (i32, %struct.dirent*, i32)*)

; Function Attrs: nounwind ssp uwtable
define i32 @open(i8* %pathname, i32 %flags, ...) #0 {
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !14), !dbg !262
  call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !15), !dbg !262
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !16), !dbg !263
  %1 = and i32 %flags, 64, !dbg !264
  %2 = icmp eq i32 %1, 0, !dbg !264
  br i1 %2, label %21, label %3, !dbg !264

; <label>:3                                       ; preds = %0
  call void @llvm.dbg.declare(metadata !{[1 x %struct.__va_list_tag]* %ap}, metadata !20), !dbg !265
  %4 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*, !dbg !266
  call void @llvm.va_start(i8* %4), !dbg !266
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0, !dbg !267
  %6 = load i32* %5, align 16, !dbg !267
  %7 = icmp ult i32 %6, 41, !dbg !267
  br i1 %7, label %8, label %14, !dbg !267

; <label>:8                                       ; preds = %3
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3, !dbg !267
  %10 = load i8** %9, align 16, !dbg !267
  %11 = sext i32 %6 to i64, !dbg !267
  %12 = getelementptr i8* %10, i64 %11, !dbg !267
  %13 = add i32 %6, 8, !dbg !267
  store i32 %13, i32* %5, align 16, !dbg !267
  br label %18, !dbg !267

; <label>:14                                      ; preds = %3
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2, !dbg !267
  %16 = load i8** %15, align 8, !dbg !267
  %17 = getelementptr i8* %16, i64 8, !dbg !267
  store i8* %17, i8** %15, align 8, !dbg !267
  br label %18, !dbg !267

; <label>:18                                      ; preds = %14, %8
  %.in = phi i8* [ %12, %8 ], [ %16, %14 ]
  %19 = bitcast i8* %.in to i32*, !dbg !267
  %20 = load i32* %19, align 4, !dbg !267
  call void @llvm.dbg.value(metadata !{i32 %20}, i64 0, metadata !16), !dbg !267
  call void @llvm.va_end(i8* %4), !dbg !268
  br label %21, !dbg !269

; <label>:21                                      ; preds = %0, %18
  %mode.0 = phi i32 [ %20, %18 ], [ 0, %0 ]
  %22 = call i32 @__fd_open(i8* %pathname, i32 %flags, i32 %mode.0) #2, !dbg !270
  ret i32 %22, !dbg !270
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #2

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #2

declare i32 @__fd_open(i8*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
define i32 @openat(i32 %fd, i8* %pathname, i32 %flags, ...) #0 {
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !41), !dbg !271
  call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !42), !dbg !271
  call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !43), !dbg !271
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !44), !dbg !272
  %1 = and i32 %flags, 64, !dbg !273
  %2 = icmp eq i32 %1, 0, !dbg !273
  br i1 %2, label %21, label %3, !dbg !273

; <label>:3                                       ; preds = %0
  call void @llvm.dbg.declare(metadata !{[1 x %struct.__va_list_tag]* %ap}, metadata !45), !dbg !274
  %4 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*, !dbg !275
  call void @llvm.va_start(i8* %4), !dbg !275
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0, !dbg !276
  %6 = load i32* %5, align 16, !dbg !276
  %7 = icmp ult i32 %6, 41, !dbg !276
  br i1 %7, label %8, label %14, !dbg !276

; <label>:8                                       ; preds = %3
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3, !dbg !276
  %10 = load i8** %9, align 16, !dbg !276
  %11 = sext i32 %6 to i64, !dbg !276
  %12 = getelementptr i8* %10, i64 %11, !dbg !276
  %13 = add i32 %6, 8, !dbg !276
  store i32 %13, i32* %5, align 16, !dbg !276
  br label %18, !dbg !276

; <label>:14                                      ; preds = %3
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2, !dbg !276
  %16 = load i8** %15, align 8, !dbg !276
  %17 = getelementptr i8* %16, i64 8, !dbg !276
  store i8* %17, i8** %15, align 8, !dbg !276
  br label %18, !dbg !276

; <label>:18                                      ; preds = %14, %8
  %.in = phi i8* [ %12, %8 ], [ %16, %14 ]
  %19 = bitcast i8* %.in to i32*, !dbg !276
  %20 = load i32* %19, align 4, !dbg !276
  call void @llvm.dbg.value(metadata !{i32 %20}, i64 0, metadata !44), !dbg !276
  call void @llvm.va_end(i8* %4), !dbg !277
  br label %21, !dbg !278

; <label>:21                                      ; preds = %0, %18
  %mode.0 = phi i32 [ %20, %18 ], [ 0, %0 ]
  %22 = call i32 @__fd_openat(i32 %fd, i8* %pathname, i32 %flags, i32 %mode.0) #2, !dbg !279
  ret i32 %22, !dbg !279
}

declare i32 @__fd_openat(i32, i8*, i32, i32) #3

; Function Attrs: nounwind ssp uwtable
define i64 @lseek(i32 %fd, i64 %off, i32 %whence) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !55), !dbg !280
  tail call void @llvm.dbg.value(metadata !{i64 %off}, i64 0, metadata !56), !dbg !280
  tail call void @llvm.dbg.value(metadata !{i32 %whence}, i64 0, metadata !57), !dbg !280
  %1 = tail call i64 @__fd_lseek(i32 %fd, i64 %off, i32 %whence) #2, !dbg !281
  ret i64 %1, !dbg !281
}

declare i64 @__fd_lseek(i32, i64, i32) #3

; Function Attrs: nounwind ssp uwtable
define i32 @__xstat(i32 %vers, i8* %path, %struct.stat* nocapture %buf) #0 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i32 %vers}, i64 0, metadata !99), !dbg !282
  call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !100), !dbg !282
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !101), !dbg !282
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !283
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !283
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !102), !dbg !283
  %2 = call i32 @__fd_stat(i8* %path, %struct.stat64* %tmp) #2, !dbg !284
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !122), !dbg !284
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !285), !dbg !287
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !288), !dbg !287
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !289
  %4 = load <2 x i64>* %3, align 16, !dbg !289, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !289
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !289, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !294
  %7 = bitcast i32* %6 to i64*, !dbg !294
  %8 = load i64* %7, align 8, !dbg !294
  %9 = trunc i64 %8 to i32, !dbg !294
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !294
  store i32 %9, i32* %10, align 4, !dbg !294, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !299
  %12 = load i64* %11, align 16, !dbg !299, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !299
  store i64 %12, i64* %13, align 8, !dbg !299, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !303
  store i32 %15, i32* %16, align 4, !dbg !303, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !305
  %18 = load i32* %17, align 16, !dbg !305, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !305
  store i32 %18, i32* %19, align 4, !dbg !305, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !308
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !308
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !308
  %23 = load <2 x i64>* %22, align 8, !dbg !308, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !308
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !308, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !309
  %26 = load i64* %25, align 8, !dbg !309, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !309
  store i64 %26, i64* %27, align 8, !dbg !309, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !312
  %29 = load i64* %28, align 8, !dbg !312, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !312
  store i64 %29, i64* %30, align 8, !dbg !312, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !315
  %32 = load i64* %31, align 8, !dbg !315, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !315
  store i64 %32, i64* %33, align 8, !dbg !315, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !318
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !318
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !318
  %37 = load <2 x i64>* %36, align 8, !dbg !318, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !318
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !318, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !319
  %40 = load i64* %39, align 8, !dbg !319, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !319
  store i64 %40, i64* %41, align 8, !dbg !319, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !322
  %43 = load i64* %42, align 8, !dbg !322, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !322
  store i64 %43, i64* %44, align 8, !dbg !322, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !325
  %46 = load i64* %45, align 8, !dbg !325, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !325
  store i64 %46, i64* %47, align 8, !dbg !325, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !328
  ret i32 %2, !dbg !328
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #2

declare i32 @__fd_stat(i8*, %struct.stat64*) #3

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #2

; Function Attrs: inlinehint nounwind ssp uwtable
define i32 @stat(i8* %path, %struct.stat* nocapture %buf) #4 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !127), !dbg !329
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !128), !dbg !329
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !330
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !330
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !129), !dbg !330
  %2 = call i32 @__fd_stat(i8* %path, %struct.stat64* %tmp) #2, !dbg !331
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !130), !dbg !331
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !332), !dbg !334
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !335), !dbg !334
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !336
  %4 = load <2 x i64>* %3, align 16, !dbg !336, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !336
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !336, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !337
  %7 = bitcast i32* %6 to i64*, !dbg !337
  %8 = load i64* %7, align 8, !dbg !337
  %9 = trunc i64 %8 to i32, !dbg !337
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !337
  store i32 %9, i32* %10, align 4, !dbg !337, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !338
  %12 = load i64* %11, align 16, !dbg !338, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !338
  store i64 %12, i64* %13, align 8, !dbg !338, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !339
  store i32 %15, i32* %16, align 4, !dbg !339, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !340
  %18 = load i32* %17, align 16, !dbg !340, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !340
  store i32 %18, i32* %19, align 4, !dbg !340, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !341
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !341
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !341
  %23 = load <2 x i64>* %22, align 8, !dbg !341, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !341
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !341, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !342
  %26 = load i64* %25, align 8, !dbg !342, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !342
  store i64 %26, i64* %27, align 8, !dbg !342, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !343
  %29 = load i64* %28, align 8, !dbg !343, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !343
  store i64 %29, i64* %30, align 8, !dbg !343, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !344
  %32 = load i64* %31, align 8, !dbg !344, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !344
  store i64 %32, i64* %33, align 8, !dbg !344, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !345
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !345
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !345
  %37 = load <2 x i64>* %36, align 8, !dbg !345, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !345
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !345, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !346
  %40 = load i64* %39, align 8, !dbg !346, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !346
  store i64 %40, i64* %41, align 8, !dbg !346, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !347
  %43 = load i64* %42, align 8, !dbg !347, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !347
  store i64 %43, i64* %44, align 8, !dbg !347, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !348
  %46 = load i64* %45, align 8, !dbg !348, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !348
  store i64 %46, i64* %47, align 8, !dbg !348, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !349
  ret i32 %2, !dbg !349
}

; Function Attrs: nounwind ssp uwtable
define i32 @__lxstat(i32 %vers, i8* %path, %struct.stat* nocapture %buf) #0 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i32 %vers}, i64 0, metadata !133), !dbg !350
  call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !134), !dbg !350
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !135), !dbg !350
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !351
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !351
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !136), !dbg !351
  %2 = call i32 @__fd_lstat(i8* %path, %struct.stat64* %tmp) #2, !dbg !352
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !137), !dbg !352
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !353), !dbg !355
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !356), !dbg !355
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !357
  %4 = load <2 x i64>* %3, align 16, !dbg !357, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !357
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !357, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !358
  %7 = bitcast i32* %6 to i64*, !dbg !358
  %8 = load i64* %7, align 8, !dbg !358
  %9 = trunc i64 %8 to i32, !dbg !358
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !358
  store i32 %9, i32* %10, align 4, !dbg !358, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !359
  %12 = load i64* %11, align 16, !dbg !359, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !359
  store i64 %12, i64* %13, align 8, !dbg !359, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !360
  store i32 %15, i32* %16, align 4, !dbg !360, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !361
  %18 = load i32* %17, align 16, !dbg !361, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !361
  store i32 %18, i32* %19, align 4, !dbg !361, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !362
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !362
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !362
  %23 = load <2 x i64>* %22, align 8, !dbg !362, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !362
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !362, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !363
  %26 = load i64* %25, align 8, !dbg !363, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !363
  store i64 %26, i64* %27, align 8, !dbg !363, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !364
  %29 = load i64* %28, align 8, !dbg !364, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !364
  store i64 %29, i64* %30, align 8, !dbg !364, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !365
  %32 = load i64* %31, align 8, !dbg !365, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !365
  store i64 %32, i64* %33, align 8, !dbg !365, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !366
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !366
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !366
  %37 = load <2 x i64>* %36, align 8, !dbg !366, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !366
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !366, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !367
  %40 = load i64* %39, align 8, !dbg !367, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !367
  store i64 %40, i64* %41, align 8, !dbg !367, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !368
  %43 = load i64* %42, align 8, !dbg !368, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !368
  store i64 %43, i64* %44, align 8, !dbg !368, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !369
  %46 = load i64* %45, align 8, !dbg !369, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !369
  store i64 %46, i64* %47, align 8, !dbg !369, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !370
  ret i32 %2, !dbg !370
}

declare i32 @__fd_lstat(i8*, %struct.stat64*) #3

; Function Attrs: inlinehint nounwind ssp uwtable
define i32 @lstat(i8* %path, %struct.stat* nocapture %buf) #4 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !140), !dbg !371
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !141), !dbg !371
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !372
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !372
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !142), !dbg !372
  %2 = call i32 @__fd_lstat(i8* %path, %struct.stat64* %tmp) #2, !dbg !373
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !143), !dbg !373
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !374), !dbg !376
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !377), !dbg !376
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !378
  %4 = load <2 x i64>* %3, align 16, !dbg !378, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !378
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !378, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !379
  %7 = bitcast i32* %6 to i64*, !dbg !379
  %8 = load i64* %7, align 8, !dbg !379
  %9 = trunc i64 %8 to i32, !dbg !379
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !379
  store i32 %9, i32* %10, align 4, !dbg !379, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !380
  %12 = load i64* %11, align 16, !dbg !380, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !380
  store i64 %12, i64* %13, align 8, !dbg !380, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !381
  store i32 %15, i32* %16, align 4, !dbg !381, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !382
  %18 = load i32* %17, align 16, !dbg !382, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !382
  store i32 %18, i32* %19, align 4, !dbg !382, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !383
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !383
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !383
  %23 = load <2 x i64>* %22, align 8, !dbg !383, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !383
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !383, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !384
  %26 = load i64* %25, align 8, !dbg !384, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !384
  store i64 %26, i64* %27, align 8, !dbg !384, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !385
  %29 = load i64* %28, align 8, !dbg !385, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !385
  store i64 %29, i64* %30, align 8, !dbg !385, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !386
  %32 = load i64* %31, align 8, !dbg !386, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !386
  store i64 %32, i64* %33, align 8, !dbg !386, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !387
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !387
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !387
  %37 = load <2 x i64>* %36, align 8, !dbg !387, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !387
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !387, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !388
  %40 = load i64* %39, align 8, !dbg !388, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !388
  store i64 %40, i64* %41, align 8, !dbg !388, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !389
  %43 = load i64* %42, align 8, !dbg !389, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !389
  store i64 %43, i64* %44, align 8, !dbg !389, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !390
  %46 = load i64* %45, align 8, !dbg !390, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !390
  store i64 %46, i64* %47, align 8, !dbg !390, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !391
  ret i32 %2, !dbg !391
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fxstat(i32 %vers, i32 %fd, %struct.stat* nocapture %buf) #0 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i32 %vers}, i64 0, metadata !148), !dbg !392
  call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !149), !dbg !392
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !150), !dbg !392
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !393
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !393
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !151), !dbg !393
  %2 = call i32 @__fd_fstat(i32 %fd, %struct.stat64* %tmp) #2, !dbg !394
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !152), !dbg !394
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !395), !dbg !397
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !398), !dbg !397
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !399
  %4 = load <2 x i64>* %3, align 16, !dbg !399, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !399
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !399, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !400
  %7 = bitcast i32* %6 to i64*, !dbg !400
  %8 = load i64* %7, align 8, !dbg !400
  %9 = trunc i64 %8 to i32, !dbg !400
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !400
  store i32 %9, i32* %10, align 4, !dbg !400, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !401
  %12 = load i64* %11, align 16, !dbg !401, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !401
  store i64 %12, i64* %13, align 8, !dbg !401, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !402
  store i32 %15, i32* %16, align 4, !dbg !402, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !403
  %18 = load i32* %17, align 16, !dbg !403, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !403
  store i32 %18, i32* %19, align 4, !dbg !403, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !404
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !404
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !404
  %23 = load <2 x i64>* %22, align 8, !dbg !404, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !404
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !404, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !405
  %26 = load i64* %25, align 8, !dbg !405, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !405
  store i64 %26, i64* %27, align 8, !dbg !405, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !406
  %29 = load i64* %28, align 8, !dbg !406, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !406
  store i64 %29, i64* %30, align 8, !dbg !406, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !407
  %32 = load i64* %31, align 8, !dbg !407, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !407
  store i64 %32, i64* %33, align 8, !dbg !407, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !408
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !408
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !408
  %37 = load <2 x i64>* %36, align 8, !dbg !408, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !408
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !408, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !409
  %40 = load i64* %39, align 8, !dbg !409, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !409
  store i64 %40, i64* %41, align 8, !dbg !409, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !410
  %43 = load i64* %42, align 8, !dbg !410, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !410
  store i64 %43, i64* %44, align 8, !dbg !410, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !411
  %46 = load i64* %45, align 8, !dbg !411, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !411
  store i64 %46, i64* %47, align 8, !dbg !411, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !412
  ret i32 %2, !dbg !412
}

declare i32 @__fd_fstat(i32, %struct.stat64*) #3

; Function Attrs: inlinehint nounwind ssp uwtable
define i32 @fstat(i32 %fd, %struct.stat* nocapture %buf) #4 {
  %tmp = alloca %struct.stat64, align 16
  call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !157), !dbg !413
  call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !158), !dbg !413
  %1 = bitcast %struct.stat64* %tmp to i8*, !dbg !414
  call void @llvm.lifetime.start(i64 144, i8* %1) #2, !dbg !414
  call void @llvm.dbg.declare(metadata !{%struct.stat64* %tmp}, metadata !159), !dbg !414
  %2 = call i32 @__fd_fstat(i32 %fd, %struct.stat64* %tmp) #2, !dbg !415
  call void @llvm.dbg.value(metadata !{i32 %2}, i64 0, metadata !160), !dbg !415
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %tmp}, i64 0, metadata !416), !dbg !418
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !419), !dbg !418
  %3 = bitcast %struct.stat64* %tmp to <2 x i64>*, !dbg !420
  %4 = load <2 x i64>* %3, align 16, !dbg !420, !tbaa !290
  %5 = bitcast %struct.stat* %buf to <2 x i64>*, !dbg !420
  store <2 x i64> %4, <2 x i64>* %5, align 8, !dbg !420, !tbaa !290
  %6 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 3, !dbg !421
  %7 = bitcast i32* %6 to i64*, !dbg !421
  %8 = load i64* %7, align 8, !dbg !421
  %9 = trunc i64 %8 to i32, !dbg !421
  %10 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 3, !dbg !421
  store i32 %9, i32* %10, align 4, !dbg !421, !tbaa !295
  %11 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 2, !dbg !422
  %12 = load i64* %11, align 16, !dbg !422, !tbaa !300
  %13 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 2, !dbg !422
  store i64 %12, i64* %13, align 8, !dbg !422, !tbaa !302
  %14 = lshr i64 %8, 32
  %15 = trunc i64 %14 to i32
  %16 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 4, !dbg !423
  store i32 %15, i32* %16, align 4, !dbg !423, !tbaa !304
  %17 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 5, !dbg !424
  %18 = load i32* %17, align 16, !dbg !424, !tbaa !306
  %19 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 5, !dbg !424
  store i32 %18, i32* %19, align 4, !dbg !424, !tbaa !307
  %20 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 7, !dbg !425
  %21 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 7, !dbg !425
  %22 = bitcast i64* %20 to <2 x i64>*, !dbg !425
  %23 = load <2 x i64>* %22, align 8, !dbg !425, !tbaa !290
  %24 = bitcast i64* %21 to <2 x i64>*, !dbg !425
  store <2 x i64> %23, <2 x i64>* %24, align 8, !dbg !425, !tbaa !290
  %25 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 0, !dbg !426
  %26 = load i64* %25, align 8, !dbg !426, !tbaa !310
  %27 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 0, !dbg !426
  store i64 %26, i64* %27, align 8, !dbg !426, !tbaa !311
  %28 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 0, !dbg !427
  %29 = load i64* %28, align 8, !dbg !427, !tbaa !313
  %30 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 0, !dbg !427
  store i64 %29, i64* %30, align 8, !dbg !427, !tbaa !314
  %31 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 0, !dbg !428
  %32 = load i64* %31, align 8, !dbg !428, !tbaa !316
  %33 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 0, !dbg !428
  store i64 %32, i64* %33, align 8, !dbg !428, !tbaa !317
  %34 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 9, !dbg !429
  %35 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 9, !dbg !429
  %36 = bitcast i64* %34 to <2 x i64>*, !dbg !429
  %37 = load <2 x i64>* %36, align 8, !dbg !429, !tbaa !290
  %38 = bitcast i64* %35 to <2 x i64>*, !dbg !429
  store <2 x i64> %37, <2 x i64>* %38, align 8, !dbg !429, !tbaa !290
  %39 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 11, i32 1, !dbg !430
  %40 = load i64* %39, align 8, !dbg !430, !tbaa !320
  %41 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 11, i32 1, !dbg !430
  store i64 %40, i64* %41, align 8, !dbg !430, !tbaa !321
  %42 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 12, i32 1, !dbg !431
  %43 = load i64* %42, align 8, !dbg !431, !tbaa !323
  %44 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 12, i32 1, !dbg !431
  store i64 %43, i64* %44, align 8, !dbg !431, !tbaa !324
  %45 = getelementptr inbounds %struct.stat64* %tmp, i64 0, i32 13, i32 1, !dbg !432
  %46 = load i64* %45, align 8, !dbg !432, !tbaa !326
  %47 = getelementptr inbounds %struct.stat* %buf, i64 0, i32 13, i32 1, !dbg !432
  store i64 %46, i64* %47, align 8, !dbg !432, !tbaa !327
  call void @llvm.lifetime.end(i64 144, i8* %1) #2, !dbg !433
  ret i32 %2, !dbg !433
}

; Function Attrs: nounwind ssp uwtable
define i32 @ftruncate(i32 %fd, i64 %length) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !165), !dbg !434
  tail call void @llvm.dbg.value(metadata !{i64 %length}, i64 0, metadata !166), !dbg !434
  %1 = tail call i32 @__fd_ftruncate(i32 %fd, i64 %length) #2, !dbg !435
  ret i32 %1, !dbg !435
}

declare i32 @__fd_ftruncate(i32, i64) #3

; Function Attrs: nounwind ssp uwtable
define i32 @statfs(i8* %path, %struct.statfs* %buf32) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !201), !dbg !436
  tail call void @llvm.dbg.value(metadata !{%struct.statfs* %buf32}, i64 0, metadata !202), !dbg !436
  %1 = tail call i32 @__fd_statfs(i8* %path, %struct.statfs* %buf32) #2, !dbg !437
  ret i32 %1, !dbg !437
}

declare i32 @__fd_statfs(i8*, %struct.statfs*) #3

; Function Attrs: nounwind ssp uwtable
define i64 @getdents(i32 %fd, %struct.dirent* %dirp, i64 %nbytes) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !224), !dbg !438
  tail call void @llvm.dbg.value(metadata !{%struct.dirent* %dirp}, i64 0, metadata !225), !dbg !438
  tail call void @llvm.dbg.value(metadata !{i64 %nbytes}, i64 0, metadata !226), !dbg !438
  %1 = bitcast %struct.dirent* %dirp to %struct.dirent64*, !dbg !439
  tail call void @llvm.dbg.value(metadata !{%struct.dirent64* %1}, i64 0, metadata !227), !dbg !439
  %2 = trunc i64 %nbytes to i32, !dbg !440
  %3 = tail call i32 @__fd_getdents(i32 %fd, %struct.dirent64* %1, i32 %2) #2, !dbg !440
  %4 = sext i32 %3 to i64, !dbg !440
  tail call void @llvm.dbg.value(metadata !{i64 %4}, i64 0, metadata !237), !dbg !440
  %5 = icmp sgt i32 %3, 0, !dbg !441
  br i1 %5, label %6, label %.loopexit, !dbg !441

; <label>:6                                       ; preds = %0
  %7 = bitcast %struct.dirent* %dirp to i8*, !dbg !442
  %8 = getelementptr inbounds i8* %7, i64 %4, !dbg !442
  %9 = bitcast i8* %8 to %struct.dirent*, !dbg !443
  %10 = icmp ugt %struct.dirent* %9, %dirp, !dbg !443
  br i1 %10, label %.lr.ph, label %.loopexit, !dbg !443

.lr.ph:                                           ; preds = %6, %.lr.ph
  %dp64.01 = phi %struct.dirent64* [ %16, %.lr.ph ], [ %1, %6 ]
  %11 = getelementptr inbounds %struct.dirent64* %dp64.01, i64 0, i32 2, !dbg !444
  %12 = bitcast %struct.dirent64* %dp64.01 to i8*, !dbg !445
  %13 = load i16* %11, align 2, !dbg !445, !tbaa !446
  %14 = zext i16 %13 to i64, !dbg !445
  %15 = getelementptr inbounds i8* %12, i64 %14, !dbg !445
  %16 = bitcast i8* %15 to %struct.dirent64*, !dbg !445
  tail call void @llvm.dbg.value(metadata !{%struct.dirent64* %16}, i64 0, metadata !227), !dbg !445
  %17 = icmp ult i8* %15, %8, !dbg !443
  br i1 %17, label %.lr.ph, label %.loopexit, !dbg !443

.loopexit:                                        ; preds = %.lr.ph, %6, %0
  ret i64 %4, !dbg !449
}

declare i32 @__fd_getdents(i32, %struct.dirent64*, i32) #3

; Function Attrs: nounwind ssp uwtable
define weak i32 @open64(i8* %pathname, i32 %flags, ...) #0 {
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !246), !dbg !450
  call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !247), !dbg !450
  call void @llvm.dbg.value(metadata !2, i64 0, metadata !248), !dbg !451
  %1 = and i32 %flags, 64, !dbg !452
  %2 = icmp eq i32 %1, 0, !dbg !452
  br i1 %2, label %21, label %3, !dbg !452

; <label>:3                                       ; preds = %0
  call void @llvm.dbg.declare(metadata !{[1 x %struct.__va_list_tag]* %ap}, metadata !249), !dbg !453
  %4 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*, !dbg !454
  call void @llvm.va_start(i8* %4), !dbg !454
  %5 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0, !dbg !455
  %6 = load i32* %5, align 16, !dbg !455
  %7 = icmp ult i32 %6, 41, !dbg !455
  br i1 %7, label %8, label %14, !dbg !455

; <label>:8                                       ; preds = %3
  %9 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3, !dbg !455
  %10 = load i8** %9, align 16, !dbg !455
  %11 = sext i32 %6 to i64, !dbg !455
  %12 = getelementptr i8* %10, i64 %11, !dbg !455
  %13 = add i32 %6, 8, !dbg !455
  store i32 %13, i32* %5, align 16, !dbg !455
  br label %18, !dbg !455

; <label>:14                                      ; preds = %3
  %15 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2, !dbg !455
  %16 = load i8** %15, align 8, !dbg !455
  %17 = getelementptr i8* %16, i64 8, !dbg !455
  store i8* %17, i8** %15, align 8, !dbg !455
  br label %18, !dbg !455

; <label>:18                                      ; preds = %14, %8
  %.in = phi i8* [ %12, %8 ], [ %16, %14 ]
  %19 = bitcast i8* %.in to i32*, !dbg !455
  %20 = load i32* %19, align 4, !dbg !455
  call void @llvm.dbg.value(metadata !{i32 %20}, i64 0, metadata !248), !dbg !455
  call void @llvm.va_end(i8* %4), !dbg !456
  br label %21, !dbg !457

; <label>:21                                      ; preds = %0, %18
  %mode.0 = phi i32 [ %20, %18 ], [ 0, %0 ]
  %22 = call i32 @__fd_open(i8* %pathname, i32 %flags, i32 %mode.0) #2, !dbg !458
  ret i32 %22, !dbg !458
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { inlinehint nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!259, !260}
!llvm.ident = !{!261}

!0 = metadata !{i32 786449, metadata !1, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !2, metadata !3, metadata !2, metadata !2, metadata !""} ; [ DW_TAG_compile_unit ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX//home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c] [DW_LANG_C89]
!1 = metadata !{metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!2 = metadata !{i32 0}
!3 = metadata !{metadata !4, metadata !37, metadata !48, metadata !58, metadata !123, metadata !131, metadata !138, metadata !144, metadata !153, metadata !161, metadata !167, metadata !203, metadata !244, metadata !252}
!4 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"open", metadata !"open", metadata !"", i32 65, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32, ...)* @open, null, null, metadata !13, i32 65} ; [ DW_TAG_subprogram ] [line 65] [def] [open]
!5 = metadata !{metadata !"fd_32.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!6 = metadata !{i32 786473, metadata !5}          ; [ DW_TAG_file_type ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!7 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !8, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!8 = metadata !{metadata !9, metadata !10, metadata !9}
!9 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!10 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !11} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!11 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !12} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!12 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!13 = metadata !{metadata !14, metadata !15, metadata !16, metadata !20}
!14 = metadata !{i32 786689, metadata !4, metadata !"pathname", metadata !6, i32 16777281, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 65]
!15 = metadata !{i32 786689, metadata !4, metadata !"flags", metadata !6, i32 33554497, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 65]
!16 = metadata !{i32 786688, metadata !4, metadata !"mode", metadata !6, i32 66, metadata !17, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mode] [line 66]
!17 = metadata !{i32 786454, metadata !5, null, metadata !"mode_t", i32 70, i64 0, i64 0, i64 0, i32 0, metadata !18} ; [ DW_TAG_typedef ] [mode_t] [line 70, size 0, align 0, offset 0] [from __mode_t]
!18 = metadata !{i32 786454, metadata !5, null, metadata !"__mode_t", i32 129, i64 0, i64 0, i64 0, i32 0, metadata !19} ; [ DW_TAG_typedef ] [__mode_t] [line 129, size 0, align 0, offset 0] [from unsigned int]
!19 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!20 = metadata !{i32 786688, metadata !21, metadata !"ap", metadata !6, i32 70, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ap] [line 70]
!21 = metadata !{i32 786443, metadata !5, metadata !22, i32 68, i32 0, i32 1} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!22 = metadata !{i32 786443, metadata !5, metadata !4, i32 68, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!23 = metadata !{i32 786454, metadata !5, null, metadata !"va_list", i32 79, i64 0, i64 0, i64 0, i32 0, metadata !24} ; [ DW_TAG_typedef ] [va_list] [line 79, size 0, align 0, offset 0] [from __gnuc_va_list]
!24 = metadata !{i32 786454, metadata !5, null, metadata !"__gnuc_va_list", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !25} ; [ DW_TAG_typedef ] [__gnuc_va_list] [line 48, size 0, align 0, offset 0] [from __builtin_va_list]
!25 = metadata !{i32 786454, metadata !5, null, metadata !"__builtin_va_list", i32 70, i64 0, i64 0, i64 0, i32 0, metadata !26} ; [ DW_TAG_typedef ] [__builtin_va_list] [line 70, size 0, align 0, offset 0] [from ]
!26 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 192, i64 64, i32 0, i32 0, metadata !27, metadata !35, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 192, align 64, offset 0] [from __va_list_tag]
!27 = metadata !{i32 786454, metadata !5, null, metadata !"__va_list_tag", i32 70, i64 0, i64 0, i64 0, i32 0, metadata !28} ; [ DW_TAG_typedef ] [__va_list_tag] [line 70, size 0, align 0, offset 0] [from __va_list_tag]
!28 = metadata !{i32 786451, metadata !1, null, metadata !"__va_list_tag", i32 70, i64 192, i64 64, i32 0, i32 0, null, metadata !29, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [__va_list_tag] [line 70, size 192, align 64, offset 0] [def] [from ]
!29 = metadata !{metadata !30, metadata !31, metadata !32, metadata !34}
!30 = metadata !{i32 786445, metadata !1, metadata !28, metadata !"gp_offset", i32 70, i64 32, i64 32, i64 0, i32 0, metadata !19} ; [ DW_TAG_member ] [gp_offset] [line 70, size 32, align 32, offset 0] [from unsigned int]
!31 = metadata !{i32 786445, metadata !1, metadata !28, metadata !"fp_offset", i32 70, i64 32, i64 32, i64 32, i32 0, metadata !19} ; [ DW_TAG_member ] [fp_offset] [line 70, size 32, align 32, offset 32] [from unsigned int]
!32 = metadata !{i32 786445, metadata !1, metadata !28, metadata !"overflow_arg_area", i32 70, i64 64, i64 64, i64 64, i32 0, metadata !33} ; [ DW_TAG_member ] [overflow_arg_area] [line 70, size 64, align 64, offset 64] [from ]
!33 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!34 = metadata !{i32 786445, metadata !1, metadata !28, metadata !"reg_save_area", i32 70, i64 64, i64 64, i64 128, i32 0, metadata !33} ; [ DW_TAG_member ] [reg_save_area] [line 70, size 64, align 64, offset 128] [from ]
!35 = metadata !{metadata !36}
!36 = metadata !{i32 786465, i64 0, i64 1}        ; [ DW_TAG_subrange_type ] [0, 0]
!37 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"openat", metadata !"openat", metadata !"", i32 79, metadata !38, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, i32, ...)* @openat, null, null, metadata !40, i32 79} ; [ DW_TAG_subprogram ] [line 79] [def] [openat]
!38 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !39, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!39 = metadata !{metadata !9, metadata !9, metadata !10, metadata !9}
!40 = metadata !{metadata !41, metadata !42, metadata !43, metadata !44, metadata !45}
!41 = metadata !{i32 786689, metadata !37, metadata !"fd", metadata !6, i32 16777295, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 79]
!42 = metadata !{i32 786689, metadata !37, metadata !"pathname", metadata !6, i32 33554511, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 79]
!43 = metadata !{i32 786689, metadata !37, metadata !"flags", metadata !6, i32 50331727, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 79]
!44 = metadata !{i32 786688, metadata !37, metadata !"mode", metadata !6, i32 80, metadata !17, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mode] [line 80]
!45 = metadata !{i32 786688, metadata !46, metadata !"ap", metadata !6, i32 84, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ap] [line 84]
!46 = metadata !{i32 786443, metadata !5, metadata !47, i32 82, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!47 = metadata !{i32 786443, metadata !5, metadata !37, i32 82, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!48 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"lseek", metadata !"lseek", metadata !"", i32 93, metadata !49, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i32, i64, i32)* @lseek, null, null, metadata !54, i32 93} ; [ DW_TAG_subprogram ] [line 93] [def] [lseek]
!49 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !50, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!50 = metadata !{metadata !51, metadata !9, metadata !53, metadata !9}
!51 = metadata !{i32 786454, metadata !5, null, metadata !"__off_t", i32 131, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__off_t] [line 131, size 0, align 0, offset 0] [from long int]
!52 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!53 = metadata !{i32 786454, metadata !5, null, metadata !"off_t", i32 86, i64 0, i64 0, i64 0, i32 0, metadata !51} ; [ DW_TAG_typedef ] [off_t] [line 86, size 0, align 0, offset 0] [from __off_t]
!54 = metadata !{metadata !55, metadata !56, metadata !57}
!55 = metadata !{i32 786689, metadata !48, metadata !"fd", metadata !6, i32 16777309, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 93]
!56 = metadata !{i32 786689, metadata !48, metadata !"off", metadata !6, i32 33554525, metadata !53, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [off] [line 93]
!57 = metadata !{i32 786689, metadata !48, metadata !"whence", metadata !6, i32 50331741, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [whence] [line 93]
!58 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__xstat", metadata !"__xstat", metadata !"", i32 97, metadata !59, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, %struct.stat*)* @__xstat, null, null, metadata !98, i32 97} ; [ DW_TAG_subprogram ] [line 97] [def] [__xstat]
!59 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !60, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!60 = metadata !{metadata !9, metadata !9, metadata !10, metadata !61}
!61 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !62} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stat]
!62 = metadata !{i32 786451, metadata !63, null, metadata !"stat", i32 46, i64 1152, i64 64, i32 0, i32 0, null, metadata !64, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stat] [line 46, size 1152, align 64, offset 0] [def] [from ]
!63 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/stat.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!64 = metadata !{metadata !65, metadata !68, metadata !70, metadata !72, metadata !73, metadata !75, metadata !77, metadata !78, metadata !79, metadata !80, metadata !82, metadata !84, metadata !92, metadata !93, metadata !94}
!65 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_dev", i32 48, i64 64, i64 64, i64 0, i32 0, metadata !66} ; [ DW_TAG_member ] [st_dev] [line 48, size 64, align 64, offset 0] [from __dev_t]
!66 = metadata !{i32 786454, metadata !63, null, metadata !"__dev_t", i32 124, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__dev_t] [line 124, size 0, align 0, offset 0] [from long unsigned int]
!67 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!68 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_ino", i32 53, i64 64, i64 64, i64 64, i32 0, metadata !69} ; [ DW_TAG_member ] [st_ino] [line 53, size 64, align 64, offset 64] [from __ino_t]
!69 = metadata !{i32 786454, metadata !63, null, metadata !"__ino_t", i32 127, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__ino_t] [line 127, size 0, align 0, offset 0] [from long unsigned int]
!70 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_nlink", i32 61, i64 64, i64 64, i64 128, i32 0, metadata !71} ; [ DW_TAG_member ] [st_nlink] [line 61, size 64, align 64, offset 128] [from __nlink_t]
!71 = metadata !{i32 786454, metadata !63, null, metadata !"__nlink_t", i32 130, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__nlink_t] [line 130, size 0, align 0, offset 0] [from long unsigned int]
!72 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_mode", i32 62, i64 32, i64 32, i64 192, i32 0, metadata !18} ; [ DW_TAG_member ] [st_mode] [line 62, size 32, align 32, offset 192] [from __mode_t]
!73 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_uid", i32 64, i64 32, i64 32, i64 224, i32 0, metadata !74} ; [ DW_TAG_member ] [st_uid] [line 64, size 32, align 32, offset 224] [from __uid_t]
!74 = metadata !{i32 786454, metadata !63, null, metadata !"__uid_t", i32 125, i64 0, i64 0, i64 0, i32 0, metadata !19} ; [ DW_TAG_typedef ] [__uid_t] [line 125, size 0, align 0, offset 0] [from unsigned int]
!75 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_gid", i32 65, i64 32, i64 32, i64 256, i32 0, metadata !76} ; [ DW_TAG_member ] [st_gid] [line 65, size 32, align 32, offset 256] [from __gid_t]
!76 = metadata !{i32 786454, metadata !63, null, metadata !"__gid_t", i32 126, i64 0, i64 0, i64 0, i32 0, metadata !19} ; [ DW_TAG_typedef ] [__gid_t] [line 126, size 0, align 0, offset 0] [from unsigned int]
!77 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"__pad0", i32 67, i64 32, i64 32, i64 288, i32 0, metadata !9} ; [ DW_TAG_member ] [__pad0] [line 67, size 32, align 32, offset 288] [from int]
!78 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_rdev", i32 69, i64 64, i64 64, i64 320, i32 0, metadata !66} ; [ DW_TAG_member ] [st_rdev] [line 69, size 64, align 64, offset 320] [from __dev_t]
!79 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_size", i32 74, i64 64, i64 64, i64 384, i32 0, metadata !51} ; [ DW_TAG_member ] [st_size] [line 74, size 64, align 64, offset 384] [from __off_t]
!80 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_blksize", i32 78, i64 64, i64 64, i64 448, i32 0, metadata !81} ; [ DW_TAG_member ] [st_blksize] [line 78, size 64, align 64, offset 448] [from __blksize_t]
!81 = metadata !{i32 786454, metadata !63, null, metadata !"__blksize_t", i32 153, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__blksize_t] [line 153, size 0, align 0, offset 0] [from long int]
!82 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_blocks", i32 80, i64 64, i64 64, i64 512, i32 0, metadata !83} ; [ DW_TAG_member ] [st_blocks] [line 80, size 64, align 64, offset 512] [from __blkcnt_t]
!83 = metadata !{i32 786454, metadata !63, null, metadata !"__blkcnt_t", i32 158, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__blkcnt_t] [line 158, size 0, align 0, offset 0] [from long int]
!84 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_atim", i32 91, i64 128, i64 64, i64 576, i32 0, metadata !85} ; [ DW_TAG_member ] [st_atim] [line 91, size 128, align 64, offset 576] [from timespec]
!85 = metadata !{i32 786451, metadata !86, null, metadata !"timespec", i32 120, i64 128, i64 64, i32 0, i32 0, null, metadata !87, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [timespec] [line 120, size 128, align 64, offset 0] [def] [from ]
!86 = metadata !{metadata !"/usr/include/time.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!87 = metadata !{metadata !88, metadata !90}
!88 = metadata !{i32 786445, metadata !86, metadata !85, metadata !"tv_sec", i32 122, i64 64, i64 64, i64 0, i32 0, metadata !89} ; [ DW_TAG_member ] [tv_sec] [line 122, size 64, align 64, offset 0] [from __time_t]
!89 = metadata !{i32 786454, metadata !86, null, metadata !"__time_t", i32 139, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__time_t] [line 139, size 0, align 0, offset 0] [from long int]
!90 = metadata !{i32 786445, metadata !86, metadata !85, metadata !"tv_nsec", i32 123, i64 64, i64 64, i64 64, i32 0, metadata !91} ; [ DW_TAG_member ] [tv_nsec] [line 123, size 64, align 64, offset 64] [from __syscall_slong_t]
!91 = metadata !{i32 786454, metadata !86, null, metadata !"__syscall_slong_t", i32 175, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__syscall_slong_t] [line 175, size 0, align 0, offset 0] [from long int]
!92 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_mtim", i32 92, i64 128, i64 64, i64 704, i32 0, metadata !85} ; [ DW_TAG_member ] [st_mtim] [line 92, size 128, align 64, offset 704] [from timespec]
!93 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"st_ctim", i32 93, i64 128, i64 64, i64 832, i32 0, metadata !85} ; [ DW_TAG_member ] [st_ctim] [line 93, size 128, align 64, offset 832] [from timespec]
!94 = metadata !{i32 786445, metadata !63, metadata !62, metadata !"__glibc_reserved", i32 106, i64 192, i64 64, i64 960, i32 0, metadata !95} ; [ DW_TAG_member ] [__glibc_reserved] [line 106, size 192, align 64, offset 960] [from ]
!95 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 192, i64 64, i32 0, i32 0, metadata !91, metadata !96, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 192, align 64, offset 0] [from __syscall_slong_t]
!96 = metadata !{metadata !97}
!97 = metadata !{i32 786465, i64 0, i64 3}        ; [ DW_TAG_subrange_type ] [0, 2]
!98 = metadata !{metadata !99, metadata !100, metadata !101, metadata !102, metadata !122}
!99 = metadata !{i32 786689, metadata !58, metadata !"vers", metadata !6, i32 16777313, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vers] [line 97]
!100 = metadata !{i32 786689, metadata !58, metadata !"path", metadata !6, i32 33554529, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 97]
!101 = metadata !{i32 786689, metadata !58, metadata !"buf", metadata !6, i32 50331745, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 97]
!102 = metadata !{i32 786688, metadata !58, metadata !"tmp", metadata !6, i32 98, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 98]
!103 = metadata !{i32 786451, metadata !63, null, metadata !"stat64", i32 119, i64 1152, i64 64, i32 0, i32 0, null, metadata !104, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stat64] [line 119, size 1152, align 64, offset 0] [def] [from ]
!104 = metadata !{metadata !105, metadata !106, metadata !108, metadata !109, metadata !110, metadata !111, metadata !112, metadata !113, metadata !114, metadata !115, metadata !116, metadata !118, metadata !119, metadata !120, metadata !121}
!105 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_dev", i32 121, i64 64, i64 64, i64 0, i32 0, metadata !66} ; [ DW_TAG_member ] [st_dev] [line 121, size 64, align 64, offset 0] [from __dev_t]
!106 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_ino", i32 123, i64 64, i64 64, i64 64, i32 0, metadata !107} ; [ DW_TAG_member ] [st_ino] [line 123, size 64, align 64, offset 64] [from __ino64_t]
!107 = metadata !{i32 786454, metadata !63, null, metadata !"__ino64_t", i32 128, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__ino64_t] [line 128, size 0, align 0, offset 0] [from long unsigned int]
!108 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_nlink", i32 124, i64 64, i64 64, i64 128, i32 0, metadata !71} ; [ DW_TAG_member ] [st_nlink] [line 124, size 64, align 64, offset 128] [from __nlink_t]
!109 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_mode", i32 125, i64 32, i64 32, i64 192, i32 0, metadata !18} ; [ DW_TAG_member ] [st_mode] [line 125, size 32, align 32, offset 192] [from __mode_t]
!110 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_uid", i32 132, i64 32, i64 32, i64 224, i32 0, metadata !74} ; [ DW_TAG_member ] [st_uid] [line 132, size 32, align 32, offset 224] [from __uid_t]
!111 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_gid", i32 133, i64 32, i64 32, i64 256, i32 0, metadata !76} ; [ DW_TAG_member ] [st_gid] [line 133, size 32, align 32, offset 256] [from __gid_t]
!112 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"__pad0", i32 135, i64 32, i64 32, i64 288, i32 0, metadata !9} ; [ DW_TAG_member ] [__pad0] [line 135, size 32, align 32, offset 288] [from int]
!113 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_rdev", i32 136, i64 64, i64 64, i64 320, i32 0, metadata !66} ; [ DW_TAG_member ] [st_rdev] [line 136, size 64, align 64, offset 320] [from __dev_t]
!114 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_size", i32 137, i64 64, i64 64, i64 384, i32 0, metadata !51} ; [ DW_TAG_member ] [st_size] [line 137, size 64, align 64, offset 384] [from __off_t]
!115 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_blksize", i32 143, i64 64, i64 64, i64 448, i32 0, metadata !81} ; [ DW_TAG_member ] [st_blksize] [line 143, size 64, align 64, offset 448] [from __blksize_t]
!116 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_blocks", i32 144, i64 64, i64 64, i64 512, i32 0, metadata !117} ; [ DW_TAG_member ] [st_blocks] [line 144, size 64, align 64, offset 512] [from __blkcnt64_t]
!117 = metadata !{i32 786454, metadata !63, null, metadata !"__blkcnt64_t", i32 159, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__blkcnt64_t] [line 159, size 0, align 0, offset 0] [from long int]
!118 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_atim", i32 152, i64 128, i64 64, i64 576, i32 0, metadata !85} ; [ DW_TAG_member ] [st_atim] [line 152, size 128, align 64, offset 576] [from timespec]
!119 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_mtim", i32 153, i64 128, i64 64, i64 704, i32 0, metadata !85} ; [ DW_TAG_member ] [st_mtim] [line 153, size 128, align 64, offset 704] [from timespec]
!120 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"st_ctim", i32 154, i64 128, i64 64, i64 832, i32 0, metadata !85} ; [ DW_TAG_member ] [st_ctim] [line 154, size 128, align 64, offset 832] [from timespec]
!121 = metadata !{i32 786445, metadata !63, metadata !103, metadata !"__glibc_reserved", i32 164, i64 192, i64 64, i64 960, i32 0, metadata !95} ; [ DW_TAG_member ] [__glibc_reserved] [line 164, size 192, align 64, offset 960] [from ]
!122 = metadata !{i32 786688, metadata !58, metadata !"res", metadata !6, i32 99, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 99]
!123 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"stat", metadata !"stat", metadata !"", i32 104, metadata !124, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stat*)* @stat, null, null, metadata !126, i32 104} ; [ DW_TAG_subprogram ] [line 104] [def] [stat]
!124 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !125, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!125 = metadata !{metadata !9, metadata !10, metadata !61}
!126 = metadata !{metadata !127, metadata !128, metadata !129, metadata !130}
!127 = metadata !{i32 786689, metadata !123, metadata !"path", metadata !6, i32 16777320, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 104]
!128 = metadata !{i32 786689, metadata !123, metadata !"buf", metadata !6, i32 33554536, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 104]
!129 = metadata !{i32 786688, metadata !123, metadata !"tmp", metadata !6, i32 105, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 105]
!130 = metadata !{i32 786688, metadata !123, metadata !"res", metadata !6, i32 106, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 106]
!131 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__lxstat", metadata !"__lxstat", metadata !"", i32 111, metadata !59, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, %struct.stat*)* @__lxstat, null, null, metadata !132, i32 111} ; [ DW_TAG_subprogram ] [line 111] [def] [__lxstat]
!132 = metadata !{metadata !133, metadata !134, metadata !135, metadata !136, metadata !137}
!133 = metadata !{i32 786689, metadata !131, metadata !"vers", metadata !6, i32 16777327, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vers] [line 111]
!134 = metadata !{i32 786689, metadata !131, metadata !"path", metadata !6, i32 33554543, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 111]
!135 = metadata !{i32 786689, metadata !131, metadata !"buf", metadata !6, i32 50331759, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 111]
!136 = metadata !{i32 786688, metadata !131, metadata !"tmp", metadata !6, i32 112, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 112]
!137 = metadata !{i32 786688, metadata !131, metadata !"res", metadata !6, i32 113, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 113]
!138 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"lstat", metadata !"lstat", metadata !"", i32 118, metadata !124, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stat*)* @lstat, null, null, metadata !139, i32 118} ; [ DW_TAG_subprogram ] [line 118] [def] [lstat]
!139 = metadata !{metadata !140, metadata !141, metadata !142, metadata !143}
!140 = metadata !{i32 786689, metadata !138, metadata !"path", metadata !6, i32 16777334, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 118]
!141 = metadata !{i32 786689, metadata !138, metadata !"buf", metadata !6, i32 33554550, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 118]
!142 = metadata !{i32 786688, metadata !138, metadata !"tmp", metadata !6, i32 119, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 119]
!143 = metadata !{i32 786688, metadata !138, metadata !"res", metadata !6, i32 120, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 120]
!144 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__fxstat", metadata !"__fxstat", metadata !"", i32 125, metadata !145, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, %struct.stat*)* @__fxstat, null, null, metadata !147, i32 125} ; [ DW_TAG_subprogram ] [line 125] [def] [__fxstat]
!145 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !146, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!146 = metadata !{metadata !9, metadata !9, metadata !9, metadata !61}
!147 = metadata !{metadata !148, metadata !149, metadata !150, metadata !151, metadata !152}
!148 = metadata !{i32 786689, metadata !144, metadata !"vers", metadata !6, i32 16777341, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [vers] [line 125]
!149 = metadata !{i32 786689, metadata !144, metadata !"fd", metadata !6, i32 33554557, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 125]
!150 = metadata !{i32 786689, metadata !144, metadata !"buf", metadata !6, i32 50331773, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 125]
!151 = metadata !{i32 786688, metadata !144, metadata !"tmp", metadata !6, i32 126, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 126]
!152 = metadata !{i32 786688, metadata !144, metadata !"res", metadata !6, i32 127, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 127]
!153 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"fstat", metadata !"fstat", metadata !"", i32 132, metadata !154, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, %struct.stat*)* @fstat, null, null, metadata !156, i32 132} ; [ DW_TAG_subprogram ] [line 132] [def] [fstat]
!154 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !155, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!155 = metadata !{metadata !9, metadata !9, metadata !61}
!156 = metadata !{metadata !157, metadata !158, metadata !159, metadata !160}
!157 = metadata !{i32 786689, metadata !153, metadata !"fd", metadata !6, i32 16777348, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 132]
!158 = metadata !{i32 786689, metadata !153, metadata !"buf", metadata !6, i32 33554564, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 132]
!159 = metadata !{i32 786688, metadata !153, metadata !"tmp", metadata !6, i32 133, metadata !103, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tmp] [line 133]
!160 = metadata !{i32 786688, metadata !153, metadata !"res", metadata !6, i32 134, metadata !9, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 134]
!161 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"ftruncate", metadata !"ftruncate", metadata !"", i32 139, metadata !162, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i64)* @ftruncate, null, null, metadata !164, i32 139} ; [ DW_TAG_subprogram ] [line 139] [def] [ftruncate]
!162 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !163, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!163 = metadata !{metadata !9, metadata !9, metadata !53}
!164 = metadata !{metadata !165, metadata !166}
!165 = metadata !{i32 786689, metadata !161, metadata !"fd", metadata !6, i32 16777355, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 139]
!166 = metadata !{i32 786689, metadata !161, metadata !"length", metadata !6, i32 33554571, metadata !53, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [length] [line 139]
!167 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"statfs", metadata !"statfs", metadata !"", i32 143, metadata !168, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.statfs*)* @statfs, null, null, metadata !200, i32 143} ; [ DW_TAG_subprogram ] [line 143] [def] [statfs]
!168 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !169, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!169 = metadata !{metadata !9, metadata !10, metadata !170}
!170 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !171} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from statfs]
!171 = metadata !{i32 786451, metadata !172, null, metadata !"statfs", i32 24, i64 960, i64 64, i32 0, i32 0, null, metadata !173, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [statfs] [line 24, size 960, align 64, offset 0] [def] [from ]
!172 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/statfs.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!173 = metadata !{metadata !174, metadata !176, metadata !177, metadata !179, metadata !180, metadata !181, metadata !183, metadata !184, metadata !193, metadata !194, metadata !195, metadata !196}
!174 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_type", i32 26, i64 64, i64 64, i64 0, i32 0, metadata !175} ; [ DW_TAG_member ] [f_type] [line 26, size 64, align 64, offset 0] [from __fsword_t]
!175 = metadata !{i32 786454, metadata !172, null, metadata !"__fsword_t", i32 170, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__fsword_t] [line 170, size 0, align 0, offset 0] [from long int]
!176 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_bsize", i32 27, i64 64, i64 64, i64 64, i32 0, metadata !175} ; [ DW_TAG_member ] [f_bsize] [line 27, size 64, align 64, offset 64] [from __fsword_t]
!177 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_blocks", i32 29, i64 64, i64 64, i64 128, i32 0, metadata !178} ; [ DW_TAG_member ] [f_blocks] [line 29, size 64, align 64, offset 128] [from __fsblkcnt_t]
!178 = metadata !{i32 786454, metadata !172, null, metadata !"__fsblkcnt_t", i32 162, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__fsblkcnt_t] [line 162, size 0, align 0, offset 0] [from long unsigned int]
!179 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_bfree", i32 30, i64 64, i64 64, i64 192, i32 0, metadata !178} ; [ DW_TAG_member ] [f_bfree] [line 30, size 64, align 64, offset 192] [from __fsblkcnt_t]
!180 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_bavail", i32 31, i64 64, i64 64, i64 256, i32 0, metadata !178} ; [ DW_TAG_member ] [f_bavail] [line 31, size 64, align 64, offset 256] [from __fsblkcnt_t]
!181 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_files", i32 32, i64 64, i64 64, i64 320, i32 0, metadata !182} ; [ DW_TAG_member ] [f_files] [line 32, size 64, align 64, offset 320] [from __fsfilcnt_t]
!182 = metadata !{i32 786454, metadata !172, null, metadata !"__fsfilcnt_t", i32 166, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__fsfilcnt_t] [line 166, size 0, align 0, offset 0] [from long unsigned int]
!183 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_ffree", i32 33, i64 64, i64 64, i64 384, i32 0, metadata !182} ; [ DW_TAG_member ] [f_ffree] [line 33, size 64, align 64, offset 384] [from __fsfilcnt_t]
!184 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_fsid", i32 41, i64 64, i64 32, i64 448, i32 0, metadata !185} ; [ DW_TAG_member ] [f_fsid] [line 41, size 64, align 32, offset 448] [from __fsid_t]
!185 = metadata !{i32 786454, metadata !172, null, metadata !"__fsid_t", i32 134, i64 0, i64 0, i64 0, i32 0, metadata !186} ; [ DW_TAG_typedef ] [__fsid_t] [line 134, size 0, align 0, offset 0] [from ]
!186 = metadata !{i32 786451, metadata !187, null, metadata !"", i32 134, i64 64, i64 32, i32 0, i32 0, null, metadata !188, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 134, size 64, align 32, offset 0] [def] [from ]
!187 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/types.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!188 = metadata !{metadata !189}
!189 = metadata !{i32 786445, metadata !187, metadata !186, metadata !"__val", i32 134, i64 64, i64 32, i64 0, i32 0, metadata !190} ; [ DW_TAG_member ] [__val] [line 134, size 64, align 32, offset 0] [from ]
!190 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 64, i64 32, i32 0, i32 0, metadata !9, metadata !191, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 32, offset 0] [from int]
!191 = metadata !{metadata !192}
!192 = metadata !{i32 786465, i64 0, i64 2}       ; [ DW_TAG_subrange_type ] [0, 1]
!193 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_namelen", i32 42, i64 64, i64 64, i64 512, i32 0, metadata !175} ; [ DW_TAG_member ] [f_namelen] [line 42, size 64, align 64, offset 512] [from __fsword_t]
!194 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_frsize", i32 43, i64 64, i64 64, i64 576, i32 0, metadata !175} ; [ DW_TAG_member ] [f_frsize] [line 43, size 64, align 64, offset 576] [from __fsword_t]
!195 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_flags", i32 44, i64 64, i64 64, i64 640, i32 0, metadata !175} ; [ DW_TAG_member ] [f_flags] [line 44, size 64, align 64, offset 640] [from __fsword_t]
!196 = metadata !{i32 786445, metadata !172, metadata !171, metadata !"f_spare", i32 45, i64 256, i64 64, i64 704, i32 0, metadata !197} ; [ DW_TAG_member ] [f_spare] [line 45, size 256, align 64, offset 704] [from ]
!197 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 256, i64 64, i32 0, i32 0, metadata !175, metadata !198, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 256, align 64, offset 0] [from __fsword_t]
!198 = metadata !{metadata !199}
!199 = metadata !{i32 786465, i64 0, i64 4}       ; [ DW_TAG_subrange_type ] [0, 3]
!200 = metadata !{metadata !201, metadata !202}
!201 = metadata !{i32 786689, metadata !167, metadata !"path", metadata !6, i32 16777359, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 143]
!202 = metadata !{i32 786689, metadata !167, metadata !"buf32", metadata !6, i32 33554575, metadata !170, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf32] [line 143]
!203 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"getdents", metadata !"getdents", metadata !"", i32 168, metadata !204, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i32, %struct.dirent*, i64)* @getdents, null, null, metadata !223, i32 168} ; [ DW_TAG_subprogram ] [line 168] [def] [getdents]
!204 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !205, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!205 = metadata !{metadata !206, metadata !9, metadata !208, metadata !222}
!206 = metadata !{i32 786454, metadata !5, null, metadata !"ssize_t", i32 109, i64 0, i64 0, i64 0, i32 0, metadata !207} ; [ DW_TAG_typedef ] [ssize_t] [line 109, size 0, align 0, offset 0] [from __ssize_t]
!207 = metadata !{i32 786454, metadata !5, null, metadata !"__ssize_t", i32 172, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__ssize_t] [line 172, size 0, align 0, offset 0] [from long int]
!208 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !209} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dirent]
!209 = metadata !{i32 786451, metadata !210, null, metadata !"dirent", i32 22, i64 2240, i64 64, i32 0, i32 0, null, metadata !211, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [dirent] [line 22, size 2240, align 64, offset 0] [def] [from ]
!210 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/dirent.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!211 = metadata !{metadata !212, metadata !213, metadata !214, metadata !216, metadata !218}
!212 = metadata !{i32 786445, metadata !210, metadata !209, metadata !"d_ino", i32 25, i64 64, i64 64, i64 0, i32 0, metadata !69} ; [ DW_TAG_member ] [d_ino] [line 25, size 64, align 64, offset 0] [from __ino_t]
!213 = metadata !{i32 786445, metadata !210, metadata !209, metadata !"d_off", i32 26, i64 64, i64 64, i64 64, i32 0, metadata !51} ; [ DW_TAG_member ] [d_off] [line 26, size 64, align 64, offset 64] [from __off_t]
!214 = metadata !{i32 786445, metadata !210, metadata !209, metadata !"d_reclen", i32 31, i64 16, i64 16, i64 128, i32 0, metadata !215} ; [ DW_TAG_member ] [d_reclen] [line 31, size 16, align 16, offset 128] [from unsigned short]
!215 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!216 = metadata !{i32 786445, metadata !210, metadata !209, metadata !"d_type", i32 32, i64 8, i64 8, i64 144, i32 0, metadata !217} ; [ DW_TAG_member ] [d_type] [line 32, size 8, align 8, offset 144] [from unsigned char]
!217 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!218 = metadata !{i32 786445, metadata !210, metadata !209, metadata !"d_name", i32 33, i64 2048, i64 8, i64 152, i32 0, metadata !219} ; [ DW_TAG_member ] [d_name] [line 33, size 2048, align 8, offset 152] [from ]
!219 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2048, i64 8, i32 0, i32 0, metadata !12, metadata !220, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2048, align 8, offset 0] [from char]
!220 = metadata !{metadata !221}
!221 = metadata !{i32 786465, i64 0, i64 256}     ; [ DW_TAG_subrange_type ] [0, 255]
!222 = metadata !{i32 786454, metadata !5, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!223 = metadata !{metadata !224, metadata !225, metadata !226, metadata !227, metadata !237, metadata !238, metadata !241, metadata !243}
!224 = metadata !{i32 786689, metadata !203, metadata !"fd", metadata !6, i32 16777384, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 168]
!225 = metadata !{i32 786689, metadata !203, metadata !"dirp", metadata !6, i32 33554600, metadata !208, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dirp] [line 168]
!226 = metadata !{i32 786689, metadata !203, metadata !"nbytes", metadata !6, i32 50331816, metadata !222, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nbytes] [line 168]
!227 = metadata !{i32 786688, metadata !203, metadata !"dp64", metadata !6, i32 169, metadata !228, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dp64] [line 169]
!228 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !229} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dirent64]
!229 = metadata !{i32 786451, metadata !210, null, metadata !"dirent64", i32 37, i64 2240, i64 64, i32 0, i32 0, null, metadata !230, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [dirent64] [line 37, size 2240, align 64, offset 0] [def] [from ]
!230 = metadata !{metadata !231, metadata !232, metadata !234, metadata !235, metadata !236}
!231 = metadata !{i32 786445, metadata !210, metadata !229, metadata !"d_ino", i32 39, i64 64, i64 64, i64 0, i32 0, metadata !107} ; [ DW_TAG_member ] [d_ino] [line 39, size 64, align 64, offset 0] [from __ino64_t]
!232 = metadata !{i32 786445, metadata !210, metadata !229, metadata !"d_off", i32 40, i64 64, i64 64, i64 64, i32 0, metadata !233} ; [ DW_TAG_member ] [d_off] [line 40, size 64, align 64, offset 64] [from __off64_t]
!233 = metadata !{i32 786454, metadata !210, null, metadata !"__off64_t", i32 132, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__off64_t] [line 132, size 0, align 0, offset 0] [from long int]
!234 = metadata !{i32 786445, metadata !210, metadata !229, metadata !"d_reclen", i32 41, i64 16, i64 16, i64 128, i32 0, metadata !215} ; [ DW_TAG_member ] [d_reclen] [line 41, size 16, align 16, offset 128] [from unsigned short]
!235 = metadata !{i32 786445, metadata !210, metadata !229, metadata !"d_type", i32 42, i64 8, i64 8, i64 144, i32 0, metadata !217} ; [ DW_TAG_member ] [d_type] [line 42, size 8, align 8, offset 144] [from unsigned char]
!236 = metadata !{i32 786445, metadata !210, metadata !229, metadata !"d_name", i32 43, i64 2048, i64 8, i64 152, i32 0, metadata !219} ; [ DW_TAG_member ] [d_name] [line 43, size 2048, align 8, offset 152] [from ]
!237 = metadata !{i32 786688, metadata !203, metadata !"res", metadata !6, i32 170, metadata !206, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 170]
!238 = metadata !{i32 786688, metadata !239, metadata !"end", metadata !6, i32 173, metadata !228, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [end] [line 173]
!239 = metadata !{i32 786443, metadata !5, metadata !240, i32 172, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!240 = metadata !{i32 786443, metadata !5, metadata !203, i32 172, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!241 = metadata !{i32 786688, metadata !242, metadata !"dp", metadata !6, i32 175, metadata !208, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dp] [line 175]
!242 = metadata !{i32 786443, metadata !5, metadata !239, i32 174, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!243 = metadata !{i32 786688, metadata !242, metadata !"name_len", metadata !6, i32 176, metadata !222, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [name_len] [line 176]
!244 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"open64", metadata !"open64", metadata !"", i32 194, metadata !7, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32, ...)* @open64, null, null, metadata !245, i32 194} ; [ DW_TAG_subprogram ] [line 194] [def] [open64]
!245 = metadata !{metadata !246, metadata !247, metadata !248, metadata !249}
!246 = metadata !{i32 786689, metadata !244, metadata !"pathname", metadata !6, i32 16777410, metadata !10, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 194]
!247 = metadata !{i32 786689, metadata !244, metadata !"flags", metadata !6, i32 33554626, metadata !9, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 194]
!248 = metadata !{i32 786688, metadata !244, metadata !"mode", metadata !6, i32 195, metadata !17, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mode] [line 195]
!249 = metadata !{i32 786688, metadata !250, metadata !"ap", metadata !6, i32 199, metadata !23, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ap] [line 199]
!250 = metadata !{i32 786443, metadata !5, metadata !251, i32 197, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!251 = metadata !{i32 786443, metadata !5, metadata !244, i32 197, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd_32.c]
!252 = metadata !{i32 786478, metadata !5, metadata !6, metadata !"__stat64_to_stat", metadata !"__stat64_to_stat", metadata !"", i32 41, metadata !253, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !256, i32 41} ; [ DW_TAG_subprogram ] [line 41] [local] [def] [__stat64_to_stat]
!253 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !254, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!254 = metadata !{null, metadata !255, metadata !61}
!255 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !103} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stat64]
!256 = metadata !{metadata !257, metadata !258}
!257 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [a] [line 41]
!258 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [b] [line 41]
!259 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!260 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!261 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!262 = metadata !{i32 65, i32 0, metadata !4, null}
!263 = metadata !{i32 66, i32 0, metadata !4, null}
!264 = metadata !{i32 68, i32 0, metadata !22, null}
!265 = metadata !{i32 70, i32 0, metadata !21, null}
!266 = metadata !{i32 71, i32 0, metadata !21, null}
!267 = metadata !{i32 72, i32 0, metadata !21, null}
!268 = metadata !{i32 73, i32 0, metadata !21, null}
!269 = metadata !{i32 74, i32 0, metadata !21, null}
!270 = metadata !{i32 76, i32 0, metadata !4, null}
!271 = metadata !{i32 79, i32 0, metadata !37, null}
!272 = metadata !{i32 80, i32 0, metadata !37, null}
!273 = metadata !{i32 82, i32 0, metadata !47, null}
!274 = metadata !{i32 84, i32 0, metadata !46, null}
!275 = metadata !{i32 85, i32 0, metadata !46, null}
!276 = metadata !{i32 86, i32 0, metadata !46, null}
!277 = metadata !{i32 87, i32 0, metadata !46, null}
!278 = metadata !{i32 88, i32 0, metadata !46, null}
!279 = metadata !{i32 90, i32 0, metadata !37, null}
!280 = metadata !{i32 93, i32 0, metadata !48, null}
!281 = metadata !{i32 94, i32 0, metadata !48, null}
!282 = metadata !{i32 97, i32 0, metadata !58, null}
!283 = metadata !{i32 98, i32 0, metadata !58, null}
!284 = metadata !{i32 99, i32 0, metadata !58, null}
!285 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !286} ; [ DW_TAG_arg_variable ] [a] [line 41]
!286 = metadata !{i32 100, i32 0, metadata !58, null}
!287 = metadata !{i32 41, i32 0, metadata !252, metadata !286}
!288 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !286} ; [ DW_TAG_arg_variable ] [b] [line 41]
!289 = metadata !{i32 42, i32 0, metadata !252, metadata !286}
!290 = metadata !{metadata !291, metadata !291, i64 0}
!291 = metadata !{metadata !"long", metadata !292, i64 0}
!292 = metadata !{metadata !"omnipotent char", metadata !293, i64 0}
!293 = metadata !{metadata !"Simple C/C++ TBAA"}
!294 = metadata !{i32 44, i32 0, metadata !252, metadata !286}
!295 = metadata !{metadata !296, metadata !297, i64 24}
!296 = metadata !{metadata !"stat", metadata !291, i64 0, metadata !291, i64 8, metadata !291, i64 16, metadata !297, i64 24, metadata !297, i64 28, metadata !297, i64 32, metadata !297, i64 36, metadata !291, i64 40, metadata !291, i64 48, metadata !291, i64 56, metadata !291, i64 64, metadata !298, i64 72, metadata !298, i64 88, metadata !298, i64 104, metadata !292, i64 120}
!297 = metadata !{metadata !"int", metadata !292, i64 0}
!298 = metadata !{metadata !"timespec", metadata !291, i64 0, metadata !291, i64 8}
!299 = metadata !{i32 45, i32 0, metadata !252, metadata !286}
!300 = metadata !{metadata !301, metadata !291, i64 16}
!301 = metadata !{metadata !"stat64", metadata !291, i64 0, metadata !291, i64 8, metadata !291, i64 16, metadata !297, i64 24, metadata !297, i64 28, metadata !297, i64 32, metadata !297, i64 36, metadata !291, i64 40, metadata !291, i64 48, metadata !291, i64 56, metadata !291, i64 64, metadata !298, i64 72, metadata !298, i64 88, metadata !298, i64 104, metadata !292, i64 120}
!302 = metadata !{metadata !296, metadata !291, i64 16}
!303 = metadata !{i32 46, i32 0, metadata !252, metadata !286}
!304 = metadata !{metadata !296, metadata !297, i64 28}
!305 = metadata !{i32 47, i32 0, metadata !252, metadata !286}
!306 = metadata !{metadata !301, metadata !297, i64 32}
!307 = metadata !{metadata !296, metadata !297, i64 32}
!308 = metadata !{i32 48, i32 0, metadata !252, metadata !286}
!309 = metadata !{i32 50, i32 0, metadata !252, metadata !286}
!310 = metadata !{metadata !301, metadata !291, i64 72}
!311 = metadata !{metadata !296, metadata !291, i64 72}
!312 = metadata !{i32 51, i32 0, metadata !252, metadata !286}
!313 = metadata !{metadata !301, metadata !291, i64 88}
!314 = metadata !{metadata !296, metadata !291, i64 88}
!315 = metadata !{i32 52, i32 0, metadata !252, metadata !286}
!316 = metadata !{metadata !301, metadata !291, i64 104}
!317 = metadata !{metadata !296, metadata !291, i64 104}
!318 = metadata !{i32 53, i32 0, metadata !252, metadata !286}
!319 = metadata !{i32 56, i32 0, metadata !252, metadata !286}
!320 = metadata !{metadata !301, metadata !291, i64 80}
!321 = metadata !{metadata !296, metadata !291, i64 80}
!322 = metadata !{i32 57, i32 0, metadata !252, metadata !286}
!323 = metadata !{metadata !301, metadata !291, i64 96}
!324 = metadata !{metadata !296, metadata !291, i64 96}
!325 = metadata !{i32 58, i32 0, metadata !252, metadata !286} ; [ DW_TAG_imported_module ]
!326 = metadata !{metadata !301, metadata !291, i64 112}
!327 = metadata !{metadata !296, metadata !291, i64 112}
!328 = metadata !{i32 102, i32 0, metadata !58, null}
!329 = metadata !{i32 104, i32 0, metadata !123, null}
!330 = metadata !{i32 105, i32 0, metadata !123, null}
!331 = metadata !{i32 106, i32 0, metadata !123, null}
!332 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !333} ; [ DW_TAG_arg_variable ] [a] [line 41]
!333 = metadata !{i32 107, i32 0, metadata !123, null}
!334 = metadata !{i32 41, i32 0, metadata !252, metadata !333}
!335 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !333} ; [ DW_TAG_arg_variable ] [b] [line 41]
!336 = metadata !{i32 42, i32 0, metadata !252, metadata !333}
!337 = metadata !{i32 44, i32 0, metadata !252, metadata !333}
!338 = metadata !{i32 45, i32 0, metadata !252, metadata !333}
!339 = metadata !{i32 46, i32 0, metadata !252, metadata !333}
!340 = metadata !{i32 47, i32 0, metadata !252, metadata !333}
!341 = metadata !{i32 48, i32 0, metadata !252, metadata !333}
!342 = metadata !{i32 50, i32 0, metadata !252, metadata !333}
!343 = metadata !{i32 51, i32 0, metadata !252, metadata !333}
!344 = metadata !{i32 52, i32 0, metadata !252, metadata !333}
!345 = metadata !{i32 53, i32 0, metadata !252, metadata !333}
!346 = metadata !{i32 56, i32 0, metadata !252, metadata !333}
!347 = metadata !{i32 57, i32 0, metadata !252, metadata !333}
!348 = metadata !{i32 58, i32 0, metadata !252, metadata !333} ; [ DW_TAG_imported_module ]
!349 = metadata !{i32 109, i32 0, metadata !123, null}
!350 = metadata !{i32 111, i32 0, metadata !131, null}
!351 = metadata !{i32 112, i32 0, metadata !131, null}
!352 = metadata !{i32 113, i32 0, metadata !131, null}
!353 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !354} ; [ DW_TAG_arg_variable ] [a] [line 41]
!354 = metadata !{i32 114, i32 0, metadata !131, null}
!355 = metadata !{i32 41, i32 0, metadata !252, metadata !354}
!356 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !354} ; [ DW_TAG_arg_variable ] [b] [line 41]
!357 = metadata !{i32 42, i32 0, metadata !252, metadata !354}
!358 = metadata !{i32 44, i32 0, metadata !252, metadata !354}
!359 = metadata !{i32 45, i32 0, metadata !252, metadata !354}
!360 = metadata !{i32 46, i32 0, metadata !252, metadata !354}
!361 = metadata !{i32 47, i32 0, metadata !252, metadata !354}
!362 = metadata !{i32 48, i32 0, metadata !252, metadata !354}
!363 = metadata !{i32 50, i32 0, metadata !252, metadata !354}
!364 = metadata !{i32 51, i32 0, metadata !252, metadata !354}
!365 = metadata !{i32 52, i32 0, metadata !252, metadata !354}
!366 = metadata !{i32 53, i32 0, metadata !252, metadata !354}
!367 = metadata !{i32 56, i32 0, metadata !252, metadata !354}
!368 = metadata !{i32 57, i32 0, metadata !252, metadata !354}
!369 = metadata !{i32 58, i32 0, metadata !252, metadata !354} ; [ DW_TAG_imported_module ]
!370 = metadata !{i32 116, i32 0, metadata !131, null}
!371 = metadata !{i32 118, i32 0, metadata !138, null}
!372 = metadata !{i32 119, i32 0, metadata !138, null}
!373 = metadata !{i32 120, i32 0, metadata !138, null}
!374 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !375} ; [ DW_TAG_arg_variable ] [a] [line 41]
!375 = metadata !{i32 121, i32 0, metadata !138, null}
!376 = metadata !{i32 41, i32 0, metadata !252, metadata !375}
!377 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !375} ; [ DW_TAG_arg_variable ] [b] [line 41]
!378 = metadata !{i32 42, i32 0, metadata !252, metadata !375}
!379 = metadata !{i32 44, i32 0, metadata !252, metadata !375}
!380 = metadata !{i32 45, i32 0, metadata !252, metadata !375}
!381 = metadata !{i32 46, i32 0, metadata !252, metadata !375}
!382 = metadata !{i32 47, i32 0, metadata !252, metadata !375}
!383 = metadata !{i32 48, i32 0, metadata !252, metadata !375}
!384 = metadata !{i32 50, i32 0, metadata !252, metadata !375}
!385 = metadata !{i32 51, i32 0, metadata !252, metadata !375}
!386 = metadata !{i32 52, i32 0, metadata !252, metadata !375}
!387 = metadata !{i32 53, i32 0, metadata !252, metadata !375}
!388 = metadata !{i32 56, i32 0, metadata !252, metadata !375}
!389 = metadata !{i32 57, i32 0, metadata !252, metadata !375}
!390 = metadata !{i32 58, i32 0, metadata !252, metadata !375} ; [ DW_TAG_imported_module ]
!391 = metadata !{i32 123, i32 0, metadata !138, null}
!392 = metadata !{i32 125, i32 0, metadata !144, null}
!393 = metadata !{i32 126, i32 0, metadata !144, null}
!394 = metadata !{i32 127, i32 0, metadata !144, null}
!395 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !396} ; [ DW_TAG_arg_variable ] [a] [line 41]
!396 = metadata !{i32 128, i32 0, metadata !144, null}
!397 = metadata !{i32 41, i32 0, metadata !252, metadata !396}
!398 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !396} ; [ DW_TAG_arg_variable ] [b] [line 41]
!399 = metadata !{i32 42, i32 0, metadata !252, metadata !396}
!400 = metadata !{i32 44, i32 0, metadata !252, metadata !396}
!401 = metadata !{i32 45, i32 0, metadata !252, metadata !396}
!402 = metadata !{i32 46, i32 0, metadata !252, metadata !396}
!403 = metadata !{i32 47, i32 0, metadata !252, metadata !396}
!404 = metadata !{i32 48, i32 0, metadata !252, metadata !396}
!405 = metadata !{i32 50, i32 0, metadata !252, metadata !396}
!406 = metadata !{i32 51, i32 0, metadata !252, metadata !396}
!407 = metadata !{i32 52, i32 0, metadata !252, metadata !396}
!408 = metadata !{i32 53, i32 0, metadata !252, metadata !396}
!409 = metadata !{i32 56, i32 0, metadata !252, metadata !396}
!410 = metadata !{i32 57, i32 0, metadata !252, metadata !396}
!411 = metadata !{i32 58, i32 0, metadata !252, metadata !396} ; [ DW_TAG_imported_module ]
!412 = metadata !{i32 130, i32 0, metadata !144, null}
!413 = metadata !{i32 132, i32 0, metadata !153, null}
!414 = metadata !{i32 133, i32 0, metadata !153, null}
!415 = metadata !{i32 134, i32 0, metadata !153, null}
!416 = metadata !{i32 786689, metadata !252, metadata !"a", metadata !6, i32 16777257, metadata !255, i32 0, metadata !417} ; [ DW_TAG_arg_variable ] [a] [line 41]
!417 = metadata !{i32 135, i32 0, metadata !153, null}
!418 = metadata !{i32 41, i32 0, metadata !252, metadata !417}
!419 = metadata !{i32 786689, metadata !252, metadata !"b", metadata !6, i32 33554473, metadata !61, i32 0, metadata !417} ; [ DW_TAG_arg_variable ] [b] [line 41]
!420 = metadata !{i32 42, i32 0, metadata !252, metadata !417}
!421 = metadata !{i32 44, i32 0, metadata !252, metadata !417}
!422 = metadata !{i32 45, i32 0, metadata !252, metadata !417}
!423 = metadata !{i32 46, i32 0, metadata !252, metadata !417}
!424 = metadata !{i32 47, i32 0, metadata !252, metadata !417}
!425 = metadata !{i32 48, i32 0, metadata !252, metadata !417}
!426 = metadata !{i32 50, i32 0, metadata !252, metadata !417}
!427 = metadata !{i32 51, i32 0, metadata !252, metadata !417}
!428 = metadata !{i32 52, i32 0, metadata !252, metadata !417}
!429 = metadata !{i32 53, i32 0, metadata !252, metadata !417}
!430 = metadata !{i32 56, i32 0, metadata !252, metadata !417}
!431 = metadata !{i32 57, i32 0, metadata !252, metadata !417}
!432 = metadata !{i32 58, i32 0, metadata !252, metadata !417} ; [ DW_TAG_imported_module ]
!433 = metadata !{i32 137, i32 0, metadata !153, null}
!434 = metadata !{i32 139, i32 0, metadata !161, null}
!435 = metadata !{i32 140, i32 0, metadata !161, null}
!436 = metadata !{i32 143, i32 0, metadata !167, null}
!437 = metadata !{i32 162, i32 0, metadata !167, null}
!438 = metadata !{i32 168, i32 0, metadata !203, null}
!439 = metadata !{i32 169, i32 0, metadata !203, null}
!440 = metadata !{i32 170, i32 0, metadata !203, null}
!441 = metadata !{i32 172, i32 0, metadata !240, null}
!442 = metadata !{i32 173, i32 0, metadata !239, null}
!443 = metadata !{i32 174, i32 0, metadata !239, null}
!444 = metadata !{i32 176, i32 0, metadata !242, null}
!445 = metadata !{i32 183, i32 0, metadata !242, null}
!446 = metadata !{metadata !447, metadata !448, i64 16}
!447 = metadata !{metadata !"dirent", metadata !291, i64 0, metadata !291, i64 8, metadata !448, i64 16, metadata !292, i64 18, metadata !292, i64 19}
!448 = metadata !{metadata !"short", metadata !292, i64 0}
!449 = metadata !{i32 187, i32 0, metadata !203, null}
!450 = metadata !{i32 194, i32 0, metadata !244, null}
!451 = metadata !{i32 195, i32 0, metadata !244, null}
!452 = metadata !{i32 197, i32 0, metadata !251, null}
!453 = metadata !{i32 199, i32 0, metadata !250, null}
!454 = metadata !{i32 200, i32 0, metadata !250, null}
!455 = metadata !{i32 201, i32 0, metadata !250, null}
!456 = metadata !{i32 202, i32 0, metadata !250, null}
!457 = metadata !{i32 203, i32 0, metadata !250, null}
!458 = metadata !{i32 205, i32 0, metadata !244, null}
