; ModuleID = 'fd.c'
target datalayout = "e-p:64:64:64-i1:8:8-i8:8:8-i16:16:16-i32:32:32-i64:64:64-f32:32:32-f64:64:64-v64:64:64-v128:128:128-a0:0:64-s0:64:64-f80:128:128-n8:16:32:64-S128"
target triple = "x86_64-pc-linux-gnu"

%struct.exe_sym_env_t = type { [32 x %struct.exe_file_t], i32, i32, i32 }
%struct.exe_file_t = type { i32, i32, i64, %struct.exe_disk_file_t* }
%struct.exe_disk_file_t = type { i32, i8*, %struct.stat64* }
%struct.stat64 = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.timespec = type { i64, i64 }
%struct.exe_file_system_t = type { i32, %struct.exe_disk_file_t*, %struct.exe_disk_file_t*, i32, %struct.exe_disk_file_t*, i32, i32*, i32*, i32*, i32*, i32*, i32*, i32* }
%struct.timeval = type { i64, i64 }
%struct.stat = type { i64, i64, i64, i32, i32, i32, i32, i64, i64, i64, i64, %struct.timespec, %struct.timespec, %struct.timespec, [3 x i64] }
%struct.dirent64 = type { i64, i64, i16, i8, [256 x i8] }
%struct.__va_list_tag = type { i32, i32, i8*, i8* }
%struct.statfs = type { i64, i64, i64, i64, i64, i64, i64, %struct.__fsid_t, i64, i64, i64, [4 x i64] }
%struct.__fsid_t = type { [2 x i32] }
%struct.fd_set = type { [16 x i64] }

@__exe_env = external global %struct.exe_sym_env_t
@.str1 = private unnamed_addr constant [47 x i8] c"Undefined call to open(): O_EXCL w/o O_RDONLY\0A\00", align 1
@.str2 = private unnamed_addr constant [44 x i8] c"symbolic file descriptor, ignoring (ENOENT)\00", align 1
@close.n_calls = internal unnamed_addr global i32 0, align 4
@__exe_fs = external global %struct.exe_file_system_t
@read.n_calls = internal unnamed_addr global i32 0, align 4
@.str3 = private unnamed_addr constant [12 x i8] c"f->off >= 0\00", align 1
@.str4 = private unnamed_addr constant [5 x i8] c"fd.c\00", align 1
@__PRETTY_FUNCTION__.read = private unnamed_addr constant [34 x i8] c"ssize_t read(int, void *, size_t)\00", align 1
@write.n_calls = internal unnamed_addr global i32 0, align 4
@.str5 = private unnamed_addr constant [7 x i8] c"r >= 0\00", align 1
@__PRETTY_FUNCTION__.write = private unnamed_addr constant [41 x i8] c"ssize_t write(int, const void *, size_t)\00", align 1
@.str6 = private unnamed_addr constant [2 x i8] c"0\00", align 1
@.str7 = private unnamed_addr constant [24 x i8] c"write() ignores bytes.\0A\00", align 1
@.str8 = private unnamed_addr constant [18 x i8] c"new_off == f->off\00", align 1
@__PRETTY_FUNCTION__.__fd_lseek = private unnamed_addr constant [38 x i8] c"off64_t __fd_lseek(int, off64_t, int)\00", align 1
@.str9 = private unnamed_addr constant [33 x i8] c"symbolic file, ignoring (ENOENT)\00", align 1
@chmod.n_calls = internal unnamed_addr global i32 0, align 4
@fchmod.n_calls = internal unnamed_addr global i32 0, align 4
@__fd_ftruncate.n_calls = internal unnamed_addr global i32 0, align 4
@.str10 = private unnamed_addr constant [30 x i8] c"symbolic file, ignoring (EIO)\00", align 1
@.str11 = private unnamed_addr constant [33 x i8] c"symbolic file, ignoring (EINVAL)\00", align 1
@.str12 = private unnamed_addr constant [18 x i8] c"s != (off64_t) -1\00", align 1
@__PRETTY_FUNCTION__.__fd_getdents = private unnamed_addr constant [65 x i8] c"int __fd_getdents(unsigned int, struct dirent64 *, unsigned int)\00", align 1
@.str13 = private unnamed_addr constant [41 x i8] c"(TCGETS) symbolic file, incomplete model\00", align 1
@.str14 = private unnamed_addr constant [42 x i8] c"(TCSETS) symbolic file, silently ignoring\00", align 1
@.str15 = private unnamed_addr constant [43 x i8] c"(TCSETSW) symbolic file, silently ignoring\00", align 1
@.str16 = private unnamed_addr constant [43 x i8] c"(TCSETSF) symbolic file, silently ignoring\00", align 1
@.str17 = private unnamed_addr constant [45 x i8] c"(TIOCGWINSZ) symbolic file, incomplete model\00", align 1
@.str18 = private unnamed_addr constant [46 x i8] c"(TIOCSWINSZ) symbolic file, ignoring (EINVAL)\00", align 1
@.str19 = private unnamed_addr constant [43 x i8] c"(FIONREAD) symbolic file, incomplete model\00", align 1
@.str20 = private unnamed_addr constant [44 x i8] c"(MTIOCGET) symbolic file, ignoring (EINVAL)\00", align 1
@.str21 = private unnamed_addr constant [32 x i8] c"symbolic file, ignoring (EBADF)\00", align 1
@.str22 = private unnamed_addr constant [17 x i8] c"ignoring (EPERM)\00", align 1
@getcwd.n_calls = internal unnamed_addr global i32 0, align 4
@.str23 = private unnamed_addr constant [18 x i8] c"ignoring (ENOENT)\00", align 1
@.str24 = private unnamed_addr constant [32 x i8] c"symbolic file, ignoring (EPERM)\00", align 1

; Function Attrs: nounwind ssp uwtable
define i32 @access(i8* %pathname, i32 %mode) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !34), !dbg !689
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !35), !dbg !689
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !690), !dbg !692
  %1 = load i8* %pathname, align 1, !dbg !693, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !697), !dbg !693
  %2 = sext i8 %1 to i32, !dbg !698
  %3 = icmp eq i8 %1, 0, !dbg !698
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !698

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %pathname, i64 1, !dbg !698
  %6 = load i8* %5, align 1, !dbg !698, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !698
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !698

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !700, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !700
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !700

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !700
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !700

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !705
  %12 = ashr exact i32 %sext.i, 24, !dbg !705
  %13 = add nsw i32 %12, 65, !dbg !705
  %14 = icmp eq i32 %2, %13, !dbg !705
  %15 = add i32 %i.02.i, 1, !dbg !700
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !706), !dbg !700
  br i1 %14, label %16, label %10, !dbg !705

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !707
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !707, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !709
  %20 = load %struct.stat64** %19, align 8, !dbg !709, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !709
  %22 = load i64* %21, align 8, !dbg !709, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !709
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !707
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !717
  %or.cond = or i1 %23, %25, !dbg !709
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %56, !dbg !709

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !718) #5, !dbg !720
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !721) #5, !dbg !723
  %26 = ptrtoint i8* %pathname to i64, !dbg !724
  %27 = tail call i64 @klee_get_valuel(i64 %26) #5, !dbg !724
  %28 = inttoptr i64 %27 to i8*, !dbg !724
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !725) #5, !dbg !724
  %29 = icmp eq i8* %28, %pathname, !dbg !726
  %30 = zext i1 %29 to i64, !dbg !726
  tail call void @klee_assume(i64 %30) #5, !dbg !726
  tail call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !727) #5, !dbg !722
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !728) #5, !dbg !729
  br label %31, !dbg !729

; <label>:31                                      ; preds = %48, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %49, %48 ]
  %sc.0.i = phi i8* [ %28, %__get_sym_file.exit.thread ], [ %sc.1.i, %48 ]
  %32 = load i8* %sc.0.i, align 1, !dbg !730, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %32}, i64 0, metadata !731) #5, !dbg !730
  %33 = add i32 %i.0.i, -1, !dbg !732
  %34 = and i32 %33, %i.0.i, !dbg !732
  %35 = icmp eq i32 %34, 0, !dbg !732
  br i1 %35, label %36, label %40, !dbg !732

; <label>:36                                      ; preds = %31
  switch i8 %32, label %48 [
    i8 0, label %37
    i8 47, label %38
  ], !dbg !733

; <label>:37                                      ; preds = %36
  store i8 0, i8* %sc.0.i, align 1, !dbg !736, !tbaa !694
  br label %__concretize_string.exit, !dbg !738

; <label>:38                                      ; preds = %36
  %39 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !739
  tail call void @llvm.dbg.value(metadata !{i8* %39}, i64 0, metadata !727) #5, !dbg !739
  store i8 47, i8* %sc.0.i, align 1, !dbg !739, !tbaa !694
  br label %48, !dbg !742

; <label>:40                                      ; preds = %31
  %41 = sext i8 %32 to i64, !dbg !743
  %42 = tail call i64 @klee_get_valuel(i64 %41) #5, !dbg !743
  %43 = trunc i64 %42 to i8, !dbg !743
  tail call void @llvm.dbg.value(metadata !{i8 %43}, i64 0, metadata !744) #5, !dbg !743
  %44 = icmp eq i8 %43, %32, !dbg !745
  %45 = zext i1 %44 to i64, !dbg !745
  tail call void @klee_assume(i64 %45) #5, !dbg !745
  %46 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !746
  tail call void @llvm.dbg.value(metadata !{i8* %46}, i64 0, metadata !727) #5, !dbg !746
  store i8 %43, i8* %sc.0.i, align 1, !dbg !746, !tbaa !694
  %47 = icmp eq i8 %43, 0, !dbg !747
  br i1 %47, label %__concretize_string.exit, label %48, !dbg !747

; <label>:48                                      ; preds = %40, %38, %36
  %sc.1.i = phi i8* [ %46, %40 ], [ %39, %38 ], [ %sc.0.i, %36 ]
  %49 = add i32 %i.0.i, 1, !dbg !729
  tail call void @llvm.dbg.value(metadata !{i32 %49}, i64 0, metadata !728) #5, !dbg !729
  br label %31, !dbg !729

__concretize_string.exit:                         ; preds = %40, %37
  %50 = tail call i64 (i64, ...)* @syscall(i64 21, i8* %pathname, i32 %mode) #5, !dbg !719
  %51 = trunc i64 %50 to i32, !dbg !719
  tail call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !86), !dbg !719
  %52 = icmp eq i32 %51, -1, !dbg !749
  br i1 %52, label %53, label %56, !dbg !749

; <label>:53                                      ; preds = %__concretize_string.exit
  %54 = tail call i32 @klee_get_errno() #5, !dbg !751
  %55 = tail call i32* @__errno_location() #1, !dbg !751
  store i32 %54, i32* %55, align 4, !dbg !751, !tbaa !752
  br label %56, !dbg !751

; <label>:56                                      ; preds = %16, %__concretize_string.exit, %53
  %.0 = phi i32 [ -1, %53 ], [ %51, %__concretize_string.exit ], [ 0, %16 ]
  ret i32 %.0, !dbg !753
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata) #1

; Function Attrs: nounwind
declare i64 @syscall(i64, ...) #2

declare i32 @klee_get_errno() #3

; Function Attrs: nounwind readnone
declare i32* @__errno_location() #4

; Function Attrs: nounwind ssp uwtable
define i32 @umask(i32 %mask) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %mask}, i64 0, metadata !94), !dbg !754
  %1 = load i32* getelementptr inbounds (%struct.exe_sym_env_t* @__exe_env, i64 0, i32 1), align 8, !dbg !755, !tbaa !756
  tail call void @llvm.dbg.value(metadata !{i32 %1}, i64 0, metadata !95), !dbg !755
  %2 = and i32 %mask, 511, !dbg !758
  store i32 %2, i32* getelementptr inbounds (%struct.exe_sym_env_t* @__exe_env, i64 0, i32 1), align 8, !dbg !758, !tbaa !756
  ret i32 %1, !dbg !759
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_open(i8* %pathname, i32 %flags, i32 %mode) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !100), !dbg !760
  tail call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !101), !dbg !760
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !102), !dbg !760
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !115), !dbg !761
  br label %4, !dbg !761

; <label>:1                                       ; preds = %4
  %2 = trunc i64 %indvars.iv.next to i32, !dbg !761
  %3 = icmp slt i32 %2, 32, !dbg !761
  br i1 %3, label %4, label %10, !dbg !761

; <label>:4                                       ; preds = %0, %1
  %indvars.iv = phi i64 [ 0, %0 ], [ %indvars.iv.next, %1 ]
  %fd.04 = phi i32 [ 0, %0 ], [ %9, %1 ]
  %5 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, i32 1, !dbg !763
  %6 = load i32* %5, align 4, !dbg !763, !tbaa !765
  %7 = and i32 %6, 1, !dbg !763
  %8 = icmp eq i32 %7, 0, !dbg !763
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !761
  %9 = add nsw i32 %fd.04, 1, !dbg !761
  tail call void @llvm.dbg.value(metadata !{i32 %9}, i64 0, metadata !115), !dbg !761
  br i1 %8, label %10, label %1, !dbg !763

; <label>:10                                      ; preds = %4, %1
  %fd.0.lcssa = phi i32 [ %fd.04, %4 ], [ %9, %1 ]
  %11 = icmp eq i32 %fd.0.lcssa, 32, !dbg !767
  br i1 %11, label %12, label %14, !dbg !767

; <label>:12                                      ; preds = %10
  %13 = tail call i32* @__errno_location() #1, !dbg !769
  store i32 24, i32* %13, align 4, !dbg !769, !tbaa !752
  br label %104, !dbg !771

; <label>:14                                      ; preds = %10
  %15 = sext i32 %fd.0.lcssa to i64, !dbg !772
  %16 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %15, !dbg !772
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %16}, i64 0, metadata !104), !dbg !772
  %17 = bitcast %struct.exe_file_t* %16 to i8*, !dbg !773
  tail call void @llvm.memset.p0i8.i64(i8* %17, i8 0, i64 24, i32 8, i1 false), !dbg !773
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !774), !dbg !776
  %18 = load i8* %pathname, align 1, !dbg !777, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %18}, i64 0, metadata !778), !dbg !777
  %19 = sext i8 %18 to i32, !dbg !779
  %20 = icmp eq i8 %18, 0, !dbg !779
  br i1 %20, label %__get_sym_file.exit.thread, label %21, !dbg !779

; <label>:21                                      ; preds = %14
  %22 = getelementptr inbounds i8* %pathname, i64 1, !dbg !779
  %23 = load i8* %22, align 1, !dbg !779, !tbaa !694
  %24 = icmp eq i8 %23, 0, !dbg !779
  br i1 %24, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !779

.preheader.i:                                     ; preds = %21
  %25 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !780, !tbaa !701
  %26 = icmp eq i32 %25, 0, !dbg !780
  br i1 %26, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !780

; <label>:27                                      ; preds = %.lr.ph.i
  %28 = icmp ult i32 %32, %25, !dbg !780
  br i1 %28, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !780

.lr.ph.i:                                         ; preds = %.preheader.i, %27
  %i.02.i = phi i32 [ %32, %27 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !781
  %29 = ashr exact i32 %sext.i, 24, !dbg !781
  %30 = add nsw i32 %29, 65, !dbg !781
  %31 = icmp eq i32 %19, %30, !dbg !781
  %32 = add i32 %i.02.i, 1, !dbg !780
  tail call void @llvm.dbg.value(metadata !{i32 %32}, i64 0, metadata !782), !dbg !780
  br i1 %31, label %33, label %27, !dbg !781

; <label>:33                                      ; preds = %.lr.ph.i
  %34 = zext i32 %i.02.i to i64, !dbg !783
  %35 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !783, !tbaa !708
  %36 = getelementptr inbounds %struct.exe_disk_file_t* %35, i64 %34, i32 2, !dbg !784
  %37 = load %struct.stat64** %36, align 8, !dbg !784, !tbaa !711
  %38 = getelementptr inbounds %struct.stat64* %37, i64 0, i32 1, !dbg !784
  %39 = load i64* %38, align 8, !dbg !784, !tbaa !713
  %40 = icmp eq i64 %39, 0, !dbg !784
  br i1 %40, label %__get_sym_file.exit.thread, label %__get_sym_file.exit, !dbg !784

__get_sym_file.exit:                              ; preds = %33
  %41 = getelementptr inbounds %struct.exe_disk_file_t* %35, i64 %34, !dbg !783
  tail call void @llvm.dbg.value(metadata !{%struct.exe_disk_file_t* %41}, i64 0, metadata !103), !dbg !775
  %42 = icmp eq %struct.exe_disk_file_t* %41, null, !dbg !785
  br i1 %42, label %__get_sym_file.exit.thread, label %43, !dbg !785

; <label>:43                                      ; preds = %__get_sym_file.exit
  %44 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %15, i32 3, !dbg !786
  store %struct.exe_disk_file_t* %41, %struct.exe_disk_file_t** %44, align 8, !dbg !786, !tbaa !788
  %45 = and i32 %flags, 192, !dbg !789
  switch i32 %45, label %50 [
    i32 192, label %46
    i32 128, label %48
  ], !dbg !789

; <label>:46                                      ; preds = %43
  %47 = tail call i32* @__errno_location() #1, !dbg !791
  store i32 17, i32* %47, align 4, !dbg !791, !tbaa !752
  br label %104, !dbg !793

; <label>:48                                      ; preds = %43
  tail call void @klee_warning(i8* getelementptr inbounds ([47 x i8]* @.str1, i64 0, i64 0)) #5, !dbg !794
  %49 = tail call i32* @__errno_location() #1, !dbg !797
  store i32 13, i32* %49, align 4, !dbg !797, !tbaa !752
  br label %104, !dbg !798

; <label>:50                                      ; preds = %43
  tail call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !799), !dbg !802
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %37}, i64 0, metadata !803), !dbg !802
  %51 = getelementptr inbounds %struct.stat64* %37, i64 0, i32 3, !dbg !804
  %52 = load i32* %51, align 4, !dbg !804, !tbaa !805
  tail call void @llvm.dbg.value(metadata !{i32 %52}, i64 0, metadata !806), !dbg !804
  %53 = and i32 %flags, 2, !dbg !807
  %54 = icmp eq i32 %53, 0, !dbg !807
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !809), !dbg !810
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !811), !dbg !812
  %55 = and i32 %52, 292, !dbg !814
  %56 = icmp eq i32 %55, 0, !dbg !814
  %or.cond3.i = or i1 %54, %56, !dbg !814
  br i1 %or.cond3.i, label %has_permission.exit, label %has_permission.exit.thread, !dbg !814

has_permission.exit:                              ; preds = %50
  %57 = and i32 %flags, 3, !dbg !816
  %not..i = icmp ne i32 %57, 0, !dbg !816
  %58 = and i32 %52, 146, !dbg !817
  %59 = icmp eq i32 %58, 0, !dbg !817
  %or.cond5.i = and i1 %not..i, %59, !dbg !817
  br i1 %or.cond5.i, label %has_permission.exit.thread, label %61, !dbg !800

has_permission.exit.thread:                       ; preds = %50, %has_permission.exit
  %60 = tail call i32* @__errno_location() #1, !dbg !819
  store i32 13, i32* %60, align 4, !dbg !819, !tbaa !752
  br label %104, !dbg !821

; <label>:61                                      ; preds = %has_permission.exit
  %62 = and i32 %52, -512, !dbg !822
  %63 = load i32* getelementptr inbounds (%struct.exe_sym_env_t* @__exe_env, i64 0, i32 1), align 8, !dbg !822, !tbaa !756
  %64 = xor i32 %63, -1, !dbg !822
  %65 = and i32 %64, %mode, !dbg !822
  %66 = or i32 %65, %62, !dbg !822
  store i32 %66, i32* %51, align 4, !dbg !822, !tbaa !805
  br label %99, !dbg !823

__get_sym_file.exit.thread:                       ; preds = %27, %.preheader.i, %33, %14, %21, %__get_sym_file.exit
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !824) #5, !dbg !826
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !827) #5, !dbg !829
  %67 = ptrtoint i8* %pathname to i64, !dbg !830
  %68 = tail call i64 @klee_get_valuel(i64 %67) #5, !dbg !830
  %69 = inttoptr i64 %68 to i8*, !dbg !830
  tail call void @llvm.dbg.value(metadata !{i8* %69}, i64 0, metadata !831) #5, !dbg !830
  %70 = icmp eq i8* %69, %pathname, !dbg !832
  %71 = zext i1 %70 to i64, !dbg !832
  tail call void @klee_assume(i64 %71) #5, !dbg !832
  tail call void @llvm.dbg.value(metadata !{i8* %69}, i64 0, metadata !833) #5, !dbg !828
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !834) #5, !dbg !835
  br label %72, !dbg !835

; <label>:72                                      ; preds = %89, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %90, %89 ]
  %sc.0.i = phi i8* [ %69, %__get_sym_file.exit.thread ], [ %sc.1.i, %89 ]
  %73 = load i8* %sc.0.i, align 1, !dbg !836, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %73}, i64 0, metadata !837) #5, !dbg !836
  %74 = add i32 %i.0.i, -1, !dbg !838
  %75 = and i32 %74, %i.0.i, !dbg !838
  %76 = icmp eq i32 %75, 0, !dbg !838
  br i1 %76, label %77, label %81, !dbg !838

; <label>:77                                      ; preds = %72
  switch i8 %73, label %89 [
    i8 0, label %78
    i8 47, label %79
  ], !dbg !839

; <label>:78                                      ; preds = %77
  store i8 0, i8* %sc.0.i, align 1, !dbg !840, !tbaa !694
  br label %__concretize_string.exit, !dbg !841

; <label>:79                                      ; preds = %77
  %80 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !842
  tail call void @llvm.dbg.value(metadata !{i8* %80}, i64 0, metadata !833) #5, !dbg !842
  store i8 47, i8* %sc.0.i, align 1, !dbg !842, !tbaa !694
  br label %89, !dbg !843

; <label>:81                                      ; preds = %72
  %82 = sext i8 %73 to i64, !dbg !844
  %83 = tail call i64 @klee_get_valuel(i64 %82) #5, !dbg !844
  %84 = trunc i64 %83 to i8, !dbg !844
  tail call void @llvm.dbg.value(metadata !{i8 %84}, i64 0, metadata !845) #5, !dbg !844
  %85 = icmp eq i8 %84, %73, !dbg !846
  %86 = zext i1 %85 to i64, !dbg !846
  tail call void @klee_assume(i64 %86) #5, !dbg !846
  %87 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !847
  tail call void @llvm.dbg.value(metadata !{i8* %87}, i64 0, metadata !833) #5, !dbg !847
  store i8 %84, i8* %sc.0.i, align 1, !dbg !847, !tbaa !694
  %88 = icmp eq i8 %84, 0, !dbg !848
  br i1 %88, label %__concretize_string.exit, label %89, !dbg !848

; <label>:89                                      ; preds = %81, %79, %77
  %sc.1.i = phi i8* [ %87, %81 ], [ %80, %79 ], [ %sc.0.i, %77 ]
  %90 = add i32 %i.0.i, 1, !dbg !835
  tail call void @llvm.dbg.value(metadata !{i32 %90}, i64 0, metadata !834) #5, !dbg !835
  br label %72, !dbg !835

__concretize_string.exit:                         ; preds = %81, %78
  %91 = tail call i64 (i64, ...)* @syscall(i64 2, i8* %pathname, i32 %flags, i32 %mode) #5, !dbg !825
  %92 = trunc i64 %91 to i32, !dbg !825
  tail call void @llvm.dbg.value(metadata !{i32 %92}, i64 0, metadata !116), !dbg !825
  %93 = icmp eq i32 %92, -1, !dbg !849
  br i1 %93, label %94, label %97, !dbg !849

; <label>:94                                      ; preds = %__concretize_string.exit
  %95 = tail call i32 @klee_get_errno() #5, !dbg !851
  %96 = tail call i32* @__errno_location() #1, !dbg !851
  store i32 %95, i32* %96, align 4, !dbg !851, !tbaa !752
  br label %104, !dbg !853

; <label>:97                                      ; preds = %__concretize_string.exit
  %98 = getelementptr inbounds %struct.exe_file_t* %16, i64 0, i32 0, !dbg !854
  store i32 %92, i32* %98, align 8, !dbg !854, !tbaa !855
  %.pre = and i32 %flags, 3, !dbg !856
  br label %99

; <label>:99                                      ; preds = %97, %61
  %.pre-phi = phi i32 [ %.pre, %97 ], [ %57, %61 ], !dbg !856
  %100 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %15, i32 1, !dbg !858
  store i32 1, i32* %100, align 4, !dbg !858, !tbaa !765
  switch i32 %.pre-phi, label %103 [
    i32 0, label %101
    i32 1, label %102
  ], !dbg !856

; <label>:101                                     ; preds = %99
  store i32 5, i32* %100, align 4, !dbg !859, !tbaa !765
  br label %104, !dbg !861

; <label>:102                                     ; preds = %99
  store i32 9, i32* %100, align 4, !dbg !862, !tbaa !765
  br label %104, !dbg !865

; <label>:103                                     ; preds = %99
  store i32 13, i32* %100, align 4, !dbg !866, !tbaa !765
  br label %104

; <label>:104                                     ; preds = %101, %103, %102, %94, %has_permission.exit.thread, %48, %46, %12
  %.0 = phi i32 [ -1, %12 ], [ -1, %46 ], [ -1, %has_permission.exit.thread ], [ -1, %48 ], [ -1, %94 ], [ %fd.0.lcssa, %102 ], [ %fd.0.lcssa, %103 ], [ %fd.0.lcssa, %101 ]
  ret i32 %.0, !dbg !868
}

; Function Attrs: nounwind
declare void @llvm.memset.p0i8.i64(i8* nocapture, i8, i64, i32, i1) #5

declare void @klee_warning(i8*) #3

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_openat(i32 %basefd, i8* %pathname, i32 %flags, i32 %mode) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %basefd}, i64 0, metadata !123), !dbg !869
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !124), !dbg !869
  tail call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !125), !dbg !869
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !126), !dbg !869
  %1 = icmp eq i32 %basefd, -100, !dbg !870
  br i1 %1, label %22, label %2, !dbg !870

; <label>:2                                       ; preds = %0
  tail call void @llvm.dbg.value(metadata !{i32 %basefd}, i64 0, metadata !871), !dbg !873
  %3 = icmp ult i32 %basefd, 32, !dbg !874
  br i1 %3, label %4, label %__get_file.exit.thread, !dbg !874

; <label>:4                                       ; preds = %2
  %5 = sext i32 %basefd to i64, !dbg !875
  %6 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 1, !dbg !876
  %7 = load i32* %6, align 4, !dbg !876, !tbaa !765
  %8 = and i32 %7, 1, !dbg !876
  %9 = icmp eq i32 %8, 0, !dbg !876
  br i1 %9, label %__get_file.exit.thread, label %__get_file.exit, !dbg !876

__get_file.exit:                                  ; preds = %4
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, !dbg !875
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !129), !dbg !872
  %11 = icmp eq %struct.exe_file_t* %10, null, !dbg !878
  br i1 %11, label %__get_file.exit.thread, label %13, !dbg !878

__get_file.exit.thread:                           ; preds = %2, %4, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !880
  store i32 9, i32* %12, align 4, !dbg !880, !tbaa !752
  br label %103, !dbg !882

; <label>:13                                      ; preds = %__get_file.exit
  %14 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 3, !dbg !883
  %15 = load %struct.exe_disk_file_t** %14, align 8, !dbg !883, !tbaa !788
  %16 = icmp eq %struct.exe_disk_file_t* %15, null, !dbg !883
  br i1 %16, label %19, label %17, !dbg !883

; <label>:17                                      ; preds = %13
  tail call void @klee_warning(i8* getelementptr inbounds ([44 x i8]* @.str2, i64 0, i64 0)) #5, !dbg !885
  %18 = tail call i32* @__errno_location() #1, !dbg !887
  store i32 2, i32* %18, align 4, !dbg !887, !tbaa !752
  br label %103, !dbg !888

; <label>:19                                      ; preds = %13
  %20 = getelementptr inbounds %struct.exe_file_t* %10, i64 0, i32 0, !dbg !889
  %21 = load i32* %20, align 8, !dbg !889, !tbaa !855
  tail call void @llvm.dbg.value(metadata !{i32 %21}, i64 0, metadata !123), !dbg !889
  %phitmp = sext i32 %21 to i64, !dbg !890
  br label %22, !dbg !890

; <label>:22                                      ; preds = %0, %19
  %.01 = phi i64 [ %phitmp, %19 ], [ -100, %0 ]
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !891), !dbg !894
  %23 = load i8* %pathname, align 1, !dbg !895, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %23}, i64 0, metadata !896), !dbg !895
  %24 = sext i8 %23 to i32, !dbg !897
  %25 = icmp eq i8 %23, 0, !dbg !897
  br i1 %25, label %__get_sym_file.exit.thread.preheader, label %26, !dbg !897

; <label>:26                                      ; preds = %22
  %27 = getelementptr inbounds i8* %pathname, i64 1, !dbg !897
  %28 = load i8* %27, align 1, !dbg !897, !tbaa !694
  %29 = icmp eq i8 %28, 0, !dbg !897
  br i1 %29, label %.preheader.i, label %__get_sym_file.exit.thread.preheader, !dbg !897

.preheader.i:                                     ; preds = %26
  %30 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !898, !tbaa !701
  %31 = icmp eq i32 %30, 0, !dbg !898
  br i1 %31, label %__get_sym_file.exit.thread.preheader, label %.lr.ph.i, !dbg !898

; <label>:32                                      ; preds = %.lr.ph.i
  %33 = icmp ult i32 %37, %30, !dbg !898
  br i1 %33, label %.lr.ph.i, label %__get_sym_file.exit.thread.preheader, !dbg !898

.lr.ph.i:                                         ; preds = %.preheader.i, %32
  %i.02.i = phi i32 [ %37, %32 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !899
  %34 = ashr exact i32 %sext.i, 24, !dbg !899
  %35 = add nsw i32 %34, 65, !dbg !899
  %36 = icmp eq i32 %24, %35, !dbg !899
  %37 = add i32 %i.02.i, 1, !dbg !898
  tail call void @llvm.dbg.value(metadata !{i32 %37}, i64 0, metadata !900), !dbg !898
  br i1 %36, label %38, label %32, !dbg !899

; <label>:38                                      ; preds = %.lr.ph.i
  %39 = zext i32 %i.02.i to i64, !dbg !901
  %40 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !901, !tbaa !708
  %41 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, i32 2, !dbg !902
  %42 = load %struct.stat64** %41, align 8, !dbg !902, !tbaa !711
  %43 = getelementptr inbounds %struct.stat64* %42, i64 0, i32 1, !dbg !902
  %44 = load i64* %43, align 8, !dbg !902, !tbaa !713
  %45 = icmp eq i64 %44, 0, !dbg !902
  %46 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, !dbg !901
  %47 = icmp eq %struct.exe_disk_file_t* %46, null, !dbg !892
  %or.cond = or i1 %45, %47, !dbg !902
  br i1 %or.cond, label %__get_sym_file.exit.thread.preheader, label %48, !dbg !902

; <label>:48                                      ; preds = %38
  %49 = tail call i32 @__fd_open(i8* %pathname, i32 %flags, i32 %mode), !dbg !903
  br label %103, !dbg !903

__get_sym_file.exit.thread:                       ; preds = %__get_sym_file.exit.thread.preheader
  %50 = trunc i64 %indvars.iv.next to i32, !dbg !905
  %51 = icmp slt i32 %50, 32, !dbg !905
  br i1 %51, label %__get_sym_file.exit.thread.preheader, label %57, !dbg !905

__get_sym_file.exit.thread.preheader:             ; preds = %.preheader.i, %38, %22, %26, %32, %__get_sym_file.exit.thread
  %indvars.iv = phi i64 [ %indvars.iv.next, %__get_sym_file.exit.thread ], [ 0, %32 ], [ 0, %26 ], [ 0, %22 ], [ 0, %38 ], [ 0, %.preheader.i ]
  %fd.05 = phi i32 [ %56, %__get_sym_file.exit.thread ], [ 0, %32 ], [ 0, %26 ], [ 0, %22 ], [ 0, %38 ], [ 0, %.preheader.i ]
  %52 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, i32 1, !dbg !907
  %53 = load i32* %52, align 4, !dbg !907, !tbaa !765
  %54 = and i32 %53, 1, !dbg !907
  %55 = icmp eq i32 %54, 0, !dbg !907
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !905
  %56 = add nsw i32 %fd.05, 1, !dbg !905
  tail call void @llvm.dbg.value(metadata !{i32 %56}, i64 0, metadata !128), !dbg !905
  br i1 %55, label %57, label %__get_sym_file.exit.thread, !dbg !907

; <label>:57                                      ; preds = %__get_sym_file.exit.thread.preheader, %__get_sym_file.exit.thread
  %fd.0.lcssa = phi i32 [ %fd.05, %__get_sym_file.exit.thread.preheader ], [ %56, %__get_sym_file.exit.thread ]
  %58 = icmp eq i32 %fd.0.lcssa, 32, !dbg !909
  br i1 %58, label %59, label %61, !dbg !909

; <label>:59                                      ; preds = %57
  %60 = tail call i32* @__errno_location() #1, !dbg !911
  store i32 24, i32* %60, align 4, !dbg !911, !tbaa !752
  br label %103, !dbg !913

; <label>:61                                      ; preds = %57
  %62 = sext i32 %fd.0.lcssa to i64, !dbg !914
  %63 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %62, !dbg !914
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %63}, i64 0, metadata !127), !dbg !914
  %64 = bitcast %struct.exe_file_t* %63 to i8*, !dbg !915
  tail call void @llvm.memset.p0i8.i64(i8* %64, i8 0, i64 24, i32 8, i1 false), !dbg !915
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !916) #5, !dbg !918
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !919) #5, !dbg !921
  %65 = ptrtoint i8* %pathname to i64, !dbg !922
  %66 = tail call i64 @klee_get_valuel(i64 %65) #5, !dbg !922
  %67 = inttoptr i64 %66 to i8*, !dbg !922
  tail call void @llvm.dbg.value(metadata !{i8* %67}, i64 0, metadata !923) #5, !dbg !922
  %68 = icmp eq i8* %67, %pathname, !dbg !924
  %69 = zext i1 %68 to i64, !dbg !924
  tail call void @klee_assume(i64 %69) #5, !dbg !924
  tail call void @llvm.dbg.value(metadata !{i8* %67}, i64 0, metadata !925) #5, !dbg !920
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !926) #5, !dbg !927
  br label %70, !dbg !927

; <label>:70                                      ; preds = %87, %61
  %i.0.i = phi i32 [ 0, %61 ], [ %88, %87 ]
  %sc.0.i = phi i8* [ %67, %61 ], [ %sc.1.i, %87 ]
  %71 = load i8* %sc.0.i, align 1, !dbg !928, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %71}, i64 0, metadata !929) #5, !dbg !928
  %72 = add i32 %i.0.i, -1, !dbg !930
  %73 = and i32 %72, %i.0.i, !dbg !930
  %74 = icmp eq i32 %73, 0, !dbg !930
  br i1 %74, label %75, label %79, !dbg !930

; <label>:75                                      ; preds = %70
  switch i8 %71, label %87 [
    i8 0, label %76
    i8 47, label %77
  ], !dbg !931

; <label>:76                                      ; preds = %75
  store i8 0, i8* %sc.0.i, align 1, !dbg !932, !tbaa !694
  br label %__concretize_string.exit, !dbg !933

; <label>:77                                      ; preds = %75
  %78 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !934
  tail call void @llvm.dbg.value(metadata !{i8* %78}, i64 0, metadata !925) #5, !dbg !934
  store i8 47, i8* %sc.0.i, align 1, !dbg !934, !tbaa !694
  br label %87, !dbg !935

; <label>:79                                      ; preds = %70
  %80 = sext i8 %71 to i64, !dbg !936
  %81 = tail call i64 @klee_get_valuel(i64 %80) #5, !dbg !936
  %82 = trunc i64 %81 to i8, !dbg !936
  tail call void @llvm.dbg.value(metadata !{i8 %82}, i64 0, metadata !937) #5, !dbg !936
  %83 = icmp eq i8 %82, %71, !dbg !938
  %84 = zext i1 %83 to i64, !dbg !938
  tail call void @klee_assume(i64 %84) #5, !dbg !938
  %85 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !939
  tail call void @llvm.dbg.value(metadata !{i8* %85}, i64 0, metadata !925) #5, !dbg !939
  store i8 %82, i8* %sc.0.i, align 1, !dbg !939, !tbaa !694
  %86 = icmp eq i8 %82, 0, !dbg !940
  br i1 %86, label %__concretize_string.exit, label %87, !dbg !940

; <label>:87                                      ; preds = %79, %77, %75
  %sc.1.i = phi i8* [ %85, %79 ], [ %78, %77 ], [ %sc.0.i, %75 ]
  %88 = add i32 %i.0.i, 1, !dbg !927
  tail call void @llvm.dbg.value(metadata !{i32 %88}, i64 0, metadata !926) #5, !dbg !927
  br label %70, !dbg !927

__concretize_string.exit:                         ; preds = %79, %76
  %89 = sext i32 %flags to i64, !dbg !917
  %90 = tail call i64 (i64, ...)* @syscall(i64 257, i64 %.01, i8* %pathname, i64 %89, i32 %mode) #5, !dbg !917
  %91 = trunc i64 %90 to i32, !dbg !917
  tail call void @llvm.dbg.value(metadata !{i32 %91}, i64 0, metadata !132), !dbg !917
  %92 = icmp eq i32 %91, -1, !dbg !941
  br i1 %92, label %93, label %96, !dbg !941

; <label>:93                                      ; preds = %__concretize_string.exit
  %94 = tail call i32 @klee_get_errno() #5, !dbg !943
  %95 = tail call i32* @__errno_location() #1, !dbg !943
  store i32 %94, i32* %95, align 4, !dbg !943, !tbaa !752
  br label %103, !dbg !945

; <label>:96                                      ; preds = %__concretize_string.exit
  %97 = getelementptr inbounds %struct.exe_file_t* %63, i64 0, i32 0, !dbg !946
  store i32 %91, i32* %97, align 8, !dbg !946, !tbaa !855
  %98 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %62, i32 1, !dbg !947
  store i32 1, i32* %98, align 4, !dbg !947, !tbaa !765
  %99 = and i32 %flags, 3, !dbg !948
  switch i32 %99, label %102 [
    i32 0, label %100
    i32 1, label %101
  ], !dbg !948

; <label>:100                                     ; preds = %96
  store i32 5, i32* %98, align 4, !dbg !950, !tbaa !765
  br label %103, !dbg !952

; <label>:101                                     ; preds = %96
  store i32 9, i32* %98, align 4, !dbg !953, !tbaa !765
  br label %103, !dbg !956

; <label>:102                                     ; preds = %96
  store i32 13, i32* %98, align 4, !dbg !957, !tbaa !765
  br label %103

; <label>:103                                     ; preds = %100, %102, %101, %93, %59, %48, %17, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %17 ], [ %49, %48 ], [ -1, %59 ], [ -1, %93 ], [ -1, %__get_file.exit.thread ], [ %fd.0.lcssa, %101 ], [ %fd.0.lcssa, %102 ], [ %fd.0.lcssa, %100 ]
  ret i32 %.0, !dbg !959
}

; Function Attrs: nounwind ssp uwtable
define i32 @utimes(i8* %path, %struct.timeval* %times) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !145), !dbg !960
  tail call void @llvm.dbg.value(metadata !{%struct.timeval* %times}, i64 0, metadata !146), !dbg !960
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !961), !dbg !963
  %1 = load i8* %path, align 1, !dbg !964, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !965), !dbg !964
  %2 = sext i8 %1 to i32, !dbg !966
  %3 = icmp eq i8 %1, 0, !dbg !966
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !966

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !966
  %6 = load i8* %5, align 1, !dbg !966, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !966
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !966

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !967, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !967
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !967

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !967
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !967

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !968
  %12 = ashr exact i32 %sext.i, 24, !dbg !968
  %13 = add nsw i32 %12, 65, !dbg !968
  %14 = icmp eq i32 %2, %13, !dbg !968
  %15 = add i32 %i.02.i, 1, !dbg !967
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !969), !dbg !967
  br i1 %14, label %16, label %10, !dbg !968

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !970
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !970, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !971
  %20 = load %struct.stat64** %19, align 8, !dbg !971, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !971
  %22 = load i64* %21, align 8, !dbg !971, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !971
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !970
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !972
  %or.cond = or i1 %23, %25, !dbg !971
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !971

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds %struct.timeval* %times, i64 0, i32 0, !dbg !974
  %28 = load i64* %27, align 8, !dbg !974, !tbaa !976
  %29 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 11, i32 0, !dbg !974
  store i64 %28, i64* %29, align 8, !dbg !974, !tbaa !978
  %30 = getelementptr inbounds %struct.timeval* %times, i64 1, i32 0, !dbg !979
  %31 = load i64* %30, align 8, !dbg !979, !tbaa !976
  %32 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 12, i32 0, !dbg !979
  store i64 %31, i64* %32, align 8, !dbg !979, !tbaa !980
  %33 = mul nsw i64 %28, 1000000000, !dbg !981
  %34 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 11, i32 1, !dbg !981
  store i64 %33, i64* %34, align 8, !dbg !981, !tbaa !982
  %35 = mul nsw i64 %31, 1000000000, !dbg !983
  %36 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 12, i32 1, !dbg !983
  store i64 %35, i64* %36, align 8, !dbg !983, !tbaa !984
  br label %67, !dbg !985

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !986) #5, !dbg !988
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !989) #5, !dbg !991
  %37 = ptrtoint i8* %path to i64, !dbg !992
  %38 = tail call i64 @klee_get_valuel(i64 %37) #5, !dbg !992
  %39 = inttoptr i64 %38 to i8*, !dbg !992
  tail call void @llvm.dbg.value(metadata !{i8* %39}, i64 0, metadata !993) #5, !dbg !992
  %40 = icmp eq i8* %39, %path, !dbg !994
  %41 = zext i1 %40 to i64, !dbg !994
  tail call void @klee_assume(i64 %41) #5, !dbg !994
  tail call void @llvm.dbg.value(metadata !{i8* %39}, i64 0, metadata !995) #5, !dbg !990
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !996) #5, !dbg !997
  br label %42, !dbg !997

; <label>:42                                      ; preds = %59, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %60, %59 ]
  %sc.0.i = phi i8* [ %39, %__get_sym_file.exit.thread ], [ %sc.1.i, %59 ]
  %43 = load i8* %sc.0.i, align 1, !dbg !998, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %43}, i64 0, metadata !999) #5, !dbg !998
  %44 = add i32 %i.0.i, -1, !dbg !1000
  %45 = and i32 %44, %i.0.i, !dbg !1000
  %46 = icmp eq i32 %45, 0, !dbg !1000
  br i1 %46, label %47, label %51, !dbg !1000

; <label>:47                                      ; preds = %42
  switch i8 %43, label %59 [
    i8 0, label %48
    i8 47, label %49
  ], !dbg !1001

; <label>:48                                      ; preds = %47
  store i8 0, i8* %sc.0.i, align 1, !dbg !1002, !tbaa !694
  br label %__concretize_string.exit, !dbg !1003

; <label>:49                                      ; preds = %47
  %50 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1004
  tail call void @llvm.dbg.value(metadata !{i8* %50}, i64 0, metadata !995) #5, !dbg !1004
  store i8 47, i8* %sc.0.i, align 1, !dbg !1004, !tbaa !694
  br label %59, !dbg !1005

; <label>:51                                      ; preds = %42
  %52 = sext i8 %43 to i64, !dbg !1006
  %53 = tail call i64 @klee_get_valuel(i64 %52) #5, !dbg !1006
  %54 = trunc i64 %53 to i8, !dbg !1006
  tail call void @llvm.dbg.value(metadata !{i8 %54}, i64 0, metadata !1007) #5, !dbg !1006
  %55 = icmp eq i8 %54, %43, !dbg !1008
  %56 = zext i1 %55 to i64, !dbg !1008
  tail call void @klee_assume(i64 %56) #5, !dbg !1008
  %57 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1009
  tail call void @llvm.dbg.value(metadata !{i8* %57}, i64 0, metadata !995) #5, !dbg !1009
  store i8 %54, i8* %sc.0.i, align 1, !dbg !1009, !tbaa !694
  %58 = icmp eq i8 %54, 0, !dbg !1010
  br i1 %58, label %__concretize_string.exit, label %59, !dbg !1010

; <label>:59                                      ; preds = %51, %49, %47
  %sc.1.i = phi i8* [ %57, %51 ], [ %50, %49 ], [ %sc.0.i, %47 ]
  %60 = add i32 %i.0.i, 1, !dbg !997
  tail call void @llvm.dbg.value(metadata !{i32 %60}, i64 0, metadata !996) #5, !dbg !997
  br label %42, !dbg !997

__concretize_string.exit:                         ; preds = %51, %48
  %61 = tail call i64 (i64, ...)* @syscall(i64 235, i8* %path, %struct.timeval* %times) #5, !dbg !987
  %62 = trunc i64 %61 to i32, !dbg !987
  tail call void @llvm.dbg.value(metadata !{i32 %62}, i64 0, metadata !148), !dbg !987
  %63 = icmp eq i32 %62, -1, !dbg !1011
  br i1 %63, label %64, label %67, !dbg !1011

; <label>:64                                      ; preds = %__concretize_string.exit
  %65 = tail call i32 @klee_get_errno() #5, !dbg !1013
  %66 = tail call i32* @__errno_location() #1, !dbg !1013
  store i32 %65, i32* %66, align 4, !dbg !1013, !tbaa !752
  br label %67, !dbg !1013

; <label>:67                                      ; preds = %__concretize_string.exit, %64, %26
  %.0 = phi i32 [ 0, %26 ], [ -1, %64 ], [ %62, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1014
}

; Function Attrs: nounwind ssp uwtable
define i32 @futimesat(i32 %fd, i8* %path, %struct.timeval* %times) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !153), !dbg !1015
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !154), !dbg !1015
  tail call void @llvm.dbg.value(metadata !{%struct.timeval* %times}, i64 0, metadata !155), !dbg !1015
  %1 = icmp eq i32 %fd, -100, !dbg !1016
  br i1 %1, label %22, label %2, !dbg !1016

; <label>:2                                       ; preds = %0
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1017), !dbg !1019
  %3 = icmp ult i32 %fd, 32, !dbg !1020
  br i1 %3, label %4, label %__get_file.exit.thread, !dbg !1020

; <label>:4                                       ; preds = %2
  %5 = sext i32 %fd to i64, !dbg !1021
  %6 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 1, !dbg !1022
  %7 = load i32* %6, align 4, !dbg !1022, !tbaa !765
  %8 = and i32 %7, 1, !dbg !1022
  %9 = icmp eq i32 %8, 0, !dbg !1022
  br i1 %9, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1022

__get_file.exit:                                  ; preds = %4
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, !dbg !1021
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !156), !dbg !1018
  %11 = icmp eq %struct.exe_file_t* %10, null, !dbg !1023
  br i1 %11, label %__get_file.exit.thread, label %13, !dbg !1023

__get_file.exit.thread:                           ; preds = %2, %4, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !1025
  store i32 9, i32* %12, align 4, !dbg !1025, !tbaa !752
  br label %83, !dbg !1027

; <label>:13                                      ; preds = %__get_file.exit
  %14 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 3, !dbg !1028
  %15 = load %struct.exe_disk_file_t** %14, align 8, !dbg !1028, !tbaa !788
  %16 = icmp eq %struct.exe_disk_file_t* %15, null, !dbg !1028
  br i1 %16, label %19, label %17, !dbg !1028

; <label>:17                                      ; preds = %13
  tail call void @klee_warning(i8* getelementptr inbounds ([44 x i8]* @.str2, i64 0, i64 0)) #5, !dbg !1030
  %18 = tail call i32* @__errno_location() #1, !dbg !1032
  store i32 2, i32* %18, align 4, !dbg !1032, !tbaa !752
  br label %83, !dbg !1033

; <label>:19                                      ; preds = %13
  %20 = getelementptr inbounds %struct.exe_file_t* %10, i64 0, i32 0, !dbg !1034
  %21 = load i32* %20, align 8, !dbg !1034, !tbaa !855
  tail call void @llvm.dbg.value(metadata !{i32 %21}, i64 0, metadata !153), !dbg !1034
  %phitmp = sext i32 %21 to i64, !dbg !1035
  br label %22, !dbg !1035

; <label>:22                                      ; preds = %0, %19
  %.01 = phi i64 [ %phitmp, %19 ], [ -100, %0 ]
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1036), !dbg !1039
  %23 = load i8* %path, align 1, !dbg !1040, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %23}, i64 0, metadata !1041), !dbg !1040
  %24 = sext i8 %23 to i32, !dbg !1042
  %25 = icmp eq i8 %23, 0, !dbg !1042
  br i1 %25, label %__get_sym_file.exit.thread, label %26, !dbg !1042

; <label>:26                                      ; preds = %22
  %27 = getelementptr inbounds i8* %path, i64 1, !dbg !1042
  %28 = load i8* %27, align 1, !dbg !1042, !tbaa !694
  %29 = icmp eq i8 %28, 0, !dbg !1042
  br i1 %29, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1042

.preheader.i:                                     ; preds = %26
  %30 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1043, !tbaa !701
  %31 = icmp eq i32 %30, 0, !dbg !1043
  br i1 %31, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1043

; <label>:32                                      ; preds = %.lr.ph.i
  %33 = icmp ult i32 %37, %30, !dbg !1043
  br i1 %33, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1043

.lr.ph.i:                                         ; preds = %.preheader.i, %32
  %i.02.i = phi i32 [ %37, %32 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1044
  %34 = ashr exact i32 %sext.i, 24, !dbg !1044
  %35 = add nsw i32 %34, 65, !dbg !1044
  %36 = icmp eq i32 %24, %35, !dbg !1044
  %37 = add i32 %i.02.i, 1, !dbg !1043
  tail call void @llvm.dbg.value(metadata !{i32 %37}, i64 0, metadata !1045), !dbg !1043
  br i1 %36, label %38, label %32, !dbg !1044

; <label>:38                                      ; preds = %.lr.ph.i
  %39 = zext i32 %i.02.i to i64, !dbg !1046
  %40 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1046, !tbaa !708
  %41 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, i32 2, !dbg !1047
  %42 = load %struct.stat64** %41, align 8, !dbg !1047, !tbaa !711
  %43 = getelementptr inbounds %struct.stat64* %42, i64 0, i32 1, !dbg !1047
  %44 = load i64* %43, align 8, !dbg !1047, !tbaa !713
  %45 = icmp eq i64 %44, 0, !dbg !1047
  %46 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, !dbg !1046
  %47 = icmp eq %struct.exe_disk_file_t* %46, null, !dbg !1037
  %or.cond = or i1 %45, %47, !dbg !1047
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %48, !dbg !1047

; <label>:48                                      ; preds = %38
  %49 = tail call i32 @utimes(i8* %path, %struct.timeval* %times), !dbg !1048
  br label %83, !dbg !1048

__get_sym_file.exit.thread:                       ; preds = %32, %.preheader.i, %38, %22, %26
  %50 = icmp eq i8* %path, null, !dbg !1050
  br i1 %50, label %__concretize_string.exit, label %51, !dbg !1050

; <label>:51                                      ; preds = %__get_sym_file.exit.thread
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1051) #5, !dbg !1053
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1054) #5, !dbg !1056
  %52 = ptrtoint i8* %path to i64, !dbg !1057
  %53 = tail call i64 @klee_get_valuel(i64 %52) #5, !dbg !1057
  %54 = inttoptr i64 %53 to i8*, !dbg !1057
  tail call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !1058) #5, !dbg !1057
  %55 = icmp eq i8* %54, %path, !dbg !1059
  %56 = zext i1 %55 to i64, !dbg !1059
  tail call void @klee_assume(i64 %56) #5, !dbg !1059
  tail call void @llvm.dbg.value(metadata !{i8* %54}, i64 0, metadata !1060) #5, !dbg !1055
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1061) #5, !dbg !1062
  br label %57, !dbg !1062

; <label>:57                                      ; preds = %74, %51
  %i.0.i = phi i32 [ 0, %51 ], [ %75, %74 ]
  %sc.0.i = phi i8* [ %54, %51 ], [ %sc.1.i, %74 ]
  %58 = load i8* %sc.0.i, align 1, !dbg !1063, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %58}, i64 0, metadata !1064) #5, !dbg !1063
  %59 = add i32 %i.0.i, -1, !dbg !1065
  %60 = and i32 %59, %i.0.i, !dbg !1065
  %61 = icmp eq i32 %60, 0, !dbg !1065
  br i1 %61, label %62, label %66, !dbg !1065

; <label>:62                                      ; preds = %57
  switch i8 %58, label %74 [
    i8 0, label %63
    i8 47, label %64
  ], !dbg !1066

; <label>:63                                      ; preds = %62
  store i8 0, i8* %sc.0.i, align 1, !dbg !1067, !tbaa !694
  br label %__concretize_string.exit, !dbg !1068

; <label>:64                                      ; preds = %62
  %65 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1069
  tail call void @llvm.dbg.value(metadata !{i8* %65}, i64 0, metadata !1060) #5, !dbg !1069
  store i8 47, i8* %sc.0.i, align 1, !dbg !1069, !tbaa !694
  br label %74, !dbg !1070

; <label>:66                                      ; preds = %57
  %67 = sext i8 %58 to i64, !dbg !1071
  %68 = tail call i64 @klee_get_valuel(i64 %67) #5, !dbg !1071
  %69 = trunc i64 %68 to i8, !dbg !1071
  tail call void @llvm.dbg.value(metadata !{i8 %69}, i64 0, metadata !1072) #5, !dbg !1071
  %70 = icmp eq i8 %69, %58, !dbg !1073
  %71 = zext i1 %70 to i64, !dbg !1073
  tail call void @klee_assume(i64 %71) #5, !dbg !1073
  %72 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1074
  tail call void @llvm.dbg.value(metadata !{i8* %72}, i64 0, metadata !1060) #5, !dbg !1074
  store i8 %69, i8* %sc.0.i, align 1, !dbg !1074, !tbaa !694
  %73 = icmp eq i8 %69, 0, !dbg !1075
  br i1 %73, label %__concretize_string.exit, label %74, !dbg !1075

; <label>:74                                      ; preds = %66, %64, %62
  %sc.1.i = phi i8* [ %72, %66 ], [ %65, %64 ], [ %sc.0.i, %62 ]
  %75 = add i32 %i.0.i, 1, !dbg !1062
  tail call void @llvm.dbg.value(metadata !{i32 %75}, i64 0, metadata !1061) #5, !dbg !1062
  br label %57, !dbg !1062

__concretize_string.exit:                         ; preds = %66, %63, %__get_sym_file.exit.thread
  %76 = phi i8* [ null, %__get_sym_file.exit.thread ], [ %path, %63 ], [ %path, %66 ], !dbg !1052
  %77 = tail call i64 (i64, ...)* @syscall(i64 261, i64 %.01, i8* %76, %struct.timeval* %times) #5, !dbg !1050
  %78 = trunc i64 %77 to i32, !dbg !1050
  tail call void @llvm.dbg.value(metadata !{i32 %78}, i64 0, metadata !159), !dbg !1050
  %79 = icmp eq i32 %78, -1, !dbg !1076
  br i1 %79, label %80, label %83, !dbg !1076

; <label>:80                                      ; preds = %__concretize_string.exit
  %81 = tail call i32 @klee_get_errno() #5, !dbg !1078
  %82 = tail call i32* @__errno_location() #1, !dbg !1078
  store i32 %81, i32* %82, align 4, !dbg !1078, !tbaa !752
  br label %83, !dbg !1078

; <label>:83                                      ; preds = %__concretize_string.exit, %80, %48, %17, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %17 ], [ %49, %48 ], [ -1, %__get_file.exit.thread ], [ -1, %80 ], [ %78, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1079
}

; Function Attrs: nounwind ssp uwtable
define i32 @close(i32 %fd) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !164), !dbg !1080
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !166), !dbg !1081
  %1 = load i32* @close.n_calls, align 4, !dbg !1082, !tbaa !752
  %2 = add nsw i32 %1, 1, !dbg !1082
  store i32 %2, i32* @close.n_calls, align 4, !dbg !1082, !tbaa !752
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1083), !dbg !1085
  %3 = icmp ult i32 %fd, 32, !dbg !1086
  br i1 %3, label %4, label %__get_file.exit.thread, !dbg !1086

; <label>:4                                       ; preds = %0
  %5 = sext i32 %fd to i64, !dbg !1087
  %6 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 1, !dbg !1088
  %7 = load i32* %6, align 4, !dbg !1088, !tbaa !765
  %8 = and i32 %7, 1, !dbg !1088
  %9 = icmp eq i32 %8, 0, !dbg !1088
  br i1 %9, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1088

__get_file.exit:                                  ; preds = %4
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, !dbg !1087
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !165), !dbg !1084
  %11 = icmp eq %struct.exe_file_t* %10, null, !dbg !1089
  br i1 %11, label %__get_file.exit.thread, label %13, !dbg !1089

__get_file.exit.thread:                           ; preds = %0, %4, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !1091
  store i32 9, i32* %12, align 4, !dbg !1091, !tbaa !752
  br label %25, !dbg !1093

; <label>:13                                      ; preds = %__get_file.exit
  %14 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1094, !tbaa !1096
  %15 = icmp eq i32 %14, 0, !dbg !1094
  br i1 %15, label %23, label %16, !dbg !1094

; <label>:16                                      ; preds = %13
  %17 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 8), align 8, !dbg !1094, !tbaa !1097
  %18 = load i32* %17, align 4, !dbg !1094, !tbaa !752
  %19 = icmp eq i32 %18, %2, !dbg !1094
  br i1 %19, label %20, label %23, !dbg !1094

; <label>:20                                      ; preds = %16
  %21 = add i32 %14, -1, !dbg !1098
  store i32 %21, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1098, !tbaa !1096
  %22 = tail call i32* @__errno_location() #1, !dbg !1100
  store i32 5, i32* %22, align 4, !dbg !1100, !tbaa !752
  br label %25, !dbg !1101

; <label>:23                                      ; preds = %13, %16
  %24 = bitcast %struct.exe_file_t* %10 to i8*, !dbg !1102
  tail call void @llvm.memset.p0i8.i64(i8* %24, i8 0, i64 24, i32 8, i1 false), !dbg !1102
  br label %25, !dbg !1103

; <label>:25                                      ; preds = %23, %20, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %20 ], [ 0, %23 ], [ -1, %__get_file.exit.thread ]
  ret i32 %.0, !dbg !1104
}

; Function Attrs: alwaysinline inlinehint nounwind ssp uwtable
define i64 @read(i32 %fd, i8* %buf, i64 %count) #6 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !175), !dbg !1105
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !176), !dbg !1105
  tail call void @llvm.dbg.value(metadata !{i64 %count}, i64 0, metadata !177), !dbg !1105
  %1 = load i32* @read.n_calls, align 4, !dbg !1106, !tbaa !752
  %2 = add nsw i32 %1, 1, !dbg !1106
  store i32 %2, i32* @read.n_calls, align 4, !dbg !1106, !tbaa !752
  %3 = icmp eq i64 %count, 0, !dbg !1107
  br i1 %3, label %._crit_edge, label %4, !dbg !1107

; <label>:4                                       ; preds = %0
  %5 = icmp eq i8* %buf, null, !dbg !1109
  br i1 %5, label %6, label %8, !dbg !1109

; <label>:6                                       ; preds = %4
  %7 = tail call i32* @__errno_location() #1, !dbg !1111
  store i32 14, i32* %7, align 4, !dbg !1111, !tbaa !752
  br label %._crit_edge, !dbg !1113

; <label>:8                                       ; preds = %4
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1114), !dbg !1116
  %9 = icmp ult i32 %fd, 32, !dbg !1117
  br i1 %9, label %10, label %__get_file.exit.thread, !dbg !1117

; <label>:10                                      ; preds = %8
  %11 = sext i32 %fd to i64, !dbg !1118
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, i32 1, !dbg !1119
  %13 = load i32* %12, align 4, !dbg !1119, !tbaa !765
  %14 = and i32 %13, 1, !dbg !1119
  %15 = icmp eq i32 %14, 0, !dbg !1119
  br i1 %15, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1119

__get_file.exit:                                  ; preds = %10
  %16 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, !dbg !1118
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %16}, i64 0, metadata !178), !dbg !1115
  %17 = icmp eq %struct.exe_file_t* %16, null, !dbg !1120
  br i1 %17, label %__get_file.exit.thread, label %19, !dbg !1120

__get_file.exit.thread:                           ; preds = %8, %10, %__get_file.exit
  %18 = tail call i32* @__errno_location() #1, !dbg !1122
  store i32 9, i32* %18, align 4, !dbg !1122, !tbaa !752
  br label %._crit_edge, !dbg !1124

; <label>:19                                      ; preds = %__get_file.exit
  %20 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1125, !tbaa !1096
  %21 = icmp eq i32 %20, 0, !dbg !1125
  br i1 %21, label %29, label %22, !dbg !1125

; <label>:22                                      ; preds = %19
  %23 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 6), align 8, !dbg !1125, !tbaa !1127
  %24 = load i32* %23, align 4, !dbg !1125, !tbaa !752
  %25 = icmp eq i32 %24, %2, !dbg !1125
  br i1 %25, label %26, label %29, !dbg !1125

; <label>:26                                      ; preds = %22
  %27 = add i32 %20, -1, !dbg !1128
  store i32 %27, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1128, !tbaa !1096
  %28 = tail call i32* @__errno_location() #1, !dbg !1130
  store i32 5, i32* %28, align 4, !dbg !1130, !tbaa !752
  br label %._crit_edge, !dbg !1131

; <label>:29                                      ; preds = %19, %22
  %30 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, i32 3, !dbg !1132
  %31 = load %struct.exe_disk_file_t** %30, align 8, !dbg !1132, !tbaa !788
  %32 = icmp eq %struct.exe_disk_file_t* %31, null, !dbg !1132
  br i1 %32, label %33, label %63, !dbg !1132

; <label>:33                                      ; preds = %29
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !1133) #5, !dbg !1135
  %34 = ptrtoint i8* %buf to i64, !dbg !1136
  %35 = tail call i64 @klee_get_valuel(i64 %34) #5, !dbg !1136
  %36 = inttoptr i64 %35 to i8*, !dbg !1136
  tail call void @llvm.dbg.value(metadata !{i8* %36}, i64 0, metadata !1137) #5, !dbg !1136
  %37 = icmp eq i8* %36, %buf, !dbg !1138
  %38 = zext i1 %37 to i64, !dbg !1138
  tail call void @klee_assume(i64 %38) #5, !dbg !1138
  tail call void @llvm.dbg.value(metadata !{i8* %36}, i64 0, metadata !176), !dbg !1134
  tail call void @llvm.dbg.value(metadata !{i64 %count}, i64 0, metadata !1139) #5, !dbg !1141
  %39 = tail call i64 @klee_get_valuel(i64 %count) #5, !dbg !1142
  tail call void @llvm.dbg.value(metadata !{i64 %39}, i64 0, metadata !1143) #5, !dbg !1142
  %40 = icmp eq i64 %39, %count, !dbg !1144
  %41 = zext i1 %40 to i64, !dbg !1144
  tail call void @klee_assume(i64 %41) #5, !dbg !1144
  tail call void @llvm.dbg.value(metadata !{i64 %39}, i64 0, metadata !177), !dbg !1140
  tail call void @klee_check_memory_access(i8* %36, i64 %39) #5, !dbg !1145
  %42 = getelementptr inbounds %struct.exe_file_t* %16, i64 0, i32 0, !dbg !1146
  %43 = load i32* %42, align 8, !dbg !1146, !tbaa !855
  %44 = icmp eq i32 %43, 0, !dbg !1146
  br i1 %44, label %45, label %47, !dbg !1146

; <label>:45                                      ; preds = %33
  %46 = tail call i64 (i64, ...)* @syscall(i64 0, i32 0, i8* %36, i64 %39) #5, !dbg !1148
  br label %51, !dbg !1148

; <label>:47                                      ; preds = %33
  %48 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, i32 2, !dbg !1149
  %49 = load i64* %48, align 8, !dbg !1149, !tbaa !1150
  %50 = tail call i64 (i64, ...)* @syscall(i64 17, i32 %43, i8* %36, i64 %39, i64 %49) #5, !dbg !1149
  br label %51

; <label>:51                                      ; preds = %47, %45
  %r.0.in = phi i64 [ %46, %45 ], [ %50, %47 ]
  %r.0 = trunc i64 %r.0.in to i32, !dbg !1148
  %52 = icmp eq i32 %r.0, -1, !dbg !1151
  br i1 %52, label %53, label %56, !dbg !1151

; <label>:53                                      ; preds = %51
  %54 = tail call i32 @klee_get_errno() #5, !dbg !1153
  %55 = tail call i32* @__errno_location() #1, !dbg !1153
  store i32 %54, i32* %55, align 4, !dbg !1153, !tbaa !752
  br label %._crit_edge, !dbg !1155

; <label>:56                                      ; preds = %51
  %57 = load i32* %42, align 8, !dbg !1156, !tbaa !855
  %58 = icmp eq i32 %57, 0, !dbg !1156
  %sext.pre = shl i64 %r.0.in, 32, !dbg !1158
  %.pre = ashr exact i64 %sext.pre, 32, !dbg !1158
  br i1 %58, label %._crit_edge, label %59, !dbg !1156

; <label>:59                                      ; preds = %56
  %60 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, i32 2, !dbg !1159
  %61 = load i64* %60, align 8, !dbg !1159, !tbaa !1150
  %62 = add nsw i64 %61, %.pre, !dbg !1159
  store i64 %62, i64* %60, align 8, !dbg !1159, !tbaa !1150
  br label %._crit_edge, !dbg !1159

; <label>:63                                      ; preds = %29
  %64 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %11, i32 2, !dbg !1160
  %65 = load i64* %64, align 8, !dbg !1160, !tbaa !1150
  %66 = icmp sgt i64 %65, -1, !dbg !1160
  br i1 %66, label %68, label %67, !dbg !1160

; <label>:67                                      ; preds = %63
  tail call void @__assert_fail(i8* getelementptr inbounds ([12 x i8]* @.str3, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i32 386, i8* getelementptr inbounds ([34 x i8]* @__PRETTY_FUNCTION__.read, i64 0, i64 0)) #9, !dbg !1160
  unreachable, !dbg !1160

; <label>:68                                      ; preds = %63
  %69 = getelementptr inbounds %struct.exe_disk_file_t* %31, i64 0, i32 0, !dbg !1162
  %70 = load i32* %69, align 4, !dbg !1162, !tbaa !1164
  %71 = zext i32 %70 to i64, !dbg !1162
  %72 = icmp slt i64 %71, %65, !dbg !1162
  br i1 %72, label %._crit_edge, label %73, !dbg !1162

; <label>:73                                      ; preds = %68
  %74 = add i64 %65, %count, !dbg !1165
  %75 = icmp ugt i64 %74, %71, !dbg !1165
  %76 = sub nsw i64 %71, %65, !dbg !1167
  tail call void @llvm.dbg.value(metadata !{i64 %76}, i64 0, metadata !177), !dbg !1167
  %.count = select i1 %75, i64 %76, i64 %count, !dbg !1165
  %77 = getelementptr inbounds %struct.exe_disk_file_t* %31, i64 0, i32 1, !dbg !1169
  %78 = load i8** %77, align 8, !dbg !1169, !tbaa !1170
  %79 = getelementptr inbounds i8* %78, i64 %65, !dbg !1169
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %buf, i8* %79, i64 %.count, i32 1, i1 false), !dbg !1169
  %80 = load i64* %64, align 8, !dbg !1171, !tbaa !1150
  %81 = add i64 %80, %.count, !dbg !1171
  store i64 %81, i64* %64, align 8, !dbg !1171, !tbaa !1150
  br label %._crit_edge, !dbg !1172

._crit_edge:                                      ; preds = %56, %59, %68, %0, %73, %53, %26, %__get_file.exit.thread, %6
  %.0 = phi i64 [ -1, %6 ], [ -1, %26 ], [ %.count, %73 ], [ -1, %53 ], [ -1, %__get_file.exit.thread ], [ 0, %0 ], [ 0, %68 ], [ %.pre, %59 ], [ %.pre, %56 ]
  ret i64 %.0, !dbg !1173
}

declare void @klee_check_memory_access(i8*, i64) #3

; Function Attrs: noreturn nounwind
declare void @__assert_fail(i8*, i8*, i32, i8*) #7

; Function Attrs: nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture, i8* nocapture readonly, i64, i32, i1) #5

; Function Attrs: nounwind ssp uwtable
define i64 @write(i32 %fd, i8* %buf, i64 %count) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !188), !dbg !1174
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !189), !dbg !1174
  tail call void @llvm.dbg.value(metadata !{i64 %count}, i64 0, metadata !190), !dbg !1174
  %1 = load i32* @write.n_calls, align 4, !dbg !1175, !tbaa !752
  %2 = add nsw i32 %1, 1, !dbg !1175
  store i32 %2, i32* @write.n_calls, align 4, !dbg !1175, !tbaa !752
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1176), !dbg !1178
  %3 = icmp ult i32 %fd, 32, !dbg !1179
  br i1 %3, label %4, label %__get_file.exit.thread, !dbg !1179

; <label>:4                                       ; preds = %0
  %5 = sext i32 %fd to i64, !dbg !1180
  %6 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 1, !dbg !1181
  %7 = load i32* %6, align 4, !dbg !1181, !tbaa !765
  %8 = and i32 %7, 1, !dbg !1181
  %9 = icmp eq i32 %8, 0, !dbg !1181
  br i1 %9, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1181

__get_file.exit:                                  ; preds = %4
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, !dbg !1180
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !191), !dbg !1177
  %11 = icmp eq %struct.exe_file_t* %10, null, !dbg !1182
  br i1 %11, label %__get_file.exit.thread, label %13, !dbg !1182

__get_file.exit.thread:                           ; preds = %0, %4, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !1184
  store i32 9, i32* %12, align 4, !dbg !1184, !tbaa !752
  br label %._crit_edge, !dbg !1186

; <label>:13                                      ; preds = %__get_file.exit
  %14 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1187, !tbaa !1096
  %15 = icmp eq i32 %14, 0, !dbg !1187
  br i1 %15, label %23, label %16, !dbg !1187

; <label>:16                                      ; preds = %13
  %17 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 7), align 8, !dbg !1187, !tbaa !1189
  %18 = load i32* %17, align 4, !dbg !1187, !tbaa !752
  %19 = icmp eq i32 %18, %2, !dbg !1187
  br i1 %19, label %20, label %23, !dbg !1187

; <label>:20                                      ; preds = %16
  %21 = add i32 %14, -1, !dbg !1190
  store i32 %21, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1190, !tbaa !1096
  %22 = tail call i32* @__errno_location() #1, !dbg !1192
  store i32 5, i32* %22, align 4, !dbg !1192, !tbaa !752
  br label %._crit_edge, !dbg !1193

; <label>:23                                      ; preds = %13, %16
  %24 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 3, !dbg !1194
  %25 = load %struct.exe_disk_file_t** %24, align 8, !dbg !1194, !tbaa !788
  %26 = icmp eq %struct.exe_disk_file_t* %25, null, !dbg !1194
  br i1 %26, label %27, label %58, !dbg !1194

; <label>:27                                      ; preds = %23
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !1195) #5, !dbg !1197
  %28 = ptrtoint i8* %buf to i64, !dbg !1198
  %29 = tail call i64 @klee_get_valuel(i64 %28) #5, !dbg !1198
  %30 = inttoptr i64 %29 to i8*, !dbg !1198
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1199) #5, !dbg !1198
  %31 = icmp eq i8* %30, %buf, !dbg !1200
  %32 = zext i1 %31 to i64, !dbg !1200
  tail call void @klee_assume(i64 %32) #5, !dbg !1200
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !189), !dbg !1196
  tail call void @llvm.dbg.value(metadata !{i64 %count}, i64 0, metadata !1201) #5, !dbg !1203
  %33 = tail call i64 @klee_get_valuel(i64 %count) #5, !dbg !1204
  tail call void @llvm.dbg.value(metadata !{i64 %33}, i64 0, metadata !1205) #5, !dbg !1204
  %34 = icmp eq i64 %33, %count, !dbg !1206
  %35 = zext i1 %34 to i64, !dbg !1206
  tail call void @klee_assume(i64 %35) #5, !dbg !1206
  tail call void @llvm.dbg.value(metadata !{i64 %33}, i64 0, metadata !190), !dbg !1202
  tail call void @klee_check_memory_access(i8* %30, i64 %33) #5, !dbg !1207
  %36 = getelementptr inbounds %struct.exe_file_t* %10, i64 0, i32 0, !dbg !1208
  %37 = load i32* %36, align 8, !dbg !1208, !tbaa !855
  %.off = add i32 %37, -1, !dbg !1208
  %switch = icmp ult i32 %.off, 2, !dbg !1208
  br i1 %switch, label %38, label %40, !dbg !1208

; <label>:38                                      ; preds = %27
  %39 = tail call i64 (i64, ...)* @syscall(i64 1, i32 %37, i8* %30, i64 %33) #5, !dbg !1210
  br label %44, !dbg !1210

; <label>:40                                      ; preds = %27
  %41 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 2, !dbg !1211
  %42 = load i64* %41, align 8, !dbg !1211, !tbaa !1150
  %43 = tail call i64 (i64, ...)* @syscall(i64 18, i32 %37, i8* %30, i64 %33, i64 %42) #5, !dbg !1211
  br label %44

; <label>:44                                      ; preds = %40, %38
  %r.0.in = phi i64 [ %39, %38 ], [ %43, %40 ]
  %r.0 = trunc i64 %r.0.in to i32, !dbg !1210
  %45 = icmp eq i32 %r.0, -1, !dbg !1212
  br i1 %45, label %46, label %49, !dbg !1212

; <label>:46                                      ; preds = %44
  %47 = tail call i32 @klee_get_errno() #5, !dbg !1214
  %48 = tail call i32* @__errno_location() #1, !dbg !1214
  store i32 %47, i32* %48, align 4, !dbg !1214, !tbaa !752
  br label %._crit_edge, !dbg !1216

; <label>:49                                      ; preds = %44
  %50 = icmp sgt i32 %r.0, -1, !dbg !1217
  br i1 %50, label %52, label %51, !dbg !1217

; <label>:51                                      ; preds = %49
  tail call void @__assert_fail(i8* getelementptr inbounds ([7 x i8]* @.str5, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i32 440, i8* getelementptr inbounds ([41 x i8]* @__PRETTY_FUNCTION__.write, i64 0, i64 0)) #9, !dbg !1217
  unreachable, !dbg !1217

; <label>:52                                      ; preds = %49
  %53 = load i32* %36, align 8, !dbg !1218, !tbaa !855
  %.off2 = add i32 %53, -1, !dbg !1218
  %switch3 = icmp ult i32 %.off2, 2, !dbg !1218
  %sext.pre = shl i64 %r.0.in, 32, !dbg !1220
  %.pre = ashr exact i64 %sext.pre, 32, !dbg !1220
  br i1 %switch3, label %._crit_edge, label %54, !dbg !1218

; <label>:54                                      ; preds = %52
  %55 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 2, !dbg !1221
  %56 = load i64* %55, align 8, !dbg !1221, !tbaa !1150
  %57 = add nsw i64 %56, %.pre, !dbg !1221
  store i64 %57, i64* %55, align 8, !dbg !1221, !tbaa !1150
  br label %._crit_edge, !dbg !1221

; <label>:58                                      ; preds = %23
  tail call void @llvm.dbg.value(metadata !1222, i64 0, metadata !195), !dbg !1223
  %59 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 2, !dbg !1224
  %60 = load i64* %59, align 8, !dbg !1224, !tbaa !1150
  %61 = add i64 %60, %count, !dbg !1224
  %62 = getelementptr inbounds %struct.exe_disk_file_t* %25, i64 0, i32 0, !dbg !1224
  %63 = load i32* %62, align 4, !dbg !1224, !tbaa !1164
  %64 = zext i32 %63 to i64, !dbg !1224
  %65 = icmp ugt i64 %61, %64, !dbg !1224
  br i1 %65, label %66, label %select.unfold, !dbg !1224

; <label>:66                                      ; preds = %58
  %67 = load i32* getelementptr inbounds (%struct.exe_sym_env_t* @__exe_env, i64 0, i32 3), align 8, !dbg !1226, !tbaa !1229
  %68 = icmp eq i32 %67, 0, !dbg !1226
  br i1 %68, label %70, label %69, !dbg !1226

; <label>:69                                      ; preds = %66
  tail call void @__assert_fail(i8* getelementptr inbounds ([2 x i8]* @.str6, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i32 453, i8* getelementptr inbounds ([41 x i8]* @__PRETTY_FUNCTION__.write, i64 0, i64 0)) #9, !dbg !1230
  unreachable, !dbg !1230

; <label>:70                                      ; preds = %66
  %71 = icmp sgt i64 %64, %60, !dbg !1231
  %72 = sub nsw i64 %64, %60, !dbg !1234
  tail call void @llvm.dbg.value(metadata !{i64 %72}, i64 0, metadata !195), !dbg !1234
  br i1 %71, label %select.unfold, label %.thread

select.unfold:                                    ; preds = %70, %58
  %actual_count.0 = phi i64 [ %count, %58 ], [ %72, %70 ]
  %73 = icmp eq i64 %actual_count.0, 0, !dbg !1235
  br i1 %73, label %.thread, label %74, !dbg !1235

; <label>:74                                      ; preds = %select.unfold
  %75 = getelementptr inbounds %struct.exe_disk_file_t* %25, i64 0, i32 1, !dbg !1237
  %76 = load i8** %75, align 8, !dbg !1237, !tbaa !1170
  %77 = getelementptr inbounds i8* %76, i64 %60, !dbg !1237
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %77, i8* %buf, i64 %actual_count.0, i32 1, i1 false), !dbg !1237
  br label %.thread, !dbg !1237

.thread:                                          ; preds = %70, %select.unfold, %74
  %actual_count.04 = phi i64 [ 0, %select.unfold ], [ %actual_count.0, %74 ], [ 0, %70 ]
  %78 = icmp eq i64 %actual_count.04, %count, !dbg !1238
  br i1 %78, label %80, label %79, !dbg !1238

; <label>:79                                      ; preds = %.thread
  tail call void @klee_warning(i8* getelementptr inbounds ([24 x i8]* @.str7, i64 0, i64 0)) #5, !dbg !1240
  br label %80, !dbg !1240

; <label>:80                                      ; preds = %.thread, %79
  %81 = load %struct.exe_disk_file_t** %24, align 8, !dbg !1241, !tbaa !788
  %82 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 2), align 8, !dbg !1241, !tbaa !1243
  %83 = icmp eq %struct.exe_disk_file_t* %81, %82, !dbg !1241
  br i1 %83, label %84, label %89, !dbg !1241

; <label>:84                                      ; preds = %80
  %85 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 3), align 8, !dbg !1244, !tbaa !1245
  %86 = zext i32 %85 to i64, !dbg !1244
  %87 = add i64 %86, %actual_count.04, !dbg !1244
  %88 = trunc i64 %87 to i32, !dbg !1244
  store i32 %88, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 3), align 8, !dbg !1244, !tbaa !1245
  br label %89, !dbg !1244

; <label>:89                                      ; preds = %84, %80
  %90 = load i64* %59, align 8, !dbg !1246, !tbaa !1150
  %91 = add i64 %90, %count, !dbg !1246
  store i64 %91, i64* %59, align 8, !dbg !1246, !tbaa !1150
  br label %._crit_edge, !dbg !1247

._crit_edge:                                      ; preds = %52, %54, %89, %46, %20, %__get_file.exit.thread
  %.0 = phi i64 [ -1, %20 ], [ %count, %89 ], [ -1, %46 ], [ -1, %__get_file.exit.thread ], [ %.pre, %54 ], [ %.pre, %52 ]
  ret i64 %.0, !dbg !1248
}

; Function Attrs: nounwind ssp uwtable
define i64 @__fd_lseek(i32 %fd, i64 %offset, i32 %whence) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !201), !dbg !1249
  tail call void @llvm.dbg.value(metadata !{i64 %offset}, i64 0, metadata !202), !dbg !1249
  tail call void @llvm.dbg.value(metadata !{i32 %whence}, i64 0, metadata !203), !dbg !1249
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1250), !dbg !1252
  %1 = icmp ult i32 %fd, 32, !dbg !1253
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1253

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1254
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1255
  %5 = load i32* %4, align 4, !dbg !1255, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1255
  %7 = icmp eq i32 %6, 0, !dbg !1255
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1255

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1254
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !205), !dbg !1251
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1256
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1256

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !1258
  store i32 9, i32* %10, align 4, !dbg !1258, !tbaa !752
  br label %57, !dbg !1260

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1261
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !1261, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !1261
  br i1 %14, label %15, label %39, !dbg !1261

; <label>:15                                      ; preds = %11
  %16 = icmp eq i32 %whence, 0, !dbg !1263
  %17 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !1266
  %18 = load i32* %17, align 8, !dbg !1266, !tbaa !855
  br i1 %16, label %19, label %21, !dbg !1263

; <label>:19                                      ; preds = %15
  %20 = tail call i64 (i64, ...)* @syscall(i64 8, i32 %18, i64 %offset, i32 0) #5, !dbg !1266
  tail call void @llvm.dbg.value(metadata !{i64 %20}, i64 0, metadata !204), !dbg !1266
  br label %33, !dbg !1268

; <label>:21                                      ; preds = %15
  %22 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1269
  %23 = load i64* %22, align 8, !dbg !1269, !tbaa !1150
  %24 = tail call i64 (i64, ...)* @syscall(i64 8, i32 %18, i64 %23, i32 0) #5, !dbg !1269
  tail call void @llvm.dbg.value(metadata !{i64 %24}, i64 0, metadata !204), !dbg !1269
  %25 = icmp eq i64 %24, -1, !dbg !1271
  br i1 %25, label %.thread, label %26, !dbg !1271

; <label>:26                                      ; preds = %21
  %27 = load i64* %22, align 8, !dbg !1273, !tbaa !1150
  %28 = icmp eq i64 %24, %27, !dbg !1273
  br i1 %28, label %30, label %29, !dbg !1273

; <label>:29                                      ; preds = %26
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8]* @.str8, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i32 499, i8* getelementptr inbounds ([38 x i8]* @__PRETTY_FUNCTION__.__fd_lseek, i64 0, i64 0)) #9, !dbg !1273
  unreachable, !dbg !1273

; <label>:30                                      ; preds = %26
  %31 = load i32* %17, align 8, !dbg !1275, !tbaa !855
  %32 = tail call i64 (i64, ...)* @syscall(i64 8, i32 %31, i64 %offset, i32 %whence) #5, !dbg !1275
  tail call void @llvm.dbg.value(metadata !{i64 %32}, i64 0, metadata !204), !dbg !1275
  br label %33, !dbg !1276

; <label>:33                                      ; preds = %30, %19
  %new_off.0 = phi i64 [ %20, %19 ], [ %32, %30 ]
  %34 = icmp eq i64 %new_off.0, -1, !dbg !1277
  br i1 %34, label %.thread, label %37, !dbg !1277

.thread:                                          ; preds = %21, %33
  %35 = tail call i32 @klee_get_errno() #5, !dbg !1279
  %36 = tail call i32* @__errno_location() #1, !dbg !1279
  store i32 %35, i32* %36, align 4, !dbg !1279, !tbaa !752
  br label %57, !dbg !1281

; <label>:37                                      ; preds = %33
  %38 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1282
  store i64 %new_off.0, i64* %38, align 8, !dbg !1282, !tbaa !1150
  br label %57, !dbg !1283

; <label>:39                                      ; preds = %11
  switch i32 %whence, label %49 [
    i32 0, label %51
    i32 1, label %40
    i32 2, label %44
  ], !dbg !1284

; <label>:40                                      ; preds = %39
  %41 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1285
  %42 = load i64* %41, align 8, !dbg !1285, !tbaa !1150
  %43 = add nsw i64 %42, %offset, !dbg !1285
  tail call void @llvm.dbg.value(metadata !{i64 %43}, i64 0, metadata !204), !dbg !1285
  br label %51, !dbg !1285

; <label>:44                                      ; preds = %39
  %45 = getelementptr inbounds %struct.exe_disk_file_t* %13, i64 0, i32 0, !dbg !1287
  %46 = load i32* %45, align 4, !dbg !1287, !tbaa !1164
  %47 = zext i32 %46 to i64, !dbg !1287
  %48 = add nsw i64 %47, %offset, !dbg !1287
  tail call void @llvm.dbg.value(metadata !{i64 %48}, i64 0, metadata !204), !dbg !1287
  br label %51, !dbg !1287

; <label>:49                                      ; preds = %39
  %50 = tail call i32* @__errno_location() #1, !dbg !1288
  store i32 22, i32* %50, align 4, !dbg !1288, !tbaa !752
  br label %57, !dbg !1290

; <label>:51                                      ; preds = %39, %44, %40
  %new_off.1 = phi i64 [ %48, %44 ], [ %43, %40 ], [ %offset, %39 ]
  %52 = icmp slt i64 %new_off.1, 0, !dbg !1291
  br i1 %52, label %53, label %55, !dbg !1291

; <label>:53                                      ; preds = %51
  %54 = tail call i32* @__errno_location() #1, !dbg !1293
  store i32 22, i32* %54, align 4, !dbg !1293, !tbaa !752
  br label %57, !dbg !1295

; <label>:55                                      ; preds = %51
  %56 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1296
  store i64 %new_off.1, i64* %56, align 8, !dbg !1296, !tbaa !1150
  br label %57, !dbg !1297

; <label>:57                                      ; preds = %55, %53, %49, %37, %.thread, %__get_file.exit.thread
  %.0 = phi i64 [ -1, %49 ], [ -1, %53 ], [ %new_off.1, %55 ], [ -1, %.thread ], [ %new_off.0, %37 ], [ -1, %__get_file.exit.thread ]
  ret i64 %.0, !dbg !1298
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_stat(i8* %path, %struct.stat64* %buf) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !210), !dbg !1299
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %buf}, i64 0, metadata !211), !dbg !1299
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1300), !dbg !1302
  %1 = load i8* %path, align 1, !dbg !1303, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1304), !dbg !1303
  %2 = sext i8 %1 to i32, !dbg !1305
  %3 = icmp eq i8 %1, 0, !dbg !1305
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !1305

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1305
  %6 = load i8* %5, align 1, !dbg !1305, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1305
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1305

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1306, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1306
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1306

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1306
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1306

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1307
  %12 = ashr exact i32 %sext.i, 24, !dbg !1307
  %13 = add nsw i32 %12, 65, !dbg !1307
  %14 = icmp eq i32 %2, %13, !dbg !1307
  %15 = add i32 %i.02.i, 1, !dbg !1306
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1308), !dbg !1306
  br i1 %14, label %16, label %10, !dbg !1307

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1309
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1309, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1310
  %20 = load %struct.stat64** %19, align 8, !dbg !1310, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1310
  %22 = load i64* %21, align 8, !dbg !1310, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1310
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1309
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !1311
  %or.cond = or i1 %23, %25, !dbg !1310
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !1310

; <label>:26                                      ; preds = %16
  %27 = bitcast %struct.stat64* %buf to i8*, !dbg !1313
  %28 = bitcast %struct.stat64* %20 to i8*, !dbg !1313
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 144, i32 8, i1 false), !dbg !1313
  br label %59, !dbg !1315

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1316) #5, !dbg !1318
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1319) #5, !dbg !1321
  %29 = ptrtoint i8* %path to i64, !dbg !1322
  %30 = tail call i64 @klee_get_valuel(i64 %29) #5, !dbg !1322
  %31 = inttoptr i64 %30 to i8*, !dbg !1322
  tail call void @llvm.dbg.value(metadata !{i8* %31}, i64 0, metadata !1323) #5, !dbg !1322
  %32 = icmp eq i8* %31, %path, !dbg !1324
  %33 = zext i1 %32 to i64, !dbg !1324
  tail call void @klee_assume(i64 %33) #5, !dbg !1324
  tail call void @llvm.dbg.value(metadata !{i8* %31}, i64 0, metadata !1325) #5, !dbg !1320
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1326) #5, !dbg !1327
  br label %34, !dbg !1327

; <label>:34                                      ; preds = %51, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %52, %51 ]
  %sc.0.i = phi i8* [ %31, %__get_sym_file.exit.thread ], [ %sc.1.i, %51 ]
  %35 = load i8* %sc.0.i, align 1, !dbg !1328, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %35}, i64 0, metadata !1329) #5, !dbg !1328
  %36 = add i32 %i.0.i, -1, !dbg !1330
  %37 = and i32 %36, %i.0.i, !dbg !1330
  %38 = icmp eq i32 %37, 0, !dbg !1330
  br i1 %38, label %39, label %43, !dbg !1330

; <label>:39                                      ; preds = %34
  switch i8 %35, label %51 [
    i8 0, label %40
    i8 47, label %41
  ], !dbg !1331

; <label>:40                                      ; preds = %39
  store i8 0, i8* %sc.0.i, align 1, !dbg !1332, !tbaa !694
  br label %__concretize_string.exit, !dbg !1333

; <label>:41                                      ; preds = %39
  %42 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1334
  tail call void @llvm.dbg.value(metadata !{i8* %42}, i64 0, metadata !1325) #5, !dbg !1334
  store i8 47, i8* %sc.0.i, align 1, !dbg !1334, !tbaa !694
  br label %51, !dbg !1335

; <label>:43                                      ; preds = %34
  %44 = sext i8 %35 to i64, !dbg !1336
  %45 = tail call i64 @klee_get_valuel(i64 %44) #5, !dbg !1336
  %46 = trunc i64 %45 to i8, !dbg !1336
  tail call void @llvm.dbg.value(metadata !{i8 %46}, i64 0, metadata !1337) #5, !dbg !1336
  %47 = icmp eq i8 %46, %35, !dbg !1338
  %48 = zext i1 %47 to i64, !dbg !1338
  tail call void @klee_assume(i64 %48) #5, !dbg !1338
  %49 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1339
  tail call void @llvm.dbg.value(metadata !{i8* %49}, i64 0, metadata !1325) #5, !dbg !1339
  store i8 %46, i8* %sc.0.i, align 1, !dbg !1339, !tbaa !694
  %50 = icmp eq i8 %46, 0, !dbg !1340
  br i1 %50, label %__concretize_string.exit, label %51, !dbg !1340

; <label>:51                                      ; preds = %43, %41, %39
  %sc.1.i = phi i8* [ %49, %43 ], [ %42, %41 ], [ %sc.0.i, %39 ]
  %52 = add i32 %i.0.i, 1, !dbg !1327
  tail call void @llvm.dbg.value(metadata !{i32 %52}, i64 0, metadata !1326) #5, !dbg !1327
  br label %34, !dbg !1327

__concretize_string.exit:                         ; preds = %43, %40
  %53 = tail call i64 (i64, ...)* @syscall(i64 4, i8* %path, %struct.stat64* %buf) #5, !dbg !1317
  %54 = trunc i64 %53 to i32, !dbg !1317
  tail call void @llvm.dbg.value(metadata !{i32 %54}, i64 0, metadata !213), !dbg !1317
  %55 = icmp eq i32 %54, -1, !dbg !1341
  br i1 %55, label %56, label %59, !dbg !1341

; <label>:56                                      ; preds = %__concretize_string.exit
  %57 = tail call i32 @klee_get_errno() #5, !dbg !1343
  %58 = tail call i32* @__errno_location() #1, !dbg !1343
  store i32 %57, i32* %58, align 4, !dbg !1343, !tbaa !752
  br label %59, !dbg !1343

; <label>:59                                      ; preds = %__concretize_string.exit, %56, %26
  %.0 = phi i32 [ 0, %26 ], [ -1, %56 ], [ %54, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1344
}

; Function Attrs: inlinehint nounwind ssp uwtable
define i32 @fstatat(i32 %fd, i8* %path, %struct.stat* %buf, i32 %flags) #8 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !239), !dbg !1345
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !240), !dbg !1345
  tail call void @llvm.dbg.value(metadata !{%struct.stat* %buf}, i64 0, metadata !241), !dbg !1345
  tail call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !242), !dbg !1345
  %1 = icmp eq i32 %fd, -100, !dbg !1346
  br i1 %1, label %22, label %2, !dbg !1346

; <label>:2                                       ; preds = %0
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1347), !dbg !1349
  %3 = icmp ult i32 %fd, 32, !dbg !1350
  br i1 %3, label %4, label %__get_file.exit.thread, !dbg !1350

; <label>:4                                       ; preds = %2
  %5 = sext i32 %fd to i64, !dbg !1351
  %6 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 1, !dbg !1352
  %7 = load i32* %6, align 4, !dbg !1352, !tbaa !765
  %8 = and i32 %7, 1, !dbg !1352
  %9 = icmp eq i32 %8, 0, !dbg !1352
  br i1 %9, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1352

__get_file.exit:                                  ; preds = %4
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, !dbg !1351
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !243), !dbg !1348
  %11 = icmp eq %struct.exe_file_t* %10, null, !dbg !1353
  br i1 %11, label %__get_file.exit.thread, label %13, !dbg !1353

__get_file.exit.thread:                           ; preds = %2, %4, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !1355
  store i32 9, i32* %12, align 4, !dbg !1355, !tbaa !752
  br label %85, !dbg !1357

; <label>:13                                      ; preds = %__get_file.exit
  %14 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %5, i32 3, !dbg !1358
  %15 = load %struct.exe_disk_file_t** %14, align 8, !dbg !1358, !tbaa !788
  %16 = icmp eq %struct.exe_disk_file_t* %15, null, !dbg !1358
  br i1 %16, label %19, label %17, !dbg !1358

; <label>:17                                      ; preds = %13
  tail call void @klee_warning(i8* getelementptr inbounds ([44 x i8]* @.str2, i64 0, i64 0)) #5, !dbg !1360
  %18 = tail call i32* @__errno_location() #1, !dbg !1362
  store i32 2, i32* %18, align 4, !dbg !1362, !tbaa !752
  br label %85, !dbg !1363

; <label>:19                                      ; preds = %13
  %20 = getelementptr inbounds %struct.exe_file_t* %10, i64 0, i32 0, !dbg !1364
  %21 = load i32* %20, align 8, !dbg !1364, !tbaa !855
  tail call void @llvm.dbg.value(metadata !{i32 %21}, i64 0, metadata !239), !dbg !1364
  %phitmp = sext i32 %21 to i64, !dbg !1365
  br label %22, !dbg !1365

; <label>:22                                      ; preds = %0, %19
  %.01 = phi i64 [ %phitmp, %19 ], [ -100, %0 ]
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1366), !dbg !1368
  %23 = load i8* %path, align 1, !dbg !1369, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %23}, i64 0, metadata !1370), !dbg !1369
  %24 = sext i8 %23 to i32, !dbg !1371
  %25 = icmp eq i8 %23, 0, !dbg !1371
  br i1 %25, label %__get_sym_file.exit.thread, label %26, !dbg !1371

; <label>:26                                      ; preds = %22
  %27 = getelementptr inbounds i8* %path, i64 1, !dbg !1371
  %28 = load i8* %27, align 1, !dbg !1371, !tbaa !694
  %29 = icmp eq i8 %28, 0, !dbg !1371
  br i1 %29, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1371

.preheader.i:                                     ; preds = %26
  %30 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1372, !tbaa !701
  %31 = icmp eq i32 %30, 0, !dbg !1372
  br i1 %31, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1372

; <label>:32                                      ; preds = %.lr.ph.i
  %33 = icmp ult i32 %37, %30, !dbg !1372
  br i1 %33, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1372

.lr.ph.i:                                         ; preds = %.preheader.i, %32
  %i.02.i = phi i32 [ %37, %32 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1373
  %34 = ashr exact i32 %sext.i, 24, !dbg !1373
  %35 = add nsw i32 %34, 65, !dbg !1373
  %36 = icmp eq i32 %24, %35, !dbg !1373
  %37 = add i32 %i.02.i, 1, !dbg !1372
  tail call void @llvm.dbg.value(metadata !{i32 %37}, i64 0, metadata !1374), !dbg !1372
  br i1 %36, label %38, label %32, !dbg !1373

; <label>:38                                      ; preds = %.lr.ph.i
  %39 = zext i32 %i.02.i to i64, !dbg !1375
  %40 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1375, !tbaa !708
  %41 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, i32 2, !dbg !1376
  %42 = load %struct.stat64** %41, align 8, !dbg !1376, !tbaa !711
  %43 = getelementptr inbounds %struct.stat64* %42, i64 0, i32 1, !dbg !1376
  %44 = load i64* %43, align 8, !dbg !1376, !tbaa !713
  %45 = icmp eq i64 %44, 0, !dbg !1376
  %46 = getelementptr inbounds %struct.exe_disk_file_t* %40, i64 %39, !dbg !1375
  %47 = icmp eq %struct.exe_disk_file_t* %46, null, !dbg !1377
  %or.cond = or i1 %45, %47, !dbg !1376
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %48, !dbg !1376

; <label>:48                                      ; preds = %38
  %49 = bitcast %struct.stat* %buf to i8*, !dbg !1379
  %50 = bitcast %struct.stat64* %42 to i8*, !dbg !1379
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %49, i8* %50, i64 144, i32 8, i1 false), !dbg !1379
  br label %85, !dbg !1381

__get_sym_file.exit.thread:                       ; preds = %32, %.preheader.i, %38, %22, %26
  %51 = icmp eq i8* %path, null, !dbg !1382
  br i1 %51, label %__concretize_string.exit, label %52, !dbg !1382

; <label>:52                                      ; preds = %__get_sym_file.exit.thread
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1383) #5, !dbg !1385
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1386) #5, !dbg !1388
  %53 = ptrtoint i8* %path to i64, !dbg !1389
  %54 = tail call i64 @klee_get_valuel(i64 %53) #5, !dbg !1389
  %55 = inttoptr i64 %54 to i8*, !dbg !1389
  tail call void @llvm.dbg.value(metadata !{i8* %55}, i64 0, metadata !1390) #5, !dbg !1389
  %56 = icmp eq i8* %55, %path, !dbg !1391
  %57 = zext i1 %56 to i64, !dbg !1391
  tail call void @klee_assume(i64 %57) #5, !dbg !1391
  tail call void @llvm.dbg.value(metadata !{i8* %55}, i64 0, metadata !1392) #5, !dbg !1387
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1393) #5, !dbg !1394
  br label %58, !dbg !1394

; <label>:58                                      ; preds = %75, %52
  %i.0.i = phi i32 [ 0, %52 ], [ %76, %75 ]
  %sc.0.i = phi i8* [ %55, %52 ], [ %sc.1.i, %75 ]
  %59 = load i8* %sc.0.i, align 1, !dbg !1395, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %59}, i64 0, metadata !1396) #5, !dbg !1395
  %60 = add i32 %i.0.i, -1, !dbg !1397
  %61 = and i32 %60, %i.0.i, !dbg !1397
  %62 = icmp eq i32 %61, 0, !dbg !1397
  br i1 %62, label %63, label %67, !dbg !1397

; <label>:63                                      ; preds = %58
  switch i8 %59, label %75 [
    i8 0, label %64
    i8 47, label %65
  ], !dbg !1398

; <label>:64                                      ; preds = %63
  store i8 0, i8* %sc.0.i, align 1, !dbg !1399, !tbaa !694
  br label %__concretize_string.exit, !dbg !1400

; <label>:65                                      ; preds = %63
  %66 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1401
  tail call void @llvm.dbg.value(metadata !{i8* %66}, i64 0, metadata !1392) #5, !dbg !1401
  store i8 47, i8* %sc.0.i, align 1, !dbg !1401, !tbaa !694
  br label %75, !dbg !1402

; <label>:67                                      ; preds = %58
  %68 = sext i8 %59 to i64, !dbg !1403
  %69 = tail call i64 @klee_get_valuel(i64 %68) #5, !dbg !1403
  %70 = trunc i64 %69 to i8, !dbg !1403
  tail call void @llvm.dbg.value(metadata !{i8 %70}, i64 0, metadata !1404) #5, !dbg !1403
  %71 = icmp eq i8 %70, %59, !dbg !1405
  %72 = zext i1 %71 to i64, !dbg !1405
  tail call void @klee_assume(i64 %72) #5, !dbg !1405
  %73 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1406
  tail call void @llvm.dbg.value(metadata !{i8* %73}, i64 0, metadata !1392) #5, !dbg !1406
  store i8 %70, i8* %sc.0.i, align 1, !dbg !1406, !tbaa !694
  %74 = icmp eq i8 %70, 0, !dbg !1407
  br i1 %74, label %__concretize_string.exit, label %75, !dbg !1407

; <label>:75                                      ; preds = %67, %65, %63
  %sc.1.i = phi i8* [ %73, %67 ], [ %66, %65 ], [ %sc.0.i, %63 ]
  %76 = add i32 %i.0.i, 1, !dbg !1394
  tail call void @llvm.dbg.value(metadata !{i32 %76}, i64 0, metadata !1393) #5, !dbg !1394
  br label %58, !dbg !1394

__concretize_string.exit:                         ; preds = %67, %64, %__get_sym_file.exit.thread
  %77 = phi i8* [ null, %__get_sym_file.exit.thread ], [ %path, %64 ], [ %path, %67 ], !dbg !1384
  %78 = sext i32 %flags to i64, !dbg !1382
  %79 = tail call i64 (i64, ...)* @syscall(i64 262, i64 %.01, i8* %77, %struct.stat* %buf, i64 %78) #5, !dbg !1382
  %80 = trunc i64 %79 to i32, !dbg !1382
  tail call void @llvm.dbg.value(metadata !{i32 %80}, i64 0, metadata !247), !dbg !1382
  %81 = icmp eq i32 %80, -1, !dbg !1408
  br i1 %81, label %82, label %85, !dbg !1408

; <label>:82                                      ; preds = %__concretize_string.exit
  %83 = tail call i32 @klee_get_errno() #5, !dbg !1410
  %84 = tail call i32* @__errno_location() #1, !dbg !1410
  store i32 %83, i32* %84, align 4, !dbg !1410, !tbaa !752
  br label %85, !dbg !1410

; <label>:85                                      ; preds = %__concretize_string.exit, %82, %48, %17, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %17 ], [ 0, %48 ], [ -1, %__get_file.exit.thread ], [ -1, %82 ], [ %80, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1411
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_lstat(i8* %path, %struct.stat64* %buf) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !250), !dbg !1412
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %buf}, i64 0, metadata !251), !dbg !1412
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1413), !dbg !1415
  %1 = load i8* %path, align 1, !dbg !1416, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1417), !dbg !1416
  %2 = sext i8 %1 to i32, !dbg !1418
  %3 = icmp eq i8 %1, 0, !dbg !1418
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !1418

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1418
  %6 = load i8* %5, align 1, !dbg !1418, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1418
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1418

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1419, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1419
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1419

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1419
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1419

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1420
  %12 = ashr exact i32 %sext.i, 24, !dbg !1420
  %13 = add nsw i32 %12, 65, !dbg !1420
  %14 = icmp eq i32 %2, %13, !dbg !1420
  %15 = add i32 %i.02.i, 1, !dbg !1419
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1421), !dbg !1419
  br i1 %14, label %16, label %10, !dbg !1420

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1422
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1422, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1423
  %20 = load %struct.stat64** %19, align 8, !dbg !1423, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1423
  %22 = load i64* %21, align 8, !dbg !1423, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1423
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1422
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !1424
  %or.cond = or i1 %23, %25, !dbg !1423
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !1423

; <label>:26                                      ; preds = %16
  %27 = bitcast %struct.stat64* %buf to i8*, !dbg !1426
  %28 = bitcast %struct.stat64* %20 to i8*, !dbg !1426
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %27, i8* %28, i64 144, i32 8, i1 false), !dbg !1426
  br label %59, !dbg !1428

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1429) #5, !dbg !1431
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1432) #5, !dbg !1434
  %29 = ptrtoint i8* %path to i64, !dbg !1435
  %30 = tail call i64 @klee_get_valuel(i64 %29) #5, !dbg !1435
  %31 = inttoptr i64 %30 to i8*, !dbg !1435
  tail call void @llvm.dbg.value(metadata !{i8* %31}, i64 0, metadata !1436) #5, !dbg !1435
  %32 = icmp eq i8* %31, %path, !dbg !1437
  %33 = zext i1 %32 to i64, !dbg !1437
  tail call void @klee_assume(i64 %33) #5, !dbg !1437
  tail call void @llvm.dbg.value(metadata !{i8* %31}, i64 0, metadata !1438) #5, !dbg !1433
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1439) #5, !dbg !1440
  br label %34, !dbg !1440

; <label>:34                                      ; preds = %51, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %52, %51 ]
  %sc.0.i = phi i8* [ %31, %__get_sym_file.exit.thread ], [ %sc.1.i, %51 ]
  %35 = load i8* %sc.0.i, align 1, !dbg !1441, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %35}, i64 0, metadata !1442) #5, !dbg !1441
  %36 = add i32 %i.0.i, -1, !dbg !1443
  %37 = and i32 %36, %i.0.i, !dbg !1443
  %38 = icmp eq i32 %37, 0, !dbg !1443
  br i1 %38, label %39, label %43, !dbg !1443

; <label>:39                                      ; preds = %34
  switch i8 %35, label %51 [
    i8 0, label %40
    i8 47, label %41
  ], !dbg !1444

; <label>:40                                      ; preds = %39
  store i8 0, i8* %sc.0.i, align 1, !dbg !1445, !tbaa !694
  br label %__concretize_string.exit, !dbg !1446

; <label>:41                                      ; preds = %39
  %42 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1447
  tail call void @llvm.dbg.value(metadata !{i8* %42}, i64 0, metadata !1438) #5, !dbg !1447
  store i8 47, i8* %sc.0.i, align 1, !dbg !1447, !tbaa !694
  br label %51, !dbg !1448

; <label>:43                                      ; preds = %34
  %44 = sext i8 %35 to i64, !dbg !1449
  %45 = tail call i64 @klee_get_valuel(i64 %44) #5, !dbg !1449
  %46 = trunc i64 %45 to i8, !dbg !1449
  tail call void @llvm.dbg.value(metadata !{i8 %46}, i64 0, metadata !1450) #5, !dbg !1449
  %47 = icmp eq i8 %46, %35, !dbg !1451
  %48 = zext i1 %47 to i64, !dbg !1451
  tail call void @klee_assume(i64 %48) #5, !dbg !1451
  %49 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1452
  tail call void @llvm.dbg.value(metadata !{i8* %49}, i64 0, metadata !1438) #5, !dbg !1452
  store i8 %46, i8* %sc.0.i, align 1, !dbg !1452, !tbaa !694
  %50 = icmp eq i8 %46, 0, !dbg !1453
  br i1 %50, label %__concretize_string.exit, label %51, !dbg !1453

; <label>:51                                      ; preds = %43, %41, %39
  %sc.1.i = phi i8* [ %49, %43 ], [ %42, %41 ], [ %sc.0.i, %39 ]
  %52 = add i32 %i.0.i, 1, !dbg !1440
  tail call void @llvm.dbg.value(metadata !{i32 %52}, i64 0, metadata !1439) #5, !dbg !1440
  br label %34, !dbg !1440

__concretize_string.exit:                         ; preds = %43, %40
  %53 = tail call i64 (i64, ...)* @syscall(i64 6, i8* %path, %struct.stat64* %buf) #5, !dbg !1430
  %54 = trunc i64 %53 to i32, !dbg !1430
  tail call void @llvm.dbg.value(metadata !{i32 %54}, i64 0, metadata !253), !dbg !1430
  %55 = icmp eq i32 %54, -1, !dbg !1454
  br i1 %55, label %56, label %59, !dbg !1454

; <label>:56                                      ; preds = %__concretize_string.exit
  %57 = tail call i32 @klee_get_errno() #5, !dbg !1456
  %58 = tail call i32* @__errno_location() #1, !dbg !1456
  store i32 %57, i32* %58, align 4, !dbg !1456, !tbaa !752
  br label %59, !dbg !1456

; <label>:59                                      ; preds = %__concretize_string.exit, %56, %26
  %.0 = phi i32 [ 0, %26 ], [ -1, %56 ], [ %54, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1457
}

; Function Attrs: nounwind ssp uwtable
define i32 @chdir(i8* %path) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !259), !dbg !1458
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1459), !dbg !1461
  %1 = load i8* %path, align 1, !dbg !1462, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1463), !dbg !1462
  %2 = sext i8 %1 to i32, !dbg !1464
  %3 = icmp eq i8 %1, 0, !dbg !1464
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !1464

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1464
  %6 = load i8* %5, align 1, !dbg !1464, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1464
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1464

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1465, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1465
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1465

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1465
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1465

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1466
  %12 = ashr exact i32 %sext.i, 24, !dbg !1466
  %13 = add nsw i32 %12, 65, !dbg !1466
  %14 = icmp eq i32 %2, %13, !dbg !1466
  %15 = add i32 %i.02.i, 1, !dbg !1465
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1467), !dbg !1465
  br i1 %14, label %16, label %10, !dbg !1466

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1468
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1468, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1469
  %20 = load %struct.stat64** %19, align 8, !dbg !1469, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1469
  %22 = load i64* %21, align 8, !dbg !1469, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1469
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1468
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !1470
  %or.cond = or i1 %23, %25, !dbg !1469
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !1469

; <label>:26                                      ; preds = %16
  tail call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str9, i64 0, i64 0)) #5, !dbg !1472
  %27 = tail call i32* @__errno_location() #1, !dbg !1474
  store i32 2, i32* %27, align 4, !dbg !1474, !tbaa !752
  br label %58, !dbg !1475

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1476) #5, !dbg !1478
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1479) #5, !dbg !1481
  %28 = ptrtoint i8* %path to i64, !dbg !1482
  %29 = tail call i64 @klee_get_valuel(i64 %28) #5, !dbg !1482
  %30 = inttoptr i64 %29 to i8*, !dbg !1482
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1483) #5, !dbg !1482
  %31 = icmp eq i8* %30, %path, !dbg !1484
  %32 = zext i1 %31 to i64, !dbg !1484
  tail call void @klee_assume(i64 %32) #5, !dbg !1484
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1485) #5, !dbg !1480
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1486) #5, !dbg !1487
  br label %33, !dbg !1487

; <label>:33                                      ; preds = %50, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %51, %50 ]
  %sc.0.i = phi i8* [ %30, %__get_sym_file.exit.thread ], [ %sc.1.i, %50 ]
  %34 = load i8* %sc.0.i, align 1, !dbg !1488, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %34}, i64 0, metadata !1489) #5, !dbg !1488
  %35 = add i32 %i.0.i, -1, !dbg !1490
  %36 = and i32 %35, %i.0.i, !dbg !1490
  %37 = icmp eq i32 %36, 0, !dbg !1490
  br i1 %37, label %38, label %42, !dbg !1490

; <label>:38                                      ; preds = %33
  switch i8 %34, label %50 [
    i8 0, label %39
    i8 47, label %40
  ], !dbg !1491

; <label>:39                                      ; preds = %38
  store i8 0, i8* %sc.0.i, align 1, !dbg !1492, !tbaa !694
  br label %__concretize_string.exit, !dbg !1493

; <label>:40                                      ; preds = %38
  %41 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1494
  tail call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !1485) #5, !dbg !1494
  store i8 47, i8* %sc.0.i, align 1, !dbg !1494, !tbaa !694
  br label %50, !dbg !1495

; <label>:42                                      ; preds = %33
  %43 = sext i8 %34 to i64, !dbg !1496
  %44 = tail call i64 @klee_get_valuel(i64 %43) #5, !dbg !1496
  %45 = trunc i64 %44 to i8, !dbg !1496
  tail call void @llvm.dbg.value(metadata !{i8 %45}, i64 0, metadata !1497) #5, !dbg !1496
  %46 = icmp eq i8 %45, %34, !dbg !1498
  %47 = zext i1 %46 to i64, !dbg !1498
  tail call void @klee_assume(i64 %47) #5, !dbg !1498
  %48 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1499
  tail call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !1485) #5, !dbg !1499
  store i8 %45, i8* %sc.0.i, align 1, !dbg !1499, !tbaa !694
  %49 = icmp eq i8 %45, 0, !dbg !1500
  br i1 %49, label %__concretize_string.exit, label %50, !dbg !1500

; <label>:50                                      ; preds = %42, %40, %38
  %sc.1.i = phi i8* [ %48, %42 ], [ %41, %40 ], [ %sc.0.i, %38 ]
  %51 = add i32 %i.0.i, 1, !dbg !1487
  tail call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !1486) #5, !dbg !1487
  br label %33, !dbg !1487

__concretize_string.exit:                         ; preds = %42, %39
  %52 = tail call i64 (i64, ...)* @syscall(i64 80, i8* %path) #5, !dbg !1477
  %53 = trunc i64 %52 to i32, !dbg !1477
  tail call void @llvm.dbg.value(metadata !{i32 %53}, i64 0, metadata !261), !dbg !1477
  %54 = icmp eq i32 %53, -1, !dbg !1501
  br i1 %54, label %55, label %58, !dbg !1501

; <label>:55                                      ; preds = %__concretize_string.exit
  %56 = tail call i32 @klee_get_errno() #5, !dbg !1503
  %57 = tail call i32* @__errno_location() #1, !dbg !1503
  store i32 %56, i32* %57, align 4, !dbg !1503, !tbaa !752
  br label %58, !dbg !1503

; <label>:58                                      ; preds = %__concretize_string.exit, %55, %26
  %.0 = phi i32 [ -1, %26 ], [ -1, %55 ], [ %53, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1504
}

; Function Attrs: nounwind ssp uwtable
define i32 @fchdir(i32 %fd) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !265), !dbg !1505
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1506), !dbg !1508
  %1 = icmp ult i32 %fd, 32, !dbg !1509
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1509

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1510
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1511
  %5 = load i32* %4, align 4, !dbg !1511, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1511
  %7 = icmp eq i32 %6, 0, !dbg !1511
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1511

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1510
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !266), !dbg !1507
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1512
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1512

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !1514
  store i32 9, i32* %10, align 4, !dbg !1514, !tbaa !752
  br label %26, !dbg !1516

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1517
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !1517, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !1517
  br i1 %14, label %17, label %15, !dbg !1517

; <label>:15                                      ; preds = %11
  tail call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str9, i64 0, i64 0)) #5, !dbg !1518
  %16 = tail call i32* @__errno_location() #1, !dbg !1520
  store i32 2, i32* %16, align 4, !dbg !1520, !tbaa !752
  br label %26, !dbg !1521

; <label>:17                                      ; preds = %11
  %18 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !1522
  %19 = load i32* %18, align 8, !dbg !1522, !tbaa !855
  %20 = tail call i64 (i64, ...)* @syscall(i64 81, i32 %19) #5, !dbg !1522
  %21 = trunc i64 %20 to i32, !dbg !1522
  tail call void @llvm.dbg.value(metadata !{i32 %21}, i64 0, metadata !267), !dbg !1522
  %22 = icmp eq i32 %21, -1, !dbg !1523
  br i1 %22, label %23, label %26, !dbg !1523

; <label>:23                                      ; preds = %17
  %24 = tail call i32 @klee_get_errno() #5, !dbg !1525
  %25 = tail call i32* @__errno_location() #1, !dbg !1525
  store i32 %24, i32* %25, align 4, !dbg !1525, !tbaa !752
  br label %26, !dbg !1525

; <label>:26                                      ; preds = %17, %23, %15, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %15 ], [ -1, %__get_file.exit.thread ], [ -1, %23 ], [ %21, %17 ]
  ret i32 %.0, !dbg !1526
}

; Function Attrs: nounwind ssp uwtable
define i32 @chmod(i8* %path, i32 %mode) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !274), !dbg !1527
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !275), !dbg !1527
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1528), !dbg !1530
  %1 = load i8* %path, align 1, !dbg !1531, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1532), !dbg !1531
  %2 = sext i8 %1 to i32, !dbg !1533
  %3 = icmp eq i8 %1, 0, !dbg !1533
  br i1 %3, label %__get_sym_file.exit, label %4, !dbg !1533

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1533
  %6 = load i8* %5, align 1, !dbg !1533, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1533
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit, !dbg !1533

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1534, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1534
  br i1 %9, label %__get_sym_file.exit, label %.lr.ph.i, !dbg !1534

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1534
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit, !dbg !1534

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1535
  %12 = ashr exact i32 %sext.i, 24, !dbg !1535
  %13 = add nsw i32 %12, 65, !dbg !1535
  %14 = icmp eq i32 %2, %13, !dbg !1535
  %15 = add i32 %i.02.i, 1, !dbg !1534
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1536), !dbg !1534
  br i1 %14, label %16, label %10, !dbg !1535

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1537
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1537, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1538
  %20 = load %struct.stat64** %19, align 8, !dbg !1538, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1538
  %22 = load i64* %21, align 8, !dbg !1538, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1538
  br i1 %23, label %__get_sym_file.exit, label %24, !dbg !1538

; <label>:24                                      ; preds = %16
  %25 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1537
  br label %__get_sym_file.exit, !dbg !1539

__get_sym_file.exit:                              ; preds = %10, %0, %4, %.preheader.i, %16, %24
  %.0.i = phi %struct.exe_disk_file_t* [ %25, %24 ], [ null, %4 ], [ null, %0 ], [ null, %16 ], [ null, %.preheader.i ], [ null, %10 ]
  tail call void @llvm.dbg.value(metadata !{%struct.exe_disk_file_t* %.0.i}, i64 0, metadata !276), !dbg !1529
  %26 = load i32* @chmod.n_calls, align 4, !dbg !1540, !tbaa !752
  %27 = add nsw i32 %26, 1, !dbg !1540
  store i32 %27, i32* @chmod.n_calls, align 4, !dbg !1540, !tbaa !752
  %28 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1541, !tbaa !1096
  %29 = icmp eq i32 %28, 0, !dbg !1541
  br i1 %29, label %37, label %30, !dbg !1541

; <label>:30                                      ; preds = %__get_sym_file.exit
  %31 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 11), align 8, !dbg !1541, !tbaa !1543
  %32 = load i32* %31, align 4, !dbg !1541, !tbaa !752
  %33 = icmp eq i32 %32, %27, !dbg !1541
  br i1 %33, label %34, label %37, !dbg !1541

; <label>:34                                      ; preds = %30
  %35 = add i32 %28, -1, !dbg !1544
  store i32 %35, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1544, !tbaa !1096
  %36 = tail call i32* @__errno_location() #1, !dbg !1546
  store i32 5, i32* %36, align 4, !dbg !1546, !tbaa !752
  br label %__df_chmod.exit, !dbg !1547

; <label>:37                                      ; preds = %__get_sym_file.exit, %30
  %38 = icmp eq %struct.exe_disk_file_t* %.0.i, null, !dbg !1548
  br i1 %38, label %60, label %39, !dbg !1548

; <label>:39                                      ; preds = %37
  tail call void @llvm.dbg.value(metadata !{%struct.exe_disk_file_t* %.0.i}, i64 0, metadata !1549) #5, !dbg !1552
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !1553) #5, !dbg !1552
  %40 = tail call i32 @geteuid() #5, !dbg !1554
  %41 = getelementptr inbounds %struct.exe_disk_file_t* %.0.i, i64 0, i32 2, !dbg !1554
  %42 = load %struct.stat64** %41, align 8, !dbg !1554, !tbaa !711
  %43 = getelementptr inbounds %struct.stat64* %42, i64 0, i32 4, !dbg !1554
  %44 = load i32* %43, align 4, !dbg !1554, !tbaa !1556
  %45 = icmp eq i32 %40, %44, !dbg !1554
  br i1 %45, label %46, label %58, !dbg !1554

; <label>:46                                      ; preds = %39
  %47 = tail call i32 @getgid() #5, !dbg !1557
  %48 = load %struct.stat64** %41, align 8, !dbg !1557, !tbaa !711
  %49 = getelementptr inbounds %struct.stat64* %48, i64 0, i32 5, !dbg !1557
  %50 = load i32* %49, align 4, !dbg !1557, !tbaa !1560
  %51 = icmp eq i32 %47, %50, !dbg !1557
  %52 = and i32 %mode, 3071, !dbg !1561
  tail call void @llvm.dbg.value(metadata !{i32 %52}, i64 0, metadata !1553) #5, !dbg !1561
  %mode..i = select i1 %51, i32 %mode, i32 %52, !dbg !1557
  %53 = getelementptr inbounds %struct.stat64* %48, i64 0, i32 3, !dbg !1562
  %54 = load i32* %53, align 4, !dbg !1562, !tbaa !805
  %55 = and i32 %54, -4096, !dbg !1562
  %56 = and i32 %mode..i, 4095, !dbg !1562
  %57 = or i32 %56, %55, !dbg !1562
  store i32 %57, i32* %53, align 4, !dbg !1562, !tbaa !805
  br label %__df_chmod.exit, !dbg !1563

; <label>:58                                      ; preds = %39
  %59 = tail call i32* @__errno_location() #1, !dbg !1564
  store i32 1, i32* %59, align 4, !dbg !1564, !tbaa !752
  br label %__df_chmod.exit, !dbg !1566

; <label>:60                                      ; preds = %37
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1567) #5, !dbg !1569
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1570) #5, !dbg !1572
  %61 = ptrtoint i8* %path to i64, !dbg !1573
  %62 = tail call i64 @klee_get_valuel(i64 %61) #5, !dbg !1573
  %63 = inttoptr i64 %62 to i8*, !dbg !1573
  tail call void @llvm.dbg.value(metadata !{i8* %63}, i64 0, metadata !1574) #5, !dbg !1573
  %64 = icmp eq i8* %63, %path, !dbg !1575
  %65 = zext i1 %64 to i64, !dbg !1575
  tail call void @klee_assume(i64 %65) #5, !dbg !1575
  tail call void @llvm.dbg.value(metadata !{i8* %63}, i64 0, metadata !1576) #5, !dbg !1571
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1577) #5, !dbg !1578
  br label %66, !dbg !1578

; <label>:66                                      ; preds = %83, %60
  %i.0.i = phi i32 [ 0, %60 ], [ %84, %83 ]
  %sc.0.i = phi i8* [ %63, %60 ], [ %sc.1.i, %83 ]
  %67 = load i8* %sc.0.i, align 1, !dbg !1579, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %67}, i64 0, metadata !1580) #5, !dbg !1579
  %68 = add i32 %i.0.i, -1, !dbg !1581
  %69 = and i32 %68, %i.0.i, !dbg !1581
  %70 = icmp eq i32 %69, 0, !dbg !1581
  br i1 %70, label %71, label %75, !dbg !1581

; <label>:71                                      ; preds = %66
  switch i8 %67, label %83 [
    i8 0, label %72
    i8 47, label %73
  ], !dbg !1582

; <label>:72                                      ; preds = %71
  store i8 0, i8* %sc.0.i, align 1, !dbg !1583, !tbaa !694
  br label %__concretize_string.exit, !dbg !1584

; <label>:73                                      ; preds = %71
  %74 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1585
  tail call void @llvm.dbg.value(metadata !{i8* %74}, i64 0, metadata !1576) #5, !dbg !1585
  store i8 47, i8* %sc.0.i, align 1, !dbg !1585, !tbaa !694
  br label %83, !dbg !1586

; <label>:75                                      ; preds = %66
  %76 = sext i8 %67 to i64, !dbg !1587
  %77 = tail call i64 @klee_get_valuel(i64 %76) #5, !dbg !1587
  %78 = trunc i64 %77 to i8, !dbg !1587
  tail call void @llvm.dbg.value(metadata !{i8 %78}, i64 0, metadata !1588) #5, !dbg !1587
  %79 = icmp eq i8 %78, %67, !dbg !1589
  %80 = zext i1 %79 to i64, !dbg !1589
  tail call void @klee_assume(i64 %80) #5, !dbg !1589
  %81 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1590
  tail call void @llvm.dbg.value(metadata !{i8* %81}, i64 0, metadata !1576) #5, !dbg !1590
  store i8 %78, i8* %sc.0.i, align 1, !dbg !1590, !tbaa !694
  %82 = icmp eq i8 %78, 0, !dbg !1591
  br i1 %82, label %__concretize_string.exit, label %83, !dbg !1591

; <label>:83                                      ; preds = %75, %73, %71
  %sc.1.i = phi i8* [ %81, %75 ], [ %74, %73 ], [ %sc.0.i, %71 ]
  %84 = add i32 %i.0.i, 1, !dbg !1578
  tail call void @llvm.dbg.value(metadata !{i32 %84}, i64 0, metadata !1577) #5, !dbg !1578
  br label %66, !dbg !1578

__concretize_string.exit:                         ; preds = %75, %72
  %85 = tail call i64 (i64, ...)* @syscall(i64 90, i8* %path, i32 %mode) #5, !dbg !1568
  %86 = trunc i64 %85 to i32, !dbg !1568
  tail call void @llvm.dbg.value(metadata !{i32 %86}, i64 0, metadata !277), !dbg !1568
  %87 = icmp eq i32 %86, -1, !dbg !1592
  br i1 %87, label %88, label %__df_chmod.exit, !dbg !1592

; <label>:88                                      ; preds = %__concretize_string.exit
  %89 = tail call i32 @klee_get_errno() #5, !dbg !1594
  %90 = tail call i32* @__errno_location() #1, !dbg !1594
  store i32 %89, i32* %90, align 4, !dbg !1594, !tbaa !752
  br label %__df_chmod.exit, !dbg !1594

__df_chmod.exit:                                  ; preds = %58, %46, %__concretize_string.exit, %88, %34
  %.0 = phi i32 [ -1, %34 ], [ -1, %88 ], [ %86, %__concretize_string.exit ], [ 0, %46 ], [ -1, %58 ]
  ret i32 %.0, !dbg !1595
}

; Function Attrs: nounwind ssp uwtable
define i32 @fchmod(i32 %fd, i32 %mode) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !284), !dbg !1596
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !285), !dbg !1596
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1597), !dbg !1599
  %1 = icmp ult i32 %fd, 32, !dbg !1600
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1600

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1601
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1602
  %5 = load i32* %4, align 4, !dbg !1602, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1602
  %7 = icmp eq i32 %6, 0, !dbg !1602
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1602

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1601
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !286), !dbg !1598
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1603
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1603

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !1605
  store i32 9, i32* %10, align 4, !dbg !1605, !tbaa !752
  br label %__df_chmod.exit, !dbg !1607

; <label>:11                                      ; preds = %__get_file.exit
  %12 = load i32* @fchmod.n_calls, align 4, !dbg !1608, !tbaa !752
  %13 = add nsw i32 %12, 1, !dbg !1608
  store i32 %13, i32* @fchmod.n_calls, align 4, !dbg !1608, !tbaa !752
  %14 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1609, !tbaa !1096
  %15 = icmp eq i32 %14, 0, !dbg !1609
  br i1 %15, label %23, label %16, !dbg !1609

; <label>:16                                      ; preds = %11
  %17 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 12), align 8, !dbg !1609, !tbaa !1611
  %18 = load i32* %17, align 4, !dbg !1609, !tbaa !752
  %19 = icmp eq i32 %18, %13, !dbg !1609
  br i1 %19, label %20, label %23, !dbg !1609

; <label>:20                                      ; preds = %16
  %21 = add i32 %14, -1, !dbg !1612
  store i32 %21, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1612, !tbaa !1096
  %22 = tail call i32* @__errno_location() #1, !dbg !1614
  store i32 5, i32* %22, align 4, !dbg !1614, !tbaa !752
  br label %__df_chmod.exit, !dbg !1615

; <label>:23                                      ; preds = %11, %16
  %24 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1616
  %25 = load %struct.exe_disk_file_t** %24, align 8, !dbg !1616, !tbaa !788
  %26 = icmp eq %struct.exe_disk_file_t* %25, null, !dbg !1616
  br i1 %26, label %48, label %27, !dbg !1616

; <label>:27                                      ; preds = %23
  tail call void @llvm.dbg.value(metadata !{%struct.exe_disk_file_t* %25}, i64 0, metadata !1617) #5, !dbg !1620
  tail call void @llvm.dbg.value(metadata !{i32 %mode}, i64 0, metadata !1621) #5, !dbg !1620
  %28 = tail call i32 @geteuid() #5, !dbg !1622
  %29 = getelementptr inbounds %struct.exe_disk_file_t* %25, i64 0, i32 2, !dbg !1622
  %30 = load %struct.stat64** %29, align 8, !dbg !1622, !tbaa !711
  %31 = getelementptr inbounds %struct.stat64* %30, i64 0, i32 4, !dbg !1622
  %32 = load i32* %31, align 4, !dbg !1622, !tbaa !1556
  %33 = icmp eq i32 %28, %32, !dbg !1622
  br i1 %33, label %34, label %46, !dbg !1622

; <label>:34                                      ; preds = %27
  %35 = tail call i32 @getgid() #5, !dbg !1623
  %36 = load %struct.stat64** %29, align 8, !dbg !1623, !tbaa !711
  %37 = getelementptr inbounds %struct.stat64* %36, i64 0, i32 5, !dbg !1623
  %38 = load i32* %37, align 4, !dbg !1623, !tbaa !1560
  %39 = icmp eq i32 %35, %38, !dbg !1623
  %40 = and i32 %mode, 3071, !dbg !1624
  tail call void @llvm.dbg.value(metadata !{i32 %40}, i64 0, metadata !1621) #5, !dbg !1624
  %mode..i = select i1 %39, i32 %mode, i32 %40, !dbg !1623
  %41 = getelementptr inbounds %struct.stat64* %36, i64 0, i32 3, !dbg !1625
  %42 = load i32* %41, align 4, !dbg !1625, !tbaa !805
  %43 = and i32 %42, -4096, !dbg !1625
  %44 = and i32 %mode..i, 4095, !dbg !1625
  %45 = or i32 %44, %43, !dbg !1625
  store i32 %45, i32* %41, align 4, !dbg !1625, !tbaa !805
  br label %__df_chmod.exit, !dbg !1626

; <label>:46                                      ; preds = %27
  %47 = tail call i32* @__errno_location() #1, !dbg !1627
  store i32 1, i32* %47, align 4, !dbg !1627, !tbaa !752
  br label %__df_chmod.exit, !dbg !1628

; <label>:48                                      ; preds = %23
  %49 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !1629
  %50 = load i32* %49, align 8, !dbg !1629, !tbaa !855
  %51 = tail call i64 (i64, ...)* @syscall(i64 91, i32 %50, i32 %mode) #5, !dbg !1629
  %52 = trunc i64 %51 to i32, !dbg !1629
  tail call void @llvm.dbg.value(metadata !{i32 %52}, i64 0, metadata !287), !dbg !1629
  %53 = icmp eq i32 %52, -1, !dbg !1630
  br i1 %53, label %54, label %__df_chmod.exit, !dbg !1630

; <label>:54                                      ; preds = %48
  %55 = tail call i32 @klee_get_errno() #5, !dbg !1632
  %56 = tail call i32* @__errno_location() #1, !dbg !1632
  store i32 %55, i32* %56, align 4, !dbg !1632, !tbaa !752
  br label %__df_chmod.exit, !dbg !1632

__df_chmod.exit:                                  ; preds = %46, %34, %48, %54, %20, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %20 ], [ -1, %__get_file.exit.thread ], [ -1, %54 ], [ %52, %48 ], [ 0, %34 ], [ -1, %46 ]
  ret i32 %.0, !dbg !1633
}

; Function Attrs: nounwind ssp uwtable
define i32 @chown(i8* %path, i32 %owner, i32 %group) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !296), !dbg !1634
  tail call void @llvm.dbg.value(metadata !{i32 %owner}, i64 0, metadata !297), !dbg !1634
  tail call void @llvm.dbg.value(metadata !{i32 %group}, i64 0, metadata !298), !dbg !1634
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1635), !dbg !1637
  %1 = load i8* %path, align 1, !dbg !1638, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1639), !dbg !1638
  %2 = sext i8 %1 to i32, !dbg !1640
  %3 = icmp eq i8 %1, 0, !dbg !1640
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !1640

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1640
  %6 = load i8* %5, align 1, !dbg !1640, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1640
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1640

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1641, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1641
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1641

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1641
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1641

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1642
  %12 = ashr exact i32 %sext.i, 24, !dbg !1642
  %13 = add nsw i32 %12, 65, !dbg !1642
  %14 = icmp eq i32 %2, %13, !dbg !1642
  %15 = add i32 %i.02.i, 1, !dbg !1641
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1643), !dbg !1641
  br i1 %14, label %16, label %10, !dbg !1642

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1644
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1644, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1645
  %20 = load %struct.stat64** %19, align 8, !dbg !1645, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1645
  %22 = load i64* %21, align 8, !dbg !1645, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1645
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1644
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !1646
  %or.cond = or i1 %23, %25, !dbg !1645
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !1645

; <label>:26                                      ; preds = %16
  tail call void @llvm.dbg.value(metadata !1647, i64 0, metadata !1648) #5, !dbg !1651
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1652) #5, !dbg !1651
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1653) #5, !dbg !1651
  tail call void @klee_warning(i8* getelementptr inbounds ([32 x i8]* @.str24, i64 0, i64 0)) #5, !dbg !1654
  %27 = tail call i32* @__errno_location() #1, !dbg !1655
  store i32 1, i32* %27, align 4, !dbg !1655, !tbaa !752
  br label %58, !dbg !1649

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1656) #5, !dbg !1658
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1659) #5, !dbg !1661
  %28 = ptrtoint i8* %path to i64, !dbg !1662
  %29 = tail call i64 @klee_get_valuel(i64 %28) #5, !dbg !1662
  %30 = inttoptr i64 %29 to i8*, !dbg !1662
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1663) #5, !dbg !1662
  %31 = icmp eq i8* %30, %path, !dbg !1664
  %32 = zext i1 %31 to i64, !dbg !1664
  tail call void @klee_assume(i64 %32) #5, !dbg !1664
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1665) #5, !dbg !1660
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1666) #5, !dbg !1667
  br label %33, !dbg !1667

; <label>:33                                      ; preds = %50, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %51, %50 ]
  %sc.0.i = phi i8* [ %30, %__get_sym_file.exit.thread ], [ %sc.1.i, %50 ]
  %34 = load i8* %sc.0.i, align 1, !dbg !1668, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %34}, i64 0, metadata !1669) #5, !dbg !1668
  %35 = add i32 %i.0.i, -1, !dbg !1670
  %36 = and i32 %35, %i.0.i, !dbg !1670
  %37 = icmp eq i32 %36, 0, !dbg !1670
  br i1 %37, label %38, label %42, !dbg !1670

; <label>:38                                      ; preds = %33
  switch i8 %34, label %50 [
    i8 0, label %39
    i8 47, label %40
  ], !dbg !1671

; <label>:39                                      ; preds = %38
  store i8 0, i8* %sc.0.i, align 1, !dbg !1672, !tbaa !694
  br label %__concretize_string.exit, !dbg !1673

; <label>:40                                      ; preds = %38
  %41 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1674
  tail call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !1665) #5, !dbg !1674
  store i8 47, i8* %sc.0.i, align 1, !dbg !1674, !tbaa !694
  br label %50, !dbg !1675

; <label>:42                                      ; preds = %33
  %43 = sext i8 %34 to i64, !dbg !1676
  %44 = tail call i64 @klee_get_valuel(i64 %43) #5, !dbg !1676
  %45 = trunc i64 %44 to i8, !dbg !1676
  tail call void @llvm.dbg.value(metadata !{i8 %45}, i64 0, metadata !1677) #5, !dbg !1676
  %46 = icmp eq i8 %45, %34, !dbg !1678
  %47 = zext i1 %46 to i64, !dbg !1678
  tail call void @klee_assume(i64 %47) #5, !dbg !1678
  %48 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1679
  tail call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !1665) #5, !dbg !1679
  store i8 %45, i8* %sc.0.i, align 1, !dbg !1679, !tbaa !694
  %49 = icmp eq i8 %45, 0, !dbg !1680
  br i1 %49, label %__concretize_string.exit, label %50, !dbg !1680

; <label>:50                                      ; preds = %42, %40, %38
  %sc.1.i = phi i8* [ %48, %42 ], [ %41, %40 ], [ %sc.0.i, %38 ]
  %51 = add i32 %i.0.i, 1, !dbg !1667
  tail call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !1666) #5, !dbg !1667
  br label %33, !dbg !1667

__concretize_string.exit:                         ; preds = %42, %39
  %52 = tail call i64 (i64, ...)* @syscall(i64 92, i8* %path, i32 %owner, i32 %group) #5, !dbg !1657
  %53 = trunc i64 %52 to i32, !dbg !1657
  tail call void @llvm.dbg.value(metadata !{i32 %53}, i64 0, metadata !300), !dbg !1657
  %54 = icmp eq i32 %53, -1, !dbg !1681
  br i1 %54, label %55, label %58, !dbg !1681

; <label>:55                                      ; preds = %__concretize_string.exit
  %56 = tail call i32 @klee_get_errno() #5, !dbg !1683
  %57 = tail call i32* @__errno_location() #1, !dbg !1683
  store i32 %56, i32* %57, align 4, !dbg !1683, !tbaa !752
  br label %58, !dbg !1683

; <label>:58                                      ; preds = %__concretize_string.exit, %55, %26
  %.0 = phi i32 [ -1, %26 ], [ -1, %55 ], [ %53, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1684
}

; Function Attrs: nounwind ssp uwtable
define i32 @fchown(i32 %fd, i32 %owner, i32 %group) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !307), !dbg !1685
  tail call void @llvm.dbg.value(metadata !{i32 %owner}, i64 0, metadata !308), !dbg !1685
  tail call void @llvm.dbg.value(metadata !{i32 %group}, i64 0, metadata !309), !dbg !1685
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1686), !dbg !1688
  %1 = icmp ult i32 %fd, 32, !dbg !1689
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1689

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1690
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1691
  %5 = load i32* %4, align 4, !dbg !1691, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1691
  %7 = icmp eq i32 %6, 0, !dbg !1691
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1690
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1692
  %or.cond = or i1 %7, %9, !dbg !1691
  br i1 %or.cond, label %__get_file.exit.thread, label %11, !dbg !1691

__get_file.exit.thread:                           ; preds = %0, %2
  %10 = tail call i32* @__errno_location() #1, !dbg !1694
  store i32 9, i32* %10, align 4, !dbg !1694, !tbaa !752
  br label %24, !dbg !1696

; <label>:11                                      ; preds = %2
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1697
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !1697, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !1697
  br i1 %14, label %17, label %15, !dbg !1697

; <label>:15                                      ; preds = %11
  tail call void @llvm.dbg.value(metadata !1647, i64 0, metadata !1698) #5, !dbg !1701
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1702) #5, !dbg !1701
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1703) #5, !dbg !1701
  tail call void @klee_warning(i8* getelementptr inbounds ([32 x i8]* @.str24, i64 0, i64 0)) #5, !dbg !1704
  %16 = tail call i32* @__errno_location() #1, !dbg !1705
  store i32 1, i32* %16, align 4, !dbg !1705, !tbaa !752
  br label %24, !dbg !1699

; <label>:17                                      ; preds = %11
  %18 = tail call i64 (i64, ...)* @syscall(i64 93, i32 %fd, i32 %owner, i32 %group) #5, !dbg !1706
  %19 = trunc i64 %18 to i32, !dbg !1706
  tail call void @llvm.dbg.value(metadata !{i32 %19}, i64 0, metadata !311), !dbg !1706
  %20 = icmp eq i32 %19, -1, !dbg !1707
  br i1 %20, label %21, label %24, !dbg !1707

; <label>:21                                      ; preds = %17
  %22 = tail call i32 @klee_get_errno() #5, !dbg !1709
  %23 = tail call i32* @__errno_location() #1, !dbg !1709
  store i32 %22, i32* %23, align 4, !dbg !1709, !tbaa !752
  br label %24, !dbg !1709

; <label>:24                                      ; preds = %17, %21, %15, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %15 ], [ -1, %__get_file.exit.thread ], [ -1, %21 ], [ %19, %17 ]
  ret i32 %.0, !dbg !1710
}

; Function Attrs: nounwind ssp uwtable
define i32 @lchown(i8* %path, i32 %owner, i32 %group) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !316), !dbg !1711
  tail call void @llvm.dbg.value(metadata !{i32 %owner}, i64 0, metadata !317), !dbg !1711
  tail call void @llvm.dbg.value(metadata !{i32 %group}, i64 0, metadata !318), !dbg !1711
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1712), !dbg !1714
  %1 = load i8* %path, align 1, !dbg !1715, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !1716), !dbg !1715
  %2 = sext i8 %1 to i32, !dbg !1717
  %3 = icmp eq i8 %1, 0, !dbg !1717
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !1717

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !1717
  %6 = load i8* %5, align 1, !dbg !1717, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !1717
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !1717

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1718, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !1718
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !1718

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !1718
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !1718

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !1719
  %12 = ashr exact i32 %sext.i, 24, !dbg !1719
  %13 = add nsw i32 %12, 65, !dbg !1719
  %14 = icmp eq i32 %2, %13, !dbg !1719
  %15 = add i32 %i.02.i, 1, !dbg !1718
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !1720), !dbg !1718
  br i1 %14, label %16, label %10, !dbg !1719

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !1721
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1721, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !1722
  %20 = load %struct.stat64** %19, align 8, !dbg !1722, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !1722
  %22 = load i64* %21, align 8, !dbg !1722, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !1722
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !1721
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !1723
  %or.cond = or i1 %23, %25, !dbg !1722
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !1722

; <label>:26                                      ; preds = %16
  tail call void @llvm.dbg.value(metadata !1647, i64 0, metadata !1724) #5, !dbg !1727
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1728) #5, !dbg !1727
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1729) #5, !dbg !1727
  tail call void @klee_warning(i8* getelementptr inbounds ([32 x i8]* @.str24, i64 0, i64 0)) #5, !dbg !1730
  %27 = tail call i32* @__errno_location() #1, !dbg !1731
  store i32 1, i32* %27, align 4, !dbg !1731, !tbaa !752
  br label %58, !dbg !1725

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1732) #5, !dbg !1734
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !1735) #5, !dbg !1737
  %28 = ptrtoint i8* %path to i64, !dbg !1738
  %29 = tail call i64 @klee_get_valuel(i64 %28) #5, !dbg !1738
  %30 = inttoptr i64 %29 to i8*, !dbg !1738
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1739) #5, !dbg !1738
  %31 = icmp eq i8* %30, %path, !dbg !1740
  %32 = zext i1 %31 to i64, !dbg !1740
  tail call void @klee_assume(i64 %32) #5, !dbg !1740
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !1741) #5, !dbg !1736
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !1742) #5, !dbg !1743
  br label %33, !dbg !1743

; <label>:33                                      ; preds = %50, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %51, %50 ]
  %sc.0.i = phi i8* [ %30, %__get_sym_file.exit.thread ], [ %sc.1.i, %50 ]
  %34 = load i8* %sc.0.i, align 1, !dbg !1744, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %34}, i64 0, metadata !1745) #5, !dbg !1744
  %35 = add i32 %i.0.i, -1, !dbg !1746
  %36 = and i32 %35, %i.0.i, !dbg !1746
  %37 = icmp eq i32 %36, 0, !dbg !1746
  br i1 %37, label %38, label %42, !dbg !1746

; <label>:38                                      ; preds = %33
  switch i8 %34, label %50 [
    i8 0, label %39
    i8 47, label %40
  ], !dbg !1747

; <label>:39                                      ; preds = %38
  store i8 0, i8* %sc.0.i, align 1, !dbg !1748, !tbaa !694
  br label %__concretize_string.exit, !dbg !1749

; <label>:40                                      ; preds = %38
  %41 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1750
  tail call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !1741) #5, !dbg !1750
  store i8 47, i8* %sc.0.i, align 1, !dbg !1750, !tbaa !694
  br label %50, !dbg !1751

; <label>:42                                      ; preds = %33
  %43 = sext i8 %34 to i64, !dbg !1752
  %44 = tail call i64 @klee_get_valuel(i64 %43) #5, !dbg !1752
  %45 = trunc i64 %44 to i8, !dbg !1752
  tail call void @llvm.dbg.value(metadata !{i8 %45}, i64 0, metadata !1753) #5, !dbg !1752
  %46 = icmp eq i8 %45, %34, !dbg !1754
  %47 = zext i1 %46 to i64, !dbg !1754
  tail call void @klee_assume(i64 %47) #5, !dbg !1754
  %48 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !1755
  tail call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !1741) #5, !dbg !1755
  store i8 %45, i8* %sc.0.i, align 1, !dbg !1755, !tbaa !694
  %49 = icmp eq i8 %45, 0, !dbg !1756
  br i1 %49, label %__concretize_string.exit, label %50, !dbg !1756

; <label>:50                                      ; preds = %42, %40, %38
  %sc.1.i = phi i8* [ %48, %42 ], [ %41, %40 ], [ %sc.0.i, %38 ]
  %51 = add i32 %i.0.i, 1, !dbg !1743
  tail call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !1742) #5, !dbg !1743
  br label %33, !dbg !1743

__concretize_string.exit:                         ; preds = %42, %39
  %52 = tail call i64 (i64, ...)* @syscall(i64 92, i8* %path, i32 %owner, i32 %group) #5, !dbg !1733
  %53 = trunc i64 %52 to i32, !dbg !1733
  tail call void @llvm.dbg.value(metadata !{i32 %53}, i64 0, metadata !320), !dbg !1733
  %54 = icmp eq i32 %53, -1, !dbg !1757
  br i1 %54, label %55, label %58, !dbg !1757

; <label>:55                                      ; preds = %__concretize_string.exit
  %56 = tail call i32 @klee_get_errno() #5, !dbg !1759
  %57 = tail call i32* @__errno_location() #1, !dbg !1759
  store i32 %56, i32* %57, align 4, !dbg !1759, !tbaa !752
  br label %58, !dbg !1759

; <label>:58                                      ; preds = %__concretize_string.exit, %55, %26
  %.0 = phi i32 [ -1, %26 ], [ -1, %55 ], [ %53, %__concretize_string.exit ]
  ret i32 %.0, !dbg !1760
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_fstat(i32 %fd, %struct.stat64* %buf) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !327), !dbg !1761
  tail call void @llvm.dbg.value(metadata !{%struct.stat64* %buf}, i64 0, metadata !328), !dbg !1761
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1762), !dbg !1764
  %1 = icmp ult i32 %fd, 32, !dbg !1765
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1765

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1766
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1767
  %5 = load i32* %4, align 4, !dbg !1767, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1767
  %7 = icmp eq i32 %6, 0, !dbg !1767
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1767

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1766
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !329), !dbg !1763
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1768
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1768

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !1770
  store i32 9, i32* %10, align 4, !dbg !1770, !tbaa !752
  br label %29, !dbg !1772

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1773
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !1773, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !1773
  br i1 %14, label %15, label %24, !dbg !1773

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !1774
  %17 = load i32* %16, align 8, !dbg !1774, !tbaa !855
  %18 = tail call i64 (i64, ...)* @syscall(i64 5, i32 %17, %struct.stat64* %buf) #5, !dbg !1774
  %19 = trunc i64 %18 to i32, !dbg !1774
  tail call void @llvm.dbg.value(metadata !{i32 %19}, i64 0, metadata !330), !dbg !1774
  %20 = icmp eq i32 %19, -1, !dbg !1775
  br i1 %20, label %21, label %29, !dbg !1775

; <label>:21                                      ; preds = %15
  %22 = tail call i32 @klee_get_errno() #5, !dbg !1777
  %23 = tail call i32* @__errno_location() #1, !dbg !1777
  store i32 %22, i32* %23, align 4, !dbg !1777, !tbaa !752
  br label %29, !dbg !1777

; <label>:24                                      ; preds = %11
  %25 = bitcast %struct.stat64* %buf to i8*, !dbg !1778
  %26 = getelementptr inbounds %struct.exe_disk_file_t* %13, i64 0, i32 2, !dbg !1778
  %27 = load %struct.stat64** %26, align 8, !dbg !1778, !tbaa !711
  %28 = bitcast %struct.stat64* %27 to i8*, !dbg !1778
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %25, i8* %28, i64 144, i32 8, i1 false), !dbg !1778
  br label %29, !dbg !1779

; <label>:29                                      ; preds = %15, %21, %24, %__get_file.exit.thread
  %.0 = phi i32 [ 0, %24 ], [ -1, %__get_file.exit.thread ], [ -1, %21 ], [ %19, %15 ]
  ret i32 %.0, !dbg !1780
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_ftruncate(i32 %fd, i64 %length) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !337), !dbg !1781
  tail call void @llvm.dbg.value(metadata !{i64 %length}, i64 0, metadata !338), !dbg !1781
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1782), !dbg !1784
  %1 = icmp ult i32 %fd, 32, !dbg !1785
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1785

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1786
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1787
  %5 = load i32* %4, align 4, !dbg !1787, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1787
  %7 = icmp eq i32 %6, 0, !dbg !1787
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1787

__get_file.exit.thread:                           ; preds = %2, %0
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !339), !dbg !1783
  %8 = load i32* @__fd_ftruncate.n_calls, align 4, !dbg !1788, !tbaa !752
  %9 = add nsw i32 %8, 1, !dbg !1788
  store i32 %9, i32* @__fd_ftruncate.n_calls, align 4, !dbg !1788, !tbaa !752
  br label %14, !dbg !1789

__get_file.exit:                                  ; preds = %2
  %10 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1786
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %10}, i64 0, metadata !339), !dbg !1783
  %11 = load i32* @__fd_ftruncate.n_calls, align 4, !dbg !1788, !tbaa !752
  %12 = add nsw i32 %11, 1, !dbg !1788
  store i32 %12, i32* @__fd_ftruncate.n_calls, align 4, !dbg !1788, !tbaa !752
  %13 = icmp eq %struct.exe_file_t* %10, null, !dbg !1789
  br i1 %13, label %14, label %16, !dbg !1789

; <label>:14                                      ; preds = %__get_file.exit.thread, %__get_file.exit
  %15 = tail call i32* @__errno_location() #1, !dbg !1791
  store i32 9, i32* %15, align 4, !dbg !1791, !tbaa !752
  br label %41, !dbg !1793

; <label>:16                                      ; preds = %__get_file.exit
  %17 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1794, !tbaa !1096
  %18 = icmp eq i32 %17, 0, !dbg !1794
  br i1 %18, label %26, label %19, !dbg !1794

; <label>:19                                      ; preds = %16
  %20 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 9), align 8, !dbg !1794, !tbaa !1796
  %21 = load i32* %20, align 4, !dbg !1794, !tbaa !752
  %22 = icmp eq i32 %21, %12, !dbg !1794
  br i1 %22, label %23, label %26, !dbg !1794

; <label>:23                                      ; preds = %19
  %24 = add i32 %17, -1, !dbg !1797
  store i32 %24, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !1797, !tbaa !1096
  %25 = tail call i32* @__errno_location() #1, !dbg !1799
  store i32 5, i32* %25, align 4, !dbg !1799, !tbaa !752
  br label %41, !dbg !1800

; <label>:26                                      ; preds = %16, %19
  %27 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1801
  %28 = load %struct.exe_disk_file_t** %27, align 8, !dbg !1801, !tbaa !788
  %29 = icmp eq %struct.exe_disk_file_t* %28, null, !dbg !1801
  br i1 %29, label %32, label %30, !dbg !1801

; <label>:30                                      ; preds = %26
  tail call void @klee_warning(i8* getelementptr inbounds ([30 x i8]* @.str10, i64 0, i64 0)) #5, !dbg !1802
  %31 = tail call i32* @__errno_location() #1, !dbg !1804
  store i32 5, i32* %31, align 4, !dbg !1804, !tbaa !752
  br label %41, !dbg !1805

; <label>:32                                      ; preds = %26
  %33 = getelementptr inbounds %struct.exe_file_t* %10, i64 0, i32 0, !dbg !1806
  %34 = load i32* %33, align 8, !dbg !1806, !tbaa !855
  %35 = tail call i64 (i64, ...)* @syscall(i64 77, i32 %34, i64 %length) #5, !dbg !1806
  %36 = trunc i64 %35 to i32, !dbg !1806
  tail call void @llvm.dbg.value(metadata !{i32 %36}, i64 0, metadata !340), !dbg !1806
  %37 = icmp eq i32 %36, -1, !dbg !1807
  br i1 %37, label %38, label %41, !dbg !1807

; <label>:38                                      ; preds = %32
  %39 = tail call i32 @klee_get_errno() #5, !dbg !1809
  %40 = tail call i32* @__errno_location() #1, !dbg !1809
  store i32 %39, i32* %40, align 4, !dbg !1809, !tbaa !752
  br label %41, !dbg !1809

; <label>:41                                      ; preds = %32, %38, %30, %23, %14
  %.0 = phi i32 [ -1, %23 ], [ -1, %30 ], [ -1, %14 ], [ -1, %38 ], [ %36, %32 ]
  ret i32 %.0, !dbg !1810
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_getdents(i32 %fd, %struct.dirent64* %dirp, i32 %count) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !361), !dbg !1811
  tail call void @llvm.dbg.value(metadata !{%struct.dirent64* %dirp}, i64 0, metadata !362), !dbg !1811
  tail call void @llvm.dbg.value(metadata !{i32 %count}, i64 0, metadata !363), !dbg !1811
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1812), !dbg !1814
  %1 = icmp ult i32 %fd, 32, !dbg !1815
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1815

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1816
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1817
  %5 = load i32* %4, align 4, !dbg !1817, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1817
  %7 = icmp eq i32 %6, 0, !dbg !1817
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1817

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1816
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !364), !dbg !1813
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1818
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1818

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !1820
  store i32 9, i32* %10, align 4, !dbg !1820, !tbaa !752
  br label %.loopexit, !dbg !1822

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1823
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !1823, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !1823
  br i1 %14, label %17, label %15, !dbg !1823

; <label>:15                                      ; preds = %11
  tail call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str11, i64 0, i64 0)) #5, !dbg !1824
  %16 = tail call i32* @__errno_location() #1, !dbg !1826
  store i32 22, i32* %16, align 4, !dbg !1826, !tbaa !752
  br label %.loopexit, !dbg !1827

; <label>:17                                      ; preds = %11
  %18 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1828
  %19 = load i64* %18, align 8, !dbg !1828, !tbaa !1150
  %20 = icmp ult i64 %19, 4096, !dbg !1828
  br i1 %20, label %21, label %69, !dbg !1828

; <label>:21                                      ; preds = %17
  tail call void @llvm.dbg.value(metadata !1222, i64 0, metadata !371), !dbg !1829
  %22 = udiv i64 %19, 280, !dbg !1830
  tail call void @llvm.dbg.value(metadata !{i64 %22}, i64 0, metadata !365), !dbg !1830
  %23 = mul i64 %22, 280, !dbg !1831
  %24 = icmp eq i64 %23, %19, !dbg !1831
  br i1 %24, label %25, label %30, !dbg !1831

; <label>:25                                      ; preds = %21
  %26 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1831, !tbaa !701
  %27 = zext i32 %26 to i64, !dbg !1831
  %28 = icmp ugt i64 %22, %27, !dbg !1831
  br i1 %28, label %30, label %.preheader, !dbg !1831

.preheader:                                       ; preds = %25
  %29 = icmp ult i64 %22, %27, !dbg !1833
  br i1 %29, label %.lr.ph, label %._crit_edge, !dbg !1833

; <label>:30                                      ; preds = %21, %25
  %31 = tail call i32* @__errno_location() #1, !dbg !1834
  store i32 22, i32* %31, align 4, !dbg !1834, !tbaa !752
  br label %.loopexit, !dbg !1836

.lr.ph:                                           ; preds = %.preheader, %.lr.ph
  %.015 = phi %struct.dirent64* [ %52, %.lr.ph ], [ %dirp, %.preheader ]
  %i.04 = phi i64 [ %48, %.lr.ph ], [ %22, %.preheader ]
  %bytes.03 = phi i64 [ %51, %.lr.ph ], [ 0, %.preheader ]
  %32 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !1837, !tbaa !708
  %33 = getelementptr inbounds %struct.exe_disk_file_t* %32, i64 %i.04, i32 2, !dbg !1838
  %34 = load %struct.stat64** %33, align 8, !dbg !1838, !tbaa !711
  %35 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 1, !dbg !1838
  %36 = load i64* %35, align 8, !dbg !1838, !tbaa !713
  %37 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 0, !dbg !1838
  store i64 %36, i64* %37, align 8, !dbg !1838, !tbaa !1839
  %38 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 2, !dbg !1842
  store i16 280, i16* %38, align 2, !dbg !1842, !tbaa !1843
  %39 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1844
  %40 = load i32* %39, align 4, !dbg !1844, !tbaa !805
  %41 = lshr i32 %40, 12, !dbg !1844
  %.tr = trunc i32 %41 to i8, !dbg !1844
  %42 = and i8 %.tr, 15, !dbg !1844
  %43 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 3, !dbg !1844
  store i8 %42, i8* %43, align 1, !dbg !1844, !tbaa !1845
  %44 = add nsw i64 %i.04, 65, !dbg !1846
  %45 = trunc i64 %44 to i8, !dbg !1846
  %46 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 4, i64 0, !dbg !1846
  store i8 %45, i8* %46, align 1, !dbg !1846, !tbaa !694
  %47 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 4, i64 1, !dbg !1847
  store i8 0, i8* %47, align 1, !dbg !1847, !tbaa !694
  %48 = add nsw i64 %i.04, 1, !dbg !1848
  %49 = mul i64 %48, 280, !dbg !1848
  %50 = getelementptr inbounds %struct.dirent64* %.015, i64 0, i32 1, !dbg !1848
  store i64 %49, i64* %50, align 8, !dbg !1848, !tbaa !1849
  %51 = add nsw i64 %bytes.03, 280, !dbg !1850
  tail call void @llvm.dbg.value(metadata !{i64 %51}, i64 0, metadata !371), !dbg !1850
  %52 = getelementptr inbounds %struct.dirent64* %.015, i64 1, !dbg !1851
  tail call void @llvm.dbg.value(metadata !{%struct.dirent64* %52}, i64 0, metadata !362), !dbg !1851
  tail call void @llvm.dbg.value(metadata !{i64 %48}, i64 0, metadata !365), !dbg !1833
  %53 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !1833, !tbaa !701
  %54 = zext i32 %53 to i64, !dbg !1833
  %55 = icmp slt i64 %48, %54, !dbg !1833
  br i1 %55, label %.lr.ph, label %._crit_edge, !dbg !1833

._crit_edge:                                      ; preds = %.lr.ph, %.preheader
  %.01.lcssa = phi %struct.dirent64* [ %dirp, %.preheader ], [ %52, %.lr.ph ]
  %bytes.0.lcssa = phi i64 [ 0, %.preheader ], [ %51, %.lr.ph ]
  %56 = icmp ult i32 %count, 4096, !dbg !1852
  %57 = zext i32 %count to i64, !dbg !1852
  %58 = select i1 %56, i64 %57, i64 4096, !dbg !1852
  tail call void @llvm.dbg.value(metadata !{i64 %58}, i64 0, metadata !370), !dbg !1852
  %59 = getelementptr inbounds %struct.dirent64* %.01.lcssa, i64 0, i32 0, !dbg !1853
  store i64 0, i64* %59, align 8, !dbg !1853, !tbaa !1839
  %60 = sub nsw i64 %58, %bytes.0.lcssa, !dbg !1854
  %61 = trunc i64 %60 to i16, !dbg !1854
  %62 = getelementptr inbounds %struct.dirent64* %.01.lcssa, i64 0, i32 2, !dbg !1854
  store i16 %61, i16* %62, align 2, !dbg !1854, !tbaa !1843
  %63 = getelementptr inbounds %struct.dirent64* %.01.lcssa, i64 0, i32 3, !dbg !1855
  store i8 0, i8* %63, align 1, !dbg !1855, !tbaa !1845
  %64 = getelementptr inbounds %struct.dirent64* %.01.lcssa, i64 0, i32 4, i64 0, !dbg !1856
  store i8 0, i8* %64, align 1, !dbg !1856, !tbaa !694
  %65 = getelementptr inbounds %struct.dirent64* %.01.lcssa, i64 0, i32 1, !dbg !1857
  store i64 4096, i64* %65, align 8, !dbg !1857, !tbaa !1849
  %66 = and i64 %60, 65535, !dbg !1858
  %67 = add nsw i64 %66, %bytes.0.lcssa, !dbg !1858
  tail call void @llvm.dbg.value(metadata !{i64 %67}, i64 0, metadata !371), !dbg !1858
  store i64 %58, i64* %18, align 8, !dbg !1859, !tbaa !1150
  %68 = trunc i64 %67 to i32, !dbg !1860
  br label %.loopexit, !dbg !1860

; <label>:69                                      ; preds = %17
  %70 = add nsw i64 %19, -4096, !dbg !1861
  tail call void @llvm.dbg.value(metadata !{i64 %70}, i64 0, metadata !375), !dbg !1861
  tail call void @llvm.dbg.value(metadata !1222, i64 0, metadata !378), !dbg !1862
  %71 = bitcast %struct.dirent64* %dirp to i8*, !dbg !1863
  %72 = zext i32 %count to i64, !dbg !1863
  tail call void @llvm.memset.p0i8.i64(i8* %71, i8 0, i64 %72, i32 8, i1 false), !dbg !1863
  %73 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !1864
  %74 = load i32* %73, align 8, !dbg !1864, !tbaa !855
  %75 = tail call i64 (i64, ...)* @syscall(i64 8, i32 %74, i64 %70, i32 0) #5, !dbg !1864
  tail call void @llvm.dbg.value(metadata !{i64 %75}, i64 0, metadata !378), !dbg !1864
  %76 = icmp eq i64 %75, -1, !dbg !1865
  br i1 %76, label %77, label %78, !dbg !1865

; <label>:77                                      ; preds = %69
  tail call void @__assert_fail(i8* getelementptr inbounds ([18 x i8]* @.str12, i64 0, i64 0), i8* getelementptr inbounds ([5 x i8]* @.str4, i64 0, i64 0), i32 875, i8* getelementptr inbounds ([65 x i8]* @__PRETTY_FUNCTION__.__fd_getdents, i64 0, i64 0)) #9, !dbg !1865
  unreachable, !dbg !1865

; <label>:78                                      ; preds = %69
  %79 = load i32* %73, align 8, !dbg !1866, !tbaa !855
  %80 = tail call i64 (i64, ...)* @syscall(i64 217, i32 %79, %struct.dirent64* %dirp, i32 %count) #5, !dbg !1866
  %81 = trunc i64 %80 to i32, !dbg !1866
  tail call void @llvm.dbg.value(metadata !{i32 %81}, i64 0, metadata !377), !dbg !1866
  %82 = icmp eq i32 %81, -1, !dbg !1867
  br i1 %82, label %83, label %86, !dbg !1867

; <label>:83                                      ; preds = %78
  %84 = tail call i32 @klee_get_errno() #5, !dbg !1868
  %85 = tail call i32* @__errno_location() #1, !dbg !1868
  store i32 %84, i32* %85, align 4, !dbg !1868, !tbaa !752
  br label %.loopexit, !dbg !1870

; <label>:86                                      ; preds = %78
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !379), !dbg !1871
  %87 = load i32* %73, align 8, !dbg !1872, !tbaa !855
  %88 = tail call i64 (i64, ...)* @syscall(i64 8, i32 %87, i32 0, i32 1) #5, !dbg !1872
  %89 = add nsw i64 %88, 4096, !dbg !1872
  store i64 %89, i64* %18, align 8, !dbg !1872, !tbaa !1150
  %90 = icmp sgt i32 %81, 0, !dbg !1873
  br i1 %90, label %.lr.ph9, label %.loopexit, !dbg !1873

.lr.ph9:                                          ; preds = %86, %.lr.ph9
  %pos.07 = phi i32 [ %100, %.lr.ph9 ], [ 0, %86 ]
  %91 = sext i32 %pos.07 to i64, !dbg !1874
  %.sum = add i64 %91, 8, !dbg !1875
  %92 = getelementptr inbounds i8* %71, i64 %.sum, !dbg !1875
  %93 = bitcast i8* %92 to i64*, !dbg !1875
  %94 = load i64* %93, align 8, !dbg !1875, !tbaa !1849
  %95 = add nsw i64 %94, 4096, !dbg !1875
  store i64 %95, i64* %93, align 8, !dbg !1875, !tbaa !1849
  %.sum2 = add i64 %91, 16, !dbg !1876
  %96 = getelementptr inbounds i8* %71, i64 %.sum2, !dbg !1876
  %97 = bitcast i8* %96 to i16*, !dbg !1876
  %98 = load i16* %97, align 2, !dbg !1876, !tbaa !1843
  %99 = zext i16 %98 to i32, !dbg !1876
  %100 = add nsw i32 %99, %pos.07, !dbg !1876
  tail call void @llvm.dbg.value(metadata !{i32 %100}, i64 0, metadata !379), !dbg !1876
  %101 = icmp slt i32 %100, %81, !dbg !1873
  br i1 %101, label %.lr.ph9, label %.loopexit, !dbg !1873

.loopexit:                                        ; preds = %.lr.ph9, %86, %83, %._crit_edge, %30, %15, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %15 ], [ -1, %30 ], [ %68, %._crit_edge ], [ -1, %__get_file.exit.thread ], [ -1, %83 ], [ %81, %86 ], [ %81, %.lr.ph9 ]
  ret i32 %.0, !dbg !1877
}

; Function Attrs: nounwind ssp uwtable
define i32 @ioctl(i32 %fd, i64 %request, ...) #0 {
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !388), !dbg !1878
  call void @llvm.dbg.value(metadata !{i64 %request}, i64 0, metadata !389), !dbg !1878
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !1879), !dbg !1881
  %1 = icmp ult i32 %fd, 32, !dbg !1882
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !1882

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !1883
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !1884
  %5 = load i32* %4, align 4, !dbg !1884, !tbaa !765
  %6 = and i32 %5, 1, !dbg !1884
  %7 = icmp eq i32 %6, 0, !dbg !1884
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !1884

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !1883
  call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !390), !dbg !1880
  call void @llvm.dbg.declare(metadata !{[1 x %struct.__va_list_tag]* %ap}, metadata !391), !dbg !1885
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !1886
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !1886

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = call i32* @__errno_location() #1, !dbg !1888
  store i32 9, i32* %10, align 4, !dbg !1888, !tbaa !752
  br label %139, !dbg !1890

; <label>:11                                      ; preds = %__get_file.exit
  %12 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*, !dbg !1891
  call void @llvm.va_start(i8* %12), !dbg !1891
  %13 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0, !dbg !1892
  %14 = load i32* %13, align 16, !dbg !1892
  %15 = icmp ult i32 %14, 41, !dbg !1892
  br i1 %15, label %16, label %22, !dbg !1892

; <label>:16                                      ; preds = %11
  %17 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3, !dbg !1892
  %18 = load i8** %17, align 16, !dbg !1892
  %19 = sext i32 %14 to i64, !dbg !1892
  %20 = getelementptr i8* %18, i64 %19, !dbg !1892
  %21 = add i32 %14, 8, !dbg !1892
  store i32 %21, i32* %13, align 16, !dbg !1892
  br label %26, !dbg !1892

; <label>:22                                      ; preds = %11
  %23 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2, !dbg !1892
  %24 = load i8** %23, align 8, !dbg !1892
  %25 = getelementptr i8* %24, i64 8, !dbg !1892
  store i8* %25, i8** %23, align 8, !dbg !1892
  br label %26, !dbg !1892

; <label>:26                                      ; preds = %22, %16
  %.in = phi i8* [ %20, %16 ], [ %24, %22 ]
  %27 = bitcast i8* %.in to i8**, !dbg !1892
  %28 = load i8** %27, align 8, !dbg !1892
  call void @llvm.dbg.value(metadata !{i8* %28}, i64 0, metadata !405), !dbg !1892
  call void @llvm.va_end(i8* %12), !dbg !1893
  %29 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !1894
  %30 = load %struct.exe_disk_file_t** %29, align 8, !dbg !1894, !tbaa !788
  %31 = icmp eq %struct.exe_disk_file_t* %30, null, !dbg !1894
  br i1 %31, label %130, label %32, !dbg !1894

; <label>:32                                      ; preds = %26
  %33 = getelementptr inbounds %struct.exe_disk_file_t* %30, i64 0, i32 2, !dbg !1895
  %34 = load %struct.stat64** %33, align 8, !dbg !1895, !tbaa !711
  switch i64 %request, label %128 [
    i64 21505, label %35
    i64 21506, label %70
    i64 21507, label %77
    i64 21508, label %81
    i64 21523, label %88
    i64 21524, label %98
    i64 21531, label %106
    i64 2150657282, label %126
  ], !dbg !1896

; <label>:35                                      ; preds = %32
  call void @klee_warning_once(i8* getelementptr inbounds ([41 x i8]* @.str13, i64 0, i64 0)) #5, !dbg !1897
  %36 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1898
  %37 = load i32* %36, align 4, !dbg !1898, !tbaa !1900
  %38 = and i32 %37, 61440, !dbg !1898
  %39 = icmp eq i32 %38, 8192, !dbg !1898
  br i1 %39, label %40, label %68, !dbg !1898

; <label>:40                                      ; preds = %35
  %41 = bitcast i8* %28 to i32*, !dbg !1902
  store i32 27906, i32* %41, align 4, !dbg !1902, !tbaa !1904
  %42 = getelementptr inbounds i8* %28, i64 4, !dbg !1906
  %43 = bitcast i8* %42 to i32*, !dbg !1906
  store i32 5, i32* %43, align 4, !dbg !1906, !tbaa !1907
  %44 = getelementptr inbounds i8* %28, i64 8, !dbg !1908
  %45 = bitcast i8* %44 to i32*, !dbg !1908
  store i32 1215, i32* %45, align 4, !dbg !1908, !tbaa !1909
  %46 = getelementptr inbounds i8* %28, i64 12, !dbg !1910
  %47 = bitcast i8* %46 to i32*, !dbg !1910
  store i32 35287, i32* %47, align 4, !dbg !1910, !tbaa !1911
  %48 = getelementptr inbounds i8* %28, i64 16, !dbg !1912
  store i8 0, i8* %48, align 1, !dbg !1912, !tbaa !1913
  %49 = getelementptr inbounds i8* %28, i64 17, !dbg !1914
  store i8 3, i8* %49, align 1, !dbg !1914, !tbaa !694
  %50 = getelementptr inbounds i8* %28, i64 18, !dbg !1915
  store i8 28, i8* %50, align 1, !dbg !1915, !tbaa !694
  %51 = getelementptr inbounds i8* %28, i64 19, !dbg !1916
  store i8 127, i8* %51, align 1, !dbg !1916, !tbaa !694
  %52 = getelementptr inbounds i8* %28, i64 20, !dbg !1917
  store i8 21, i8* %52, align 1, !dbg !1917, !tbaa !694
  %53 = getelementptr inbounds i8* %28, i64 21, !dbg !1918
  store i8 4, i8* %53, align 1, !dbg !1918, !tbaa !694
  %54 = getelementptr inbounds i8* %28, i64 22, !dbg !1919
  store i8 0, i8* %54, align 1, !dbg !1919, !tbaa !694
  %55 = getelementptr inbounds i8* %28, i64 23, !dbg !1920
  store i8 1, i8* %55, align 1, !dbg !1920, !tbaa !694
  %56 = getelementptr inbounds i8* %28, i64 24, !dbg !1921
  store i8 -1, i8* %56, align 1, !dbg !1921, !tbaa !694
  %57 = getelementptr inbounds i8* %28, i64 25, !dbg !1922
  store i8 17, i8* %57, align 1, !dbg !1922, !tbaa !694
  %58 = getelementptr inbounds i8* %28, i64 26, !dbg !1923
  store i8 19, i8* %58, align 1, !dbg !1923, !tbaa !694
  %59 = getelementptr inbounds i8* %28, i64 27, !dbg !1924
  store i8 26, i8* %59, align 1, !dbg !1924, !tbaa !694
  %60 = getelementptr inbounds i8* %28, i64 28, !dbg !1925
  store i8 -1, i8* %60, align 1, !dbg !1925, !tbaa !694
  %61 = getelementptr inbounds i8* %28, i64 29, !dbg !1926
  store i8 18, i8* %61, align 1, !dbg !1926, !tbaa !694
  %62 = getelementptr inbounds i8* %28, i64 30, !dbg !1927
  store i8 15, i8* %62, align 1, !dbg !1927, !tbaa !694
  %63 = getelementptr inbounds i8* %28, i64 31, !dbg !1928
  store i8 23, i8* %63, align 1, !dbg !1928, !tbaa !694
  %64 = getelementptr inbounds i8* %28, i64 32, !dbg !1929
  store i8 22, i8* %64, align 1, !dbg !1929, !tbaa !694
  %65 = getelementptr inbounds i8* %28, i64 33, !dbg !1930
  store i8 -1, i8* %65, align 1, !dbg !1930, !tbaa !694
  %66 = getelementptr inbounds i8* %28, i64 34, !dbg !1931
  store i8 0, i8* %66, align 1, !dbg !1931, !tbaa !694
  %67 = getelementptr inbounds i8* %28, i64 35, !dbg !1932
  store i8 0, i8* %67, align 1, !dbg !1932, !tbaa !694
  br label %139, !dbg !1933

; <label>:68                                      ; preds = %35
  %69 = call i32* @__errno_location() #1, !dbg !1934
  store i32 25, i32* %69, align 4, !dbg !1934, !tbaa !752
  br label %139, !dbg !1936

; <label>:70                                      ; preds = %32
  call void @klee_warning_once(i8* getelementptr inbounds ([42 x i8]* @.str14, i64 0, i64 0)) #5, !dbg !1937
  %71 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1939
  %72 = load i32* %71, align 4, !dbg !1939, !tbaa !1900
  %73 = and i32 %72, 61440, !dbg !1939
  %74 = icmp eq i32 %73, 8192, !dbg !1939
  br i1 %74, label %139, label %75, !dbg !1939

; <label>:75                                      ; preds = %70
  %76 = call i32* @__errno_location() #1, !dbg !1941
  store i32 25, i32* %76, align 4, !dbg !1941, !tbaa !752
  br label %139, !dbg !1943

; <label>:77                                      ; preds = %32
  call void @klee_warning_once(i8* getelementptr inbounds ([43 x i8]* @.str15, i64 0, i64 0)) #5, !dbg !1944
  %78 = icmp eq i32 %fd, 0, !dbg !1946
  br i1 %78, label %139, label %79, !dbg !1946

; <label>:79                                      ; preds = %77
  %80 = call i32* @__errno_location() #1, !dbg !1948
  store i32 25, i32* %80, align 4, !dbg !1948, !tbaa !752
  br label %139, !dbg !1950

; <label>:81                                      ; preds = %32
  call void @klee_warning_once(i8* getelementptr inbounds ([43 x i8]* @.str16, i64 0, i64 0)) #5, !dbg !1951
  %82 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1953
  %83 = load i32* %82, align 4, !dbg !1953, !tbaa !1900
  %84 = and i32 %83, 61440, !dbg !1953
  %85 = icmp eq i32 %84, 8192, !dbg !1953
  br i1 %85, label %139, label %86, !dbg !1953

; <label>:86                                      ; preds = %81
  %87 = call i32* @__errno_location() #1, !dbg !1955
  store i32 25, i32* %87, align 4, !dbg !1955, !tbaa !752
  br label %139, !dbg !1957

; <label>:88                                      ; preds = %32
  %89 = bitcast i8* %28 to i16*, !dbg !1958
  store i16 24, i16* %89, align 2, !dbg !1958, !tbaa !1959
  %90 = getelementptr inbounds i8* %28, i64 2, !dbg !1961
  %91 = bitcast i8* %90 to i16*, !dbg !1961
  store i16 80, i16* %91, align 2, !dbg !1961, !tbaa !1962
  call void @klee_warning_once(i8* getelementptr inbounds ([45 x i8]* @.str17, i64 0, i64 0)) #5, !dbg !1963
  %92 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1964
  %93 = load i32* %92, align 4, !dbg !1964, !tbaa !1900
  %94 = and i32 %93, 61440, !dbg !1964
  %95 = icmp eq i32 %94, 8192, !dbg !1964
  br i1 %95, label %139, label %96, !dbg !1964

; <label>:96                                      ; preds = %88
  %97 = call i32* @__errno_location() #1, !dbg !1966
  store i32 25, i32* %97, align 4, !dbg !1966, !tbaa !752
  br label %139, !dbg !1968

; <label>:98                                      ; preds = %32
  call void @klee_warning_once(i8* getelementptr inbounds ([46 x i8]* @.str18, i64 0, i64 0)) #5, !dbg !1969
  %99 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1971
  %100 = load i32* %99, align 4, !dbg !1971, !tbaa !1900
  %101 = and i32 %100, 61440, !dbg !1971
  %102 = icmp eq i32 %101, 8192, !dbg !1971
  %103 = call i32* @__errno_location() #1, !dbg !1973
  br i1 %102, label %104, label %105, !dbg !1971

; <label>:104                                     ; preds = %98
  store i32 22, i32* %103, align 4, !dbg !1973, !tbaa !752
  br label %139, !dbg !1975

; <label>:105                                     ; preds = %98
  store i32 25, i32* %103, align 4, !dbg !1976, !tbaa !752
  br label %139, !dbg !1978

; <label>:106                                     ; preds = %32
  %107 = bitcast i8* %28 to i32*, !dbg !1979
  call void @llvm.dbg.value(metadata !{i32* %107}, i64 0, metadata !440), !dbg !1979
  call void @klee_warning_once(i8* getelementptr inbounds ([43 x i8]* @.str19, i64 0, i64 0)) #5, !dbg !1980
  %108 = getelementptr inbounds %struct.stat64* %34, i64 0, i32 3, !dbg !1981
  %109 = load i32* %108, align 4, !dbg !1981, !tbaa !1900
  %110 = and i32 %109, 61440, !dbg !1981
  %111 = icmp eq i32 %110, 8192, !dbg !1981
  br i1 %111, label %112, label %124, !dbg !1981

; <label>:112                                     ; preds = %106
  %113 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 2, !dbg !1983
  %114 = load i64* %113, align 8, !dbg !1983, !tbaa !1150
  %115 = load %struct.exe_disk_file_t** %29, align 8, !dbg !1983, !tbaa !788
  %116 = getelementptr inbounds %struct.exe_disk_file_t* %115, i64 0, i32 0, !dbg !1983
  %117 = load i32* %116, align 4, !dbg !1983, !tbaa !1164
  %118 = zext i32 %117 to i64, !dbg !1983
  %119 = icmp sgt i64 %118, %114, !dbg !1983
  br i1 %119, label %120, label %123, !dbg !1983

; <label>:120                                     ; preds = %112
  %121 = sub nsw i64 %118, %114, !dbg !1986
  %122 = trunc i64 %121 to i32, !dbg !1986
  br label %123, !dbg !1988

; <label>:123                                     ; preds = %112, %120
  %storemerge = phi i32 [ %122, %120 ], [ 0, %112 ]
  store i32 %storemerge, i32* %107, align 4, !dbg !1986, !tbaa !752
  br label %139, !dbg !1989

; <label>:124                                     ; preds = %106
  %125 = call i32* @__errno_location() #1, !dbg !1990
  store i32 25, i32* %125, align 4, !dbg !1990, !tbaa !752
  br label %139, !dbg !1992

; <label>:126                                     ; preds = %32
  call void @klee_warning(i8* getelementptr inbounds ([44 x i8]* @.str20, i64 0, i64 0)) #5, !dbg !1993
  %127 = call i32* @__errno_location() #1, !dbg !1995
  store i32 22, i32* %127, align 4, !dbg !1995, !tbaa !752
  br label %139, !dbg !1996

; <label>:128                                     ; preds = %32
  call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str11, i64 0, i64 0)) #5, !dbg !1997
  %129 = call i32* @__errno_location() #1, !dbg !1998
  store i32 22, i32* %129, align 4, !dbg !1998, !tbaa !752
  br label %139, !dbg !1999

; <label>:130                                     ; preds = %26
  %131 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !2000
  %132 = load i32* %131, align 8, !dbg !2000, !tbaa !855
  %133 = call i64 (i64, ...)* @syscall(i64 16, i32 %132, i64 %request, i8* %28) #5, !dbg !2000
  %134 = trunc i64 %133 to i32, !dbg !2000
  call void @llvm.dbg.value(metadata !{i32 %134}, i64 0, metadata !443), !dbg !2000
  %135 = icmp eq i32 %134, -1, !dbg !2001
  br i1 %135, label %136, label %139, !dbg !2001

; <label>:136                                     ; preds = %130
  %137 = call i32 @klee_get_errno() #5, !dbg !2003
  %138 = call i32* @__errno_location() #1, !dbg !2003
  store i32 %137, i32* %138, align 4, !dbg !2003, !tbaa !752
  br label %139, !dbg !2003

; <label>:139                                     ; preds = %130, %136, %88, %81, %77, %70, %128, %126, %124, %123, %105, %104, %96, %86, %79, %75, %68, %40, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %128 ], [ -1, %126 ], [ 0, %123 ], [ -1, %124 ], [ -1, %104 ], [ -1, %105 ], [ -1, %96 ], [ -1, %86 ], [ -1, %79 ], [ -1, %75 ], [ 0, %40 ], [ -1, %68 ], [ -1, %__get_file.exit.thread ], [ 0, %70 ], [ 0, %77 ], [ 0, %81 ], [ 0, %88 ], [ -1, %136 ], [ %134, %130 ]
  ret i32 %.0, !dbg !2004
}

; Function Attrs: nounwind
declare void @llvm.va_start(i8*) #5

; Function Attrs: nounwind
declare void @llvm.va_end(i8*) #5

declare void @klee_warning_once(i8*) #3

; Function Attrs: nounwind ssp uwtable
define i32 @fcntl(i32 %fd, i32 %cmd, ...) #0 {
  %ap = alloca [1 x %struct.__va_list_tag], align 16
  call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !449), !dbg !2005
  call void @llvm.dbg.value(metadata !{i32 %cmd}, i64 0, metadata !450), !dbg !2005
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !2006), !dbg !2008
  %1 = icmp ult i32 %fd, 32, !dbg !2009
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !2009

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !2010
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !2011
  %5 = load i32* %4, align 4, !dbg !2011, !tbaa !765
  %6 = and i32 %5, 1, !dbg !2011
  %7 = icmp eq i32 %6, 0, !dbg !2011
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !2011

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !2010
  call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !451), !dbg !2007
  call void @llvm.dbg.declare(metadata !{[1 x %struct.__va_list_tag]* %ap}, metadata !452), !dbg !2012
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !2013
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !2013

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = call i32* @__errno_location() #1, !dbg !2015
  store i32 9, i32* %10, align 4, !dbg !2015, !tbaa !752
  br label %55, !dbg !2017

; <label>:11                                      ; preds = %__get_file.exit
  switch i32 %cmd, label %12 [
    i32 1026, label %30
    i32 1025, label %30
    i32 11, label %30
    i32 9, label %30
    i32 3, label %30
    i32 1, label %30
  ], !dbg !2018

; <label>:12                                      ; preds = %11
  %13 = bitcast [1 x %struct.__va_list_tag]* %ap to i8*, !dbg !2020
  call void @llvm.va_start(i8* %13), !dbg !2020
  %14 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 0, !dbg !2022
  %15 = load i32* %14, align 16, !dbg !2022
  %16 = icmp ult i32 %15, 41, !dbg !2022
  br i1 %16, label %17, label %23, !dbg !2022

; <label>:17                                      ; preds = %12
  %18 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 3, !dbg !2022
  %19 = load i8** %18, align 16, !dbg !2022
  %20 = sext i32 %15 to i64, !dbg !2022
  %21 = getelementptr i8* %19, i64 %20, !dbg !2022
  %22 = add i32 %15, 8, !dbg !2022
  store i32 %22, i32* %14, align 16, !dbg !2022
  br label %27, !dbg !2022

; <label>:23                                      ; preds = %12
  %24 = getelementptr inbounds [1 x %struct.__va_list_tag]* %ap, i64 0, i64 0, i32 2, !dbg !2022
  %25 = load i8** %24, align 8, !dbg !2022
  %26 = getelementptr i8* %25, i64 8, !dbg !2022
  store i8* %26, i8** %24, align 8, !dbg !2022
  br label %27, !dbg !2022

; <label>:27                                      ; preds = %23, %17
  %.in = phi i8* [ %21, %17 ], [ %25, %23 ]
  %28 = bitcast i8* %.in to i32*, !dbg !2022
  %29 = load i32* %28, align 4, !dbg !2022
  call void @llvm.dbg.value(metadata !{i32 %29}, i64 0, metadata !453), !dbg !2022
  call void @llvm.va_end(i8* %13), !dbg !2023
  br label %30

; <label>:30                                      ; preds = %11, %11, %11, %11, %11, %11, %27
  %arg.0 = phi i32 [ %29, %27 ], [ 0, %11 ], [ 0, %11 ], [ 0, %11 ], [ 0, %11 ], [ 0, %11 ], [ 0, %11 ]
  %31 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !2024
  %32 = load %struct.exe_disk_file_t** %31, align 8, !dbg !2024, !tbaa !788
  %33 = icmp eq %struct.exe_disk_file_t* %32, null, !dbg !2024
  br i1 %33, label %46, label %34, !dbg !2024

; <label>:34                                      ; preds = %30
  switch i32 %cmd, label %44 [
    i32 1, label %35
    i32 2, label %38
    i32 3, label %55
  ], !dbg !2025

; <label>:35                                      ; preds = %34
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !454), !dbg !2026
  %36 = load i32* %4, align 4, !dbg !2027, !tbaa !765
  call void @llvm.dbg.value(metadata !2029, i64 0, metadata !454), !dbg !2030
  %37 = lshr i32 %36, 1, !dbg !2027
  %.lobit = and i32 %37, 1, !dbg !2027
  br label %55, !dbg !2031

; <label>:38                                      ; preds = %34
  %39 = load i32* %4, align 4, !dbg !2032, !tbaa !765
  %40 = and i32 %39, -3, !dbg !2032
  %41 = and i32 %arg.0, 1, !dbg !2034
  %42 = icmp eq i32 %41, 0, !dbg !2034
  %43 = or i32 %39, 2, !dbg !2036
  %.10 = select i1 %42, i32 %40, i32 %43, !dbg !2034
  store i32 %.10, i32* %4, align 4, !dbg !2032, !tbaa !765
  br label %55, !dbg !2037

; <label>:44                                      ; preds = %34
  call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str11, i64 0, i64 0)) #5, !dbg !2038
  %45 = call i32* @__errno_location() #1, !dbg !2039
  store i32 22, i32* %45, align 4, !dbg !2039, !tbaa !752
  br label %55, !dbg !2040

; <label>:46                                      ; preds = %30
  %47 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !2041
  %48 = load i32* %47, align 8, !dbg !2041, !tbaa !855
  %49 = call i64 (i64, ...)* @syscall(i64 72, i32 %48, i32 %cmd, i32 %arg.0) #5, !dbg !2041
  %50 = trunc i64 %49 to i32, !dbg !2041
  call void @llvm.dbg.value(metadata !{i32 %50}, i64 0, metadata !459), !dbg !2041
  %51 = icmp eq i32 %50, -1, !dbg !2042
  br i1 %51, label %52, label %55, !dbg !2042

; <label>:52                                      ; preds = %46
  %53 = call i32 @klee_get_errno() #5, !dbg !2044
  %54 = call i32* @__errno_location() #1, !dbg !2044
  store i32 %53, i32* %54, align 4, !dbg !2044, !tbaa !752
  br label %55, !dbg !2044

; <label>:55                                      ; preds = %46, %52, %34, %44, %38, %35, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %44 ], [ 0, %38 ], [ %.lobit, %35 ], [ -1, %__get_file.exit.thread ], [ 0, %34 ], [ -1, %52 ], [ %50, %46 ]
  ret i32 %.0, !dbg !2045
}

; Function Attrs: nounwind ssp uwtable
define i32 @__fd_statfs(i8* %path, %struct.statfs* %buf) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !495), !dbg !2046
  tail call void @llvm.dbg.value(metadata !{%struct.statfs* %buf}, i64 0, metadata !496), !dbg !2046
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !2047), !dbg !2049
  %1 = load i8* %path, align 1, !dbg !2050, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !2051), !dbg !2050
  %2 = sext i8 %1 to i32, !dbg !2052
  %3 = icmp eq i8 %1, 0, !dbg !2052
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !2052

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !2052
  %6 = load i8* %5, align 1, !dbg !2052, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2052
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !2052

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !2053, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !2053
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !2053

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !2053
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !2053

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !2054
  %12 = ashr exact i32 %sext.i, 24, !dbg !2054
  %13 = add nsw i32 %12, 65, !dbg !2054
  %14 = icmp eq i32 %2, %13, !dbg !2054
  %15 = add i32 %i.02.i, 1, !dbg !2053
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !2055), !dbg !2053
  br i1 %14, label %16, label %10, !dbg !2054

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !2056
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !2056, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !2057
  %20 = load %struct.stat64** %19, align 8, !dbg !2057, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !2057
  %22 = load i64* %21, align 8, !dbg !2057, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !2057
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !2056
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !2058
  %or.cond = or i1 %23, %25, !dbg !2057
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !2057

; <label>:26                                      ; preds = %16
  tail call void @klee_warning(i8* getelementptr inbounds ([33 x i8]* @.str9, i64 0, i64 0)) #5, !dbg !2060
  %27 = tail call i32* @__errno_location() #1, !dbg !2062
  store i32 2, i32* %27, align 4, !dbg !2062, !tbaa !752
  br label %58, !dbg !2063

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !2064) #5, !dbg !2066
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !2067) #5, !dbg !2069
  %28 = ptrtoint i8* %path to i64, !dbg !2070
  %29 = tail call i64 @klee_get_valuel(i64 %28) #5, !dbg !2070
  %30 = inttoptr i64 %29 to i8*, !dbg !2070
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !2071) #5, !dbg !2070
  %31 = icmp eq i8* %30, %path, !dbg !2072
  %32 = zext i1 %31 to i64, !dbg !2072
  tail call void @klee_assume(i64 %32) #5, !dbg !2072
  tail call void @llvm.dbg.value(metadata !{i8* %30}, i64 0, metadata !2073) #5, !dbg !2068
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !2074) #5, !dbg !2075
  br label %33, !dbg !2075

; <label>:33                                      ; preds = %50, %__get_sym_file.exit.thread
  %i.0.i = phi i32 [ 0, %__get_sym_file.exit.thread ], [ %51, %50 ]
  %sc.0.i = phi i8* [ %30, %__get_sym_file.exit.thread ], [ %sc.1.i, %50 ]
  %34 = load i8* %sc.0.i, align 1, !dbg !2076, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %34}, i64 0, metadata !2077) #5, !dbg !2076
  %35 = add i32 %i.0.i, -1, !dbg !2078
  %36 = and i32 %35, %i.0.i, !dbg !2078
  %37 = icmp eq i32 %36, 0, !dbg !2078
  br i1 %37, label %38, label %42, !dbg !2078

; <label>:38                                      ; preds = %33
  switch i8 %34, label %50 [
    i8 0, label %39
    i8 47, label %40
  ], !dbg !2079

; <label>:39                                      ; preds = %38
  store i8 0, i8* %sc.0.i, align 1, !dbg !2080, !tbaa !694
  br label %__concretize_string.exit, !dbg !2081

; <label>:40                                      ; preds = %38
  %41 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !2082
  tail call void @llvm.dbg.value(metadata !{i8* %41}, i64 0, metadata !2073) #5, !dbg !2082
  store i8 47, i8* %sc.0.i, align 1, !dbg !2082, !tbaa !694
  br label %50, !dbg !2083

; <label>:42                                      ; preds = %33
  %43 = sext i8 %34 to i64, !dbg !2084
  %44 = tail call i64 @klee_get_valuel(i64 %43) #5, !dbg !2084
  %45 = trunc i64 %44 to i8, !dbg !2084
  tail call void @llvm.dbg.value(metadata !{i8 %45}, i64 0, metadata !2085) #5, !dbg !2084
  %46 = icmp eq i8 %45, %34, !dbg !2086
  %47 = zext i1 %46 to i64, !dbg !2086
  tail call void @klee_assume(i64 %47) #5, !dbg !2086
  %48 = getelementptr inbounds i8* %sc.0.i, i64 1, !dbg !2087
  tail call void @llvm.dbg.value(metadata !{i8* %48}, i64 0, metadata !2073) #5, !dbg !2087
  store i8 %45, i8* %sc.0.i, align 1, !dbg !2087, !tbaa !694
  %49 = icmp eq i8 %45, 0, !dbg !2088
  br i1 %49, label %__concretize_string.exit, label %50, !dbg !2088

; <label>:50                                      ; preds = %42, %40, %38
  %sc.1.i = phi i8* [ %48, %42 ], [ %41, %40 ], [ %sc.0.i, %38 ]
  %51 = add i32 %i.0.i, 1, !dbg !2075
  tail call void @llvm.dbg.value(metadata !{i32 %51}, i64 0, metadata !2074) #5, !dbg !2075
  br label %33, !dbg !2075

__concretize_string.exit:                         ; preds = %42, %39
  %52 = tail call i64 (i64, ...)* @syscall(i64 137, i8* %path, %struct.statfs* %buf) #5, !dbg !2065
  %53 = trunc i64 %52 to i32, !dbg !2065
  tail call void @llvm.dbg.value(metadata !{i32 %53}, i64 0, metadata !498), !dbg !2065
  %54 = icmp eq i32 %53, -1, !dbg !2089
  br i1 %54, label %55, label %58, !dbg !2089

; <label>:55                                      ; preds = %__concretize_string.exit
  %56 = tail call i32 @klee_get_errno() #5, !dbg !2091
  %57 = tail call i32* @__errno_location() #1, !dbg !2091
  store i32 %56, i32* %57, align 4, !dbg !2091, !tbaa !752
  br label %58, !dbg !2091

; <label>:58                                      ; preds = %__concretize_string.exit, %55, %26
  %.0 = phi i32 [ -1, %26 ], [ -1, %55 ], [ %53, %__concretize_string.exit ]
  ret i32 %.0, !dbg !2092
}

; Function Attrs: nounwind ssp uwtable
define i32 @fstatfs(i32 %fd, %struct.statfs* %buf) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !504), !dbg !2093
  tail call void @llvm.dbg.value(metadata !{%struct.statfs* %buf}, i64 0, metadata !505), !dbg !2093
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !2094), !dbg !2096
  %1 = icmp ult i32 %fd, 32, !dbg !2097
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !2097

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !2098
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !2099
  %5 = load i32* %4, align 4, !dbg !2099, !tbaa !765
  %6 = and i32 %5, 1, !dbg !2099
  %7 = icmp eq i32 %6, 0, !dbg !2099
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !2099

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !2098
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !506), !dbg !2095
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !2100
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !2100

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !2102
  store i32 9, i32* %10, align 4, !dbg !2102, !tbaa !752
  br label %26, !dbg !2104

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !2105
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !2105, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !2105
  br i1 %14, label %17, label %15, !dbg !2105

; <label>:15                                      ; preds = %11
  tail call void @klee_warning(i8* getelementptr inbounds ([32 x i8]* @.str21, i64 0, i64 0)) #5, !dbg !2106
  %16 = tail call i32* @__errno_location() #1, !dbg !2108
  store i32 9, i32* %16, align 4, !dbg !2108, !tbaa !752
  br label %26, !dbg !2109

; <label>:17                                      ; preds = %11
  %18 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !2110
  %19 = load i32* %18, align 8, !dbg !2110, !tbaa !855
  %20 = tail call i64 (i64, ...)* @syscall(i64 138, i32 %19, %struct.statfs* %buf) #5, !dbg !2110
  %21 = trunc i64 %20 to i32, !dbg !2110
  tail call void @llvm.dbg.value(metadata !{i32 %21}, i64 0, metadata !507), !dbg !2110
  %22 = icmp eq i32 %21, -1, !dbg !2111
  br i1 %22, label %23, label %26, !dbg !2111

; <label>:23                                      ; preds = %17
  %24 = tail call i32 @klee_get_errno() #5, !dbg !2113
  %25 = tail call i32* @__errno_location() #1, !dbg !2113
  store i32 %24, i32* %25, align 4, !dbg !2113, !tbaa !752
  br label %26, !dbg !2113

; <label>:26                                      ; preds = %17, %23, %15, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %15 ], [ -1, %__get_file.exit.thread ], [ -1, %23 ], [ %21, %17 ]
  ret i32 %.0, !dbg !2114
}

; Function Attrs: nounwind ssp uwtable
define i32 @fsync(i32 %fd) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !512), !dbg !2115
  tail call void @llvm.dbg.value(metadata !{i32 %fd}, i64 0, metadata !2116), !dbg !2118
  %1 = icmp ult i32 %fd, 32, !dbg !2119
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !2119

; <label>:2                                       ; preds = %0
  %3 = sext i32 %fd to i64, !dbg !2120
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !2121
  %5 = load i32* %4, align 4, !dbg !2121, !tbaa !765
  %6 = and i32 %5, 1, !dbg !2121
  %7 = icmp eq i32 %6, 0, !dbg !2121
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !2121

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !2120
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !513), !dbg !2117
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !2122
  br i1 %9, label %__get_file.exit.thread, label %11, !dbg !2122

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %10 = tail call i32* @__errno_location() #1, !dbg !2123
  store i32 9, i32* %10, align 4, !dbg !2123, !tbaa !752
  br label %24, !dbg !2125

; <label>:11                                      ; preds = %__get_file.exit
  %12 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 3, !dbg !2126
  %13 = load %struct.exe_disk_file_t** %12, align 8, !dbg !2126, !tbaa !788
  %14 = icmp eq %struct.exe_disk_file_t* %13, null, !dbg !2126
  br i1 %14, label %15, label %24, !dbg !2126

; <label>:15                                      ; preds = %11
  %16 = getelementptr inbounds %struct.exe_file_t* %8, i64 0, i32 0, !dbg !2127
  %17 = load i32* %16, align 8, !dbg !2127, !tbaa !855
  %18 = tail call i64 (i64, ...)* @syscall(i64 74, i32 %17) #5, !dbg !2127
  %19 = trunc i64 %18 to i32, !dbg !2127
  tail call void @llvm.dbg.value(metadata !{i32 %19}, i64 0, metadata !514), !dbg !2127
  %20 = icmp eq i32 %19, -1, !dbg !2128
  br i1 %20, label %21, label %24, !dbg !2128

; <label>:21                                      ; preds = %15
  %22 = tail call i32 @klee_get_errno() #5, !dbg !2130
  %23 = tail call i32* @__errno_location() #1, !dbg !2130
  store i32 %22, i32* %23, align 4, !dbg !2130, !tbaa !752
  br label %24, !dbg !2130

; <label>:24                                      ; preds = %15, %21, %11, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %__get_file.exit.thread ], [ 0, %11 ], [ -1, %21 ], [ %19, %15 ]
  ret i32 %.0, !dbg !2131
}

; Function Attrs: nounwind ssp uwtable
define i32 @dup2(i32 %oldfd, i32 %newfd) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %oldfd}, i64 0, metadata !520), !dbg !2132
  tail call void @llvm.dbg.value(metadata !{i32 %newfd}, i64 0, metadata !521), !dbg !2132
  tail call void @llvm.dbg.value(metadata !{i32 %oldfd}, i64 0, metadata !2133), !dbg !2135
  %1 = icmp ult i32 %oldfd, 32, !dbg !2136
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !2136

; <label>:2                                       ; preds = %0
  %3 = sext i32 %oldfd to i64, !dbg !2137
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !2138
  %5 = load i32* %4, align 4, !dbg !2138, !tbaa !765
  %6 = and i32 %5, 1, !dbg !2138
  %7 = icmp eq i32 %6, 0, !dbg !2138
  br i1 %7, label %__get_file.exit.thread, label %__get_file.exit, !dbg !2138

__get_file.exit:                                  ; preds = %2
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !2137
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %8}, i64 0, metadata !522), !dbg !2134
  %9 = icmp ne %struct.exe_file_t* %8, null, !dbg !2139
  %10 = icmp sgt i32 %newfd, -1, !dbg !2139
  %or.cond = and i1 %9, %10, !dbg !2139
  %11 = icmp slt i32 %newfd, 32, !dbg !2139
  %or.cond3 = and i1 %or.cond, %11, !dbg !2139
  br i1 %or.cond3, label %13, label %__get_file.exit.thread, !dbg !2139

__get_file.exit.thread:                           ; preds = %0, %2, %__get_file.exit
  %12 = tail call i32* @__errno_location() #1, !dbg !2140
  store i32 9, i32* %12, align 4, !dbg !2140, !tbaa !752
  br label %42, !dbg !2142

; <label>:13                                      ; preds = %__get_file.exit
  %14 = sext i32 %newfd to i64, !dbg !2143
  %15 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %14, !dbg !2143
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %15}, i64 0, metadata !523), !dbg !2143
  %16 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %14, i32 1, !dbg !2144
  %17 = load i32* %16, align 4, !dbg !2144, !tbaa !765
  %18 = and i32 %17, 1, !dbg !2144
  %19 = icmp eq i32 %18, 0, !dbg !2144
  br i1 %19, label %close.exit, label %20, !dbg !2144

; <label>:20                                      ; preds = %13
  tail call void @llvm.dbg.value(metadata !{i32 %newfd}, i64 0, metadata !2146) #5, !dbg !2147
  tail call void @llvm.dbg.value(metadata !22, i64 0, metadata !2148) #5, !dbg !2149
  %21 = load i32* @close.n_calls, align 4, !dbg !2150, !tbaa !752
  %22 = add nsw i32 %21, 1, !dbg !2150
  store i32 %22, i32* @close.n_calls, align 4, !dbg !2150, !tbaa !752
  tail call void @llvm.dbg.value(metadata !{i32 %newfd}, i64 0, metadata !2151) #5, !dbg !2153
  %23 = icmp ugt i32 %newfd, 31, !dbg !2154
  %24 = icmp eq %struct.exe_file_t* %15, null, !dbg !2155
  %or.cond8 = or i1 %23, %24, !dbg !2154
  tail call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %15}, i64 0, metadata !2156) #5, !dbg !2152
  br i1 %or.cond8, label %__get_file.exit.thread.i, label %26, !dbg !2154

__get_file.exit.thread.i:                         ; preds = %20
  %25 = tail call i32* @__errno_location() #1, !dbg !2157
  store i32 9, i32* %25, align 4, !dbg !2157, !tbaa !752
  br label %close.exit, !dbg !2158

; <label>:26                                      ; preds = %20
  %27 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !2159, !tbaa !1096
  %28 = icmp eq i32 %27, 0, !dbg !2159
  br i1 %28, label %36, label %29, !dbg !2159

; <label>:29                                      ; preds = %26
  %30 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 8), align 8, !dbg !2159, !tbaa !1097
  %31 = load i32* %30, align 4, !dbg !2159, !tbaa !752
  %32 = icmp eq i32 %31, %22, !dbg !2159
  br i1 %32, label %33, label %36, !dbg !2159

; <label>:33                                      ; preds = %29
  %34 = add i32 %27, -1, !dbg !2160
  store i32 %34, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !2160, !tbaa !1096
  %35 = tail call i32* @__errno_location() #1, !dbg !2161
  store i32 5, i32* %35, align 4, !dbg !2161, !tbaa !752
  br label %close.exit, !dbg !2162

; <label>:36                                      ; preds = %29, %26
  %37 = bitcast %struct.exe_file_t* %15 to i8*, !dbg !2163
  tail call void @llvm.memset.p0i8.i64(i8* %37, i8 0, i64 24, i32 8, i1 false) #5, !dbg !2163
  br label %close.exit, !dbg !2164

close.exit:                                       ; preds = %36, %33, %__get_file.exit.thread.i, %13
  %38 = bitcast %struct.exe_file_t* %15 to i8*, !dbg !2165
  %39 = bitcast %struct.exe_file_t* %8 to i8*, !dbg !2165
  tail call void @llvm.memcpy.p0i8.p0i8.i64(i8* %38, i8* %39, i64 24, i32 8, i1 false), !dbg !2165, !tbaa.struct !2166
  %40 = load i32* %16, align 4, !dbg !2169, !tbaa !765
  %41 = and i32 %40, -3, !dbg !2169
  store i32 %41, i32* %16, align 4, !dbg !2169, !tbaa !765
  br label %42, !dbg !2170

; <label>:42                                      ; preds = %close.exit, %__get_file.exit.thread
  %.0 = phi i32 [ %newfd, %close.exit ], [ -1, %__get_file.exit.thread ]
  ret i32 %.0, !dbg !2171
}

; Function Attrs: nounwind ssp uwtable
define i32 @dup(i32 %oldfd) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %oldfd}, i64 0, metadata !528), !dbg !2172
  tail call void @llvm.dbg.value(metadata !{i32 %oldfd}, i64 0, metadata !2173), !dbg !2175
  %1 = icmp ult i32 %oldfd, 32, !dbg !2176
  br i1 %1, label %2, label %__get_file.exit.thread, !dbg !2176

; <label>:2                                       ; preds = %0
  %3 = sext i32 %oldfd to i64, !dbg !2177
  %4 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, i32 1, !dbg !2178
  %5 = load i32* %4, align 4, !dbg !2178, !tbaa !765
  %6 = and i32 %5, 1, !dbg !2178
  %7 = icmp eq i32 %6, 0, !dbg !2178
  %8 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %3, !dbg !2177
  %9 = icmp eq %struct.exe_file_t* %8, null, !dbg !2179
  %or.cond = or i1 %7, %9, !dbg !2178
  br i1 %or.cond, label %__get_file.exit.thread, label %.preheader, !dbg !2178

__get_file.exit.thread:                           ; preds = %0, %2
  %10 = tail call i32* @__errno_location() #1, !dbg !2180
  store i32 9, i32* %10, align 4, !dbg !2180, !tbaa !752
  br label %25, !dbg !2182

; <label>:11                                      ; preds = %.preheader
  %12 = trunc i64 %indvars.iv.next to i32, !dbg !2183
  %13 = icmp slt i32 %12, 32, !dbg !2183
  br i1 %13, label %.preheader, label %19, !dbg !2183

.preheader:                                       ; preds = %2, %11
  %indvars.iv = phi i64 [ %indvars.iv.next, %11 ], [ 0, %2 ]
  %fd.02 = phi i32 [ %18, %11 ], [ 0, %2 ]
  %14 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, i32 1, !dbg !2185
  %15 = load i32* %14, align 4, !dbg !2185, !tbaa !765
  %16 = and i32 %15, 1, !dbg !2185
  %17 = icmp eq i32 %16, 0, !dbg !2185
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !2183
  %18 = add nsw i32 %fd.02, 1, !dbg !2183
  tail call void @llvm.dbg.value(metadata !{i32 %18}, i64 0, metadata !530), !dbg !2183
  br i1 %17, label %19, label %11, !dbg !2185

; <label>:19                                      ; preds = %.preheader, %11
  %fd.0.lcssa = phi i32 [ %fd.02, %.preheader ], [ %18, %11 ]
  %20 = icmp eq i32 %fd.0.lcssa, 32, !dbg !2187
  br i1 %20, label %21, label %23, !dbg !2187

; <label>:21                                      ; preds = %19
  %22 = tail call i32* @__errno_location() #1, !dbg !2189
  store i32 24, i32* %22, align 4, !dbg !2189, !tbaa !752
  br label %25, !dbg !2191

; <label>:23                                      ; preds = %19
  %24 = tail call i32 @dup2(i32 %oldfd, i32 %fd.0.lcssa) #5, !dbg !2192
  br label %25, !dbg !2192

; <label>:25                                      ; preds = %23, %21, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %21 ], [ %24, %23 ], [ -1, %__get_file.exit.thread ]
  ret i32 %.0, !dbg !2194
}

; Function Attrs: nounwind ssp uwtable
define i32 @rmdir(i8* nocapture readonly %pathname) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !535), !dbg !2195
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !2196), !dbg !2198
  %1 = load i8* %pathname, align 1, !dbg !2199, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !2200), !dbg !2199
  %2 = sext i8 %1 to i32, !dbg !2201
  %3 = icmp eq i8 %1, 0, !dbg !2201
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !2201

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %pathname, i64 1, !dbg !2201
  %6 = load i8* %5, align 1, !dbg !2201, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2201
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !2201

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !2202, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !2202
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !2202

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !2202
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !2202

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !2203
  %12 = ashr exact i32 %sext.i, 24, !dbg !2203
  %13 = add nsw i32 %12, 65, !dbg !2203
  %14 = icmp eq i32 %2, %13, !dbg !2203
  %15 = add i32 %i.02.i, 1, !dbg !2202
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !2204), !dbg !2202
  br i1 %14, label %16, label %10, !dbg !2203

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !2205
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !2205, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !2206
  %20 = load %struct.stat64** %19, align 8, !dbg !2206, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !2206
  %22 = load i64* %21, align 8, !dbg !2206, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !2206
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !2205
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !2207
  %or.cond = or i1 %23, %25, !dbg !2206
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !2206

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 3, !dbg !2209
  %28 = load i32* %27, align 4, !dbg !2209, !tbaa !805
  %29 = and i32 %28, 61440, !dbg !2209
  %30 = icmp eq i32 %29, 16384, !dbg !2209
  br i1 %30, label %31, label %32, !dbg !2209

; <label>:31                                      ; preds = %26
  store i64 0, i64* %21, align 8, !dbg !2212, !tbaa !713
  br label %35, !dbg !2214

; <label>:32                                      ; preds = %26
  %33 = tail call i32* @__errno_location() #1, !dbg !2215
  store i32 20, i32* %33, align 4, !dbg !2215, !tbaa !752
  br label %35, !dbg !2217

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @klee_warning(i8* getelementptr inbounds ([17 x i8]* @.str22, i64 0, i64 0)) #5, !dbg !2218
  %34 = tail call i32* @__errno_location() #1, !dbg !2219
  store i32 1, i32* %34, align 4, !dbg !2219, !tbaa !752
  br label %35, !dbg !2220

; <label>:35                                      ; preds = %__get_sym_file.exit.thread, %32, %31
  %.0 = phi i32 [ 0, %31 ], [ -1, %32 ], [ -1, %__get_sym_file.exit.thread ]
  ret i32 %.0, !dbg !2221
}

; Function Attrs: nounwind ssp uwtable
define i32 @unlink(i8* nocapture readonly %pathname) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !539), !dbg !2222
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !2223), !dbg !2225
  %1 = load i8* %pathname, align 1, !dbg !2226, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !2227), !dbg !2226
  %2 = sext i8 %1 to i32, !dbg !2228
  %3 = icmp eq i8 %1, 0, !dbg !2228
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !2228

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %pathname, i64 1, !dbg !2228
  %6 = load i8* %5, align 1, !dbg !2228, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2228
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !2228

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !2229, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !2229
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !2229

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !2229
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !2229

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !2230
  %12 = ashr exact i32 %sext.i, 24, !dbg !2230
  %13 = add nsw i32 %12, 65, !dbg !2230
  %14 = icmp eq i32 %2, %13, !dbg !2230
  %15 = add i32 %i.02.i, 1, !dbg !2229
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !2231), !dbg !2229
  br i1 %14, label %16, label %10, !dbg !2230

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !2232
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !2232, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !2233
  %20 = load %struct.stat64** %19, align 8, !dbg !2233, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !2233
  %22 = load i64* %21, align 8, !dbg !2233, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !2233
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !2232
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !2234
  %or.cond = or i1 %23, %25, !dbg !2233
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !2233

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 3, !dbg !2236
  %28 = load i32* %27, align 4, !dbg !2236, !tbaa !805
  %29 = and i32 %28, 61440, !dbg !2236
  %30 = icmp eq i32 %29, 32768, !dbg !2236
  br i1 %30, label %31, label %32, !dbg !2236

; <label>:31                                      ; preds = %26
  store i64 0, i64* %21, align 8, !dbg !2239, !tbaa !713
  br label %38, !dbg !2241

; <label>:32                                      ; preds = %26
  %33 = icmp eq i32 %29, 16384, !dbg !2242
  %34 = tail call i32* @__errno_location() #1, !dbg !2244
  br i1 %33, label %35, label %36, !dbg !2242

; <label>:35                                      ; preds = %32
  store i32 21, i32* %34, align 4, !dbg !2244, !tbaa !752
  br label %38, !dbg !2246

; <label>:36                                      ; preds = %32
  store i32 1, i32* %34, align 4, !dbg !2247, !tbaa !752
  br label %38, !dbg !2249

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @klee_warning(i8* getelementptr inbounds ([17 x i8]* @.str22, i64 0, i64 0)) #5, !dbg !2250
  %37 = tail call i32* @__errno_location() #1, !dbg !2251
  store i32 1, i32* %37, align 4, !dbg !2251, !tbaa !752
  br label %38, !dbg !2252

; <label>:38                                      ; preds = %__get_sym_file.exit.thread, %36, %35, %31
  %.0 = phi i32 [ 0, %31 ], [ -1, %35 ], [ -1, %36 ], [ -1, %__get_sym_file.exit.thread ]
  ret i32 %.0, !dbg !2253
}

; Function Attrs: nounwind ssp uwtable
define i32 @unlinkat(i32 %dirfd, i8* nocapture readonly %pathname, i32 %flags) #0 {
  tail call void @llvm.dbg.value(metadata !{i32 %dirfd}, i64 0, metadata !545), !dbg !2254
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !546), !dbg !2254
  tail call void @llvm.dbg.value(metadata !{i32 %flags}, i64 0, metadata !547), !dbg !2254
  tail call void @llvm.dbg.value(metadata !{i8* %pathname}, i64 0, metadata !2255), !dbg !2257
  %1 = load i8* %pathname, align 1, !dbg !2258, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !2259), !dbg !2258
  %2 = sext i8 %1 to i32, !dbg !2260
  %3 = icmp eq i8 %1, 0, !dbg !2260
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !2260

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %pathname, i64 1, !dbg !2260
  %6 = load i8* %5, align 1, !dbg !2260, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2260
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !2260

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !2261, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !2261
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !2261

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !2261
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !2261

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !2262
  %12 = ashr exact i32 %sext.i, 24, !dbg !2262
  %13 = add nsw i32 %12, 65, !dbg !2262
  %14 = icmp eq i32 %2, %13, !dbg !2262
  %15 = add i32 %i.02.i, 1, !dbg !2261
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !2263), !dbg !2261
  br i1 %14, label %16, label %10, !dbg !2262

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !2264
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !2264, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !2265
  %20 = load %struct.stat64** %19, align 8, !dbg !2265, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !2265
  %22 = load i64* %21, align 8, !dbg !2265, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !2265
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !2264
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !2266
  %or.cond = or i1 %23, %25, !dbg !2265
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !2265

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 3, !dbg !2268
  %28 = load i32* %27, align 4, !dbg !2268, !tbaa !805
  %29 = and i32 %28, 61440, !dbg !2268
  %30 = icmp eq i32 %29, 32768, !dbg !2268
  br i1 %30, label %31, label %32, !dbg !2268

; <label>:31                                      ; preds = %26
  store i64 0, i64* %21, align 8, !dbg !2271, !tbaa !713
  br label %38, !dbg !2273

; <label>:32                                      ; preds = %26
  %33 = icmp eq i32 %29, 16384, !dbg !2274
  %34 = tail call i32* @__errno_location() #1, !dbg !2276
  br i1 %33, label %35, label %36, !dbg !2274

; <label>:35                                      ; preds = %32
  store i32 21, i32* %34, align 4, !dbg !2276, !tbaa !752
  br label %38, !dbg !2278

; <label>:36                                      ; preds = %32
  store i32 1, i32* %34, align 4, !dbg !2279, !tbaa !752
  br label %38, !dbg !2281

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  tail call void @klee_warning(i8* getelementptr inbounds ([17 x i8]* @.str22, i64 0, i64 0)) #5, !dbg !2282
  %37 = tail call i32* @__errno_location() #1, !dbg !2283
  store i32 1, i32* %37, align 4, !dbg !2283, !tbaa !752
  br label %38, !dbg !2284

; <label>:38                                      ; preds = %__get_sym_file.exit.thread, %36, %35, %31
  %.0 = phi i32 [ 0, %31 ], [ -1, %35 ], [ -1, %36 ], [ -1, %__get_sym_file.exit.thread ]
  ret i32 %.0, !dbg !2285
}

; Function Attrs: alwaysinline inlinehint nounwind ssp uwtable
define i64 @readlink(i8* %path, i8* %buf, i64 %bufsize) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !553), !dbg !2286
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !554), !dbg !2286
  tail call void @llvm.dbg.value(metadata !{i64 %bufsize}, i64 0, metadata !555), !dbg !2286
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !2287), !dbg !2289
  %1 = load i8* %path, align 1, !dbg !2290, !tbaa !694
  tail call void @llvm.dbg.value(metadata !{i8 %1}, i64 0, metadata !2291), !dbg !2290
  %2 = sext i8 %1 to i32, !dbg !2292
  %3 = icmp eq i8 %1, 0, !dbg !2292
  br i1 %3, label %__get_sym_file.exit.thread, label %4, !dbg !2292

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !2292
  %6 = load i8* %5, align 1, !dbg !2292, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2292
  br i1 %7, label %.preheader.i, label %__get_sym_file.exit.thread, !dbg !2292

.preheader.i:                                     ; preds = %4
  %8 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 0), align 8, !dbg !2293, !tbaa !701
  %9 = icmp eq i32 %8, 0, !dbg !2293
  br i1 %9, label %__get_sym_file.exit.thread, label %.lr.ph.i, !dbg !2293

; <label>:10                                      ; preds = %.lr.ph.i
  %11 = icmp ult i32 %15, %8, !dbg !2293
  br i1 %11, label %.lr.ph.i, label %__get_sym_file.exit.thread, !dbg !2293

.lr.ph.i:                                         ; preds = %.preheader.i, %10
  %i.02.i = phi i32 [ %15, %10 ], [ 0, %.preheader.i ]
  %sext.i = shl i32 %i.02.i, 24, !dbg !2294
  %12 = ashr exact i32 %sext.i, 24, !dbg !2294
  %13 = add nsw i32 %12, 65, !dbg !2294
  %14 = icmp eq i32 %2, %13, !dbg !2294
  %15 = add i32 %i.02.i, 1, !dbg !2293
  tail call void @llvm.dbg.value(metadata !{i32 %15}, i64 0, metadata !2295), !dbg !2293
  br i1 %14, label %16, label %10, !dbg !2294

; <label>:16                                      ; preds = %.lr.ph.i
  %17 = zext i32 %i.02.i to i64, !dbg !2296
  %18 = load %struct.exe_disk_file_t** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 4), align 8, !dbg !2296, !tbaa !708
  %19 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, i32 2, !dbg !2297
  %20 = load %struct.stat64** %19, align 8, !dbg !2297, !tbaa !711
  %21 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 1, !dbg !2297
  %22 = load i64* %21, align 8, !dbg !2297, !tbaa !713
  %23 = icmp eq i64 %22, 0, !dbg !2297
  %24 = getelementptr inbounds %struct.exe_disk_file_t* %18, i64 %17, !dbg !2296
  %25 = icmp eq %struct.exe_disk_file_t* %24, null, !dbg !2298
  %or.cond = or i1 %23, %25, !dbg !2297
  br i1 %or.cond, label %__get_sym_file.exit.thread, label %26, !dbg !2297

; <label>:26                                      ; preds = %16
  %27 = getelementptr inbounds %struct.stat64* %20, i64 0, i32 3, !dbg !2299
  %28 = load i32* %27, align 4, !dbg !2299, !tbaa !805
  %29 = and i32 %28, 61440, !dbg !2299
  %30 = icmp eq i32 %29, 40960, !dbg !2299
  br i1 %30, label %31, label %45, !dbg !2299

; <label>:31                                      ; preds = %26
  store i8 %1, i8* %buf, align 1, !dbg !2302, !tbaa !694
  %32 = icmp ugt i64 %bufsize, 1, !dbg !2304
  br i1 %32, label %33, label %.thread2, !dbg !2304

; <label>:33                                      ; preds = %31
  %34 = getelementptr inbounds i8* %buf, i64 1, !dbg !2304
  store i8 46, i8* %34, align 1, !dbg !2304, !tbaa !694
  %35 = icmp ugt i64 %bufsize, 2, !dbg !2306
  br i1 %35, label %36, label %.thread2, !dbg !2306

; <label>:36                                      ; preds = %33
  %37 = getelementptr inbounds i8* %buf, i64 2, !dbg !2306
  store i8 108, i8* %37, align 1, !dbg !2306, !tbaa !694
  %38 = icmp ugt i64 %bufsize, 3, !dbg !2308
  br i1 %38, label %.thread1, label %.thread2, !dbg !2308

.thread1:                                         ; preds = %36
  %39 = getelementptr inbounds i8* %buf, i64 3, !dbg !2308
  store i8 110, i8* %39, align 1, !dbg !2308, !tbaa !694
  %40 = icmp ugt i64 %bufsize, 4, !dbg !2310
  br i1 %40, label %41, label %.thread2, !dbg !2310

; <label>:41                                      ; preds = %.thread1
  %42 = getelementptr inbounds i8* %buf, i64 4, !dbg !2310
  store i8 107, i8* %42, align 1, !dbg !2310, !tbaa !694
  br label %.thread2, !dbg !2310

.thread2:                                         ; preds = %33, %31, %36, %41, %.thread1
  %43 = icmp ugt i64 %bufsize, 5, !dbg !2312
  %44 = select i1 %43, i64 5, i64 %bufsize, !dbg !2312
  br label %55, !dbg !2312

; <label>:45                                      ; preds = %26
  %46 = tail call i32* @__errno_location() #1, !dbg !2313
  store i32 22, i32* %46, align 4, !dbg !2313, !tbaa !752
  br label %55, !dbg !2315

__get_sym_file.exit.thread:                       ; preds = %10, %.preheader.i, %16, %0, %4
  %47 = tail call i64 (i64, ...)* @syscall(i64 89, i8* %path, i8* %buf, i64 %bufsize) #5, !dbg !2316
  %48 = trunc i64 %47 to i32, !dbg !2316
  tail call void @llvm.dbg.value(metadata !{i32 %48}, i64 0, metadata !557), !dbg !2316
  %49 = icmp eq i32 %48, -1, !dbg !2317
  br i1 %49, label %50, label %53, !dbg !2317

; <label>:50                                      ; preds = %__get_sym_file.exit.thread
  %51 = tail call i32 @klee_get_errno() #5, !dbg !2319
  %52 = tail call i32* @__errno_location() #1, !dbg !2319
  store i32 %51, i32* %52, align 4, !dbg !2319, !tbaa !752
  br label %53, !dbg !2319

; <label>:53                                      ; preds = %50, %__get_sym_file.exit.thread
  %sext = shl i64 %47, 32, !dbg !2320
  %54 = ashr exact i64 %sext, 32, !dbg !2320
  br label %55, !dbg !2320

; <label>:55                                      ; preds = %53, %45, %.thread2
  %.0 = phi i64 [ %44, %.thread2 ], [ -1, %45 ], [ %54, %53 ]
  ret i64 %.0, !dbg !2321
}

; Function Attrs: nounwind ssp uwtable
define i32 @select(i32 %nfds, %struct.fd_set* %read, %struct.fd_set* %write, %struct.fd_set* %except, %struct.timeval* nocapture readnone %timeout) #0 {
  %in_read = alloca %struct.fd_set, align 8
  %in_write = alloca %struct.fd_set, align 8
  %in_except = alloca %struct.fd_set, align 8
  %os_read = alloca %struct.fd_set, align 8
  %os_write = alloca %struct.fd_set, align 8
  %os_except = alloca %struct.fd_set, align 8
  %tv = alloca %struct.timeval, align 8
  call void @llvm.dbg.value(metadata !{i32 %nfds}, i64 0, metadata !575), !dbg !2322
  call void @llvm.dbg.value(metadata !{%struct.fd_set* %read}, i64 0, metadata !576), !dbg !2322
  call void @llvm.dbg.value(metadata !{%struct.fd_set* %write}, i64 0, metadata !577), !dbg !2322
  call void @llvm.dbg.value(metadata !{%struct.fd_set* %except}, i64 0, metadata !578), !dbg !2323
  call void @llvm.dbg.value(metadata !{%struct.timeval* %timeout}, i64 0, metadata !579), !dbg !2323
  %1 = bitcast %struct.fd_set* %in_read to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %1) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %in_read}, metadata !580), !dbg !2324
  %2 = bitcast %struct.fd_set* %in_write to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %2) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %in_write}, metadata !581), !dbg !2324
  %3 = bitcast %struct.fd_set* %in_except to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %3) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %in_except}, metadata !582), !dbg !2324
  %4 = bitcast %struct.fd_set* %os_read to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %4) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %os_read}, metadata !583), !dbg !2324
  %5 = bitcast %struct.fd_set* %os_write to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %5) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %os_write}, metadata !584), !dbg !2324
  %6 = bitcast %struct.fd_set* %os_except to i8*, !dbg !2324
  call void @llvm.lifetime.start(i64 128, i8* %6) #5, !dbg !2324
  call void @llvm.dbg.declare(metadata !{%struct.fd_set* %os_except}, metadata !585), !dbg !2324
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !587), !dbg !2325
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !588), !dbg !2325
  %7 = icmp ne %struct.fd_set* %read, null, !dbg !2326
  br i1 %7, label %8, label %10, !dbg !2326

; <label>:8                                       ; preds = %0
  %9 = bitcast %struct.fd_set* %read to i8*, !dbg !2328
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %1, i8* %9, i64 128, i32 8, i1 false), !dbg !2328, !tbaa.struct !2330
  call void @llvm.memset.p0i8.i64(i8* %9, i8 0, i64 128, i32 1, i1 false), !dbg !2331
  br label %11, !dbg !2332

; <label>:10                                      ; preds = %0
  call void @llvm.memset.p0i8.i64(i8* %1, i8 0, i64 128, i32 8, i1 false), !dbg !2333
  br label %11

; <label>:11                                      ; preds = %10, %8
  %12 = icmp ne %struct.fd_set* %write, null, !dbg !2335
  br i1 %12, label %13, label %15, !dbg !2335

; <label>:13                                      ; preds = %11
  %14 = bitcast %struct.fd_set* %write to i8*, !dbg !2337
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %14, i64 128, i32 8, i1 false), !dbg !2337, !tbaa.struct !2330
  call void @llvm.memset.p0i8.i64(i8* %14, i8 0, i64 128, i32 1, i1 false), !dbg !2339
  br label %16, !dbg !2340

; <label>:15                                      ; preds = %11
  call void @llvm.memset.p0i8.i64(i8* %2, i8 0, i64 128, i32 8, i1 false), !dbg !2341
  br label %16

; <label>:16                                      ; preds = %15, %13
  %17 = icmp ne %struct.fd_set* %except, null, !dbg !2343
  br i1 %17, label %18, label %20, !dbg !2343

; <label>:18                                      ; preds = %16
  %19 = bitcast %struct.fd_set* %except to i8*, !dbg !2345
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %3, i8* %19, i64 128, i32 8, i1 false), !dbg !2345, !tbaa.struct !2330
  call void @llvm.memset.p0i8.i64(i8* %19, i8 0, i64 128, i32 1, i1 false), !dbg !2347
  br label %21, !dbg !2348

; <label>:20                                      ; preds = %16
  call void @llvm.memset.p0i8.i64(i8* %3, i8 0, i64 128, i32 8, i1 false), !dbg !2349
  br label %21

; <label>:21                                      ; preds = %20, %18
  call void @llvm.memset.p0i8.i64(i8* %4, i8 0, i64 128, i32 8, i1 false), !dbg !2351
  call void @llvm.memset.p0i8.i64(i8* %5, i8 0, i64 128, i32 8, i1 false), !dbg !2352
  call void @llvm.memset.p0i8.i64(i8* %6, i8 0, i64 128, i32 8, i1 false), !dbg !2353
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !586), !dbg !2354
  %22 = icmp sgt i32 %nfds, 0, !dbg !2354
  br i1 %22, label %.lr.ph12, label %.loopexit, !dbg !2354

.lr.ph12:                                         ; preds = %21, %127
  %indvars.iv14 = phi i64 [ %indvars.iv.next15, %127 ], [ 0, %21 ]
  %count.09 = phi i32 [ %count.1, %127 ], [ 0, %21 ]
  %os_nfds.08 = phi i32 [ %os_nfds.1, %127 ], [ 0, %21 ]
  %23 = trunc i64 %indvars.iv14 to i32, !dbg !2355
  %24 = sdiv i32 %23, 64, !dbg !2355
  %25 = sext i32 %24 to i64, !dbg !2355
  %26 = getelementptr inbounds %struct.fd_set* %in_read, i64 0, i32 0, i64 %25, !dbg !2355
  %27 = load i64* %26, align 8, !dbg !2355, !tbaa !2167
  %28 = and i32 %23, 63, !dbg !2355
  %29 = shl i32 1, %28, !dbg !2355
  %30 = sext i32 %29 to i64, !dbg !2355
  %31 = and i64 %27, %30, !dbg !2355
  %32 = icmp eq i64 %31, 0, !dbg !2355
  br i1 %32, label %33, label %43, !dbg !2355

; <label>:33                                      ; preds = %.lr.ph12
  %34 = getelementptr inbounds %struct.fd_set* %in_write, i64 0, i32 0, i64 %25, !dbg !2355
  %35 = load i64* %34, align 8, !dbg !2355, !tbaa !2167
  %36 = and i64 %35, %30, !dbg !2355
  %37 = icmp eq i64 %36, 0, !dbg !2355
  br i1 %37, label %38, label %43, !dbg !2355

; <label>:38                                      ; preds = %33
  %39 = getelementptr inbounds %struct.fd_set* %in_except, i64 0, i32 0, i64 %25, !dbg !2355
  %40 = load i64* %39, align 8, !dbg !2355, !tbaa !2167
  %41 = and i64 %40, %30, !dbg !2355
  %42 = icmp eq i64 %41, 0, !dbg !2355
  br i1 %42, label %127, label %43, !dbg !2355

; <label>:43                                      ; preds = %38, %33, %.lr.ph12
  tail call void @llvm.dbg.value(metadata !2356, i64 0, metadata !2357), !dbg !2359
  %44 = icmp ult i32 %23, 32, !dbg !2360
  br i1 %44, label %45, label %__get_file.exit.thread, !dbg !2360

; <label>:45                                      ; preds = %43
  %46 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv14, i32 1, !dbg !2361
  %47 = load i32* %46, align 4, !dbg !2361, !tbaa !765
  %48 = and i32 %47, 1, !dbg !2361
  %49 = icmp eq i32 %48, 0, !dbg !2361
  br i1 %49, label %__get_file.exit.thread, label %__get_file.exit, !dbg !2361

__get_file.exit:                                  ; preds = %45
  %50 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv14, !dbg !2362
  call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %50}, i64 0, metadata !589), !dbg !2358
  %51 = icmp eq %struct.exe_file_t* %50, null, !dbg !2363
  br i1 %51, label %__get_file.exit.thread, label %53, !dbg !2363

__get_file.exit.thread:                           ; preds = %43, %45, %__get_file.exit
  %52 = call i32* @__errno_location() #1, !dbg !2365
  store i32 9, i32* %52, align 4, !dbg !2365, !tbaa !752
  br label %.loopexit, !dbg !2367

; <label>:53                                      ; preds = %__get_file.exit
  %54 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv14, i32 3, !dbg !2368
  %55 = load %struct.exe_disk_file_t** %54, align 8, !dbg !2368, !tbaa !788
  %56 = icmp eq %struct.exe_disk_file_t* %55, null, !dbg !2368
  %57 = icmp ne i64 %31, 0, !dbg !2370
  br i1 %56, label %83, label %58, !dbg !2368

; <label>:58                                      ; preds = %53
  br i1 %57, label %59, label %63, !dbg !2370

; <label>:59                                      ; preds = %58
  %60 = getelementptr inbounds %struct.fd_set* %read, i64 0, i32 0, i64 %25, !dbg !2370
  %61 = load i64* %60, align 8, !dbg !2370, !tbaa !2167
  %62 = or i64 %61, %30, !dbg !2370
  store i64 %62, i64* %60, align 8, !dbg !2370, !tbaa !2167
  br label %63, !dbg !2370

; <label>:63                                      ; preds = %59, %58
  %64 = getelementptr inbounds %struct.fd_set* %in_write, i64 0, i32 0, i64 %25, !dbg !2373
  %65 = load i64* %64, align 8, !dbg !2373, !tbaa !2167
  %66 = and i64 %65, %30, !dbg !2373
  %67 = icmp eq i64 %66, 0, !dbg !2373
  br i1 %67, label %72, label %68, !dbg !2373

; <label>:68                                      ; preds = %63
  %69 = getelementptr inbounds %struct.fd_set* %write, i64 0, i32 0, i64 %25, !dbg !2373
  %70 = load i64* %69, align 8, !dbg !2373, !tbaa !2167
  %71 = or i64 %70, %30, !dbg !2373
  store i64 %71, i64* %69, align 8, !dbg !2373, !tbaa !2167
  br label %72, !dbg !2373

; <label>:72                                      ; preds = %63, %68
  %73 = getelementptr inbounds %struct.fd_set* %in_except, i64 0, i32 0, i64 %25, !dbg !2375
  %74 = load i64* %73, align 8, !dbg !2375, !tbaa !2167
  %75 = and i64 %74, %30, !dbg !2375
  %76 = icmp eq i64 %75, 0, !dbg !2375
  br i1 %76, label %81, label %77, !dbg !2375

; <label>:77                                      ; preds = %72
  %78 = getelementptr inbounds %struct.fd_set* %except, i64 0, i32 0, i64 %25, !dbg !2375
  %79 = load i64* %78, align 8, !dbg !2375, !tbaa !2167
  %80 = or i64 %79, %30, !dbg !2375
  store i64 %80, i64* %78, align 8, !dbg !2375, !tbaa !2167
  br label %81, !dbg !2375

; <label>:81                                      ; preds = %72, %77
  %82 = add nsw i32 %count.09, 1, !dbg !2377
  call void @llvm.dbg.value(metadata !{i32 %82}, i64 0, metadata !587), !dbg !2377
  br label %127, !dbg !2378

; <label>:83                                      ; preds = %53
  br i1 %57, label %84, label %95, !dbg !2379

; <label>:84                                      ; preds = %83
  %85 = getelementptr inbounds %struct.exe_file_t* %50, i64 0, i32 0, !dbg !2379
  %86 = load i32* %85, align 8, !dbg !2379, !tbaa !855
  %87 = and i32 %86, 63, !dbg !2379
  %88 = shl i32 1, %87, !dbg !2379
  %89 = sext i32 %88 to i64, !dbg !2379
  %90 = sdiv i32 %86, 64, !dbg !2379
  %91 = sext i32 %90 to i64, !dbg !2379
  %92 = getelementptr inbounds %struct.fd_set* %os_read, i64 0, i32 0, i64 %91, !dbg !2379
  %93 = load i64* %92, align 8, !dbg !2379, !tbaa !2167
  %94 = or i64 %89, %93, !dbg !2379
  store i64 %94, i64* %92, align 8, !dbg !2379, !tbaa !2167
  br label %95, !dbg !2379

; <label>:95                                      ; preds = %84, %83
  %96 = getelementptr inbounds %struct.fd_set* %in_write, i64 0, i32 0, i64 %25, !dbg !2382
  %97 = load i64* %96, align 8, !dbg !2382, !tbaa !2167
  %98 = and i64 %97, %30, !dbg !2382
  %99 = icmp eq i64 %98, 0, !dbg !2382
  br i1 %99, label %111, label %100, !dbg !2382

; <label>:100                                     ; preds = %95
  %101 = getelementptr inbounds %struct.exe_file_t* %50, i64 0, i32 0, !dbg !2382
  %102 = load i32* %101, align 8, !dbg !2382, !tbaa !855
  %103 = and i32 %102, 63, !dbg !2382
  %104 = shl i32 1, %103, !dbg !2382
  %105 = sext i32 %104 to i64, !dbg !2382
  %106 = sdiv i32 %102, 64, !dbg !2382
  %107 = sext i32 %106 to i64, !dbg !2382
  %108 = getelementptr inbounds %struct.fd_set* %os_write, i64 0, i32 0, i64 %107, !dbg !2382
  %109 = load i64* %108, align 8, !dbg !2382, !tbaa !2167
  %110 = or i64 %105, %109, !dbg !2382
  store i64 %110, i64* %108, align 8, !dbg !2382, !tbaa !2167
  br label %111, !dbg !2382

; <label>:111                                     ; preds = %95, %100
  %112 = getelementptr inbounds %struct.fd_set* %in_except, i64 0, i32 0, i64 %25, !dbg !2384
  %113 = load i64* %112, align 8, !dbg !2384, !tbaa !2167
  %114 = and i64 %113, %30, !dbg !2384
  %115 = icmp eq i64 %114, 0, !dbg !2384
  %.phi.trans.insert = getelementptr inbounds %struct.exe_file_t* %50, i64 0, i32 0
  %.pre = load i32* %.phi.trans.insert, align 8, !dbg !2386, !tbaa !855
  br i1 %115, label %._crit_edge16, label %116, !dbg !2384

; <label>:116                                     ; preds = %111
  %117 = and i32 %.pre, 63, !dbg !2384
  %118 = shl i32 1, %117, !dbg !2384
  %119 = sext i32 %118 to i64, !dbg !2384
  %120 = sdiv i32 %.pre, 64, !dbg !2384
  %121 = sext i32 %120 to i64, !dbg !2384
  %122 = getelementptr inbounds %struct.fd_set* %os_except, i64 0, i32 0, i64 %121, !dbg !2384
  %123 = load i64* %122, align 8, !dbg !2384, !tbaa !2167
  %124 = or i64 %119, %123, !dbg !2384
  store i64 %124, i64* %122, align 8, !dbg !2384, !tbaa !2167
  br label %._crit_edge16, !dbg !2384

._crit_edge16:                                    ; preds = %111, %116
  %125 = icmp slt i32 %.pre, %os_nfds.08, !dbg !2386
  %126 = add nsw i32 %.pre, 1, !dbg !2386
  call void @llvm.dbg.value(metadata !{i32 %126}, i64 0, metadata !588), !dbg !2386
  %os_nfds.0. = select i1 %125, i32 %os_nfds.08, i32 %126, !dbg !2386
  br label %127, !dbg !2386

; <label>:127                                     ; preds = %._crit_edge16, %38, %81
  %os_nfds.1 = phi i32 [ %os_nfds.08, %81 ], [ %os_nfds.08, %38 ], [ %os_nfds.0., %._crit_edge16 ]
  %count.1 = phi i32 [ %82, %81 ], [ %count.09, %38 ], [ %count.09, %._crit_edge16 ]
  %indvars.iv.next15 = add nuw nsw i64 %indvars.iv14, 1, !dbg !2354
  %128 = trunc i64 %indvars.iv.next15 to i32, !dbg !2354
  %129 = icmp slt i32 %128, %nfds, !dbg !2354
  br i1 %129, label %.lr.ph12, label %._crit_edge, !dbg !2354

._crit_edge:                                      ; preds = %127
  %130 = icmp sgt i32 %os_nfds.1, 0, !dbg !2388
  br i1 %130, label %131, label %.loopexit, !dbg !2388

; <label>:131                                     ; preds = %._crit_edge
  call void @llvm.dbg.declare(metadata !{%struct.timeval* %tv}, metadata !594), !dbg !2389
  %132 = bitcast %struct.timeval* %tv to i8*, !dbg !2389
  call void @llvm.memset.p0i8.i64(i8* %132, i8 0, i64 16, i32 8, i1 false), !dbg !2389
  %133 = call i64 (i64, ...)* @syscall(i64 23, i32 %os_nfds.1, %struct.fd_set* %os_read, %struct.fd_set* %os_write, %struct.fd_set* %os_except, %struct.timeval* %tv) #5, !dbg !2390
  %134 = trunc i64 %133 to i32, !dbg !2390
  call void @llvm.dbg.value(metadata !{i32 %134}, i64 0, metadata !597), !dbg !2390
  %135 = icmp eq i32 %134, -1, !dbg !2391
  br i1 %135, label %136, label %141, !dbg !2391

; <label>:136                                     ; preds = %131
  %137 = icmp eq i32 %count.1, 0, !dbg !2392
  br i1 %137, label %138, label %.loopexit, !dbg !2392

; <label>:138                                     ; preds = %136
  %139 = call i32 @klee_get_errno() #5, !dbg !2395
  %140 = call i32* @__errno_location() #1, !dbg !2395
  store i32 %139, i32* %140, align 4, !dbg !2395, !tbaa !752
  br label %.loopexit, !dbg !2397

; <label>:141                                     ; preds = %131
  %142 = add nsw i32 %134, %count.1, !dbg !2398
  call void @llvm.dbg.value(metadata !{i32 %142}, i64 0, metadata !587), !dbg !2398
  call void @llvm.dbg.value(metadata !22, i64 0, metadata !586), !dbg !2399
  br i1 %22, label %.lr.ph, label %.loopexit, !dbg !2399

.lr.ph:                                           ; preds = %141, %__get_file.exit3.thread
  %indvars.iv = phi i64 [ %indvars.iv.next, %__get_file.exit3.thread ], [ 0, %141 ]
  tail call void @llvm.dbg.value(metadata !2356, i64 0, metadata !2400), !dbg !2402
  %143 = trunc i64 %indvars.iv to i32, !dbg !2403
  %144 = icmp ult i32 %143, 32, !dbg !2403
  br i1 %144, label %145, label %__get_file.exit3.thread, !dbg !2403

; <label>:145                                     ; preds = %.lr.ph
  %146 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, i32 1, !dbg !2404
  %147 = load i32* %146, align 4, !dbg !2404, !tbaa !765
  %148 = and i32 %147, 1, !dbg !2404
  %149 = icmp eq i32 %148, 0, !dbg !2404
  br i1 %149, label %__get_file.exit3.thread, label %__get_file.exit3, !dbg !2404

__get_file.exit3:                                 ; preds = %145
  %150 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, !dbg !2405
  call void @llvm.dbg.value(metadata !{%struct.exe_file_t* %150}, i64 0, metadata !598), !dbg !2401
  %151 = icmp eq %struct.exe_file_t* %150, null, !dbg !2406
  br i1 %151, label %__get_file.exit3.thread, label %152, !dbg !2406

; <label>:152                                     ; preds = %__get_file.exit3
  %153 = getelementptr inbounds %struct.exe_sym_env_t* @__exe_env, i64 0, i32 0, i64 %indvars.iv, i32 3, !dbg !2406
  %154 = load %struct.exe_disk_file_t** %153, align 8, !dbg !2406, !tbaa !788
  %155 = icmp eq %struct.exe_disk_file_t* %154, null, !dbg !2406
  br i1 %155, label %156, label %__get_file.exit3.thread, !dbg !2406

; <label>:156                                     ; preds = %152
  br i1 %7, label %157, label %178, !dbg !2408

; <label>:157                                     ; preds = %156
  %158 = getelementptr inbounds %struct.exe_file_t* %150, i64 0, i32 0, !dbg !2408
  %159 = load i32* %158, align 8, !dbg !2408, !tbaa !855
  %160 = sdiv i32 %159, 64, !dbg !2408
  %161 = sext i32 %160 to i64, !dbg !2408
  %162 = getelementptr inbounds %struct.fd_set* %os_read, i64 0, i32 0, i64 %161, !dbg !2408
  %163 = load i64* %162, align 8, !dbg !2408, !tbaa !2167
  %164 = and i32 %159, 63, !dbg !2408
  %165 = shl i32 1, %164, !dbg !2408
  %166 = sext i32 %165 to i64, !dbg !2408
  %167 = and i64 %166, %163, !dbg !2408
  %168 = icmp eq i64 %167, 0, !dbg !2408
  br i1 %168, label %178, label %169, !dbg !2408

; <label>:169                                     ; preds = %157
  %170 = and i32 %143, 63, !dbg !2408
  %171 = shl i32 1, %170, !dbg !2408
  %172 = sext i32 %171 to i64, !dbg !2408
  %173 = sdiv i32 %143, 64, !dbg !2408
  %174 = sext i32 %173 to i64, !dbg !2408
  %175 = getelementptr inbounds %struct.fd_set* %read, i64 0, i32 0, i64 %174, !dbg !2408
  %176 = load i64* %175, align 8, !dbg !2408, !tbaa !2167
  %177 = or i64 %176, %172, !dbg !2408
  store i64 %177, i64* %175, align 8, !dbg !2408, !tbaa !2167
  br label %178, !dbg !2408

; <label>:178                                     ; preds = %157, %169, %156
  br i1 %12, label %179, label %200, !dbg !2411

; <label>:179                                     ; preds = %178
  %180 = getelementptr inbounds %struct.exe_file_t* %150, i64 0, i32 0, !dbg !2411
  %181 = load i32* %180, align 8, !dbg !2411, !tbaa !855
  %182 = sdiv i32 %181, 64, !dbg !2411
  %183 = sext i32 %182 to i64, !dbg !2411
  %184 = getelementptr inbounds %struct.fd_set* %os_write, i64 0, i32 0, i64 %183, !dbg !2411
  %185 = load i64* %184, align 8, !dbg !2411, !tbaa !2167
  %186 = and i32 %181, 63, !dbg !2411
  %187 = shl i32 1, %186, !dbg !2411
  %188 = sext i32 %187 to i64, !dbg !2411
  %189 = and i64 %188, %185, !dbg !2411
  %190 = icmp eq i64 %189, 0, !dbg !2411
  br i1 %190, label %200, label %191, !dbg !2411

; <label>:191                                     ; preds = %179
  %192 = and i32 %143, 63, !dbg !2411
  %193 = shl i32 1, %192, !dbg !2411
  %194 = sext i32 %193 to i64, !dbg !2411
  %195 = sdiv i32 %143, 64, !dbg !2411
  %196 = sext i32 %195 to i64, !dbg !2411
  %197 = getelementptr inbounds %struct.fd_set* %write, i64 0, i32 0, i64 %196, !dbg !2411
  %198 = load i64* %197, align 8, !dbg !2411, !tbaa !2167
  %199 = or i64 %198, %194, !dbg !2411
  store i64 %199, i64* %197, align 8, !dbg !2411, !tbaa !2167
  br label %200, !dbg !2411

; <label>:200                                     ; preds = %179, %191, %178
  br i1 %17, label %201, label %__get_file.exit3.thread, !dbg !2413

; <label>:201                                     ; preds = %200
  %202 = getelementptr inbounds %struct.exe_file_t* %150, i64 0, i32 0, !dbg !2413
  %203 = load i32* %202, align 8, !dbg !2413, !tbaa !855
  %204 = sdiv i32 %203, 64, !dbg !2413
  %205 = sext i32 %204 to i64, !dbg !2413
  %206 = getelementptr inbounds %struct.fd_set* %os_except, i64 0, i32 0, i64 %205, !dbg !2413
  %207 = load i64* %206, align 8, !dbg !2413, !tbaa !2167
  %208 = and i32 %203, 63, !dbg !2413
  %209 = shl i32 1, %208, !dbg !2413
  %210 = sext i32 %209 to i64, !dbg !2413
  %211 = and i64 %210, %207, !dbg !2413
  %212 = icmp eq i64 %211, 0, !dbg !2413
  br i1 %212, label %__get_file.exit3.thread, label %213, !dbg !2413

; <label>:213                                     ; preds = %201
  %214 = and i32 %143, 63, !dbg !2413
  %215 = shl i32 1, %214, !dbg !2413
  %216 = sext i32 %215 to i64, !dbg !2413
  %217 = sdiv i32 %143, 64, !dbg !2413
  %218 = sext i32 %217 to i64, !dbg !2413
  %219 = getelementptr inbounds %struct.fd_set* %except, i64 0, i32 0, i64 %218, !dbg !2413
  %220 = load i64* %219, align 8, !dbg !2413, !tbaa !2167
  %221 = or i64 %220, %216, !dbg !2413
  store i64 %221, i64* %219, align 8, !dbg !2413, !tbaa !2167
  br label %__get_file.exit3.thread, !dbg !2413

__get_file.exit3.thread:                          ; preds = %.lr.ph, %145, %201, %152, %__get_file.exit3, %213, %200
  %indvars.iv.next = add nuw nsw i64 %indvars.iv, 1, !dbg !2399
  %lftr.wideiv = trunc i64 %indvars.iv.next to i32, !dbg !2399
  %exitcond = icmp eq i32 %lftr.wideiv, %nfds, !dbg !2399
  br i1 %exitcond, label %.loopexit, label %.lr.ph, !dbg !2399

.loopexit:                                        ; preds = %__get_file.exit3.thread, %21, %141, %._crit_edge, %136, %138, %__get_file.exit.thread
  %.0 = phi i32 [ -1, %__get_file.exit.thread ], [ -1, %138 ], [ %count.1, %136 ], [ %count.1, %._crit_edge ], [ %142, %141 ], [ 0, %21 ], [ %142, %__get_file.exit3.thread ]
  call void @llvm.lifetime.end(i64 128, i8* %6) #5, !dbg !2415
  call void @llvm.lifetime.end(i64 128, i8* %5) #5, !dbg !2415
  call void @llvm.lifetime.end(i64 128, i8* %4) #5, !dbg !2415
  call void @llvm.lifetime.end(i64 128, i8* %3) #5, !dbg !2415
  call void @llvm.lifetime.end(i64 128, i8* %2) #5, !dbg !2415
  call void @llvm.lifetime.end(i64 128, i8* %1) #5, !dbg !2415
  ret i32 %.0, !dbg !2415
}

; Function Attrs: nounwind
declare void @llvm.lifetime.start(i64, i8* nocapture) #5

; Function Attrs: nounwind
declare void @llvm.lifetime.end(i64, i8* nocapture) #5

; Function Attrs: alwaysinline inlinehint nounwind ssp uwtable
define i8* @getcwd(i8* %buf, i64 %size) #6 {
  tail call void @llvm.dbg.value(metadata !{i8* %buf}, i64 0, metadata !607), !dbg !2416
  tail call void @llvm.dbg.value(metadata !{i64 %size}, i64 0, metadata !608), !dbg !2416
  %1 = load i32* @getcwd.n_calls, align 4, !dbg !2417, !tbaa !752
  %2 = add nsw i32 %1, 1, !dbg !2417
  store i32 %2, i32* @getcwd.n_calls, align 4, !dbg !2417, !tbaa !752
  %3 = load i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !2418, !tbaa !1096
  %4 = icmp eq i32 %3, 0, !dbg !2418
  br i1 %4, label %12, label %5, !dbg !2418

; <label>:5                                       ; preds = %0
  %6 = load i32** getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 10), align 8, !dbg !2418, !tbaa !2420
  %7 = load i32* %6, align 4, !dbg !2418, !tbaa !752
  %8 = icmp eq i32 %7, %2, !dbg !2418
  br i1 %8, label %9, label %12, !dbg !2418

; <label>:9                                       ; preds = %5
  %10 = add i32 %3, -1, !dbg !2421
  store i32 %10, i32* getelementptr inbounds (%struct.exe_file_system_t* @__exe_fs, i64 0, i32 5), align 8, !dbg !2421, !tbaa !1096
  %11 = tail call i32* @__errno_location() #1, !dbg !2423
  store i32 34, i32* %11, align 4, !dbg !2423, !tbaa !752
  br label %32, !dbg !2424

; <label>:12                                      ; preds = %0, %5
  %13 = icmp eq i8* %buf, null, !dbg !2425
  br i1 %13, label %14, label %17, !dbg !2425

; <label>:14                                      ; preds = %12
  %15 = icmp eq i64 %size, 0, !dbg !2427
  tail call void @llvm.dbg.value(metadata !2430, i64 0, metadata !608), !dbg !2431
  %.size = select i1 %15, i64 1024, i64 %size, !dbg !2427
  %16 = tail call noalias i8* @malloc(i64 %.size) #5, !dbg !2432
  tail call void @llvm.dbg.value(metadata !{i8* %16}, i64 0, metadata !607), !dbg !2432
  br label %17, !dbg !2433

; <label>:17                                      ; preds = %12, %14
  %.02 = phi i8* [ %buf, %12 ], [ %16, %14 ]
  %.1 = phi i64 [ %size, %12 ], [ %.size, %14 ]
  tail call void @llvm.dbg.value(metadata !{i8* %.02}, i64 0, metadata !2434) #5, !dbg !2436
  %18 = ptrtoint i8* %.02 to i64, !dbg !2437
  %19 = tail call i64 @klee_get_valuel(i64 %18) #5, !dbg !2437
  %20 = inttoptr i64 %19 to i8*, !dbg !2437
  tail call void @llvm.dbg.value(metadata !{i8* %20}, i64 0, metadata !2438) #5, !dbg !2437
  %21 = icmp eq i8* %20, %.02, !dbg !2439
  %22 = zext i1 %21 to i64, !dbg !2439
  tail call void @klee_assume(i64 %22) #5, !dbg !2439
  tail call void @llvm.dbg.value(metadata !{i8* %20}, i64 0, metadata !607), !dbg !2435
  tail call void @llvm.dbg.value(metadata !{i64 %.1}, i64 0, metadata !2440) #5, !dbg !2442
  %23 = tail call i64 @klee_get_valuel(i64 %.1) #5, !dbg !2443
  tail call void @llvm.dbg.value(metadata !{i64 %23}, i64 0, metadata !2444) #5, !dbg !2443
  %24 = icmp eq i64 %23, %.1, !dbg !2445
  %25 = zext i1 %24 to i64, !dbg !2445
  tail call void @klee_assume(i64 %25) #5, !dbg !2445
  tail call void @llvm.dbg.value(metadata !{i64 %23}, i64 0, metadata !608), !dbg !2441
  tail call void @klee_check_memory_access(i8* %20, i64 %23) #5, !dbg !2446
  %26 = tail call i64 (i64, ...)* @syscall(i64 79, i8* %20, i64 %23) #5, !dbg !2447
  %27 = trunc i64 %26 to i32, !dbg !2447
  tail call void @llvm.dbg.value(metadata !{i32 %27}, i64 0, metadata !609), !dbg !2447
  %28 = icmp eq i32 %27, -1, !dbg !2448
  br i1 %28, label %29, label %32, !dbg !2448

; <label>:29                                      ; preds = %17
  %30 = tail call i32 @klee_get_errno() #5, !dbg !2450
  %31 = tail call i32* @__errno_location() #1, !dbg !2450
  store i32 %30, i32* %31, align 4, !dbg !2450, !tbaa !752
  br label %32, !dbg !2452

; <label>:32                                      ; preds = %17, %29, %9
  %.0 = phi i8* [ null, %9 ], [ null, %29 ], [ %20, %17 ]
  ret i8* %.0, !dbg !2453
}

; Function Attrs: nounwind
declare noalias i8* @malloc(i64) #2

; Function Attrs: nounwind ssp uwtable
define i32 @chroot(i8* nocapture readonly %path) #0 {
  tail call void @llvm.dbg.value(metadata !{i8* %path}, i64 0, metadata !612), !dbg !2454
  %1 = load i8* %path, align 1, !dbg !2455, !tbaa !694
  switch i8 %1, label %8 [
    i8 0, label %2
    i8 47, label %4
  ], !dbg !2455

; <label>:2                                       ; preds = %0
  %3 = tail call i32* @__errno_location() #1, !dbg !2457
  store i32 2, i32* %3, align 4, !dbg !2457, !tbaa !752
  br label %10, !dbg !2459

; <label>:4                                       ; preds = %0
  %5 = getelementptr inbounds i8* %path, i64 1, !dbg !2460
  %6 = load i8* %5, align 1, !dbg !2460, !tbaa !694
  %7 = icmp eq i8 %6, 0, !dbg !2460
  br i1 %7, label %10, label %8, !dbg !2460

; <label>:8                                       ; preds = %0, %4
  tail call void @klee_warning(i8* getelementptr inbounds ([18 x i8]* @.str23, i64 0, i64 0)) #5, !dbg !2462
  %9 = tail call i32* @__errno_location() #1, !dbg !2463
  store i32 2, i32* %9, align 4, !dbg !2463, !tbaa !752
  br label %10, !dbg !2464

; <label>:10                                      ; preds = %4, %8, %2
  %.0 = phi i32 [ -1, %2 ], [ -1, %8 ], [ 0, %4 ]
  ret i32 %.0, !dbg !2465
}

declare i64 @klee_get_valuel(i64) #3

declare void @klee_assume(i64) #3

; Function Attrs: nounwind
declare i32 @geteuid() #2

; Function Attrs: nounwind
declare i32 @getgid() #2

; Function Attrs: nounwind readnone
declare void @llvm.dbg.value(metadata, i64, metadata) #1

attributes #0 = { nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #4 = { nounwind readnone "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #5 = { nounwind }
attributes #6 = { alwaysinline inlinehint nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #7 = { noreturn nounwind "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #8 = { inlinehint nounwind ssp uwtable "less-precise-fpmad"="false" "no-frame-pointer-elim"="false" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "stack-protector-buffer-size"="4" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #9 = { noreturn nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!686, !687}
!llvm.ident = !{!688}

!0 = metadata !{i32 786449, metadata !1, i32 1, metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)", i1 true, metadata !"", i32 0, metadata !2, metadata !22, metadata !23, metadata !678, metadata !22, metadata !""} ; [ DW_TAG_compile_unit ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX//home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c] [DW_LANG_C89]
!1 = metadata !{metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!2 = metadata !{metadata !3, metadata !10}
!3 = metadata !{i32 786436, metadata !4, null, metadata !"", i32 26, i64 32, i64 32, i32 0, i32 0, null, metadata !5, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 26, size 32, align 32, offset 0] [def] [from ]
!4 = metadata !{metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!5 = metadata !{metadata !6, metadata !7, metadata !8, metadata !9}
!6 = metadata !{i32 786472, metadata !"eOpen", i64 1} ; [ DW_TAG_enumerator ] [eOpen :: 1]
!7 = metadata !{i32 786472, metadata !"eCloseOnExec", i64 2} ; [ DW_TAG_enumerator ] [eCloseOnExec :: 2]
!8 = metadata !{i32 786472, metadata !"eReadable", i64 4} ; [ DW_TAG_enumerator ] [eReadable :: 4]
!9 = metadata !{i32 786472, metadata !"eWriteable", i64 8} ; [ DW_TAG_enumerator ] [eWriteable :: 8]
!10 = metadata !{i32 786436, metadata !11, null, metadata !"", i32 97, i64 32, i64 32, i32 0, i32 0, null, metadata !12, i32 0, null, null, null} ; [ DW_TAG_enumeration_type ] [line 97, size 32, align 32, offset 0] [def] [from ]
!11 = metadata !{metadata !"/usr/include/dirent.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!12 = metadata !{metadata !13, metadata !14, metadata !15, metadata !16, metadata !17, metadata !18, metadata !19, metadata !20, metadata !21}
!13 = metadata !{i32 786472, metadata !"DT_UNKNOWN", i64 0} ; [ DW_TAG_enumerator ] [DT_UNKNOWN :: 0]
!14 = metadata !{i32 786472, metadata !"DT_FIFO", i64 1} ; [ DW_TAG_enumerator ] [DT_FIFO :: 1]
!15 = metadata !{i32 786472, metadata !"DT_CHR", i64 2} ; [ DW_TAG_enumerator ] [DT_CHR :: 2]
!16 = metadata !{i32 786472, metadata !"DT_DIR", i64 4} ; [ DW_TAG_enumerator ] [DT_DIR :: 4]
!17 = metadata !{i32 786472, metadata !"DT_BLK", i64 6} ; [ DW_TAG_enumerator ] [DT_BLK :: 6]
!18 = metadata !{i32 786472, metadata !"DT_REG", i64 8} ; [ DW_TAG_enumerator ] [DT_REG :: 8]
!19 = metadata !{i32 786472, metadata !"DT_LNK", i64 10} ; [ DW_TAG_enumerator ] [DT_LNK :: 10]
!20 = metadata !{i32 786472, metadata !"DT_SOCK", i64 12} ; [ DW_TAG_enumerator ] [DT_SOCK :: 12]
!21 = metadata !{i32 786472, metadata !"DT_WHT", i64 14} ; [ DW_TAG_enumerator ] [DT_WHT :: 14]
!22 = metadata !{i32 0}
!23 = metadata !{metadata !24, metadata !89, metadata !96, metadata !119, metadata !133, metadata !149, metadata !160, metadata !167, metadata !182, metadata !197, metadata !206, metadata !215, metadata !248, metadata !255, metadata !263, metadata !270, metadata !280, metadata !290, metadata !303, metadata !314, metadata !323, metadata !333, metadata !343, metadata !384, metadata !445, metadata !461, metadata !500, metadata !510, metadata !518, metadata !526, metadata !533, metadata !537, metadata !541, metadata !549, metadata !560, metadata !603, metadata !610, metadata !613, metadata !626, metadata !632, metadata !638, metadata !645, metadata !651, metadata !659, metadata !666}
!24 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"access", metadata !"access", metadata !"", i32 73, metadata !27, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32)* @access, null, null, metadata !33, i32 73} ; [ DW_TAG_subprogram ] [line 73] [def] [access]
!25 = metadata !{metadata !"fd.c", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!26 = metadata !{i32 786473, metadata !25}        ; [ DW_TAG_file_type ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!27 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !28, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!28 = metadata !{metadata !29, metadata !30, metadata !29}
!29 = metadata !{i32 786468, null, null, metadata !"int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [int] [line 0, size 32, align 32, offset 0, enc DW_ATE_signed]
!30 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !31} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!31 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !32} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from char]
!32 = metadata !{i32 786468, null, null, metadata !"char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 6} ; [ DW_TAG_base_type ] [char] [line 0, size 8, align 8, offset 0, enc DW_ATE_signed_char]
!33 = metadata !{metadata !34, metadata !35, metadata !36, metadata !86}
!34 = metadata !{i32 786689, metadata !24, metadata !"pathname", metadata !26, i32 16777289, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 73]
!35 = metadata !{i32 786689, metadata !24, metadata !"mode", metadata !26, i32 33554505, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 73]
!36 = metadata !{i32 786688, metadata !24, metadata !"dfile", metadata !26, i32 74, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 74]
!37 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !38} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from exe_disk_file_t]
!38 = metadata !{i32 786454, metadata !25, null, metadata !"exe_disk_file_t", i32 24, i64 0, i64 0, i64 0, i32 0, metadata !39} ; [ DW_TAG_typedef ] [exe_disk_file_t] [line 24, size 0, align 0, offset 0] [from ]
!39 = metadata !{i32 786451, metadata !4, null, metadata !"", i32 20, i64 192, i64 64, i32 0, i32 0, null, metadata !40, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 20, size 192, align 64, offset 0] [def] [from ]
!40 = metadata !{metadata !41, metadata !43, metadata !45}
!41 = metadata !{i32 786445, metadata !4, metadata !39, metadata !"size", i32 21, i64 32, i64 32, i64 0, i32 0, metadata !42} ; [ DW_TAG_member ] [size] [line 21, size 32, align 32, offset 0] [from unsigned int]
!42 = metadata !{i32 786468, null, null, metadata !"unsigned int", i32 0, i64 32, i64 32, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned int] [line 0, size 32, align 32, offset 0, enc DW_ATE_unsigned]
!43 = metadata !{i32 786445, metadata !4, metadata !39, metadata !"contents", i32 22, i64 64, i64 64, i64 64, i32 0, metadata !44} ; [ DW_TAG_member ] [contents] [line 22, size 64, align 64, offset 64] [from ]
!44 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !32} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from char]
!45 = metadata !{i32 786445, metadata !4, metadata !39, metadata !"stat", i32 23, i64 64, i64 64, i64 128, i32 0, metadata !46} ; [ DW_TAG_member ] [stat] [line 23, size 64, align 64, offset 128] [from ]
!46 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !47} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stat64]
!47 = metadata !{i32 786451, metadata !48, null, metadata !"stat64", i32 119, i64 1152, i64 64, i32 0, i32 0, null, metadata !49, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stat64] [line 119, size 1152, align 64, offset 0] [def] [from ]
!48 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/stat.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!49 = metadata !{metadata !50, metadata !53, metadata !55, metadata !57, metadata !59, metadata !61, metadata !63, metadata !64, metadata !65, metadata !68, metadata !70, metadata !72, metadata !80, metadata !81, metadata !82}
!50 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_dev", i32 121, i64 64, i64 64, i64 0, i32 0, metadata !51} ; [ DW_TAG_member ] [st_dev] [line 121, size 64, align 64, offset 0] [from __dev_t]
!51 = metadata !{i32 786454, metadata !48, null, metadata !"__dev_t", i32 124, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__dev_t] [line 124, size 0, align 0, offset 0] [from long unsigned int]
!52 = metadata !{i32 786468, null, null, metadata !"long unsigned int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [long unsigned int] [line 0, size 64, align 64, offset 0, enc DW_ATE_unsigned]
!53 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_ino", i32 123, i64 64, i64 64, i64 64, i32 0, metadata !54} ; [ DW_TAG_member ] [st_ino] [line 123, size 64, align 64, offset 64] [from __ino64_t]
!54 = metadata !{i32 786454, metadata !48, null, metadata !"__ino64_t", i32 128, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__ino64_t] [line 128, size 0, align 0, offset 0] [from long unsigned int]
!55 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_nlink", i32 124, i64 64, i64 64, i64 128, i32 0, metadata !56} ; [ DW_TAG_member ] [st_nlink] [line 124, size 64, align 64, offset 128] [from __nlink_t]
!56 = metadata !{i32 786454, metadata !48, null, metadata !"__nlink_t", i32 130, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__nlink_t] [line 130, size 0, align 0, offset 0] [from long unsigned int]
!57 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_mode", i32 125, i64 32, i64 32, i64 192, i32 0, metadata !58} ; [ DW_TAG_member ] [st_mode] [line 125, size 32, align 32, offset 192] [from __mode_t]
!58 = metadata !{i32 786454, metadata !48, null, metadata !"__mode_t", i32 129, i64 0, i64 0, i64 0, i32 0, metadata !42} ; [ DW_TAG_typedef ] [__mode_t] [line 129, size 0, align 0, offset 0] [from unsigned int]
!59 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_uid", i32 132, i64 32, i64 32, i64 224, i32 0, metadata !60} ; [ DW_TAG_member ] [st_uid] [line 132, size 32, align 32, offset 224] [from __uid_t]
!60 = metadata !{i32 786454, metadata !48, null, metadata !"__uid_t", i32 125, i64 0, i64 0, i64 0, i32 0, metadata !42} ; [ DW_TAG_typedef ] [__uid_t] [line 125, size 0, align 0, offset 0] [from unsigned int]
!61 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_gid", i32 133, i64 32, i64 32, i64 256, i32 0, metadata !62} ; [ DW_TAG_member ] [st_gid] [line 133, size 32, align 32, offset 256] [from __gid_t]
!62 = metadata !{i32 786454, metadata !48, null, metadata !"__gid_t", i32 126, i64 0, i64 0, i64 0, i32 0, metadata !42} ; [ DW_TAG_typedef ] [__gid_t] [line 126, size 0, align 0, offset 0] [from unsigned int]
!63 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"__pad0", i32 135, i64 32, i64 32, i64 288, i32 0, metadata !29} ; [ DW_TAG_member ] [__pad0] [line 135, size 32, align 32, offset 288] [from int]
!64 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_rdev", i32 136, i64 64, i64 64, i64 320, i32 0, metadata !51} ; [ DW_TAG_member ] [st_rdev] [line 136, size 64, align 64, offset 320] [from __dev_t]
!65 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_size", i32 137, i64 64, i64 64, i64 384, i32 0, metadata !66} ; [ DW_TAG_member ] [st_size] [line 137, size 64, align 64, offset 384] [from __off_t]
!66 = metadata !{i32 786454, metadata !48, null, metadata !"__off_t", i32 131, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__off_t] [line 131, size 0, align 0, offset 0] [from long int]
!67 = metadata !{i32 786468, null, null, metadata !"long int", i32 0, i64 64, i64 64, i64 0, i32 0, i32 5} ; [ DW_TAG_base_type ] [long int] [line 0, size 64, align 64, offset 0, enc DW_ATE_signed]
!68 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_blksize", i32 143, i64 64, i64 64, i64 448, i32 0, metadata !69} ; [ DW_TAG_member ] [st_blksize] [line 143, size 64, align 64, offset 448] [from __blksize_t]
!69 = metadata !{i32 786454, metadata !48, null, metadata !"__blksize_t", i32 153, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__blksize_t] [line 153, size 0, align 0, offset 0] [from long int]
!70 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_blocks", i32 144, i64 64, i64 64, i64 512, i32 0, metadata !71} ; [ DW_TAG_member ] [st_blocks] [line 144, size 64, align 64, offset 512] [from __blkcnt64_t]
!71 = metadata !{i32 786454, metadata !48, null, metadata !"__blkcnt64_t", i32 159, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__blkcnt64_t] [line 159, size 0, align 0, offset 0] [from long int]
!72 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_atim", i32 152, i64 128, i64 64, i64 576, i32 0, metadata !73} ; [ DW_TAG_member ] [st_atim] [line 152, size 128, align 64, offset 576] [from timespec]
!73 = metadata !{i32 786451, metadata !74, null, metadata !"timespec", i32 120, i64 128, i64 64, i32 0, i32 0, null, metadata !75, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [timespec] [line 120, size 128, align 64, offset 0] [def] [from ]
!74 = metadata !{metadata !"/usr/include/time.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!75 = metadata !{metadata !76, metadata !78}
!76 = metadata !{i32 786445, metadata !74, metadata !73, metadata !"tv_sec", i32 122, i64 64, i64 64, i64 0, i32 0, metadata !77} ; [ DW_TAG_member ] [tv_sec] [line 122, size 64, align 64, offset 0] [from __time_t]
!77 = metadata !{i32 786454, metadata !74, null, metadata !"__time_t", i32 139, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__time_t] [line 139, size 0, align 0, offset 0] [from long int]
!78 = metadata !{i32 786445, metadata !74, metadata !73, metadata !"tv_nsec", i32 123, i64 64, i64 64, i64 64, i32 0, metadata !79} ; [ DW_TAG_member ] [tv_nsec] [line 123, size 64, align 64, offset 64] [from __syscall_slong_t]
!79 = metadata !{i32 786454, metadata !74, null, metadata !"__syscall_slong_t", i32 175, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__syscall_slong_t] [line 175, size 0, align 0, offset 0] [from long int]
!80 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_mtim", i32 153, i64 128, i64 64, i64 704, i32 0, metadata !73} ; [ DW_TAG_member ] [st_mtim] [line 153, size 128, align 64, offset 704] [from timespec]
!81 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"st_ctim", i32 154, i64 128, i64 64, i64 832, i32 0, metadata !73} ; [ DW_TAG_member ] [st_ctim] [line 154, size 128, align 64, offset 832] [from timespec]
!82 = metadata !{i32 786445, metadata !48, metadata !47, metadata !"__glibc_reserved", i32 164, i64 192, i64 64, i64 960, i32 0, metadata !83} ; [ DW_TAG_member ] [__glibc_reserved] [line 164, size 192, align 64, offset 960] [from ]
!83 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 192, i64 64, i32 0, i32 0, metadata !79, metadata !84, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 192, align 64, offset 0] [from __syscall_slong_t]
!84 = metadata !{metadata !85}
!85 = metadata !{i32 786465, i64 0, i64 3}        ; [ DW_TAG_subrange_type ] [0, 2]
!86 = metadata !{i32 786688, metadata !87, metadata !"r", metadata !26, i32 81, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 81]
!87 = metadata !{i32 786443, metadata !25, metadata !88, i32 80, i32 0, i32 2} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!88 = metadata !{i32 786443, metadata !25, metadata !24, i32 76, i32 0, i32 0} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!89 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"umask", metadata !"umask", metadata !"", i32 88, metadata !90, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32)* @umask, null, null, metadata !93, i32 88} ; [ DW_TAG_subprogram ] [line 88] [def] [umask]
!90 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !91, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!91 = metadata !{metadata !58, metadata !92}
!92 = metadata !{i32 786454, metadata !25, null, metadata !"mode_t", i32 70, i64 0, i64 0, i64 0, i32 0, metadata !58} ; [ DW_TAG_typedef ] [mode_t] [line 70, size 0, align 0, offset 0] [from __mode_t]
!93 = metadata !{metadata !94, metadata !95}
!94 = metadata !{i32 786689, metadata !89, metadata !"mask", metadata !26, i32 16777304, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mask] [line 88]
!95 = metadata !{i32 786688, metadata !89, metadata !"r", metadata !26, i32 89, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 89]
!96 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_open", metadata !"__fd_open", metadata !"", i32 128, metadata !97, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32, i32)* @__fd_open, null, null, metadata !99, i32 128} ; [ DW_TAG_subprogram ] [line 128] [def] [__fd_open]
!97 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !98, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!98 = metadata !{metadata !29, metadata !30, metadata !29, metadata !92}
!99 = metadata !{metadata !100, metadata !101, metadata !102, metadata !103, metadata !104, metadata !115, metadata !116}
!100 = metadata !{i32 786689, metadata !96, metadata !"pathname", metadata !26, i32 16777344, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 128]
!101 = metadata !{i32 786689, metadata !96, metadata !"flags", metadata !26, i32 33554560, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 128]
!102 = metadata !{i32 786689, metadata !96, metadata !"mode", metadata !26, i32 50331776, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 128]
!103 = metadata !{i32 786688, metadata !96, metadata !"df", metadata !26, i32 129, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [df] [line 129]
!104 = metadata !{i32 786688, metadata !96, metadata !"f", metadata !26, i32 130, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 130]
!105 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !106} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from exe_file_t]
!106 = metadata !{i32 786454, metadata !25, null, metadata !"exe_file_t", i32 40, i64 0, i64 0, i64 0, i32 0, metadata !107} ; [ DW_TAG_typedef ] [exe_file_t] [line 40, size 0, align 0, offset 0] [from ]
!107 = metadata !{i32 786451, metadata !4, null, metadata !"", i32 33, i64 192, i64 64, i32 0, i32 0, null, metadata !108, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 33, size 192, align 64, offset 0] [def] [from ]
!108 = metadata !{metadata !109, metadata !110, metadata !111, metadata !114}
!109 = metadata !{i32 786445, metadata !4, metadata !107, metadata !"fd", i32 34, i64 32, i64 32, i64 0, i32 0, metadata !29} ; [ DW_TAG_member ] [fd] [line 34, size 32, align 32, offset 0] [from int]
!110 = metadata !{i32 786445, metadata !4, metadata !107, metadata !"flags", i32 35, i64 32, i64 32, i64 32, i32 0, metadata !42} ; [ DW_TAG_member ] [flags] [line 35, size 32, align 32, offset 32] [from unsigned int]
!111 = metadata !{i32 786445, metadata !4, metadata !107, metadata !"off", i32 38, i64 64, i64 64, i64 64, i32 0, metadata !112} ; [ DW_TAG_member ] [off] [line 38, size 64, align 64, offset 64] [from off64_t]
!112 = metadata !{i32 786454, metadata !4, null, metadata !"off64_t", i32 93, i64 0, i64 0, i64 0, i32 0, metadata !113} ; [ DW_TAG_typedef ] [off64_t] [line 93, size 0, align 0, offset 0] [from __off64_t]
!113 = metadata !{i32 786454, metadata !4, null, metadata !"__off64_t", i32 132, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__off64_t] [line 132, size 0, align 0, offset 0] [from long int]
!114 = metadata !{i32 786445, metadata !4, metadata !107, metadata !"dfile", i32 39, i64 64, i64 64, i64 128, i32 0, metadata !37} ; [ DW_TAG_member ] [dfile] [line 39, size 64, align 64, offset 128] [from ]
!115 = metadata !{i32 786688, metadata !96, metadata !"fd", metadata !26, i32 131, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fd] [line 131]
!116 = metadata !{i32 786688, metadata !117, metadata !"os_fd", metadata !26, i32 181, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_fd] [line 181]
!117 = metadata !{i32 786443, metadata !25, metadata !118, i32 180, i32 0, i32 18} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!118 = metadata !{i32 786443, metadata !25, metadata !96, i32 147, i32 0, i32 8} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!119 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_openat", metadata !"__fd_openat", metadata !"", i32 201, metadata !120, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, i32, i32)* @__fd_openat, null, null, metadata !122, i32 201} ; [ DW_TAG_subprogram ] [line 201] [def] [__fd_openat]
!120 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !121, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!121 = metadata !{metadata !29, metadata !29, metadata !30, metadata !29, metadata !92}
!122 = metadata !{metadata !123, metadata !124, metadata !125, metadata !126, metadata !127, metadata !128, metadata !129, metadata !132}
!123 = metadata !{i32 786689, metadata !119, metadata !"basefd", metadata !26, i32 16777417, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [basefd] [line 201]
!124 = metadata !{i32 786689, metadata !119, metadata !"pathname", metadata !26, i32 33554633, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 201]
!125 = metadata !{i32 786689, metadata !119, metadata !"flags", metadata !26, i32 50331849, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 201]
!126 = metadata !{i32 786689, metadata !119, metadata !"mode", metadata !26, i32 67109065, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 201]
!127 = metadata !{i32 786688, metadata !119, metadata !"f", metadata !26, i32 202, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 202]
!128 = metadata !{i32 786688, metadata !119, metadata !"fd", metadata !26, i32 203, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fd] [line 203]
!129 = metadata !{i32 786688, metadata !130, metadata !"bf", metadata !26, i32 205, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bf] [line 205]
!130 = metadata !{i32 786443, metadata !25, metadata !131, i32 204, i32 0, i32 27} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!131 = metadata !{i32 786443, metadata !25, metadata !119, i32 204, i32 0, i32 26} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!132 = metadata !{i32 786688, metadata !119, metadata !"os_fd", metadata !26, i32 236, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_fd] [line 236]
!133 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"utimes", metadata !"utimes", metadata !"", i32 256, metadata !134, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.timeval*)* @utimes, null, null, metadata !144, i32 256} ; [ DW_TAG_subprogram ] [line 256] [def] [utimes]
!134 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !135, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!135 = metadata !{metadata !29, metadata !30, metadata !136}
!136 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !137} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!137 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, metadata !138} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from timeval]
!138 = metadata !{i32 786451, metadata !139, null, metadata !"timeval", i32 30, i64 128, i64 64, i32 0, i32 0, null, metadata !140, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [timeval] [line 30, size 128, align 64, offset 0] [def] [from ]
!139 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/time.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!140 = metadata !{metadata !141, metadata !142}
!141 = metadata !{i32 786445, metadata !139, metadata !138, metadata !"tv_sec", i32 32, i64 64, i64 64, i64 0, i32 0, metadata !77} ; [ DW_TAG_member ] [tv_sec] [line 32, size 64, align 64, offset 0] [from __time_t]
!142 = metadata !{i32 786445, metadata !139, metadata !138, metadata !"tv_usec", i32 33, i64 64, i64 64, i64 64, i32 0, metadata !143} ; [ DW_TAG_member ] [tv_usec] [line 33, size 64, align 64, offset 64] [from __suseconds_t]
!143 = metadata !{i32 786454, metadata !139, null, metadata !"__suseconds_t", i32 141, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__suseconds_t] [line 141, size 0, align 0, offset 0] [from long int]
!144 = metadata !{metadata !145, metadata !146, metadata !147, metadata !148}
!145 = metadata !{i32 786689, metadata !133, metadata !"path", metadata !26, i32 16777472, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 256]
!146 = metadata !{i32 786689, metadata !133, metadata !"times", metadata !26, i32 33554688, metadata !136, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [times] [line 256]
!147 = metadata !{i32 786688, metadata !133, metadata !"dfile", metadata !26, i32 257, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 257]
!148 = metadata !{i32 786688, metadata !133, metadata !"r", metadata !26, i32 269, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 269]
!149 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"futimesat", metadata !"futimesat", metadata !"", i32 277, metadata !150, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, %struct.timeval*)* @futimesat, null, null, metadata !152, i32 277} ; [ DW_TAG_subprogram ] [line 277] [def] [futimesat]
!150 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !151, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!151 = metadata !{metadata !29, metadata !29, metadata !30, metadata !136}
!152 = metadata !{metadata !153, metadata !154, metadata !155, metadata !156, metadata !159}
!153 = metadata !{i32 786689, metadata !149, metadata !"fd", metadata !26, i32 16777493, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 277]
!154 = metadata !{i32 786689, metadata !149, metadata !"path", metadata !26, i32 33554709, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 277]
!155 = metadata !{i32 786689, metadata !149, metadata !"times", metadata !26, i32 50331925, metadata !136, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [times] [line 277]
!156 = metadata !{i32 786688, metadata !157, metadata !"f", metadata !26, i32 279, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 279]
!157 = metadata !{i32 786443, metadata !25, metadata !158, i32 278, i32 0, i32 49} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!158 = metadata !{i32 786443, metadata !25, metadata !149, i32 278, i32 0, i32 48} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!159 = metadata !{i32 786688, metadata !149, metadata !"r", metadata !26, i32 295, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 295]
!160 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"close", metadata !"close", metadata !"", i32 303, metadata !161, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32)* @close, null, null, metadata !163, i32 303} ; [ DW_TAG_subprogram ] [line 303] [def] [close]
!161 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !162, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!162 = metadata !{metadata !29, metadata !29}
!163 = metadata !{metadata !164, metadata !165, metadata !166}
!164 = metadata !{i32 786689, metadata !160, metadata !"fd", metadata !26, i32 16777519, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 303]
!165 = metadata !{i32 786688, metadata !160, metadata !"f", metadata !26, i32 305, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 305]
!166 = metadata !{i32 786688, metadata !160, metadata !"r", metadata !26, i32 306, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 306]
!167 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"read", metadata !"read", metadata !"", i32 335, metadata !168, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i32, i8*, i64)* @read, null, null, metadata !174, i32 335} ; [ DW_TAG_subprogram ] [line 335] [def] [read]
!168 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !169, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!169 = metadata !{metadata !170, metadata !29, metadata !172, metadata !173}
!170 = metadata !{i32 786454, metadata !25, null, metadata !"ssize_t", i32 109, i64 0, i64 0, i64 0, i32 0, metadata !171} ; [ DW_TAG_typedef ] [ssize_t] [line 109, size 0, align 0, offset 0] [from __ssize_t]
!171 = metadata !{i32 786454, metadata !25, null, metadata !"__ssize_t", i32 172, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__ssize_t] [line 172, size 0, align 0, offset 0] [from long int]
!172 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, null} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!173 = metadata !{i32 786454, metadata !25, null, metadata !"size_t", i32 42, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [size_t] [line 42, size 0, align 0, offset 0] [from long unsigned int]
!174 = metadata !{metadata !175, metadata !176, metadata !177, metadata !178, metadata !179}
!175 = metadata !{i32 786689, metadata !167, metadata !"fd", metadata !26, i32 16777551, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 335]
!176 = metadata !{i32 786689, metadata !167, metadata !"buf", metadata !26, i32 33554767, metadata !172, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 335]
!177 = metadata !{i32 786689, metadata !167, metadata !"count", metadata !26, i32 50331983, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 335]
!178 = metadata !{i32 786688, metadata !167, metadata !"f", metadata !26, i32 337, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 337]
!179 = metadata !{i32 786688, metadata !180, metadata !"r", metadata !26, i32 364, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 364]
!180 = metadata !{i32 786443, metadata !25, metadata !181, i32 362, i32 0, i32 69} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!181 = metadata !{i32 786443, metadata !25, metadata !167, i32 362, i32 0, i32 68} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!182 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"write", metadata !"write", metadata !"", i32 403, metadata !183, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i32, i8*, i64)* @write, null, null, metadata !187, i32 403} ; [ DW_TAG_subprogram ] [line 403] [def] [write]
!183 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !184, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!184 = metadata !{metadata !170, metadata !29, metadata !185, metadata !173}
!185 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !186} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from ]
!186 = metadata !{i32 786470, null, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null} ; [ DW_TAG_const_type ] [line 0, size 0, align 0, offset 0] [from ]
!187 = metadata !{metadata !188, metadata !189, metadata !190, metadata !191, metadata !192, metadata !195}
!188 = metadata !{i32 786689, metadata !182, metadata !"fd", metadata !26, i32 16777619, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 403]
!189 = metadata !{i32 786689, metadata !182, metadata !"buf", metadata !26, i32 33554835, metadata !185, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 403]
!190 = metadata !{i32 786689, metadata !182, metadata !"count", metadata !26, i32 50332051, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 403]
!191 = metadata !{i32 786688, metadata !182, metadata !"f", metadata !26, i32 405, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 405]
!192 = metadata !{i32 786688, metadata !193, metadata !"r", metadata !26, i32 423, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 423]
!193 = metadata !{i32 786443, metadata !25, metadata !194, i32 422, i32 0, i32 83} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!194 = metadata !{i32 786443, metadata !25, metadata !182, i32 422, i32 0, i32 82} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!195 = metadata !{i32 786688, metadata !196, metadata !"actual_count", metadata !26, i32 448, metadata !173, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [actual_count] [line 448]
!196 = metadata !{i32 786443, metadata !25, metadata !194, i32 446, i32 0, i32 88} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!197 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_lseek", metadata !"__fd_lseek", metadata !"", i32 475, metadata !198, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i32, i64, i32)* @__fd_lseek, null, null, metadata !200, i32 475} ; [ DW_TAG_subprogram ] [line 475] [def] [__fd_lseek]
!198 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !199, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!199 = metadata !{metadata !112, metadata !29, metadata !112, metadata !29}
!200 = metadata !{metadata !201, metadata !202, metadata !203, metadata !204, metadata !205}
!201 = metadata !{i32 786689, metadata !197, metadata !"fd", metadata !26, i32 16777691, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 475]
!202 = metadata !{i32 786689, metadata !197, metadata !"offset", metadata !26, i32 33554907, metadata !112, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [offset] [line 475]
!203 = metadata !{i32 786689, metadata !197, metadata !"whence", metadata !26, i32 50332123, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [whence] [line 475]
!204 = metadata !{i32 786688, metadata !197, metadata !"new_off", metadata !26, i32 476, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [new_off] [line 476]
!205 = metadata !{i32 786688, metadata !197, metadata !"f", metadata !26, i32 477, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 477]
!206 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_stat", metadata !"__fd_stat", metadata !"", i32 532, metadata !207, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stat64*)* @__fd_stat, null, null, metadata !209, i32 532} ; [ DW_TAG_subprogram ] [line 532] [def] [__fd_stat]
!207 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !208, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!208 = metadata !{metadata !29, metadata !30, metadata !46}
!209 = metadata !{metadata !210, metadata !211, metadata !212, metadata !213}
!210 = metadata !{i32 786689, metadata !206, metadata !"path", metadata !26, i32 16777748, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 532]
!211 = metadata !{i32 786689, metadata !206, metadata !"buf", metadata !26, i32 33554964, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 532]
!212 = metadata !{i32 786688, metadata !206, metadata !"dfile", metadata !26, i32 533, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 533]
!213 = metadata !{i32 786688, metadata !214, metadata !"r", metadata !26, i32 541, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 541]
!214 = metadata !{i32 786443, metadata !25, metadata !206, i32 539, i32 0, i32 114} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!215 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fstatat", metadata !"fstatat", metadata !"", i32 551, metadata !216, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, %struct.stat*, i32)* @fstatat, null, null, metadata !238, i32 551} ; [ DW_TAG_subprogram ] [line 551] [def] [fstatat]
!216 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !217, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!217 = metadata !{metadata !29, metadata !29, metadata !30, metadata !218, metadata !29}
!218 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !219} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from stat]
!219 = metadata !{i32 786451, metadata !48, null, metadata !"stat", i32 46, i64 1152, i64 64, i32 0, i32 0, null, metadata !220, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [stat] [line 46, size 1152, align 64, offset 0] [def] [from ]
!220 = metadata !{metadata !221, metadata !222, metadata !224, metadata !225, metadata !226, metadata !227, metadata !228, metadata !229, metadata !230, metadata !231, metadata !232, metadata !234, metadata !235, metadata !236, metadata !237}
!221 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_dev", i32 48, i64 64, i64 64, i64 0, i32 0, metadata !51} ; [ DW_TAG_member ] [st_dev] [line 48, size 64, align 64, offset 0] [from __dev_t]
!222 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_ino", i32 53, i64 64, i64 64, i64 64, i32 0, metadata !223} ; [ DW_TAG_member ] [st_ino] [line 53, size 64, align 64, offset 64] [from __ino_t]
!223 = metadata !{i32 786454, metadata !48, null, metadata !"__ino_t", i32 127, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__ino_t] [line 127, size 0, align 0, offset 0] [from long unsigned int]
!224 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_nlink", i32 61, i64 64, i64 64, i64 128, i32 0, metadata !56} ; [ DW_TAG_member ] [st_nlink] [line 61, size 64, align 64, offset 128] [from __nlink_t]
!225 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_mode", i32 62, i64 32, i64 32, i64 192, i32 0, metadata !58} ; [ DW_TAG_member ] [st_mode] [line 62, size 32, align 32, offset 192] [from __mode_t]
!226 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_uid", i32 64, i64 32, i64 32, i64 224, i32 0, metadata !60} ; [ DW_TAG_member ] [st_uid] [line 64, size 32, align 32, offset 224] [from __uid_t]
!227 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_gid", i32 65, i64 32, i64 32, i64 256, i32 0, metadata !62} ; [ DW_TAG_member ] [st_gid] [line 65, size 32, align 32, offset 256] [from __gid_t]
!228 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"__pad0", i32 67, i64 32, i64 32, i64 288, i32 0, metadata !29} ; [ DW_TAG_member ] [__pad0] [line 67, size 32, align 32, offset 288] [from int]
!229 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_rdev", i32 69, i64 64, i64 64, i64 320, i32 0, metadata !51} ; [ DW_TAG_member ] [st_rdev] [line 69, size 64, align 64, offset 320] [from __dev_t]
!230 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_size", i32 74, i64 64, i64 64, i64 384, i32 0, metadata !66} ; [ DW_TAG_member ] [st_size] [line 74, size 64, align 64, offset 384] [from __off_t]
!231 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_blksize", i32 78, i64 64, i64 64, i64 448, i32 0, metadata !69} ; [ DW_TAG_member ] [st_blksize] [line 78, size 64, align 64, offset 448] [from __blksize_t]
!232 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_blocks", i32 80, i64 64, i64 64, i64 512, i32 0, metadata !233} ; [ DW_TAG_member ] [st_blocks] [line 80, size 64, align 64, offset 512] [from __blkcnt_t]
!233 = metadata !{i32 786454, metadata !48, null, metadata !"__blkcnt_t", i32 158, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__blkcnt_t] [line 158, size 0, align 0, offset 0] [from long int]
!234 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_atim", i32 91, i64 128, i64 64, i64 576, i32 0, metadata !73} ; [ DW_TAG_member ] [st_atim] [line 91, size 128, align 64, offset 576] [from timespec]
!235 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_mtim", i32 92, i64 128, i64 64, i64 704, i32 0, metadata !73} ; [ DW_TAG_member ] [st_mtim] [line 92, size 128, align 64, offset 704] [from timespec]
!236 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"st_ctim", i32 93, i64 128, i64 64, i64 832, i32 0, metadata !73} ; [ DW_TAG_member ] [st_ctim] [line 93, size 128, align 64, offset 832] [from timespec]
!237 = metadata !{i32 786445, metadata !48, metadata !219, metadata !"__glibc_reserved", i32 106, i64 192, i64 64, i64 960, i32 0, metadata !83} ; [ DW_TAG_member ] [__glibc_reserved] [line 106, size 192, align 64, offset 960] [from ]
!238 = metadata !{metadata !239, metadata !240, metadata !241, metadata !242, metadata !243, metadata !246, metadata !247}
!239 = metadata !{i32 786689, metadata !215, metadata !"fd", metadata !26, i32 16777767, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 551]
!240 = metadata !{i32 786689, metadata !215, metadata !"path", metadata !26, i32 33554983, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 551]
!241 = metadata !{i32 786689, metadata !215, metadata !"buf", metadata !26, i32 50332199, metadata !218, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 551]
!242 = metadata !{i32 786689, metadata !215, metadata !"flags", metadata !26, i32 67109415, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 551]
!243 = metadata !{i32 786688, metadata !244, metadata !"f", metadata !26, i32 553, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 553]
!244 = metadata !{i32 786443, metadata !25, metadata !245, i32 552, i32 0, i32 117} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!245 = metadata !{i32 786443, metadata !25, metadata !215, i32 552, i32 0, i32 116} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!246 = metadata !{i32 786688, metadata !215, metadata !"dfile", metadata !26, i32 565, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 565]
!247 = metadata !{i32 786688, metadata !215, metadata !"r", metadata !26, i32 572, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 572]
!248 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_lstat", metadata !"__fd_lstat", metadata !"", i32 587, metadata !207, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.stat64*)* @__fd_lstat, null, null, metadata !249, i32 587} ; [ DW_TAG_subprogram ] [line 587] [def] [__fd_lstat]
!249 = metadata !{metadata !250, metadata !251, metadata !252, metadata !253}
!250 = metadata !{i32 786689, metadata !248, metadata !"path", metadata !26, i32 16777803, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 587]
!251 = metadata !{i32 786689, metadata !248, metadata !"buf", metadata !26, i32 33555019, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 587]
!252 = metadata !{i32 786688, metadata !248, metadata !"dfile", metadata !26, i32 588, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 588]
!253 = metadata !{i32 786688, metadata !254, metadata !"r", metadata !26, i32 596, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 596]
!254 = metadata !{i32 786443, metadata !25, metadata !248, i32 594, i32 0, i32 127} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!255 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"chdir", metadata !"chdir", metadata !"", i32 606, metadata !256, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @chdir, null, null, metadata !258, i32 606} ; [ DW_TAG_subprogram ] [line 606] [def] [chdir]
!256 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !257, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!257 = metadata !{metadata !29, metadata !30}
!258 = metadata !{metadata !259, metadata !260, metadata !261}
!259 = metadata !{i32 786689, metadata !255, metadata !"path", metadata !26, i32 16777822, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 606]
!260 = metadata !{i32 786688, metadata !255, metadata !"dfile", metadata !26, i32 607, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 607]
!261 = metadata !{i32 786688, metadata !262, metadata !"r", metadata !26, i32 617, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 617]
!262 = metadata !{i32 786443, metadata !25, metadata !255, i32 616, i32 0, i32 131} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!263 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fchdir", metadata !"fchdir", metadata !"", i32 624, metadata !161, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32)* @fchdir, null, null, metadata !264, i32 624} ; [ DW_TAG_subprogram ] [line 624] [def] [fchdir]
!264 = metadata !{metadata !265, metadata !266, metadata !267}
!265 = metadata !{i32 786689, metadata !263, metadata !"fd", metadata !26, i32 16777840, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 624]
!266 = metadata !{i32 786688, metadata !263, metadata !"f", metadata !26, i32 625, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 625]
!267 = metadata !{i32 786688, metadata !268, metadata !"r", metadata !26, i32 637, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 637]
!268 = metadata !{i32 786443, metadata !25, metadata !269, i32 636, i32 0, i32 137} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!269 = metadata !{i32 786443, metadata !25, metadata !263, i32 632, i32 0, i32 135} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!270 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"chmod", metadata !"chmod", metadata !"", i32 658, metadata !271, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32)* @chmod, null, null, metadata !273, i32 658} ; [ DW_TAG_subprogram ] [line 658] [def] [chmod]
!271 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !272, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!272 = metadata !{metadata !29, metadata !30, metadata !92}
!273 = metadata !{metadata !274, metadata !275, metadata !276, metadata !277}
!274 = metadata !{i32 786689, metadata !270, metadata !"path", metadata !26, i32 16777874, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 658]
!275 = metadata !{i32 786689, metadata !270, metadata !"mode", metadata !26, i32 33555090, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 658]
!276 = metadata !{i32 786688, metadata !270, metadata !"dfile", metadata !26, i32 661, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 661]
!277 = metadata !{i32 786688, metadata !278, metadata !"r", metadata !26, i32 673, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 673]
!278 = metadata !{i32 786443, metadata !25, metadata !279, i32 672, i32 0, i32 143} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!279 = metadata !{i32 786443, metadata !25, metadata !270, i32 670, i32 0, i32 141} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!280 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fchmod", metadata !"fchmod", metadata !"", i32 680, metadata !281, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32)* @fchmod, null, null, metadata !283, i32 680} ; [ DW_TAG_subprogram ] [line 680] [def] [fchmod]
!281 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !282, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!282 = metadata !{metadata !29, metadata !29, metadata !92}
!283 = metadata !{metadata !284, metadata !285, metadata !286, metadata !287}
!284 = metadata !{i32 786689, metadata !280, metadata !"fd", metadata !26, i32 16777896, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 680]
!285 = metadata !{i32 786689, metadata !280, metadata !"mode", metadata !26, i32 33555112, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 680]
!286 = metadata !{i32 786688, metadata !280, metadata !"f", metadata !26, i32 683, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 683]
!287 = metadata !{i32 786688, metadata !288, metadata !"r", metadata !26, i32 700, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 700]
!288 = metadata !{i32 786443, metadata !25, metadata !289, i32 699, i32 0, i32 151} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!289 = metadata !{i32 786443, metadata !25, metadata !280, i32 697, i32 0, i32 149} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!290 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"chown", metadata !"chown", metadata !"", i32 713, metadata !291, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32, i32)* @chown, null, null, metadata !295, i32 713} ; [ DW_TAG_subprogram ] [line 713] [def] [chown]
!291 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !292, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!292 = metadata !{metadata !29, metadata !30, metadata !293, metadata !294}
!293 = metadata !{i32 786454, metadata !25, null, metadata !"uid_t", i32 80, i64 0, i64 0, i64 0, i32 0, metadata !60} ; [ DW_TAG_typedef ] [uid_t] [line 80, size 0, align 0, offset 0] [from __uid_t]
!294 = metadata !{i32 786454, metadata !25, null, metadata !"gid_t", i32 65, i64 0, i64 0, i64 0, i32 0, metadata !62} ; [ DW_TAG_typedef ] [gid_t] [line 65, size 0, align 0, offset 0] [from __gid_t]
!295 = metadata !{metadata !296, metadata !297, metadata !298, metadata !299, metadata !300}
!296 = metadata !{i32 786689, metadata !290, metadata !"path", metadata !26, i32 16777929, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 713]
!297 = metadata !{i32 786689, metadata !290, metadata !"owner", metadata !26, i32 33555145, metadata !293, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [owner] [line 713]
!298 = metadata !{i32 786689, metadata !290, metadata !"group", metadata !26, i32 50332361, metadata !294, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [group] [line 713]
!299 = metadata !{i32 786688, metadata !290, metadata !"df", metadata !26, i32 714, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [df] [line 714]
!300 = metadata !{i32 786688, metadata !301, metadata !"r", metadata !26, i32 719, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 719]
!301 = metadata !{i32 786443, metadata !25, metadata !302, i32 718, i32 0, i32 155} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!302 = metadata !{i32 786443, metadata !25, metadata !290, i32 716, i32 0, i32 153} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!303 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fchown", metadata !"fchown", metadata !"", i32 726, metadata !304, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, i32)* @fchown, null, null, metadata !306, i32 726} ; [ DW_TAG_subprogram ] [line 726] [def] [fchown]
!304 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !305, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!305 = metadata !{metadata !29, metadata !29, metadata !293, metadata !294}
!306 = metadata !{metadata !307, metadata !308, metadata !309, metadata !310, metadata !311}
!307 = metadata !{i32 786689, metadata !303, metadata !"fd", metadata !26, i32 16777942, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 726]
!308 = metadata !{i32 786689, metadata !303, metadata !"owner", metadata !26, i32 33555158, metadata !293, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [owner] [line 726]
!309 = metadata !{i32 786689, metadata !303, metadata !"group", metadata !26, i32 50332374, metadata !294, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [group] [line 726]
!310 = metadata !{i32 786688, metadata !303, metadata !"f", metadata !26, i32 727, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 727]
!311 = metadata !{i32 786688, metadata !312, metadata !"r", metadata !26, i32 737, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 737]
!312 = metadata !{i32 786443, metadata !25, metadata !313, i32 736, i32 0, i32 161} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!313 = metadata !{i32 786443, metadata !25, metadata !303, i32 734, i32 0, i32 159} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!314 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"lchown", metadata !"lchown", metadata !"", i32 744, metadata !291, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, i32, i32)* @lchown, null, null, metadata !315, i32 744} ; [ DW_TAG_subprogram ] [line 744] [def] [lchown]
!315 = metadata !{metadata !316, metadata !317, metadata !318, metadata !319, metadata !320}
!316 = metadata !{i32 786689, metadata !314, metadata !"path", metadata !26, i32 16777960, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 744]
!317 = metadata !{i32 786689, metadata !314, metadata !"owner", metadata !26, i32 33555176, metadata !293, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [owner] [line 744]
!318 = metadata !{i32 786689, metadata !314, metadata !"group", metadata !26, i32 50332392, metadata !294, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [group] [line 744]
!319 = metadata !{i32 786688, metadata !314, metadata !"df", metadata !26, i32 746, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [df] [line 746]
!320 = metadata !{i32 786688, metadata !321, metadata !"r", metadata !26, i32 751, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 751]
!321 = metadata !{i32 786443, metadata !25, metadata !322, i32 750, i32 0, i32 165} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!322 = metadata !{i32 786443, metadata !25, metadata !314, i32 748, i32 0, i32 163} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!323 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_fstat", metadata !"__fd_fstat", metadata !"", i32 758, metadata !324, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, %struct.stat64*)* @__fd_fstat, null, null, metadata !326, i32 758} ; [ DW_TAG_subprogram ] [line 758] [def] [__fd_fstat]
!324 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !325, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!325 = metadata !{metadata !29, metadata !29, metadata !46}
!326 = metadata !{metadata !327, metadata !328, metadata !329, metadata !330}
!327 = metadata !{i32 786689, metadata !323, metadata !"fd", metadata !26, i32 16777974, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 758]
!328 = metadata !{i32 786689, metadata !323, metadata !"buf", metadata !26, i32 33555190, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 758]
!329 = metadata !{i32 786688, metadata !323, metadata !"f", metadata !26, i32 759, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 759]
!330 = metadata !{i32 786688, metadata !331, metadata !"r", metadata !26, i32 768, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 768]
!331 = metadata !{i32 786443, metadata !25, metadata !332, i32 766, i32 0, i32 170} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!332 = metadata !{i32 786443, metadata !25, metadata !323, i32 766, i32 0, i32 169} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!333 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_ftruncate", metadata !"__fd_ftruncate", metadata !"", i32 781, metadata !334, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i64)* @__fd_ftruncate, null, null, metadata !336, i32 781} ; [ DW_TAG_subprogram ] [line 781] [def] [__fd_ftruncate]
!334 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !335, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!335 = metadata !{metadata !29, metadata !29, metadata !112}
!336 = metadata !{metadata !337, metadata !338, metadata !339, metadata !340}
!337 = metadata !{i32 786689, metadata !333, metadata !"fd", metadata !26, i32 16777997, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 781]
!338 = metadata !{i32 786689, metadata !333, metadata !"length", metadata !26, i32 33555213, metadata !112, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [length] [line 781]
!339 = metadata !{i32 786688, metadata !333, metadata !"f", metadata !26, i32 783, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 783]
!340 = metadata !{i32 786688, metadata !341, metadata !"r", metadata !26, i32 804, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 804]
!341 = metadata !{i32 786443, metadata !25, metadata !342, i32 802, i32 0, i32 178} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!342 = metadata !{i32 786443, metadata !25, metadata !333, i32 798, i32 0, i32 176} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!343 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_getdents", metadata !"__fd_getdents", metadata !"", i32 814, metadata !344, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, %struct.dirent64*, i32)* @__fd_getdents, null, null, metadata !360, i32 814} ; [ DW_TAG_subprogram ] [line 814] [def] [__fd_getdents]
!344 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !345, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!345 = metadata !{metadata !29, metadata !42, metadata !346, metadata !42}
!346 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !347} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from dirent64]
!347 = metadata !{i32 786451, metadata !348, null, metadata !"dirent64", i32 37, i64 2240, i64 64, i32 0, i32 0, null, metadata !349, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [dirent64] [line 37, size 2240, align 64, offset 0] [def] [from ]
!348 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/dirent.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!349 = metadata !{metadata !350, metadata !351, metadata !352, metadata !354, metadata !356}
!350 = metadata !{i32 786445, metadata !348, metadata !347, metadata !"d_ino", i32 39, i64 64, i64 64, i64 0, i32 0, metadata !54} ; [ DW_TAG_member ] [d_ino] [line 39, size 64, align 64, offset 0] [from __ino64_t]
!351 = metadata !{i32 786445, metadata !348, metadata !347, metadata !"d_off", i32 40, i64 64, i64 64, i64 64, i32 0, metadata !113} ; [ DW_TAG_member ] [d_off] [line 40, size 64, align 64, offset 64] [from __off64_t]
!352 = metadata !{i32 786445, metadata !348, metadata !347, metadata !"d_reclen", i32 41, i64 16, i64 16, i64 128, i32 0, metadata !353} ; [ DW_TAG_member ] [d_reclen] [line 41, size 16, align 16, offset 128] [from unsigned short]
!353 = metadata !{i32 786468, null, null, metadata !"unsigned short", i32 0, i64 16, i64 16, i64 0, i32 0, i32 7} ; [ DW_TAG_base_type ] [unsigned short] [line 0, size 16, align 16, offset 0, enc DW_ATE_unsigned]
!354 = metadata !{i32 786445, metadata !348, metadata !347, metadata !"d_type", i32 42, i64 8, i64 8, i64 144, i32 0, metadata !355} ; [ DW_TAG_member ] [d_type] [line 42, size 8, align 8, offset 144] [from unsigned char]
!355 = metadata !{i32 786468, null, null, metadata !"unsigned char", i32 0, i64 8, i64 8, i64 0, i32 0, i32 8} ; [ DW_TAG_base_type ] [unsigned char] [line 0, size 8, align 8, offset 0, enc DW_ATE_unsigned_char]
!356 = metadata !{i32 786445, metadata !348, metadata !347, metadata !"d_name", i32 43, i64 2048, i64 8, i64 152, i32 0, metadata !357} ; [ DW_TAG_member ] [d_name] [line 43, size 2048, align 8, offset 152] [from ]
!357 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 2048, i64 8, i32 0, i32 0, metadata !32, metadata !358, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 2048, align 8, offset 0] [from char]
!358 = metadata !{metadata !359}
!359 = metadata !{i32 786465, i64 0, i64 256}     ; [ DW_TAG_subrange_type ] [0, 255]
!360 = metadata !{metadata !361, metadata !362, metadata !363, metadata !364, metadata !365, metadata !370, metadata !371, metadata !372, metadata !375, metadata !377, metadata !378, metadata !379, metadata !382}
!361 = metadata !{i32 786689, metadata !343, metadata !"fd", metadata !26, i32 16778030, metadata !42, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 814]
!362 = metadata !{i32 786689, metadata !343, metadata !"dirp", metadata !26, i32 33555246, metadata !346, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dirp] [line 814]
!363 = metadata !{i32 786689, metadata !343, metadata !"count", metadata !26, i32 50332462, metadata !42, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [count] [line 814]
!364 = metadata !{i32 786688, metadata !343, metadata !"f", metadata !26, i32 815, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 815]
!365 = metadata !{i32 786688, metadata !366, metadata !"i", metadata !26, i32 829, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 829]
!366 = metadata !{i32 786443, metadata !25, metadata !367, i32 827, i32 0, i32 186} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!367 = metadata !{i32 786443, metadata !25, metadata !368, i32 827, i32 0, i32 185} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!368 = metadata !{i32 786443, metadata !25, metadata !369, i32 826, i32 0, i32 184} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!369 = metadata !{i32 786443, metadata !25, metadata !343, i32 822, i32 0, i32 182} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!370 = metadata !{i32 786688, metadata !366, metadata !"pad", metadata !26, i32 829, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pad] [line 829]
!371 = metadata !{i32 786688, metadata !366, metadata !"bytes", metadata !26, i32 829, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [bytes] [line 829]
!372 = metadata !{i32 786688, metadata !373, metadata !"df", metadata !26, i32 839, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [df] [line 839]
!373 = metadata !{i32 786443, metadata !25, metadata !374, i32 838, i32 0, i32 190} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!374 = metadata !{i32 786443, metadata !25, metadata !366, i32 838, i32 0, i32 189} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!375 = metadata !{i32 786688, metadata !376, metadata !"os_pos", metadata !26, i32 862, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_pos] [line 862]
!376 = metadata !{i32 786443, metadata !25, metadata !367, i32 861, i32 0, i32 191} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!377 = metadata !{i32 786688, metadata !376, metadata !"res", metadata !26, i32 863, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 863]
!378 = metadata !{i32 786688, metadata !376, metadata !"s", metadata !26, i32 864, metadata !112, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [s] [line 864]
!379 = metadata !{i32 786688, metadata !380, metadata !"pos", metadata !26, i32 880, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pos] [line 880]
!380 = metadata !{i32 786443, metadata !25, metadata !381, i32 879, i32 0, i32 194} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!381 = metadata !{i32 786443, metadata !25, metadata !376, i32 877, i32 0, i32 192} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!382 = metadata !{i32 786688, metadata !383, metadata !"dp", metadata !26, i32 886, metadata !346, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dp] [line 886]
!383 = metadata !{i32 786443, metadata !25, metadata !380, i32 885, i32 0, i32 195} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!384 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"ioctl", metadata !"ioctl", metadata !"", i32 898, metadata !385, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i64, ...)* @ioctl, null, null, metadata !387, i32 898} ; [ DW_TAG_subprogram ] [line 898] [def] [ioctl]
!385 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !386, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!386 = metadata !{metadata !29, metadata !29, metadata !52}
!387 = metadata !{metadata !388, metadata !389, metadata !390, metadata !391, metadata !405, metadata !406, metadata !409, metadata !430, metadata !440, metadata !443}
!388 = metadata !{i32 786689, metadata !384, metadata !"fd", metadata !26, i32 16778114, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 898]
!389 = metadata !{i32 786689, metadata !384, metadata !"request", metadata !26, i32 33555330, metadata !52, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [request] [line 898]
!390 = metadata !{i32 786688, metadata !384, metadata !"f", metadata !26, i32 902, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 902]
!391 = metadata !{i32 786688, metadata !384, metadata !"ap", metadata !26, i32 903, metadata !392, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ap] [line 903]
!392 = metadata !{i32 786454, metadata !25, null, metadata !"va_list", i32 79, i64 0, i64 0, i64 0, i32 0, metadata !393} ; [ DW_TAG_typedef ] [va_list] [line 79, size 0, align 0, offset 0] [from __gnuc_va_list]
!393 = metadata !{i32 786454, metadata !25, null, metadata !"__gnuc_va_list", i32 48, i64 0, i64 0, i64 0, i32 0, metadata !394} ; [ DW_TAG_typedef ] [__gnuc_va_list] [line 48, size 0, align 0, offset 0] [from __builtin_va_list]
!394 = metadata !{i32 786454, metadata !25, null, metadata !"__builtin_va_list", i32 903, i64 0, i64 0, i64 0, i32 0, metadata !395} ; [ DW_TAG_typedef ] [__builtin_va_list] [line 903, size 0, align 0, offset 0] [from ]
!395 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 192, i64 64, i32 0, i32 0, metadata !396, metadata !403, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 192, align 64, offset 0] [from __va_list_tag]
!396 = metadata !{i32 786454, metadata !25, null, metadata !"__va_list_tag", i32 903, i64 0, i64 0, i64 0, i32 0, metadata !397} ; [ DW_TAG_typedef ] [__va_list_tag] [line 903, size 0, align 0, offset 0] [from __va_list_tag]
!397 = metadata !{i32 786451, metadata !1, null, metadata !"__va_list_tag", i32 903, i64 192, i64 64, i32 0, i32 0, null, metadata !398, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [__va_list_tag] [line 903, size 192, align 64, offset 0] [def] [from ]
!398 = metadata !{metadata !399, metadata !400, metadata !401, metadata !402}
!399 = metadata !{i32 786445, metadata !1, metadata !397, metadata !"gp_offset", i32 903, i64 32, i64 32, i64 0, i32 0, metadata !42} ; [ DW_TAG_member ] [gp_offset] [line 903, size 32, align 32, offset 0] [from unsigned int]
!400 = metadata !{i32 786445, metadata !1, metadata !397, metadata !"fp_offset", i32 903, i64 32, i64 32, i64 32, i32 0, metadata !42} ; [ DW_TAG_member ] [fp_offset] [line 903, size 32, align 32, offset 32] [from unsigned int]
!401 = metadata !{i32 786445, metadata !1, metadata !397, metadata !"overflow_arg_area", i32 903, i64 64, i64 64, i64 64, i32 0, metadata !172} ; [ DW_TAG_member ] [overflow_arg_area] [line 903, size 64, align 64, offset 64] [from ]
!402 = metadata !{i32 786445, metadata !1, metadata !397, metadata !"reg_save_area", i32 903, i64 64, i64 64, i64 128, i32 0, metadata !172} ; [ DW_TAG_member ] [reg_save_area] [line 903, size 64, align 64, offset 128] [from ]
!403 = metadata !{metadata !404}
!404 = metadata !{i32 786465, i64 0, i64 1}       ; [ DW_TAG_subrange_type ] [0, 0]
!405 = metadata !{i32 786688, metadata !384, metadata !"buf", metadata !26, i32 904, metadata !172, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [buf] [line 904]
!406 = metadata !{i32 786688, metadata !407, metadata !"stat", metadata !26, i32 920, metadata !218, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [stat] [line 920]
!407 = metadata !{i32 786443, metadata !25, metadata !408, i32 919, i32 0, i32 199} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!408 = metadata !{i32 786443, metadata !25, metadata !384, i32 919, i32 0, i32 198} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!409 = metadata !{i32 786688, metadata !410, metadata !"ts", metadata !26, i32 924, metadata !412, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ts] [line 924]
!410 = metadata !{i32 786443, metadata !25, metadata !411, i32 923, i32 0, i32 201} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!411 = metadata !{i32 786443, metadata !25, metadata !407, i32 922, i32 0, i32 200} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!412 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !413} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from termios]
!413 = metadata !{i32 786451, metadata !414, null, metadata !"termios", i32 28, i64 480, i64 32, i32 0, i32 0, null, metadata !415, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [termios] [line 28, size 480, align 32, offset 0] [def] [from ]
!414 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/termios.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!415 = metadata !{metadata !416, metadata !418, metadata !419, metadata !420, metadata !421, metadata !423, metadata !427, metadata !429}
!416 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_iflag", i32 30, i64 32, i64 32, i64 0, i32 0, metadata !417} ; [ DW_TAG_member ] [c_iflag] [line 30, size 32, align 32, offset 0] [from tcflag_t]
!417 = metadata !{i32 786454, metadata !414, null, metadata !"tcflag_t", i32 25, i64 0, i64 0, i64 0, i32 0, metadata !42} ; [ DW_TAG_typedef ] [tcflag_t] [line 25, size 0, align 0, offset 0] [from unsigned int]
!418 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_oflag", i32 31, i64 32, i64 32, i64 32, i32 0, metadata !417} ; [ DW_TAG_member ] [c_oflag] [line 31, size 32, align 32, offset 32] [from tcflag_t]
!419 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_cflag", i32 32, i64 32, i64 32, i64 64, i32 0, metadata !417} ; [ DW_TAG_member ] [c_cflag] [line 32, size 32, align 32, offset 64] [from tcflag_t]
!420 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_lflag", i32 33, i64 32, i64 32, i64 96, i32 0, metadata !417} ; [ DW_TAG_member ] [c_lflag] [line 33, size 32, align 32, offset 96] [from tcflag_t]
!421 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_line", i32 34, i64 8, i64 8, i64 128, i32 0, metadata !422} ; [ DW_TAG_member ] [c_line] [line 34, size 8, align 8, offset 128] [from cc_t]
!422 = metadata !{i32 786454, metadata !414, null, metadata !"cc_t", i32 23, i64 0, i64 0, i64 0, i32 0, metadata !355} ; [ DW_TAG_typedef ] [cc_t] [line 23, size 0, align 0, offset 0] [from unsigned char]
!423 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_cc", i32 35, i64 256, i64 8, i64 136, i32 0, metadata !424} ; [ DW_TAG_member ] [c_cc] [line 35, size 256, align 8, offset 136] [from ]
!424 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 256, i64 8, i32 0, i32 0, metadata !422, metadata !425, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 256, align 8, offset 0] [from cc_t]
!425 = metadata !{metadata !426}
!426 = metadata !{i32 786465, i64 0, i64 32}      ; [ DW_TAG_subrange_type ] [0, 31]
!427 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_ispeed", i32 36, i64 32, i64 32, i64 416, i32 0, metadata !428} ; [ DW_TAG_member ] [c_ispeed] [line 36, size 32, align 32, offset 416] [from speed_t]
!428 = metadata !{i32 786454, metadata !414, null, metadata !"speed_t", i32 24, i64 0, i64 0, i64 0, i32 0, metadata !42} ; [ DW_TAG_typedef ] [speed_t] [line 24, size 0, align 0, offset 0] [from unsigned int]
!429 = metadata !{i32 786445, metadata !414, metadata !413, metadata !"c_ospeed", i32 37, i64 32, i64 32, i64 448, i32 0, metadata !428} ; [ DW_TAG_member ] [c_ospeed] [line 37, size 32, align 32, offset 448] [from speed_t]
!430 = metadata !{i32 786688, metadata !431, metadata !"ws", metadata !26, i32 993, metadata !432, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ws] [line 993]
!431 = metadata !{i32 786443, metadata !25, metadata !411, i32 992, i32 0, i32 217} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!432 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !433} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from winsize]
!433 = metadata !{i32 786451, metadata !434, null, metadata !"winsize", i32 27, i64 64, i64 16, i32 0, i32 0, null, metadata !435, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [winsize] [line 27, size 64, align 16, offset 0] [def] [from ]
!434 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/ioctl-types.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!435 = metadata !{metadata !436, metadata !437, metadata !438, metadata !439}
!436 = metadata !{i32 786445, metadata !434, metadata !433, metadata !"ws_row", i32 29, i64 16, i64 16, i64 0, i32 0, metadata !353} ; [ DW_TAG_member ] [ws_row] [line 29, size 16, align 16, offset 0] [from unsigned short]
!437 = metadata !{i32 786445, metadata !434, metadata !433, metadata !"ws_col", i32 30, i64 16, i64 16, i64 16, i32 0, metadata !353} ; [ DW_TAG_member ] [ws_col] [line 30, size 16, align 16, offset 16] [from unsigned short]
!438 = metadata !{i32 786445, metadata !434, metadata !433, metadata !"ws_xpixel", i32 31, i64 16, i64 16, i64 32, i32 0, metadata !353} ; [ DW_TAG_member ] [ws_xpixel] [line 31, size 16, align 16, offset 32] [from unsigned short]
!439 = metadata !{i32 786445, metadata !434, metadata !433, metadata !"ws_ypixel", i32 32, i64 16, i64 16, i64 48, i32 0, metadata !353} ; [ DW_TAG_member ] [ws_ypixel] [line 32, size 16, align 16, offset 48] [from unsigned short]
!440 = metadata !{i32 786688, metadata !441, metadata !"res", metadata !26, i32 1016, metadata !442, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [res] [line 1016]
!441 = metadata !{i32 786443, metadata !25, metadata !411, i32 1015, i32 0, i32 225} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!442 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !29} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from int]
!443 = metadata !{i32 786688, metadata !444, metadata !"r", metadata !26, i32 1041, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1041]
!444 = metadata !{i32 786443, metadata !25, metadata !408, i32 1040, i32 0, i32 233} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!445 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fcntl", metadata !"fcntl", metadata !"", i32 1048, metadata !446, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32, ...)* @fcntl, null, null, metadata !448, i32 1048} ; [ DW_TAG_subprogram ] [line 1048] [def] [fcntl]
!446 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !447, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!447 = metadata !{metadata !29, metadata !29, metadata !29}
!448 = metadata !{metadata !449, metadata !450, metadata !451, metadata !452, metadata !453, metadata !454, metadata !459}
!449 = metadata !{i32 786689, metadata !445, metadata !"fd", metadata !26, i32 16778264, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 1048]
!450 = metadata !{i32 786689, metadata !445, metadata !"cmd", metadata !26, i32 33555480, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [cmd] [line 1048]
!451 = metadata !{i32 786688, metadata !445, metadata !"f", metadata !26, i32 1049, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1049]
!452 = metadata !{i32 786688, metadata !445, metadata !"ap", metadata !26, i32 1050, metadata !392, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [ap] [line 1050]
!453 = metadata !{i32 786688, metadata !445, metadata !"arg", metadata !26, i32 1051, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [arg] [line 1051]
!454 = metadata !{i32 786688, metadata !455, metadata !"flags", metadata !26, i32 1070, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [flags] [line 1070]
!455 = metadata !{i32 786443, metadata !25, metadata !456, i32 1069, i32 0, i32 243} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!456 = metadata !{i32 786443, metadata !25, metadata !457, i32 1068, i32 0, i32 242} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!457 = metadata !{i32 786443, metadata !25, metadata !458, i32 1067, i32 0, i32 241} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!458 = metadata !{i32 786443, metadata !25, metadata !445, i32 1067, i32 0, i32 240} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!459 = metadata !{i32 786688, metadata !460, metadata !"r", metadata !26, i32 1096, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1096]
!460 = metadata !{i32 786443, metadata !25, metadata !458, i32 1095, i32 0, i32 248} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!461 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__fd_statfs", metadata !"__fd_statfs", metadata !"", i32 1103, metadata !462, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*, %struct.statfs*)* @__fd_statfs, null, null, metadata !494, i32 1103} ; [ DW_TAG_subprogram ] [line 1103] [def] [__fd_statfs]
!462 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !463, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!463 = metadata !{metadata !29, metadata !30, metadata !464}
!464 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !465} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from statfs]
!465 = metadata !{i32 786451, metadata !466, null, metadata !"statfs", i32 24, i64 960, i64 64, i32 0, i32 0, null, metadata !467, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [statfs] [line 24, size 960, align 64, offset 0] [def] [from ]
!466 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/statfs.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!467 = metadata !{metadata !468, metadata !470, metadata !471, metadata !473, metadata !474, metadata !475, metadata !477, metadata !478, metadata !487, metadata !488, metadata !489, metadata !490}
!468 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_type", i32 26, i64 64, i64 64, i64 0, i32 0, metadata !469} ; [ DW_TAG_member ] [f_type] [line 26, size 64, align 64, offset 0] [from __fsword_t]
!469 = metadata !{i32 786454, metadata !466, null, metadata !"__fsword_t", i32 170, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__fsword_t] [line 170, size 0, align 0, offset 0] [from long int]
!470 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_bsize", i32 27, i64 64, i64 64, i64 64, i32 0, metadata !469} ; [ DW_TAG_member ] [f_bsize] [line 27, size 64, align 64, offset 64] [from __fsword_t]
!471 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_blocks", i32 29, i64 64, i64 64, i64 128, i32 0, metadata !472} ; [ DW_TAG_member ] [f_blocks] [line 29, size 64, align 64, offset 128] [from __fsblkcnt_t]
!472 = metadata !{i32 786454, metadata !466, null, metadata !"__fsblkcnt_t", i32 162, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__fsblkcnt_t] [line 162, size 0, align 0, offset 0] [from long unsigned int]
!473 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_bfree", i32 30, i64 64, i64 64, i64 192, i32 0, metadata !472} ; [ DW_TAG_member ] [f_bfree] [line 30, size 64, align 64, offset 192] [from __fsblkcnt_t]
!474 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_bavail", i32 31, i64 64, i64 64, i64 256, i32 0, metadata !472} ; [ DW_TAG_member ] [f_bavail] [line 31, size 64, align 64, offset 256] [from __fsblkcnt_t]
!475 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_files", i32 32, i64 64, i64 64, i64 320, i32 0, metadata !476} ; [ DW_TAG_member ] [f_files] [line 32, size 64, align 64, offset 320] [from __fsfilcnt_t]
!476 = metadata !{i32 786454, metadata !466, null, metadata !"__fsfilcnt_t", i32 166, i64 0, i64 0, i64 0, i32 0, metadata !52} ; [ DW_TAG_typedef ] [__fsfilcnt_t] [line 166, size 0, align 0, offset 0] [from long unsigned int]
!477 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_ffree", i32 33, i64 64, i64 64, i64 384, i32 0, metadata !476} ; [ DW_TAG_member ] [f_ffree] [line 33, size 64, align 64, offset 384] [from __fsfilcnt_t]
!478 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_fsid", i32 41, i64 64, i64 32, i64 448, i32 0, metadata !479} ; [ DW_TAG_member ] [f_fsid] [line 41, size 64, align 32, offset 448] [from __fsid_t]
!479 = metadata !{i32 786454, metadata !466, null, metadata !"__fsid_t", i32 134, i64 0, i64 0, i64 0, i32 0, metadata !480} ; [ DW_TAG_typedef ] [__fsid_t] [line 134, size 0, align 0, offset 0] [from ]
!480 = metadata !{i32 786451, metadata !481, null, metadata !"", i32 134, i64 64, i64 32, i32 0, i32 0, null, metadata !482, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 134, size 64, align 32, offset 0] [def] [from ]
!481 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/bits/types.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!482 = metadata !{metadata !483}
!483 = metadata !{i32 786445, metadata !481, metadata !480, metadata !"__val", i32 134, i64 64, i64 32, i64 0, i32 0, metadata !484} ; [ DW_TAG_member ] [__val] [line 134, size 64, align 32, offset 0] [from ]
!484 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 64, i64 32, i32 0, i32 0, metadata !29, metadata !485, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 64, align 32, offset 0] [from int]
!485 = metadata !{metadata !486}
!486 = metadata !{i32 786465, i64 0, i64 2}       ; [ DW_TAG_subrange_type ] [0, 1]
!487 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_namelen", i32 42, i64 64, i64 64, i64 512, i32 0, metadata !469} ; [ DW_TAG_member ] [f_namelen] [line 42, size 64, align 64, offset 512] [from __fsword_t]
!488 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_frsize", i32 43, i64 64, i64 64, i64 576, i32 0, metadata !469} ; [ DW_TAG_member ] [f_frsize] [line 43, size 64, align 64, offset 576] [from __fsword_t]
!489 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_flags", i32 44, i64 64, i64 64, i64 640, i32 0, metadata !469} ; [ DW_TAG_member ] [f_flags] [line 44, size 64, align 64, offset 640] [from __fsword_t]
!490 = metadata !{i32 786445, metadata !466, metadata !465, metadata !"f_spare", i32 45, i64 256, i64 64, i64 704, i32 0, metadata !491} ; [ DW_TAG_member ] [f_spare] [line 45, size 256, align 64, offset 704] [from ]
!491 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 256, i64 64, i32 0, i32 0, metadata !469, metadata !492, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 256, align 64, offset 0] [from __fsword_t]
!492 = metadata !{metadata !493}
!493 = metadata !{i32 786465, i64 0, i64 4}       ; [ DW_TAG_subrange_type ] [0, 3]
!494 = metadata !{metadata !495, metadata !496, metadata !497, metadata !498}
!495 = metadata !{i32 786689, metadata !461, metadata !"path", metadata !26, i32 16778319, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 1103]
!496 = metadata !{i32 786689, metadata !461, metadata !"buf", metadata !26, i32 33555535, metadata !464, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 1103]
!497 = metadata !{i32 786688, metadata !461, metadata !"dfile", metadata !26, i32 1104, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 1104]
!498 = metadata !{i32 786688, metadata !499, metadata !"r", metadata !26, i32 1113, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1113]
!499 = metadata !{i32 786443, metadata !25, metadata !461, i32 1112, i32 0, i32 252} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!500 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fstatfs", metadata !"fstatfs", metadata !"", i32 1120, metadata !501, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, %struct.statfs*)* @fstatfs, null, null, metadata !503, i32 1120} ; [ DW_TAG_subprogram ] [line 1120] [def] [fstatfs]
!501 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !502, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!502 = metadata !{metadata !29, metadata !29, metadata !464}
!503 = metadata !{metadata !504, metadata !505, metadata !506, metadata !507}
!504 = metadata !{i32 786689, metadata !500, metadata !"fd", metadata !26, i32 16778336, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 1120]
!505 = metadata !{i32 786689, metadata !500, metadata !"buf", metadata !26, i32 33555552, metadata !464, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 1120]
!506 = metadata !{i32 786688, metadata !500, metadata !"f", metadata !26, i32 1121, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1121]
!507 = metadata !{i32 786688, metadata !508, metadata !"r", metadata !26, i32 1133, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1133]
!508 = metadata !{i32 786443, metadata !25, metadata !509, i32 1132, i32 0, i32 258} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!509 = metadata !{i32 786443, metadata !25, metadata !500, i32 1128, i32 0, i32 256} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!510 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"fsync", metadata !"fsync", metadata !"", i32 1140, metadata !161, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32)* @fsync, null, null, metadata !511, i32 1140} ; [ DW_TAG_subprogram ] [line 1140] [def] [fsync]
!511 = metadata !{metadata !512, metadata !513, metadata !514}
!512 = metadata !{i32 786689, metadata !510, metadata !"fd", metadata !26, i32 16778356, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 1140]
!513 = metadata !{i32 786688, metadata !510, metadata !"f", metadata !26, i32 1141, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1141]
!514 = metadata !{i32 786688, metadata !515, metadata !"r", metadata !26, i32 1149, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1149]
!515 = metadata !{i32 786443, metadata !25, metadata !516, i32 1148, i32 0, i32 264} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!516 = metadata !{i32 786443, metadata !25, metadata !517, i32 1146, i32 0, i32 262} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!517 = metadata !{i32 786443, metadata !25, metadata !510, i32 1143, i32 0, i32 260} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!518 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"dup2", metadata !"dup2", metadata !"", i32 1156, metadata !446, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i32)* @dup2, null, null, metadata !519, i32 1156} ; [ DW_TAG_subprogram ] [line 1156] [def] [dup2]
!519 = metadata !{metadata !520, metadata !521, metadata !522, metadata !523}
!520 = metadata !{i32 786689, metadata !518, metadata !"oldfd", metadata !26, i32 16778372, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [oldfd] [line 1156]
!521 = metadata !{i32 786689, metadata !518, metadata !"newfd", metadata !26, i32 33555588, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [newfd] [line 1156]
!522 = metadata !{i32 786688, metadata !518, metadata !"f", metadata !26, i32 1157, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1157]
!523 = metadata !{i32 786688, metadata !524, metadata !"f2", metadata !26, i32 1163, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f2] [line 1163]
!524 = metadata !{i32 786443, metadata !25, metadata !525, i32 1162, i32 0, i32 268} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!525 = metadata !{i32 786443, metadata !25, metadata !518, i32 1159, i32 0, i32 266} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!526 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"dup", metadata !"dup", metadata !"", i32 1181, metadata !161, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32)* @dup, null, null, metadata !527, i32 1181} ; [ DW_TAG_subprogram ] [line 1181] [def] [dup]
!527 = metadata !{metadata !528, metadata !529, metadata !530}
!528 = metadata !{i32 786689, metadata !526, metadata !"oldfd", metadata !26, i32 16778397, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [oldfd] [line 1181]
!529 = metadata !{i32 786688, metadata !526, metadata !"f", metadata !26, i32 1182, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1182]
!530 = metadata !{i32 786688, metadata !531, metadata !"fd", metadata !26, i32 1187, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [fd] [line 1187]
!531 = metadata !{i32 786443, metadata !25, metadata !532, i32 1186, i32 0, i32 272} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!532 = metadata !{i32 786443, metadata !25, metadata !526, i32 1183, i32 0, i32 270} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!533 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"rmdir", metadata !"rmdir", metadata !"", i32 1200, metadata !256, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @rmdir, null, null, metadata !534, i32 1200} ; [ DW_TAG_subprogram ] [line 1200] [def] [rmdir]
!534 = metadata !{metadata !535, metadata !536}
!535 = metadata !{i32 786689, metadata !533, metadata !"pathname", metadata !26, i32 16778416, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 1200]
!536 = metadata !{i32 786688, metadata !533, metadata !"dfile", metadata !26, i32 1201, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 1201]
!537 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"unlink", metadata !"unlink", metadata !"", i32 1218, metadata !256, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @unlink, null, null, metadata !538, i32 1218} ; [ DW_TAG_subprogram ] [line 1218] [def] [unlink]
!538 = metadata !{metadata !539, metadata !540}
!539 = metadata !{i32 786689, metadata !537, metadata !"pathname", metadata !26, i32 16778434, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 1218]
!540 = metadata !{i32 786688, metadata !537, metadata !"dfile", metadata !26, i32 1219, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 1219]
!541 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"unlinkat", metadata !"unlinkat", metadata !"", i32 1239, metadata !542, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, i8*, i32)* @unlinkat, null, null, metadata !544, i32 1239} ; [ DW_TAG_subprogram ] [line 1239] [def] [unlinkat]
!542 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !543, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!543 = metadata !{metadata !29, metadata !29, metadata !30, metadata !29}
!544 = metadata !{metadata !545, metadata !546, metadata !547, metadata !548}
!545 = metadata !{i32 786689, metadata !541, metadata !"dirfd", metadata !26, i32 16778455, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [dirfd] [line 1239]
!546 = metadata !{i32 786689, metadata !541, metadata !"pathname", metadata !26, i32 33555671, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 1239]
!547 = metadata !{i32 786689, metadata !541, metadata !"flags", metadata !26, i32 50332887, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 1239]
!548 = metadata !{i32 786688, metadata !541, metadata !"dfile", metadata !26, i32 1242, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 1242]
!549 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"readlink", metadata !"readlink", metadata !"", i32 1262, metadata !550, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i64 (i8*, i8*, i64)* @readlink, null, null, metadata !552, i32 1262} ; [ DW_TAG_subprogram ] [line 1262] [def] [readlink]
!550 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !551, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!551 = metadata !{metadata !170, metadata !30, metadata !44, metadata !173}
!552 = metadata !{metadata !553, metadata !554, metadata !555, metadata !556, metadata !557}
!553 = metadata !{i32 786689, metadata !549, metadata !"path", metadata !26, i32 16778478, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 1262]
!554 = metadata !{i32 786689, metadata !549, metadata !"buf", metadata !26, i32 33555694, metadata !44, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 1262]
!555 = metadata !{i32 786689, metadata !549, metadata !"bufsize", metadata !26, i32 50332910, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [bufsize] [line 1262]
!556 = metadata !{i32 786688, metadata !549, metadata !"dfile", metadata !26, i32 1263, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [dfile] [line 1263]
!557 = metadata !{i32 786688, metadata !558, metadata !"r", metadata !26, i32 1279, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1279]
!558 = metadata !{i32 786443, metadata !25, metadata !559, i32 1278, i32 0, i32 306} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!559 = metadata !{i32 786443, metadata !25, metadata !549, i32 1264, i32 0, i32 297} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!560 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"select", metadata !"select", metadata !"", i32 1294, metadata !561, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i32, %struct.fd_set*, %struct.fd_set*, %struct.fd_set*, %struct.timeval*)* @select, null, null, metadata !574, i32 1295} ; [ DW_TAG_subprogram ] [line 1294] [def] [scope 1295] [select]
!561 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !562, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!562 = metadata !{metadata !29, metadata !29, metadata !563, metadata !563, metadata !563, metadata !573}
!563 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !564} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from fd_set]
!564 = metadata !{i32 786454, metadata !25, null, metadata !"fd_set", i32 75, i64 0, i64 0, i64 0, i32 0, metadata !565} ; [ DW_TAG_typedef ] [fd_set] [line 75, size 0, align 0, offset 0] [from ]
!565 = metadata !{i32 786451, metadata !566, null, metadata !"", i32 64, i64 1024, i64 64, i32 0, i32 0, null, metadata !567, i32 0, null, null, null} ; [ DW_TAG_structure_type ] [line 64, size 1024, align 64, offset 0] [def] [from ]
!566 = metadata !{metadata !"/usr/include/x86_64-linux-gnu/sys/select.h", metadata !"/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX"}
!567 = metadata !{metadata !568}
!568 = metadata !{i32 786445, metadata !566, metadata !565, metadata !"fds_bits", i32 69, i64 1024, i64 64, i64 0, i32 0, metadata !569} ; [ DW_TAG_member ] [fds_bits] [line 69, size 1024, align 64, offset 0] [from ]
!569 = metadata !{i32 786433, null, null, metadata !"", i32 0, i64 1024, i64 64, i32 0, i32 0, metadata !570, metadata !571, i32 0, null, null, null} ; [ DW_TAG_array_type ] [line 0, size 1024, align 64, offset 0] [from __fd_mask]
!570 = metadata !{i32 786454, metadata !566, null, metadata !"__fd_mask", i32 54, i64 0, i64 0, i64 0, i32 0, metadata !67} ; [ DW_TAG_typedef ] [__fd_mask] [line 54, size 0, align 0, offset 0] [from long int]
!571 = metadata !{metadata !572}
!572 = metadata !{i32 786465, i64 0, i64 16}      ; [ DW_TAG_subrange_type ] [0, 15]
!573 = metadata !{i32 786447, null, null, metadata !"", i32 0, i64 64, i64 64, i64 0, i32 0, metadata !138} ; [ DW_TAG_pointer_type ] [line 0, size 64, align 64, offset 0] [from timeval]
!574 = metadata !{metadata !575, metadata !576, metadata !577, metadata !578, metadata !579, metadata !580, metadata !581, metadata !582, metadata !583, metadata !584, metadata !585, metadata !586, metadata !587, metadata !588, metadata !589, metadata !594, metadata !597, metadata !598}
!575 = metadata !{i32 786689, metadata !560, metadata !"nfds", metadata !26, i32 16778510, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [nfds] [line 1294]
!576 = metadata !{i32 786689, metadata !560, metadata !"read", metadata !26, i32 33555726, metadata !563, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [read] [line 1294]
!577 = metadata !{i32 786689, metadata !560, metadata !"write", metadata !26, i32 50332942, metadata !563, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [write] [line 1294]
!578 = metadata !{i32 786689, metadata !560, metadata !"except", metadata !26, i32 67110159, metadata !563, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [except] [line 1295]
!579 = metadata !{i32 786689, metadata !560, metadata !"timeout", metadata !26, i32 83887375, metadata !573, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [timeout] [line 1295]
!580 = metadata !{i32 786688, metadata !560, metadata !"in_read", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [in_read] [line 1296]
!581 = metadata !{i32 786688, metadata !560, metadata !"in_write", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [in_write] [line 1296]
!582 = metadata !{i32 786688, metadata !560, metadata !"in_except", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [in_except] [line 1296]
!583 = metadata !{i32 786688, metadata !560, metadata !"os_read", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_read] [line 1296]
!584 = metadata !{i32 786688, metadata !560, metadata !"os_write", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_write] [line 1296]
!585 = metadata !{i32 786688, metadata !560, metadata !"os_except", metadata !26, i32 1296, metadata !564, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_except] [line 1296]
!586 = metadata !{i32 786688, metadata !560, metadata !"i", metadata !26, i32 1297, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 1297]
!587 = metadata !{i32 786688, metadata !560, metadata !"count", metadata !26, i32 1297, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [count] [line 1297]
!588 = metadata !{i32 786688, metadata !560, metadata !"os_nfds", metadata !26, i32 1297, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [os_nfds] [line 1297]
!589 = metadata !{i32 786688, metadata !590, metadata !"f", metadata !26, i32 1327, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1327]
!590 = metadata !{i32 786443, metadata !25, metadata !591, i32 1326, i32 0, i32 320} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!591 = metadata !{i32 786443, metadata !25, metadata !592, i32 1326, i32 0, i32 319} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!592 = metadata !{i32 786443, metadata !25, metadata !593, i32 1325, i32 0, i32 318} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!593 = metadata !{i32 786443, metadata !25, metadata !560, i32 1325, i32 0, i32 317} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!594 = metadata !{i32 786688, metadata !595, metadata !"tv", metadata !26, i32 1349, metadata !138, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [tv] [line 1349]
!595 = metadata !{i32 786443, metadata !25, metadata !596, i32 1346, i32 0, i32 334} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!596 = metadata !{i32 786443, metadata !25, metadata !560, i32 1346, i32 0, i32 333} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!597 = metadata !{i32 786688, metadata !595, metadata !"r", metadata !26, i32 1350, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1350]
!598 = metadata !{i32 786688, metadata !599, metadata !"f", metadata !26, i32 1365, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 1365]
!599 = metadata !{i32 786443, metadata !25, metadata !600, i32 1364, i32 0, i32 341} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!600 = metadata !{i32 786443, metadata !25, metadata !601, i32 1364, i32 0, i32 340} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!601 = metadata !{i32 786443, metadata !25, metadata !602, i32 1360, i32 0, i32 339} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!602 = metadata !{i32 786443, metadata !25, metadata !595, i32 1353, i32 0, i32 335} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!603 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"getcwd", metadata !"getcwd", metadata !"", i32 1380, metadata !604, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i8* (i8*, i64)* @getcwd, null, null, metadata !606, i32 1380} ; [ DW_TAG_subprogram ] [line 1380] [def] [getcwd]
!604 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !605, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!605 = metadata !{metadata !44, metadata !44, metadata !173}
!606 = metadata !{metadata !607, metadata !608, metadata !609}
!607 = metadata !{i32 786689, metadata !603, metadata !"buf", metadata !26, i32 16778596, metadata !44, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [buf] [line 1380]
!608 = metadata !{i32 786689, metadata !603, metadata !"size", metadata !26, i32 33555812, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [size] [line 1380]
!609 = metadata !{i32 786688, metadata !603, metadata !"r", metadata !26, i32 1382, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [r] [line 1382]
!610 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"chroot", metadata !"chroot", metadata !"", i32 1457, metadata !256, i1 false, i1 true, i32 0, i32 0, null, i32 256, i1 true, i32 (i8*)* @chroot, null, null, metadata !611, i32 1457} ; [ DW_TAG_subprogram ] [line 1457] [def] [chroot]
!611 = metadata !{metadata !612}
!612 = metadata !{i32 786689, metadata !610, metadata !"path", metadata !26, i32 16778673, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [path] [line 1457]
!613 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__concretize_string", metadata !"__concretize_string", metadata !"", i32 1428, metadata !614, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !616, i32 1428} ; [ DW_TAG_subprogram ] [line 1428] [local] [def] [__concretize_string]
!614 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !615, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!615 = metadata !{metadata !30, metadata !30}
!616 = metadata !{metadata !617, metadata !618, metadata !619, metadata !620, metadata !623}
!617 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!618 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!619 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!620 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!621 = metadata !{i32 786443, metadata !25, metadata !622, i32 1432, i32 0, i32 359} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!622 = metadata !{i32 786443, metadata !25, metadata !613, i32 1432, i32 0, i32 358} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!623 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!624 = metadata !{i32 786443, metadata !25, metadata !625, i32 1441, i32 0, i32 366} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!625 = metadata !{i32 786443, metadata !25, metadata !621, i32 1434, i32 0, i32 360} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!626 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__concretize_size", metadata !"__concretize_size", metadata !"", i32 1422, metadata !627, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !629, i32 1422} ; [ DW_TAG_subprogram ] [line 1422] [local] [def] [__concretize_size]
!627 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !628, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!628 = metadata !{metadata !173, metadata !173}
!629 = metadata !{metadata !630, metadata !631}
!630 = metadata !{i32 786689, metadata !626, metadata !"s", metadata !26, i32 16778638, metadata !173, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 1422]
!631 = metadata !{i32 786688, metadata !626, metadata !"sc", metadata !26, i32 1423, metadata !173, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [sc] [line 1423]
!632 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__concretize_ptr", metadata !"__concretize_ptr", metadata !"", i32 1415, metadata !633, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !635, i32 1415} ; [ DW_TAG_subprogram ] [line 1415] [local] [def] [__concretize_ptr]
!633 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !634, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!634 = metadata !{metadata !172, metadata !185}
!635 = metadata !{metadata !636, metadata !637}
!636 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!637 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!638 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__df_chown", metadata !"__df_chown", metadata !"", i32 707, metadata !639, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !641, i32 707} ; [ DW_TAG_subprogram ] [line 707] [local] [def] [__df_chown]
!639 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !640, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!640 = metadata !{metadata !29, metadata !37, metadata !293, metadata !294}
!641 = metadata !{metadata !642, metadata !643, metadata !644}
!642 = metadata !{i32 786689, metadata !638, metadata !"df", metadata !26, i32 16777923, metadata !37, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [df] [line 707]
!643 = metadata !{i32 786689, metadata !638, metadata !"owner", metadata !26, i32 33555139, metadata !293, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [owner] [line 707]
!644 = metadata !{i32 786689, metadata !638, metadata !"group", metadata !26, i32 50332355, metadata !294, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [group] [line 707]
!645 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__df_chmod", metadata !"__df_chmod", metadata !"", i32 645, metadata !646, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !648, i32 645} ; [ DW_TAG_subprogram ] [line 645] [local] [def] [__df_chmod]
!646 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !647, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!647 = metadata !{metadata !29, metadata !37, metadata !92}
!648 = metadata !{metadata !649, metadata !650}
!649 = metadata !{i32 786689, metadata !645, metadata !"df", metadata !26, i32 16777861, metadata !37, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [df] [line 645]
!650 = metadata !{i32 786689, metadata !645, metadata !"mode", metadata !26, i32 33555077, metadata !92, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [mode] [line 645]
!651 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__get_file", metadata !"__get_file", metadata !"", i32 63, metadata !652, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !654, i32 63} ; [ DW_TAG_subprogram ] [line 63] [local] [def] [__get_file]
!652 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !653, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!653 = metadata !{metadata !105, metadata !29}
!654 = metadata !{metadata !655, metadata !656}
!655 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!656 = metadata !{i32 786688, metadata !657, metadata !"f", metadata !26, i32 65, metadata !105, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [f] [line 65]
!657 = metadata !{i32 786443, metadata !25, metadata !658, i32 64, i32 0, i32 373} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!658 = metadata !{i32 786443, metadata !25, metadata !651, i32 64, i32 0, i32 372} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!659 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"has_permission", metadata !"has_permission", metadata !"", i32 97, metadata !324, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !660, i32 97} ; [ DW_TAG_subprogram ] [line 97] [local] [def] [has_permission]
!660 = metadata !{metadata !661, metadata !662, metadata !663, metadata !664, metadata !665}
!661 = metadata !{i32 786689, metadata !659, metadata !"flags", metadata !26, i32 16777313, metadata !29, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [flags] [line 97]
!662 = metadata !{i32 786689, metadata !659, metadata !"s", metadata !26, i32 33554529, metadata !46, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [s] [line 97]
!663 = metadata !{i32 786688, metadata !659, metadata !"write_access", metadata !26, i32 98, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [write_access] [line 98]
!664 = metadata !{i32 786688, metadata !659, metadata !"read_access", metadata !26, i32 98, metadata !29, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [read_access] [line 98]
!665 = metadata !{i32 786688, metadata !659, metadata !"mode", metadata !26, i32 99, metadata !92, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [mode] [line 99]
!666 = metadata !{i32 786478, metadata !25, metadata !26, metadata !"__get_sym_file", metadata !"__get_sym_file", metadata !"", i32 39, metadata !667, i1 true, i1 true, i32 0, i32 0, null, i32 256, i1 true, null, null, null, metadata !669, i32 39} ; [ DW_TAG_subprogram ] [line 39] [local] [def] [__get_sym_file]
!667 = metadata !{i32 786453, i32 0, null, metadata !"", i32 0, i64 0, i64 0, i64 0, i32 0, null, metadata !668, i32 0, null, null, null} ; [ DW_TAG_subroutine_type ] [line 0, size 0, align 0, offset 0] [from ]
!668 = metadata !{metadata !37, metadata !30}
!669 = metadata !{metadata !670, metadata !671, metadata !672, metadata !673}
!670 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, i32 0} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!671 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [c] [line 40]
!672 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [i] [line 41]
!673 = metadata !{i32 786688, metadata !674, metadata !"df", metadata !26, i32 48, metadata !37, i32 0, i32 0} ; [ DW_TAG_auto_variable ] [df] [line 48]
!674 = metadata !{i32 786443, metadata !25, metadata !675, i32 47, i32 0, i32 383} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!675 = metadata !{i32 786443, metadata !25, metadata !676, i32 47, i32 0, i32 382} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!676 = metadata !{i32 786443, metadata !25, metadata !677, i32 46, i32 0, i32 381} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!677 = metadata !{i32 786443, metadata !25, metadata !666, i32 46, i32 0, i32 380} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!678 = metadata !{metadata !679, metadata !680, metadata !681, metadata !682, metadata !683, metadata !684, metadata !685}
!679 = metadata !{i32 786484, i32 0, metadata !160, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 304, metadata !29, i32 1, i32 1, i32* @close.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 304] [local] [def]
!680 = metadata !{i32 786484, i32 0, metadata !167, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 336, metadata !29, i32 1, i32 1, i32* @read.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 336] [local] [def]
!681 = metadata !{i32 786484, i32 0, metadata !182, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 404, metadata !29, i32 1, i32 1, i32* @write.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 404] [local] [def]
!682 = metadata !{i32 786484, i32 0, metadata !270, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 659, metadata !29, i32 1, i32 1, i32* @chmod.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 659] [local] [def]
!683 = metadata !{i32 786484, i32 0, metadata !280, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 681, metadata !29, i32 1, i32 1, i32* @fchmod.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 681] [local] [def]
!684 = metadata !{i32 786484, i32 0, metadata !333, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 782, metadata !29, i32 1, i32 1, i32* @__fd_ftruncate.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 782] [local] [def]
!685 = metadata !{i32 786484, i32 0, metadata !603, metadata !"n_calls", metadata !"n_calls", metadata !"", metadata !26, i32 1381, metadata !29, i32 1, i32 1, i32* @getcwd.n_calls, null} ; [ DW_TAG_variable ] [n_calls] [line 1381] [local] [def]
!686 = metadata !{i32 2, metadata !"Dwarf Version", i32 4}
!687 = metadata !{i32 1, metadata !"Debug Info Version", i32 1}
!688 = metadata !{metadata !"Ubuntu clang version 3.4.2- (branches/release_34) (based on LLVM 3.4.2)"}
!689 = metadata !{i32 73, i32 0, metadata !24, null}
!690 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !691} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!691 = metadata !{i32 74, i32 0, metadata !24, null}
!692 = metadata !{i32 39, i32 0, metadata !666, metadata !691}
!693 = metadata !{i32 40, i32 0, metadata !666, metadata !691}
!694 = metadata !{metadata !695, metadata !695, i64 0}
!695 = metadata !{metadata !"omnipotent char", metadata !696, i64 0}
!696 = metadata !{metadata !"Simple C/C++ TBAA"}
!697 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !691} ; [ DW_TAG_auto_variable ] [c] [line 40]
!698 = metadata !{i32 43, i32 0, metadata !699, metadata !691}
!699 = metadata !{i32 786443, metadata !25, metadata !666, i32 43, i32 0, i32 379} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!700 = metadata !{i32 46, i32 0, metadata !677, metadata !691}
!701 = metadata !{metadata !702, metadata !703, i64 0}
!702 = metadata !{metadata !"", metadata !703, i64 0, metadata !704, i64 8, metadata !704, i64 16, metadata !703, i64 24, metadata !704, i64 32, metadata !703, i64 40, metadata !704, i64 48, metadata !704, i64 56, metadata !704, i64 64, metadata !704, i64 72, metadata !704, i64 80, metadata !704, i64 88, metadata !704, i64 96}
!703 = metadata !{metadata !"int", metadata !695, i64 0}
!704 = metadata !{metadata !"any pointer", metadata !695, i64 0}
!705 = metadata !{i32 47, i32 0, metadata !675, metadata !691}
!706 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !691} ; [ DW_TAG_auto_variable ] [i] [line 41]
!707 = metadata !{i32 48, i32 0, metadata !674, metadata !691}
!708 = metadata !{metadata !702, metadata !704, i64 32}
!709 = metadata !{i32 49, i32 0, metadata !710, metadata !691}
!710 = metadata !{i32 786443, metadata !25, metadata !674, i32 49, i32 0, i32 384} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!711 = metadata !{metadata !712, metadata !704, i64 16}
!712 = metadata !{metadata !"", metadata !703, i64 0, metadata !704, i64 8, metadata !704, i64 16}
!713 = metadata !{metadata !714, metadata !715, i64 8}
!714 = metadata !{metadata !"stat64", metadata !715, i64 0, metadata !715, i64 8, metadata !715, i64 16, metadata !703, i64 24, metadata !703, i64 28, metadata !703, i64 32, metadata !703, i64 36, metadata !715, i64 40, metadata !715, i64 48, metadata !715, i64 56, metadata !715, i64 64, metadata !716, i64 72, metadata !716, i64 88, metadata !716, i64 104, metadata !695, i64 120}
!715 = metadata !{metadata !"long", metadata !695, i64 0}
!716 = metadata !{metadata !"timespec", metadata !715, i64 0, metadata !715, i64 8}
!717 = metadata !{i32 76, i32 0, metadata !88, null}
!718 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !719} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!719 = metadata !{i32 81, i32 0, metadata !87, null}
!720 = metadata !{i32 1428, i32 0, metadata !613, metadata !719}
!721 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !722} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!722 = metadata !{i32 1429, i32 0, metadata !613, metadata !719}
!723 = metadata !{i32 1415, i32 0, metadata !632, metadata !722}
!724 = metadata !{i32 1417, i32 0, metadata !632, metadata !722}
!725 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !722} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!726 = metadata !{i32 1418, i32 0, metadata !632, metadata !722}
!727 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !719} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!728 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !719} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!729 = metadata !{i32 1432, i32 0, metadata !622, metadata !719}
!730 = metadata !{i32 1433, i32 0, metadata !621, metadata !719}
!731 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !719} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!732 = metadata !{i32 1434, i32 0, metadata !625, metadata !719}
!733 = metadata !{i32 1435, i32 0, metadata !734, metadata !719}
!734 = metadata !{i32 786443, metadata !25, metadata !735, i32 1435, i32 0, i32 362} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!735 = metadata !{i32 786443, metadata !25, metadata !625, i32 1434, i32 0, i32 361} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!736 = metadata !{i32 1436, i32 0, metadata !737, metadata !719}
!737 = metadata !{i32 786443, metadata !25, metadata !734, i32 1435, i32 0, i32 363} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!738 = metadata !{i32 1437, i32 0, metadata !737, metadata !719}
!739 = metadata !{i32 1439, i32 0, metadata !740, metadata !719}
!740 = metadata !{i32 786443, metadata !25, metadata !741, i32 1438, i32 0, i32 365} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!741 = metadata !{i32 786443, metadata !25, metadata !734, i32 1438, i32 0, i32 364} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!742 = metadata !{i32 1440, i32 0, metadata !740, metadata !719}
!743 = metadata !{i32 1442, i32 0, metadata !624, metadata !719}
!744 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !719} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!745 = metadata !{i32 1443, i32 0, metadata !624, metadata !719}
!746 = metadata !{i32 1444, i32 0, metadata !624, metadata !719}
!747 = metadata !{i32 1445, i32 0, metadata !748, metadata !719}
!748 = metadata !{i32 786443, metadata !25, metadata !624, i32 1445, i32 0, i32 367} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!749 = metadata !{i32 82, i32 0, metadata !750, null}
!750 = metadata !{i32 786443, metadata !25, metadata !87, i32 82, i32 0, i32 3} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!751 = metadata !{i32 83, i32 0, metadata !750, null}
!752 = metadata !{metadata !703, metadata !703, i64 0}
!753 = metadata !{i32 86, i32 0, metadata !24, null}
!754 = metadata !{i32 88, i32 0, metadata !89, null}
!755 = metadata !{i32 89, i32 0, metadata !89, null}
!756 = metadata !{metadata !757, metadata !703, i64 768}
!757 = metadata !{metadata !"", metadata !695, i64 0, metadata !703, i64 768, metadata !703, i64 772, metadata !703, i64 776}
!758 = metadata !{i32 90, i32 0, metadata !89, null}
!759 = metadata !{i32 91, i32 0, metadata !89, null}
!760 = metadata !{i32 128, i32 0, metadata !96, null}
!761 = metadata !{i32 133, i32 0, metadata !762, null}
!762 = metadata !{i32 786443, metadata !25, metadata !96, i32 133, i32 0, i32 4} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!763 = metadata !{i32 134, i32 0, metadata !764, null}
!764 = metadata !{i32 786443, metadata !25, metadata !762, i32 134, i32 0, i32 5} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!765 = metadata !{metadata !766, metadata !703, i64 4}
!766 = metadata !{metadata !"", metadata !703, i64 0, metadata !703, i64 4, metadata !715, i64 8, metadata !704, i64 16}
!767 = metadata !{i32 136, i32 0, metadata !768, null}
!768 = metadata !{i32 786443, metadata !25, metadata !96, i32 136, i32 0, i32 6} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!769 = metadata !{i32 137, i32 0, metadata !770, null}
!770 = metadata !{i32 786443, metadata !25, metadata !768, i32 136, i32 0, i32 7} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!771 = metadata !{i32 138, i32 0, metadata !770, null}
!772 = metadata !{i32 141, i32 0, metadata !96, null}
!773 = metadata !{i32 144, i32 0, metadata !96, null}
!774 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !775} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!775 = metadata !{i32 146, i32 0, metadata !96, null}
!776 = metadata !{i32 39, i32 0, metadata !666, metadata !775}
!777 = metadata !{i32 40, i32 0, metadata !666, metadata !775}
!778 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !775} ; [ DW_TAG_auto_variable ] [c] [line 40]
!779 = metadata !{i32 43, i32 0, metadata !699, metadata !775}
!780 = metadata !{i32 46, i32 0, metadata !677, metadata !775}
!781 = metadata !{i32 47, i32 0, metadata !675, metadata !775}
!782 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !775} ; [ DW_TAG_auto_variable ] [i] [line 41]
!783 = metadata !{i32 48, i32 0, metadata !674, metadata !775}
!784 = metadata !{i32 49, i32 0, metadata !710, metadata !775}
!785 = metadata !{i32 147, i32 0, metadata !118, null}
!786 = metadata !{i32 150, i32 0, metadata !787, null}
!787 = metadata !{i32 786443, metadata !25, metadata !118, i32 147, i32 0, i32 9} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!788 = metadata !{metadata !766, metadata !704, i64 16}
!789 = metadata !{i32 152, i32 0, metadata !790, null}
!790 = metadata !{i32 786443, metadata !25, metadata !787, i32 152, i32 0, i32 10} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!791 = metadata !{i32 153, i32 0, metadata !792, null}
!792 = metadata !{i32 786443, metadata !25, metadata !790, i32 152, i32 0, i32 11} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!793 = metadata !{i32 154, i32 0, metadata !792, null}
!794 = metadata !{i32 168, i32 0, metadata !795, null}
!795 = metadata !{i32 786443, metadata !25, metadata !796, i32 165, i32 0, i32 15} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!796 = metadata !{i32 786443, metadata !25, metadata !787, i32 165, i32 0, i32 14} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!797 = metadata !{i32 169, i32 0, metadata !795, null}
!798 = metadata !{i32 170, i32 0, metadata !795, null}
!799 = metadata !{i32 786689, metadata !659, metadata !"flags", metadata !26, i32 16777313, metadata !29, i32 0, metadata !800} ; [ DW_TAG_arg_variable ] [flags] [line 97]
!800 = metadata !{i32 173, i32 0, metadata !801, null}
!801 = metadata !{i32 786443, metadata !25, metadata !787, i32 173, i32 0, i32 16} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!802 = metadata !{i32 97, i32 0, metadata !659, metadata !800}
!803 = metadata !{i32 786689, metadata !659, metadata !"s", metadata !26, i32 33554529, metadata !46, i32 0, metadata !800} ; [ DW_TAG_arg_variable ] [s] [line 97]
!804 = metadata !{i32 99, i32 0, metadata !659, metadata !800}
!805 = metadata !{metadata !714, metadata !703, i64 24}
!806 = metadata !{i32 786688, metadata !659, metadata !"mode", metadata !26, i32 99, metadata !92, i32 0, metadata !800} ; [ DW_TAG_auto_variable ] [mode] [line 99]
!807 = metadata !{i32 101, i32 0, metadata !808, metadata !800}
!808 = metadata !{i32 786443, metadata !25, metadata !659, i32 101, i32 0, i32 375} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!809 = metadata !{i32 786688, metadata !659, metadata !"read_access", metadata !26, i32 98, metadata !29, i32 0, metadata !800} ; [ DW_TAG_auto_variable ] [read_access] [line 98]
!810 = metadata !{i32 103, i32 0, metadata !808, metadata !800}
!811 = metadata !{i32 786688, metadata !659, metadata !"write_access", metadata !26, i32 98, metadata !29, i32 0, metadata !800} ; [ DW_TAG_auto_variable ] [write_access] [line 98]
!812 = metadata !{i32 107, i32 0, metadata !813, metadata !800}
!813 = metadata !{i32 786443, metadata !25, metadata !659, i32 105, i32 0, i32 376} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!814 = metadata !{i32 118, i32 0, metadata !815, metadata !800}
!815 = metadata !{i32 786443, metadata !25, metadata !659, i32 118, i32 0, i32 377} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!816 = metadata !{i32 105, i32 0, metadata !813, metadata !800}
!817 = metadata !{i32 121, i32 0, metadata !818, metadata !800}
!818 = metadata !{i32 786443, metadata !25, metadata !659, i32 121, i32 0, i32 378} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!819 = metadata !{i32 174, i32 0, metadata !820, null}
!820 = metadata !{i32 786443, metadata !25, metadata !801, i32 173, i32 0, i32 17} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!821 = metadata !{i32 175, i32 0, metadata !820, null}
!822 = metadata !{i32 178, i32 0, metadata !801, null}
!823 = metadata !{i32 180, i32 0, metadata !787, null}
!824 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !825} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!825 = metadata !{i32 181, i32 0, metadata !117, null}
!826 = metadata !{i32 1428, i32 0, metadata !613, metadata !825}
!827 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !828} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!828 = metadata !{i32 1429, i32 0, metadata !613, metadata !825}
!829 = metadata !{i32 1415, i32 0, metadata !632, metadata !828}
!830 = metadata !{i32 1417, i32 0, metadata !632, metadata !828}
!831 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !828} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!832 = metadata !{i32 1418, i32 0, metadata !632, metadata !828}
!833 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !825} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!834 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !825} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!835 = metadata !{i32 1432, i32 0, metadata !622, metadata !825}
!836 = metadata !{i32 1433, i32 0, metadata !621, metadata !825}
!837 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !825} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!838 = metadata !{i32 1434, i32 0, metadata !625, metadata !825}
!839 = metadata !{i32 1435, i32 0, metadata !734, metadata !825}
!840 = metadata !{i32 1436, i32 0, metadata !737, metadata !825}
!841 = metadata !{i32 1437, i32 0, metadata !737, metadata !825}
!842 = metadata !{i32 1439, i32 0, metadata !740, metadata !825}
!843 = metadata !{i32 1440, i32 0, metadata !740, metadata !825}
!844 = metadata !{i32 1442, i32 0, metadata !624, metadata !825}
!845 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !825} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!846 = metadata !{i32 1443, i32 0, metadata !624, metadata !825}
!847 = metadata !{i32 1444, i32 0, metadata !624, metadata !825}
!848 = metadata !{i32 1445, i32 0, metadata !748, metadata !825}
!849 = metadata !{i32 182, i32 0, metadata !850, null}
!850 = metadata !{i32 786443, metadata !25, metadata !117, i32 182, i32 0, i32 19} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!851 = metadata !{i32 183, i32 0, metadata !852, null}
!852 = metadata !{i32 786443, metadata !25, metadata !850, i32 182, i32 0, i32 20} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!853 = metadata !{i32 184, i32 0, metadata !852, null}
!854 = metadata !{i32 186, i32 0, metadata !117, null}
!855 = metadata !{metadata !766, metadata !703, i64 0}
!856 = metadata !{i32 190, i32 0, metadata !857, null}
!857 = metadata !{i32 786443, metadata !25, metadata !96, i32 190, i32 0, i32 21} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!858 = metadata !{i32 189, i32 0, metadata !96, null}
!859 = metadata !{i32 191, i32 0, metadata !860, null}
!860 = metadata !{i32 786443, metadata !25, metadata !857, i32 190, i32 0, i32 22} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!861 = metadata !{i32 192, i32 0, metadata !860, null}
!862 = metadata !{i32 193, i32 0, metadata !863, null}
!863 = metadata !{i32 786443, metadata !25, metadata !864, i32 192, i32 0, i32 24} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!864 = metadata !{i32 786443, metadata !25, metadata !857, i32 192, i32 0, i32 23} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!865 = metadata !{i32 194, i32 0, metadata !863, null}
!866 = metadata !{i32 195, i32 0, metadata !867, null}
!867 = metadata !{i32 786443, metadata !25, metadata !864, i32 194, i32 0, i32 25} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!868 = metadata !{i32 199, i32 0, metadata !96, null}
!869 = metadata !{i32 201, i32 0, metadata !119, null}
!870 = metadata !{i32 204, i32 0, metadata !131, null}
!871 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !872} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!872 = metadata !{i32 205, i32 0, metadata !130, null}
!873 = metadata !{i32 63, i32 0, metadata !651, metadata !872}
!874 = metadata !{i32 64, i32 0, metadata !658, metadata !872}
!875 = metadata !{i32 65, i32 0, metadata !657, metadata !872}
!876 = metadata !{i32 66, i32 0, metadata !877, metadata !872}
!877 = metadata !{i32 786443, metadata !25, metadata !657, i32 66, i32 0, i32 374} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!878 = metadata !{i32 207, i32 0, metadata !879, null}
!879 = metadata !{i32 786443, metadata !25, metadata !130, i32 207, i32 0, i32 28} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!880 = metadata !{i32 208, i32 0, metadata !881, null}
!881 = metadata !{i32 786443, metadata !25, metadata !879, i32 207, i32 0, i32 29} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!882 = metadata !{i32 209, i32 0, metadata !881, null}
!883 = metadata !{i32 210, i32 0, metadata !884, null}
!884 = metadata !{i32 786443, metadata !25, metadata !879, i32 210, i32 0, i32 30} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!885 = metadata !{i32 211, i32 0, metadata !886, null}
!886 = metadata !{i32 786443, metadata !25, metadata !884, i32 210, i32 0, i32 31} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!887 = metadata !{i32 212, i32 0, metadata !886, null}
!888 = metadata !{i32 213, i32 0, metadata !886, null}
!889 = metadata !{i32 215, i32 0, metadata !130, null}
!890 = metadata !{i32 216, i32 0, metadata !130, null}
!891 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !892} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!892 = metadata !{i32 218, i32 0, metadata !893, null}
!893 = metadata !{i32 786443, metadata !25, metadata !119, i32 218, i32 0, i32 32} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!894 = metadata !{i32 39, i32 0, metadata !666, metadata !892}
!895 = metadata !{i32 40, i32 0, metadata !666, metadata !892}
!896 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !892} ; [ DW_TAG_auto_variable ] [c] [line 40]
!897 = metadata !{i32 43, i32 0, metadata !699, metadata !892}
!898 = metadata !{i32 46, i32 0, metadata !677, metadata !892}
!899 = metadata !{i32 47, i32 0, metadata !675, metadata !892}
!900 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !892} ; [ DW_TAG_auto_variable ] [i] [line 41]
!901 = metadata !{i32 48, i32 0, metadata !674, metadata !892}
!902 = metadata !{i32 49, i32 0, metadata !710, metadata !892}
!903 = metadata !{i32 220, i32 0, metadata !904, null}
!904 = metadata !{i32 786443, metadata !25, metadata !893, i32 218, i32 0, i32 33} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!905 = metadata !{i32 223, i32 0, metadata !906, null}
!906 = metadata !{i32 786443, metadata !25, metadata !119, i32 223, i32 0, i32 34} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!907 = metadata !{i32 224, i32 0, metadata !908, null}
!908 = metadata !{i32 786443, metadata !25, metadata !906, i32 224, i32 0, i32 35} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!909 = metadata !{i32 226, i32 0, metadata !910, null}
!910 = metadata !{i32 786443, metadata !25, metadata !119, i32 226, i32 0, i32 36} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!911 = metadata !{i32 227, i32 0, metadata !912, null}
!912 = metadata !{i32 786443, metadata !25, metadata !910, i32 226, i32 0, i32 37} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!913 = metadata !{i32 228, i32 0, metadata !912, null}
!914 = metadata !{i32 231, i32 0, metadata !119, null}
!915 = metadata !{i32 234, i32 0, metadata !119, null}
!916 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !917} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!917 = metadata !{i32 236, i32 0, metadata !119, null}
!918 = metadata !{i32 1428, i32 0, metadata !613, metadata !917}
!919 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !920} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!920 = metadata !{i32 1429, i32 0, metadata !613, metadata !917}
!921 = metadata !{i32 1415, i32 0, metadata !632, metadata !920}
!922 = metadata !{i32 1417, i32 0, metadata !632, metadata !920}
!923 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !920} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!924 = metadata !{i32 1418, i32 0, metadata !632, metadata !920}
!925 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !917} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!926 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !917} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!927 = metadata !{i32 1432, i32 0, metadata !622, metadata !917}
!928 = metadata !{i32 1433, i32 0, metadata !621, metadata !917}
!929 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !917} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!930 = metadata !{i32 1434, i32 0, metadata !625, metadata !917}
!931 = metadata !{i32 1435, i32 0, metadata !734, metadata !917}
!932 = metadata !{i32 1436, i32 0, metadata !737, metadata !917}
!933 = metadata !{i32 1437, i32 0, metadata !737, metadata !917}
!934 = metadata !{i32 1439, i32 0, metadata !740, metadata !917}
!935 = metadata !{i32 1440, i32 0, metadata !740, metadata !917}
!936 = metadata !{i32 1442, i32 0, metadata !624, metadata !917}
!937 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !917} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!938 = metadata !{i32 1443, i32 0, metadata !624, metadata !917}
!939 = metadata !{i32 1444, i32 0, metadata !624, metadata !917}
!940 = metadata !{i32 1445, i32 0, metadata !748, metadata !917}
!941 = metadata !{i32 237, i32 0, metadata !942, null}
!942 = metadata !{i32 786443, metadata !25, metadata !119, i32 237, i32 0, i32 38} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!943 = metadata !{i32 238, i32 0, metadata !944, null}
!944 = metadata !{i32 786443, metadata !25, metadata !942, i32 237, i32 0, i32 39} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!945 = metadata !{i32 239, i32 0, metadata !944, null}
!946 = metadata !{i32 242, i32 0, metadata !119, null}
!947 = metadata !{i32 243, i32 0, metadata !119, null}
!948 = metadata !{i32 244, i32 0, metadata !949, null}
!949 = metadata !{i32 786443, metadata !25, metadata !119, i32 244, i32 0, i32 40} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!950 = metadata !{i32 245, i32 0, metadata !951, null}
!951 = metadata !{i32 786443, metadata !25, metadata !949, i32 244, i32 0, i32 41} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!952 = metadata !{i32 246, i32 0, metadata !951, null}
!953 = metadata !{i32 247, i32 0, metadata !954, null}
!954 = metadata !{i32 786443, metadata !25, metadata !955, i32 246, i32 0, i32 43} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!955 = metadata !{i32 786443, metadata !25, metadata !949, i32 246, i32 0, i32 42} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!956 = metadata !{i32 248, i32 0, metadata !954, null}
!957 = metadata !{i32 249, i32 0, metadata !958, null}
!958 = metadata !{i32 786443, metadata !25, metadata !955, i32 248, i32 0, i32 44} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!959 = metadata !{i32 253, i32 0, metadata !119, null}
!960 = metadata !{i32 256, i32 0, metadata !133, null}
!961 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !962} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!962 = metadata !{i32 257, i32 0, metadata !133, null}
!963 = metadata !{i32 39, i32 0, metadata !666, metadata !962}
!964 = metadata !{i32 40, i32 0, metadata !666, metadata !962}
!965 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !962} ; [ DW_TAG_auto_variable ] [c] [line 40]
!966 = metadata !{i32 43, i32 0, metadata !699, metadata !962}
!967 = metadata !{i32 46, i32 0, metadata !677, metadata !962}
!968 = metadata !{i32 47, i32 0, metadata !675, metadata !962}
!969 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !962} ; [ DW_TAG_auto_variable ] [i] [line 41]
!970 = metadata !{i32 48, i32 0, metadata !674, metadata !962}
!971 = metadata !{i32 49, i32 0, metadata !710, metadata !962}
!972 = metadata !{i32 259, i32 0, metadata !973, null}
!973 = metadata !{i32 786443, metadata !25, metadata !133, i32 259, i32 0, i32 45} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!974 = metadata !{i32 261, i32 0, metadata !975, null}
!975 = metadata !{i32 786443, metadata !25, metadata !973, i32 259, i32 0, i32 46} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!976 = metadata !{metadata !977, metadata !715, i64 0}
!977 = metadata !{metadata !"timeval", metadata !715, i64 0, metadata !715, i64 8}
!978 = metadata !{metadata !714, metadata !715, i64 72}
!979 = metadata !{i32 262, i32 0, metadata !975, null}
!980 = metadata !{metadata !714, metadata !715, i64 88}
!981 = metadata !{i32 264, i32 0, metadata !975, null}
!982 = metadata !{metadata !714, metadata !715, i64 80}
!983 = metadata !{i32 265, i32 0, metadata !975, null}
!984 = metadata !{metadata !714, metadata !715, i64 96}
!985 = metadata !{i32 267, i32 0, metadata !975, null}
!986 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !987} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!987 = metadata !{i32 269, i32 0, metadata !133, null}
!988 = metadata !{i32 1428, i32 0, metadata !613, metadata !987}
!989 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !990} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!990 = metadata !{i32 1429, i32 0, metadata !613, metadata !987}
!991 = metadata !{i32 1415, i32 0, metadata !632, metadata !990}
!992 = metadata !{i32 1417, i32 0, metadata !632, metadata !990}
!993 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !990} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!994 = metadata !{i32 1418, i32 0, metadata !632, metadata !990}
!995 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !987} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!996 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !987} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!997 = metadata !{i32 1432, i32 0, metadata !622, metadata !987}
!998 = metadata !{i32 1433, i32 0, metadata !621, metadata !987}
!999 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !987} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1000 = metadata !{i32 1434, i32 0, metadata !625, metadata !987}
!1001 = metadata !{i32 1435, i32 0, metadata !734, metadata !987}
!1002 = metadata !{i32 1436, i32 0, metadata !737, metadata !987}
!1003 = metadata !{i32 1437, i32 0, metadata !737, metadata !987}
!1004 = metadata !{i32 1439, i32 0, metadata !740, metadata !987}
!1005 = metadata !{i32 1440, i32 0, metadata !740, metadata !987}
!1006 = metadata !{i32 1442, i32 0, metadata !624, metadata !987}
!1007 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !987} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1008 = metadata !{i32 1443, i32 0, metadata !624, metadata !987}
!1009 = metadata !{i32 1444, i32 0, metadata !624, metadata !987}
!1010 = metadata !{i32 1445, i32 0, metadata !748, metadata !987}
!1011 = metadata !{i32 270, i32 0, metadata !1012, null}
!1012 = metadata !{i32 786443, metadata !25, metadata !133, i32 270, i32 0, i32 47} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1013 = metadata !{i32 271, i32 0, metadata !1012, null}
!1014 = metadata !{i32 274, i32 0, metadata !133, null}
!1015 = metadata !{i32 277, i32 0, metadata !149, null}
!1016 = metadata !{i32 278, i32 0, metadata !158, null}
!1017 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1018} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1018 = metadata !{i32 279, i32 0, metadata !157, null}
!1019 = metadata !{i32 63, i32 0, metadata !651, metadata !1018}
!1020 = metadata !{i32 64, i32 0, metadata !658, metadata !1018}
!1021 = metadata !{i32 65, i32 0, metadata !657, metadata !1018}
!1022 = metadata !{i32 66, i32 0, metadata !877, metadata !1018}
!1023 = metadata !{i32 281, i32 0, metadata !1024, null}
!1024 = metadata !{i32 786443, metadata !25, metadata !157, i32 281, i32 0, i32 50} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1025 = metadata !{i32 282, i32 0, metadata !1026, null}
!1026 = metadata !{i32 786443, metadata !25, metadata !1024, i32 281, i32 0, i32 51} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1027 = metadata !{i32 283, i32 0, metadata !1026, null}
!1028 = metadata !{i32 284, i32 0, metadata !1029, null}
!1029 = metadata !{i32 786443, metadata !25, metadata !1024, i32 284, i32 0, i32 52} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1030 = metadata !{i32 285, i32 0, metadata !1031, null}
!1031 = metadata !{i32 786443, metadata !25, metadata !1029, i32 284, i32 0, i32 53} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1032 = metadata !{i32 286, i32 0, metadata !1031, null}
!1033 = metadata !{i32 287, i32 0, metadata !1031, null}
!1034 = metadata !{i32 289, i32 0, metadata !157, null}
!1035 = metadata !{i32 290, i32 0, metadata !157, null}
!1036 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1037} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1037 = metadata !{i32 291, i32 0, metadata !1038, null}
!1038 = metadata !{i32 786443, metadata !25, metadata !149, i32 291, i32 0, i32 54} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1039 = metadata !{i32 39, i32 0, metadata !666, metadata !1037}
!1040 = metadata !{i32 40, i32 0, metadata !666, metadata !1037}
!1041 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1037} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1042 = metadata !{i32 43, i32 0, metadata !699, metadata !1037}
!1043 = metadata !{i32 46, i32 0, metadata !677, metadata !1037}
!1044 = metadata !{i32 47, i32 0, metadata !675, metadata !1037}
!1045 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1037} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1046 = metadata !{i32 48, i32 0, metadata !674, metadata !1037}
!1047 = metadata !{i32 49, i32 0, metadata !710, metadata !1037}
!1048 = metadata !{i32 292, i32 0, metadata !1049, null}
!1049 = metadata !{i32 786443, metadata !25, metadata !1038, i32 291, i32 0, i32 55} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1050 = metadata !{i32 295, i32 0, metadata !149, null}
!1051 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1052} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1052 = metadata !{i32 296, i32 0, metadata !149, null}
!1053 = metadata !{i32 1428, i32 0, metadata !613, metadata !1052}
!1054 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1055} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1055 = metadata !{i32 1429, i32 0, metadata !613, metadata !1052}
!1056 = metadata !{i32 1415, i32 0, metadata !632, metadata !1055}
!1057 = metadata !{i32 1417, i32 0, metadata !632, metadata !1055}
!1058 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1055} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1059 = metadata !{i32 1418, i32 0, metadata !632, metadata !1055}
!1060 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1052} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1061 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1052} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1062 = metadata !{i32 1432, i32 0, metadata !622, metadata !1052}
!1063 = metadata !{i32 1433, i32 0, metadata !621, metadata !1052}
!1064 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1052} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1065 = metadata !{i32 1434, i32 0, metadata !625, metadata !1052}
!1066 = metadata !{i32 1435, i32 0, metadata !734, metadata !1052}
!1067 = metadata !{i32 1436, i32 0, metadata !737, metadata !1052}
!1068 = metadata !{i32 1437, i32 0, metadata !737, metadata !1052}
!1069 = metadata !{i32 1439, i32 0, metadata !740, metadata !1052}
!1070 = metadata !{i32 1440, i32 0, metadata !740, metadata !1052}
!1071 = metadata !{i32 1442, i32 0, metadata !624, metadata !1052}
!1072 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1052} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1073 = metadata !{i32 1443, i32 0, metadata !624, metadata !1052}
!1074 = metadata !{i32 1444, i32 0, metadata !624, metadata !1052}
!1075 = metadata !{i32 1445, i32 0, metadata !748, metadata !1052}
!1076 = metadata !{i32 298, i32 0, metadata !1077, null}
!1077 = metadata !{i32 786443, metadata !25, metadata !149, i32 298, i32 0, i32 56} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1078 = metadata !{i32 299, i32 0, metadata !1077, null}
!1079 = metadata !{i32 301, i32 0, metadata !149, null}
!1080 = metadata !{i32 303, i32 0, metadata !160, null}
!1081 = metadata !{i32 306, i32 0, metadata !160, null}
!1082 = metadata !{i32 308, i32 0, metadata !160, null}
!1083 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1084} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1084 = metadata !{i32 310, i32 0, metadata !160, null}
!1085 = metadata !{i32 63, i32 0, metadata !651, metadata !1084}
!1086 = metadata !{i32 64, i32 0, metadata !658, metadata !1084}
!1087 = metadata !{i32 65, i32 0, metadata !657, metadata !1084}
!1088 = metadata !{i32 66, i32 0, metadata !877, metadata !1084}
!1089 = metadata !{i32 311, i32 0, metadata !1090, null}
!1090 = metadata !{i32 786443, metadata !25, metadata !160, i32 311, i32 0, i32 57} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1091 = metadata !{i32 312, i32 0, metadata !1092, null}
!1092 = metadata !{i32 786443, metadata !25, metadata !1090, i32 311, i32 0, i32 58} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1093 = metadata !{i32 313, i32 0, metadata !1092, null}
!1094 = metadata !{i32 316, i32 0, metadata !1095, null}
!1095 = metadata !{i32 786443, metadata !25, metadata !160, i32 316, i32 0, i32 59} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1096 = metadata !{metadata !702, metadata !703, i64 40}
!1097 = metadata !{metadata !702, metadata !704, i64 64}
!1098 = metadata !{i32 317, i32 0, metadata !1099, null}
!1099 = metadata !{i32 786443, metadata !25, metadata !1095, i32 316, i32 0, i32 60} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1100 = metadata !{i32 318, i32 0, metadata !1099, null}
!1101 = metadata !{i32 319, i32 0, metadata !1099, null}
!1102 = metadata !{i32 330, i32 0, metadata !160, null}
!1103 = metadata !{i32 332, i32 0, metadata !160, null}
!1104 = metadata !{i32 333, i32 0, metadata !160, null}
!1105 = metadata !{i32 335, i32 0, metadata !167, null}
!1106 = metadata !{i32 339, i32 0, metadata !167, null}
!1107 = metadata !{i32 341, i32 0, metadata !1108, null}
!1108 = metadata !{i32 786443, metadata !25, metadata !167, i32 341, i32 0, i32 61} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1109 = metadata !{i32 344, i32 0, metadata !1110, null}
!1110 = metadata !{i32 786443, metadata !25, metadata !167, i32 344, i32 0, i32 62} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1111 = metadata !{i32 345, i32 0, metadata !1112, null}
!1112 = metadata !{i32 786443, metadata !25, metadata !1110, i32 344, i32 0, i32 63} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1113 = metadata !{i32 346, i32 0, metadata !1112, null}
!1114 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1115} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1115 = metadata !{i32 349, i32 0, metadata !167, null}
!1116 = metadata !{i32 63, i32 0, metadata !651, metadata !1115}
!1117 = metadata !{i32 64, i32 0, metadata !658, metadata !1115}
!1118 = metadata !{i32 65, i32 0, metadata !657, metadata !1115}
!1119 = metadata !{i32 66, i32 0, metadata !877, metadata !1115}
!1120 = metadata !{i32 351, i32 0, metadata !1121, null}
!1121 = metadata !{i32 786443, metadata !25, metadata !167, i32 351, i32 0, i32 64} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1122 = metadata !{i32 352, i32 0, metadata !1123, null}
!1123 = metadata !{i32 786443, metadata !25, metadata !1121, i32 351, i32 0, i32 65} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1124 = metadata !{i32 353, i32 0, metadata !1123, null}
!1125 = metadata !{i32 356, i32 0, metadata !1126, null}
!1126 = metadata !{i32 786443, metadata !25, metadata !167, i32 356, i32 0, i32 66} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1127 = metadata !{metadata !702, metadata !704, i64 48}
!1128 = metadata !{i32 357, i32 0, metadata !1129, null}
!1129 = metadata !{i32 786443, metadata !25, metadata !1126, i32 356, i32 0, i32 67} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1130 = metadata !{i32 358, i32 0, metadata !1129, null}
!1131 = metadata !{i32 359, i32 0, metadata !1129, null}
!1132 = metadata !{i32 362, i32 0, metadata !181, null}
!1133 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1134} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1134 = metadata !{i32 365, i32 0, metadata !180, null}
!1135 = metadata !{i32 1415, i32 0, metadata !632, metadata !1134}
!1136 = metadata !{i32 1417, i32 0, metadata !632, metadata !1134}
!1137 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1134} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1138 = metadata !{i32 1418, i32 0, metadata !632, metadata !1134}
!1139 = metadata !{i32 786689, metadata !626, metadata !"s", metadata !26, i32 16778638, metadata !173, i32 0, metadata !1140} ; [ DW_TAG_arg_variable ] [s] [line 1422]
!1140 = metadata !{i32 366, i32 0, metadata !180, null}
!1141 = metadata !{i32 1422, i32 0, metadata !626, metadata !1140}
!1142 = metadata !{i32 1423, i32 0, metadata !626, metadata !1140}
!1143 = metadata !{i32 786688, metadata !626, metadata !"sc", metadata !26, i32 1423, metadata !173, i32 0, metadata !1140} ; [ DW_TAG_auto_variable ] [sc] [line 1423]
!1144 = metadata !{i32 1424, i32 0, metadata !626, metadata !1140}
!1145 = metadata !{i32 370, i32 0, metadata !180, null}
!1146 = metadata !{i32 371, i32 0, metadata !1147, null}
!1147 = metadata !{i32 786443, metadata !25, metadata !180, i32 371, i32 0, i32 70} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1148 = metadata !{i32 372, i32 0, metadata !1147, null}
!1149 = metadata !{i32 374, i32 0, metadata !1147, null}
!1150 = metadata !{metadata !766, metadata !715, i64 8}
!1151 = metadata !{i32 376, i32 0, metadata !1152, null}
!1152 = metadata !{i32 786443, metadata !25, metadata !180, i32 376, i32 0, i32 71} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1153 = metadata !{i32 377, i32 0, metadata !1154, null}
!1154 = metadata !{i32 786443, metadata !25, metadata !1152, i32 376, i32 0, i32 72} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1155 = metadata !{i32 378, i32 0, metadata !1154, null}
!1156 = metadata !{i32 381, i32 0, metadata !1157, null}
!1157 = metadata !{i32 786443, metadata !25, metadata !180, i32 381, i32 0, i32 73} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1158 = metadata !{i32 383, i32 0, metadata !180, null}
!1159 = metadata !{i32 382, i32 0, metadata !1157, null}
!1160 = metadata !{i32 386, i32 0, metadata !1161, null}
!1161 = metadata !{i32 786443, metadata !25, metadata !181, i32 385, i32 0, i32 74} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1162 = metadata !{i32 387, i32 0, metadata !1163, null}
!1163 = metadata !{i32 786443, metadata !25, metadata !1161, i32 387, i32 0, i32 75} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1164 = metadata !{metadata !712, metadata !703, i64 0}
!1165 = metadata !{i32 391, i32 0, metadata !1166, null}
!1166 = metadata !{i32 786443, metadata !25, metadata !1161, i32 391, i32 0, i32 76} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1167 = metadata !{i32 392, i32 0, metadata !1168, null}
!1168 = metadata !{i32 786443, metadata !25, metadata !1166, i32 391, i32 0, i32 77} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1169 = metadata !{i32 395, i32 0, metadata !1161, null}
!1170 = metadata !{metadata !712, metadata !704, i64 8}
!1171 = metadata !{i32 396, i32 0, metadata !1161, null}
!1172 = metadata !{i32 398, i32 0, metadata !1161, null}
!1173 = metadata !{i32 400, i32 0, metadata !167, null}
!1174 = metadata !{i32 403, i32 0, metadata !182, null}
!1175 = metadata !{i32 407, i32 0, metadata !182, null}
!1176 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1177} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1177 = metadata !{i32 409, i32 0, metadata !182, null}
!1178 = metadata !{i32 63, i32 0, metadata !651, metadata !1177}
!1179 = metadata !{i32 64, i32 0, metadata !658, metadata !1177}
!1180 = metadata !{i32 65, i32 0, metadata !657, metadata !1177}
!1181 = metadata !{i32 66, i32 0, metadata !877, metadata !1177}
!1182 = metadata !{i32 411, i32 0, metadata !1183, null}
!1183 = metadata !{i32 786443, metadata !25, metadata !182, i32 411, i32 0, i32 78} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1184 = metadata !{i32 412, i32 0, metadata !1185, null}
!1185 = metadata !{i32 786443, metadata !25, metadata !1183, i32 411, i32 0, i32 79} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1186 = metadata !{i32 413, i32 0, metadata !1185, null}
!1187 = metadata !{i32 416, i32 0, metadata !1188, null}
!1188 = metadata !{i32 786443, metadata !25, metadata !182, i32 416, i32 0, i32 80} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1189 = metadata !{metadata !702, metadata !704, i64 56}
!1190 = metadata !{i32 417, i32 0, metadata !1191, null}
!1191 = metadata !{i32 786443, metadata !25, metadata !1188, i32 416, i32 0, i32 81} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1192 = metadata !{i32 418, i32 0, metadata !1191, null}
!1193 = metadata !{i32 419, i32 0, metadata !1191, null}
!1194 = metadata !{i32 422, i32 0, metadata !194, null}
!1195 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1196} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1196 = metadata !{i32 425, i32 0, metadata !193, null}
!1197 = metadata !{i32 1415, i32 0, metadata !632, metadata !1196}
!1198 = metadata !{i32 1417, i32 0, metadata !632, metadata !1196}
!1199 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1196} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1200 = metadata !{i32 1418, i32 0, metadata !632, metadata !1196}
!1201 = metadata !{i32 786689, metadata !626, metadata !"s", metadata !26, i32 16778638, metadata !173, i32 0, metadata !1202} ; [ DW_TAG_arg_variable ] [s] [line 1422]
!1202 = metadata !{i32 426, i32 0, metadata !193, null}
!1203 = metadata !{i32 1422, i32 0, metadata !626, metadata !1202}
!1204 = metadata !{i32 1423, i32 0, metadata !626, metadata !1202}
!1205 = metadata !{i32 786688, metadata !626, metadata !"sc", metadata !26, i32 1423, metadata !173, i32 0, metadata !1202} ; [ DW_TAG_auto_variable ] [sc] [line 1423]
!1206 = metadata !{i32 1424, i32 0, metadata !626, metadata !1202}
!1207 = metadata !{i32 430, i32 0, metadata !193, null}
!1208 = metadata !{i32 431, i32 0, metadata !1209, null}
!1209 = metadata !{i32 786443, metadata !25, metadata !193, i32 431, i32 0, i32 84} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1210 = metadata !{i32 432, i32 0, metadata !1209, null}
!1211 = metadata !{i32 433, i32 0, metadata !1209, null}
!1212 = metadata !{i32 435, i32 0, metadata !1213, null}
!1213 = metadata !{i32 786443, metadata !25, metadata !193, i32 435, i32 0, i32 85} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1214 = metadata !{i32 436, i32 0, metadata !1215, null}
!1215 = metadata !{i32 786443, metadata !25, metadata !1213, i32 435, i32 0, i32 86} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1216 = metadata !{i32 437, i32 0, metadata !1215, null}
!1217 = metadata !{i32 440, i32 0, metadata !193, null}
!1218 = metadata !{i32 441, i32 0, metadata !1219, null}
!1219 = metadata !{i32 786443, metadata !25, metadata !193, i32 441, i32 0, i32 87} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1220 = metadata !{i32 444, i32 0, metadata !193, null}
!1221 = metadata !{i32 442, i32 0, metadata !1219, null}
!1222 = metadata !{i64 0}
!1223 = metadata !{i32 448, i32 0, metadata !196, null}
!1224 = metadata !{i32 449, i32 0, metadata !1225, null}
!1225 = metadata !{i32 786443, metadata !25, metadata !196, i32 449, i32 0, i32 89} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1226 = metadata !{i32 452, i32 0, metadata !1227, null}
!1227 = metadata !{i32 786443, metadata !25, metadata !1228, i32 452, i32 0, i32 91} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1228 = metadata !{i32 786443, metadata !25, metadata !1225, i32 451, i32 0, i32 90} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1229 = metadata !{metadata !757, metadata !703, i64 776}
!1230 = metadata !{i32 453, i32 0, metadata !1227, null}
!1231 = metadata !{i32 455, i32 0, metadata !1232, null}
!1232 = metadata !{i32 786443, metadata !25, metadata !1233, i32 455, i32 0, i32 93} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1233 = metadata !{i32 786443, metadata !25, metadata !1227, i32 454, i32 0, i32 92} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1234 = metadata !{i32 456, i32 0, metadata !1232, null}
!1235 = metadata !{i32 460, i32 0, metadata !1236, null}
!1236 = metadata !{i32 786443, metadata !25, metadata !196, i32 460, i32 0, i32 94} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1237 = metadata !{i32 461, i32 0, metadata !1236, null}
!1238 = metadata !{i32 463, i32 0, metadata !1239, null}
!1239 = metadata !{i32 786443, metadata !25, metadata !196, i32 463, i32 0, i32 95} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1240 = metadata !{i32 464, i32 0, metadata !1239, null}
!1241 = metadata !{i32 466, i32 0, metadata !1242, null}
!1242 = metadata !{i32 786443, metadata !25, metadata !196, i32 466, i32 0, i32 96} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1243 = metadata !{metadata !702, metadata !704, i64 16}
!1244 = metadata !{i32 467, i32 0, metadata !1242, null}
!1245 = metadata !{metadata !702, metadata !703, i64 24}
!1246 = metadata !{i32 469, i32 0, metadata !196, null}
!1247 = metadata !{i32 470, i32 0, metadata !196, null}
!1248 = metadata !{i32 472, i32 0, metadata !182, null}
!1249 = metadata !{i32 475, i32 0, metadata !197, null}
!1250 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1251} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1251 = metadata !{i32 477, i32 0, metadata !197, null}
!1252 = metadata !{i32 63, i32 0, metadata !651, metadata !1251}
!1253 = metadata !{i32 64, i32 0, metadata !658, metadata !1251}
!1254 = metadata !{i32 65, i32 0, metadata !657, metadata !1251}
!1255 = metadata !{i32 66, i32 0, metadata !877, metadata !1251}
!1256 = metadata !{i32 479, i32 0, metadata !1257, null}
!1257 = metadata !{i32 786443, metadata !25, metadata !197, i32 479, i32 0, i32 97} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1258 = metadata !{i32 480, i32 0, metadata !1259, null}
!1259 = metadata !{i32 786443, metadata !25, metadata !1257, i32 479, i32 0, i32 98} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1260 = metadata !{i32 481, i32 0, metadata !1259, null}
!1261 = metadata !{i32 484, i32 0, metadata !1262, null}
!1262 = metadata !{i32 786443, metadata !25, metadata !197, i32 484, i32 0, i32 99} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1263 = metadata !{i32 491, i32 0, metadata !1264, null}
!1264 = metadata !{i32 786443, metadata !25, metadata !1265, i32 491, i32 0, i32 101} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1265 = metadata !{i32 786443, metadata !25, metadata !1262, i32 484, i32 0, i32 100} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1266 = metadata !{i32 492, i32 0, metadata !1267, null}
!1267 = metadata !{i32 786443, metadata !25, metadata !1264, i32 491, i32 0, i32 102} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1268 = metadata !{i32 493, i32 0, metadata !1267, null}
!1269 = metadata !{i32 494, i32 0, metadata !1270, null}
!1270 = metadata !{i32 786443, metadata !25, metadata !1264, i32 493, i32 0, i32 103} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1271 = metadata !{i32 498, i32 0, metadata !1272, null}
!1272 = metadata !{i32 786443, metadata !25, metadata !1270, i32 498, i32 0, i32 104} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1273 = metadata !{i32 499, i32 0, metadata !1274, null}
!1274 = metadata !{i32 786443, metadata !25, metadata !1272, i32 498, i32 0, i32 105} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1275 = metadata !{i32 500, i32 0, metadata !1274, null}
!1276 = metadata !{i32 501, i32 0, metadata !1274, null}
!1277 = metadata !{i32 504, i32 0, metadata !1278, null}
!1278 = metadata !{i32 786443, metadata !25, metadata !1265, i32 504, i32 0, i32 106} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1279 = metadata !{i32 505, i32 0, metadata !1280, null}
!1280 = metadata !{i32 786443, metadata !25, metadata !1278, i32 504, i32 0, i32 107} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1281 = metadata !{i32 506, i32 0, metadata !1280, null}
!1282 = metadata !{i32 509, i32 0, metadata !1265, null}
!1283 = metadata !{i32 510, i32 0, metadata !1265, null}
!1284 = metadata !{i32 513, i32 0, metadata !197, null}
!1285 = metadata !{i32 515, i32 0, metadata !1286, null}
!1286 = metadata !{i32 786443, metadata !25, metadata !197, i32 513, i32 0, i32 108} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1287 = metadata !{i32 516, i32 0, metadata !1286, null}
!1288 = metadata !{i32 518, i32 0, metadata !1289, null}
!1289 = metadata !{i32 786443, metadata !25, metadata !1286, i32 517, i32 0, i32 109} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1290 = metadata !{i32 519, i32 0, metadata !1289, null}
!1291 = metadata !{i32 523, i32 0, metadata !1292, null}
!1292 = metadata !{i32 786443, metadata !25, metadata !197, i32 523, i32 0, i32 110} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1293 = metadata !{i32 524, i32 0, metadata !1294, null}
!1294 = metadata !{i32 786443, metadata !25, metadata !1292, i32 523, i32 0, i32 111} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1295 = metadata !{i32 525, i32 0, metadata !1294, null}
!1296 = metadata !{i32 528, i32 0, metadata !197, null}
!1297 = metadata !{i32 529, i32 0, metadata !197, null}
!1298 = metadata !{i32 530, i32 0, metadata !197, null}
!1299 = metadata !{i32 532, i32 0, metadata !206, null}
!1300 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1301} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1301 = metadata !{i32 533, i32 0, metadata !206, null}
!1302 = metadata !{i32 39, i32 0, metadata !666, metadata !1301}
!1303 = metadata !{i32 40, i32 0, metadata !666, metadata !1301}
!1304 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1301} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1305 = metadata !{i32 43, i32 0, metadata !699, metadata !1301}
!1306 = metadata !{i32 46, i32 0, metadata !677, metadata !1301}
!1307 = metadata !{i32 47, i32 0, metadata !675, metadata !1301}
!1308 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1301} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1309 = metadata !{i32 48, i32 0, metadata !674, metadata !1301}
!1310 = metadata !{i32 49, i32 0, metadata !710, metadata !1301}
!1311 = metadata !{i32 534, i32 0, metadata !1312, null}
!1312 = metadata !{i32 786443, metadata !25, metadata !206, i32 534, i32 0, i32 112} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1313 = metadata !{i32 535, i32 0, metadata !1314, null}
!1314 = metadata !{i32 786443, metadata !25, metadata !1312, i32 534, i32 0, i32 113} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1315 = metadata !{i32 536, i32 0, metadata !1314, null}
!1316 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1317} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1317 = metadata !{i32 541, i32 0, metadata !214, null}
!1318 = metadata !{i32 1428, i32 0, metadata !613, metadata !1317}
!1319 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1320} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1320 = metadata !{i32 1429, i32 0, metadata !613, metadata !1317}
!1321 = metadata !{i32 1415, i32 0, metadata !632, metadata !1320}
!1322 = metadata !{i32 1417, i32 0, metadata !632, metadata !1320}
!1323 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1320} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1324 = metadata !{i32 1418, i32 0, metadata !632, metadata !1320}
!1325 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1317} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1326 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1317} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1327 = metadata !{i32 1432, i32 0, metadata !622, metadata !1317}
!1328 = metadata !{i32 1433, i32 0, metadata !621, metadata !1317}
!1329 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1317} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1330 = metadata !{i32 1434, i32 0, metadata !625, metadata !1317}
!1331 = metadata !{i32 1435, i32 0, metadata !734, metadata !1317}
!1332 = metadata !{i32 1436, i32 0, metadata !737, metadata !1317}
!1333 = metadata !{i32 1437, i32 0, metadata !737, metadata !1317}
!1334 = metadata !{i32 1439, i32 0, metadata !740, metadata !1317}
!1335 = metadata !{i32 1440, i32 0, metadata !740, metadata !1317}
!1336 = metadata !{i32 1442, i32 0, metadata !624, metadata !1317}
!1337 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1317} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1338 = metadata !{i32 1443, i32 0, metadata !624, metadata !1317}
!1339 = metadata !{i32 1444, i32 0, metadata !624, metadata !1317}
!1340 = metadata !{i32 1445, i32 0, metadata !748, metadata !1317}
!1341 = metadata !{i32 545, i32 0, metadata !1342, null}
!1342 = metadata !{i32 786443, metadata !25, metadata !214, i32 545, i32 0, i32 115} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1343 = metadata !{i32 546, i32 0, metadata !1342, null}
!1344 = metadata !{i32 549, i32 0, metadata !206, null}
!1345 = metadata !{i32 551, i32 0, metadata !215, null}
!1346 = metadata !{i32 552, i32 0, metadata !245, null}
!1347 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1348} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1348 = metadata !{i32 553, i32 0, metadata !244, null}
!1349 = metadata !{i32 63, i32 0, metadata !651, metadata !1348}
!1350 = metadata !{i32 64, i32 0, metadata !658, metadata !1348}
!1351 = metadata !{i32 65, i32 0, metadata !657, metadata !1348}
!1352 = metadata !{i32 66, i32 0, metadata !877, metadata !1348}
!1353 = metadata !{i32 555, i32 0, metadata !1354, null}
!1354 = metadata !{i32 786443, metadata !25, metadata !244, i32 555, i32 0, i32 118} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1355 = metadata !{i32 556, i32 0, metadata !1356, null}
!1356 = metadata !{i32 786443, metadata !25, metadata !1354, i32 555, i32 0, i32 119} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1357 = metadata !{i32 557, i32 0, metadata !1356, null}
!1358 = metadata !{i32 558, i32 0, metadata !1359, null}
!1359 = metadata !{i32 786443, metadata !25, metadata !1354, i32 558, i32 0, i32 120} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1360 = metadata !{i32 559, i32 0, metadata !1361, null}
!1361 = metadata !{i32 786443, metadata !25, metadata !1359, i32 558, i32 0, i32 121} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1362 = metadata !{i32 560, i32 0, metadata !1361, null}
!1363 = metadata !{i32 561, i32 0, metadata !1361, null}
!1364 = metadata !{i32 563, i32 0, metadata !244, null}
!1365 = metadata !{i32 564, i32 0, metadata !244, null}
!1366 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1367} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1367 = metadata !{i32 565, i32 0, metadata !215, null}
!1368 = metadata !{i32 39, i32 0, metadata !666, metadata !1367}
!1369 = metadata !{i32 40, i32 0, metadata !666, metadata !1367}
!1370 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1367} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1371 = metadata !{i32 43, i32 0, metadata !699, metadata !1367}
!1372 = metadata !{i32 46, i32 0, metadata !677, metadata !1367}
!1373 = metadata !{i32 47, i32 0, metadata !675, metadata !1367}
!1374 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1367} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1375 = metadata !{i32 48, i32 0, metadata !674, metadata !1367}
!1376 = metadata !{i32 49, i32 0, metadata !710, metadata !1367}
!1377 = metadata !{i32 566, i32 0, metadata !1378, null}
!1378 = metadata !{i32 786443, metadata !25, metadata !215, i32 566, i32 0, i32 122} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1379 = metadata !{i32 567, i32 0, metadata !1380, null}
!1380 = metadata !{i32 786443, metadata !25, metadata !1378, i32 566, i32 0, i32 123} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1381 = metadata !{i32 568, i32 0, metadata !1380, null}
!1382 = metadata !{i32 572, i32 0, metadata !215, null}
!1383 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1384} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1384 = metadata !{i32 573, i32 0, metadata !215, null}
!1385 = metadata !{i32 1428, i32 0, metadata !613, metadata !1384}
!1386 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1387} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1387 = metadata !{i32 1429, i32 0, metadata !613, metadata !1384}
!1388 = metadata !{i32 1415, i32 0, metadata !632, metadata !1387}
!1389 = metadata !{i32 1417, i32 0, metadata !632, metadata !1387}
!1390 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1387} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1391 = metadata !{i32 1418, i32 0, metadata !632, metadata !1387}
!1392 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1384} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1393 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1384} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1394 = metadata !{i32 1432, i32 0, metadata !622, metadata !1384}
!1395 = metadata !{i32 1433, i32 0, metadata !621, metadata !1384}
!1396 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1384} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1397 = metadata !{i32 1434, i32 0, metadata !625, metadata !1384}
!1398 = metadata !{i32 1435, i32 0, metadata !734, metadata !1384}
!1399 = metadata !{i32 1436, i32 0, metadata !737, metadata !1384}
!1400 = metadata !{i32 1437, i32 0, metadata !737, metadata !1384}
!1401 = metadata !{i32 1439, i32 0, metadata !740, metadata !1384}
!1402 = metadata !{i32 1440, i32 0, metadata !740, metadata !1384}
!1403 = metadata !{i32 1442, i32 0, metadata !624, metadata !1384}
!1404 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1384} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1405 = metadata !{i32 1443, i32 0, metadata !624, metadata !1384}
!1406 = metadata !{i32 1444, i32 0, metadata !624, metadata !1384}
!1407 = metadata !{i32 1445, i32 0, metadata !748, metadata !1384}
!1408 = metadata !{i32 581, i32 0, metadata !1409, null}
!1409 = metadata !{i32 786443, metadata !25, metadata !215, i32 581, i32 0, i32 124} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1410 = metadata !{i32 582, i32 0, metadata !1409, null}
!1411 = metadata !{i32 584, i32 0, metadata !215, null}
!1412 = metadata !{i32 587, i32 0, metadata !248, null}
!1413 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1414} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1414 = metadata !{i32 588, i32 0, metadata !248, null}
!1415 = metadata !{i32 39, i32 0, metadata !666, metadata !1414}
!1416 = metadata !{i32 40, i32 0, metadata !666, metadata !1414}
!1417 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1414} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1418 = metadata !{i32 43, i32 0, metadata !699, metadata !1414}
!1419 = metadata !{i32 46, i32 0, metadata !677, metadata !1414}
!1420 = metadata !{i32 47, i32 0, metadata !675, metadata !1414}
!1421 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1414} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1422 = metadata !{i32 48, i32 0, metadata !674, metadata !1414}
!1423 = metadata !{i32 49, i32 0, metadata !710, metadata !1414}
!1424 = metadata !{i32 589, i32 0, metadata !1425, null}
!1425 = metadata !{i32 786443, metadata !25, metadata !248, i32 589, i32 0, i32 125} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1426 = metadata !{i32 590, i32 0, metadata !1427, null}
!1427 = metadata !{i32 786443, metadata !25, metadata !1425, i32 589, i32 0, i32 126} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1428 = metadata !{i32 591, i32 0, metadata !1427, null}
!1429 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1430} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1430 = metadata !{i32 596, i32 0, metadata !254, null}
!1431 = metadata !{i32 1428, i32 0, metadata !613, metadata !1430}
!1432 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1433} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1433 = metadata !{i32 1429, i32 0, metadata !613, metadata !1430}
!1434 = metadata !{i32 1415, i32 0, metadata !632, metadata !1433}
!1435 = metadata !{i32 1417, i32 0, metadata !632, metadata !1433}
!1436 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1433} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1437 = metadata !{i32 1418, i32 0, metadata !632, metadata !1433}
!1438 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1430} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1439 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1430} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1440 = metadata !{i32 1432, i32 0, metadata !622, metadata !1430}
!1441 = metadata !{i32 1433, i32 0, metadata !621, metadata !1430}
!1442 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1430} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1443 = metadata !{i32 1434, i32 0, metadata !625, metadata !1430}
!1444 = metadata !{i32 1435, i32 0, metadata !734, metadata !1430}
!1445 = metadata !{i32 1436, i32 0, metadata !737, metadata !1430}
!1446 = metadata !{i32 1437, i32 0, metadata !737, metadata !1430}
!1447 = metadata !{i32 1439, i32 0, metadata !740, metadata !1430}
!1448 = metadata !{i32 1440, i32 0, metadata !740, metadata !1430}
!1449 = metadata !{i32 1442, i32 0, metadata !624, metadata !1430}
!1450 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1430} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1451 = metadata !{i32 1443, i32 0, metadata !624, metadata !1430}
!1452 = metadata !{i32 1444, i32 0, metadata !624, metadata !1430}
!1453 = metadata !{i32 1445, i32 0, metadata !748, metadata !1430}
!1454 = metadata !{i32 600, i32 0, metadata !1455, null}
!1455 = metadata !{i32 786443, metadata !25, metadata !254, i32 600, i32 0, i32 128} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1456 = metadata !{i32 601, i32 0, metadata !1455, null}
!1457 = metadata !{i32 604, i32 0, metadata !248, null}
!1458 = metadata !{i32 606, i32 0, metadata !255, null}
!1459 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1460} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1460 = metadata !{i32 607, i32 0, metadata !255, null}
!1461 = metadata !{i32 39, i32 0, metadata !666, metadata !1460}
!1462 = metadata !{i32 40, i32 0, metadata !666, metadata !1460}
!1463 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1460} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1464 = metadata !{i32 43, i32 0, metadata !699, metadata !1460}
!1465 = metadata !{i32 46, i32 0, metadata !677, metadata !1460}
!1466 = metadata !{i32 47, i32 0, metadata !675, metadata !1460}
!1467 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1460} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1468 = metadata !{i32 48, i32 0, metadata !674, metadata !1460}
!1469 = metadata !{i32 49, i32 0, metadata !710, metadata !1460}
!1470 = metadata !{i32 609, i32 0, metadata !1471, null}
!1471 = metadata !{i32 786443, metadata !25, metadata !255, i32 609, i32 0, i32 129} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1472 = metadata !{i32 611, i32 0, metadata !1473, null}
!1473 = metadata !{i32 786443, metadata !25, metadata !1471, i32 609, i32 0, i32 130} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1474 = metadata !{i32 612, i32 0, metadata !1473, null}
!1475 = metadata !{i32 613, i32 0, metadata !1473, null}
!1476 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1477} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1477 = metadata !{i32 617, i32 0, metadata !262, null}
!1478 = metadata !{i32 1428, i32 0, metadata !613, metadata !1477}
!1479 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1480} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1480 = metadata !{i32 1429, i32 0, metadata !613, metadata !1477}
!1481 = metadata !{i32 1415, i32 0, metadata !632, metadata !1480}
!1482 = metadata !{i32 1417, i32 0, metadata !632, metadata !1480}
!1483 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1480} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1484 = metadata !{i32 1418, i32 0, metadata !632, metadata !1480}
!1485 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1477} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1486 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1477} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1487 = metadata !{i32 1432, i32 0, metadata !622, metadata !1477}
!1488 = metadata !{i32 1433, i32 0, metadata !621, metadata !1477}
!1489 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1477} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1490 = metadata !{i32 1434, i32 0, metadata !625, metadata !1477}
!1491 = metadata !{i32 1435, i32 0, metadata !734, metadata !1477}
!1492 = metadata !{i32 1436, i32 0, metadata !737, metadata !1477}
!1493 = metadata !{i32 1437, i32 0, metadata !737, metadata !1477}
!1494 = metadata !{i32 1439, i32 0, metadata !740, metadata !1477}
!1495 = metadata !{i32 1440, i32 0, metadata !740, metadata !1477}
!1496 = metadata !{i32 1442, i32 0, metadata !624, metadata !1477}
!1497 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1477} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1498 = metadata !{i32 1443, i32 0, metadata !624, metadata !1477}
!1499 = metadata !{i32 1444, i32 0, metadata !624, metadata !1477}
!1500 = metadata !{i32 1445, i32 0, metadata !748, metadata !1477}
!1501 = metadata !{i32 618, i32 0, metadata !1502, null}
!1502 = metadata !{i32 786443, metadata !25, metadata !262, i32 618, i32 0, i32 132} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1503 = metadata !{i32 619, i32 0, metadata !1502, null}
!1504 = metadata !{i32 622, i32 0, metadata !255, null}
!1505 = metadata !{i32 624, i32 0, metadata !263, null}
!1506 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1507} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1507 = metadata !{i32 625, i32 0, metadata !263, null}
!1508 = metadata !{i32 63, i32 0, metadata !651, metadata !1507}
!1509 = metadata !{i32 64, i32 0, metadata !658, metadata !1507}
!1510 = metadata !{i32 65, i32 0, metadata !657, metadata !1507}
!1511 = metadata !{i32 66, i32 0, metadata !877, metadata !1507}
!1512 = metadata !{i32 627, i32 0, metadata !1513, null}
!1513 = metadata !{i32 786443, metadata !25, metadata !263, i32 627, i32 0, i32 133} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1514 = metadata !{i32 628, i32 0, metadata !1515, null}
!1515 = metadata !{i32 786443, metadata !25, metadata !1513, i32 627, i32 0, i32 134} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1516 = metadata !{i32 629, i32 0, metadata !1515, null}
!1517 = metadata !{i32 632, i32 0, metadata !269, null}
!1518 = metadata !{i32 633, i32 0, metadata !1519, null}
!1519 = metadata !{i32 786443, metadata !25, metadata !269, i32 632, i32 0, i32 136} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1520 = metadata !{i32 634, i32 0, metadata !1519, null}
!1521 = metadata !{i32 635, i32 0, metadata !1519, null}
!1522 = metadata !{i32 637, i32 0, metadata !268, null}
!1523 = metadata !{i32 638, i32 0, metadata !1524, null}
!1524 = metadata !{i32 786443, metadata !25, metadata !268, i32 638, i32 0, i32 138} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1525 = metadata !{i32 639, i32 0, metadata !1524, null}
!1526 = metadata !{i32 642, i32 0, metadata !263, null}
!1527 = metadata !{i32 658, i32 0, metadata !270, null}
!1528 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1529} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1529 = metadata !{i32 661, i32 0, metadata !270, null}
!1530 = metadata !{i32 39, i32 0, metadata !666, metadata !1529}
!1531 = metadata !{i32 40, i32 0, metadata !666, metadata !1529}
!1532 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1529} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1533 = metadata !{i32 43, i32 0, metadata !699, metadata !1529}
!1534 = metadata !{i32 46, i32 0, metadata !677, metadata !1529}
!1535 = metadata !{i32 47, i32 0, metadata !675, metadata !1529}
!1536 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1529} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1537 = metadata !{i32 48, i32 0, metadata !674, metadata !1529}
!1538 = metadata !{i32 49, i32 0, metadata !710, metadata !1529}
!1539 = metadata !{i32 51, i32 0, metadata !674, metadata !1529}
!1540 = metadata !{i32 663, i32 0, metadata !270, null}
!1541 = metadata !{i32 664, i32 0, metadata !1542, null}
!1542 = metadata !{i32 786443, metadata !25, metadata !270, i32 664, i32 0, i32 139} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1543 = metadata !{metadata !702, metadata !704, i64 88}
!1544 = metadata !{i32 665, i32 0, metadata !1545, null}
!1545 = metadata !{i32 786443, metadata !25, metadata !1542, i32 664, i32 0, i32 140} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1546 = metadata !{i32 666, i32 0, metadata !1545, null}
!1547 = metadata !{i32 667, i32 0, metadata !1545, null}
!1548 = metadata !{i32 670, i32 0, metadata !279, null}
!1549 = metadata !{i32 786689, metadata !645, metadata !"df", metadata !26, i32 16777861, metadata !37, i32 0, metadata !1550} ; [ DW_TAG_arg_variable ] [df] [line 645]
!1550 = metadata !{i32 671, i32 0, metadata !1551, null}
!1551 = metadata !{i32 786443, metadata !25, metadata !279, i32 670, i32 0, i32 142} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1552 = metadata !{i32 645, i32 0, metadata !645, metadata !1550}
!1553 = metadata !{i32 786689, metadata !645, metadata !"mode", metadata !26, i32 33555077, metadata !92, i32 0, metadata !1550} ; [ DW_TAG_arg_variable ] [mode] [line 645]
!1554 = metadata !{i32 646, i32 0, metadata !1555, metadata !1550}
!1555 = metadata !{i32 786443, metadata !25, metadata !645, i32 646, i32 0, i32 368} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1556 = metadata !{metadata !714, metadata !703, i64 28}
!1557 = metadata !{i32 647, i32 0, metadata !1558, metadata !1550}
!1558 = metadata !{i32 786443, metadata !25, metadata !1559, i32 647, i32 0, i32 370} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1559 = metadata !{i32 786443, metadata !25, metadata !1555, i32 646, i32 0, i32 369} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1560 = metadata !{metadata !714, metadata !703, i64 32}
!1561 = metadata !{i32 648, i32 0, metadata !1558, metadata !1550}
!1562 = metadata !{i32 649, i32 0, metadata !1559, metadata !1550}
!1563 = metadata !{i32 651, i32 0, metadata !1559, metadata !1550}
!1564 = metadata !{i32 653, i32 0, metadata !1565, metadata !1550}
!1565 = metadata !{i32 786443, metadata !25, metadata !1555, i32 652, i32 0, i32 371} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1566 = metadata !{i32 654, i32 0, metadata !1565, metadata !1550}
!1567 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1568} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1568 = metadata !{i32 673, i32 0, metadata !278, null}
!1569 = metadata !{i32 1428, i32 0, metadata !613, metadata !1568}
!1570 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1571} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1571 = metadata !{i32 1429, i32 0, metadata !613, metadata !1568}
!1572 = metadata !{i32 1415, i32 0, metadata !632, metadata !1571}
!1573 = metadata !{i32 1417, i32 0, metadata !632, metadata !1571}
!1574 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1571} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1575 = metadata !{i32 1418, i32 0, metadata !632, metadata !1571}
!1576 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1568} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1577 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1568} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1578 = metadata !{i32 1432, i32 0, metadata !622, metadata !1568}
!1579 = metadata !{i32 1433, i32 0, metadata !621, metadata !1568}
!1580 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1568} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1581 = metadata !{i32 1434, i32 0, metadata !625, metadata !1568}
!1582 = metadata !{i32 1435, i32 0, metadata !734, metadata !1568}
!1583 = metadata !{i32 1436, i32 0, metadata !737, metadata !1568}
!1584 = metadata !{i32 1437, i32 0, metadata !737, metadata !1568}
!1585 = metadata !{i32 1439, i32 0, metadata !740, metadata !1568}
!1586 = metadata !{i32 1440, i32 0, metadata !740, metadata !1568}
!1587 = metadata !{i32 1442, i32 0, metadata !624, metadata !1568}
!1588 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1568} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1589 = metadata !{i32 1443, i32 0, metadata !624, metadata !1568}
!1590 = metadata !{i32 1444, i32 0, metadata !624, metadata !1568}
!1591 = metadata !{i32 1445, i32 0, metadata !748, metadata !1568}
!1592 = metadata !{i32 674, i32 0, metadata !1593, null}
!1593 = metadata !{i32 786443, metadata !25, metadata !278, i32 674, i32 0, i32 144} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1594 = metadata !{i32 675, i32 0, metadata !1593, null}
!1595 = metadata !{i32 678, i32 0, metadata !270, null}
!1596 = metadata !{i32 680, i32 0, metadata !280, null}
!1597 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1598} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1598 = metadata !{i32 683, i32 0, metadata !280, null}
!1599 = metadata !{i32 63, i32 0, metadata !651, metadata !1598}
!1600 = metadata !{i32 64, i32 0, metadata !658, metadata !1598}
!1601 = metadata !{i32 65, i32 0, metadata !657, metadata !1598}
!1602 = metadata !{i32 66, i32 0, metadata !877, metadata !1598}
!1603 = metadata !{i32 685, i32 0, metadata !1604, null}
!1604 = metadata !{i32 786443, metadata !25, metadata !280, i32 685, i32 0, i32 145} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1605 = metadata !{i32 686, i32 0, metadata !1606, null}
!1606 = metadata !{i32 786443, metadata !25, metadata !1604, i32 685, i32 0, i32 146} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1607 = metadata !{i32 687, i32 0, metadata !1606, null}
!1608 = metadata !{i32 690, i32 0, metadata !280, null}
!1609 = metadata !{i32 691, i32 0, metadata !1610, null}
!1610 = metadata !{i32 786443, metadata !25, metadata !280, i32 691, i32 0, i32 147} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1611 = metadata !{metadata !702, metadata !704, i64 96}
!1612 = metadata !{i32 692, i32 0, metadata !1613, null}
!1613 = metadata !{i32 786443, metadata !25, metadata !1610, i32 691, i32 0, i32 148} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1614 = metadata !{i32 693, i32 0, metadata !1613, null}
!1615 = metadata !{i32 694, i32 0, metadata !1613, null}
!1616 = metadata !{i32 697, i32 0, metadata !289, null}
!1617 = metadata !{i32 786689, metadata !645, metadata !"df", metadata !26, i32 16777861, metadata !37, i32 0, metadata !1618} ; [ DW_TAG_arg_variable ] [df] [line 645]
!1618 = metadata !{i32 698, i32 0, metadata !1619, null}
!1619 = metadata !{i32 786443, metadata !25, metadata !289, i32 697, i32 0, i32 150} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1620 = metadata !{i32 645, i32 0, metadata !645, metadata !1618}
!1621 = metadata !{i32 786689, metadata !645, metadata !"mode", metadata !26, i32 33555077, metadata !92, i32 0, metadata !1618} ; [ DW_TAG_arg_variable ] [mode] [line 645]
!1622 = metadata !{i32 646, i32 0, metadata !1555, metadata !1618}
!1623 = metadata !{i32 647, i32 0, metadata !1558, metadata !1618}
!1624 = metadata !{i32 648, i32 0, metadata !1558, metadata !1618}
!1625 = metadata !{i32 649, i32 0, metadata !1559, metadata !1618}
!1626 = metadata !{i32 651, i32 0, metadata !1559, metadata !1618}
!1627 = metadata !{i32 653, i32 0, metadata !1565, metadata !1618}
!1628 = metadata !{i32 654, i32 0, metadata !1565, metadata !1618}
!1629 = metadata !{i32 700, i32 0, metadata !288, null}
!1630 = metadata !{i32 701, i32 0, metadata !1631, null}
!1631 = metadata !{i32 786443, metadata !25, metadata !288, i32 701, i32 0, i32 152} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1632 = metadata !{i32 702, i32 0, metadata !1631, null}
!1633 = metadata !{i32 705, i32 0, metadata !280, null}
!1634 = metadata !{i32 713, i32 0, metadata !290, null}
!1635 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1636} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1636 = metadata !{i32 714, i32 0, metadata !290, null}
!1637 = metadata !{i32 39, i32 0, metadata !666, metadata !1636}
!1638 = metadata !{i32 40, i32 0, metadata !666, metadata !1636}
!1639 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1636} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1640 = metadata !{i32 43, i32 0, metadata !699, metadata !1636}
!1641 = metadata !{i32 46, i32 0, metadata !677, metadata !1636}
!1642 = metadata !{i32 47, i32 0, metadata !675, metadata !1636}
!1643 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1636} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1644 = metadata !{i32 48, i32 0, metadata !674, metadata !1636}
!1645 = metadata !{i32 49, i32 0, metadata !710, metadata !1636}
!1646 = metadata !{i32 716, i32 0, metadata !302, null}
!1647 = metadata !{%struct.exe_disk_file_t* null}
!1648 = metadata !{i32 786689, metadata !638, metadata !"df", metadata !26, i32 16777923, metadata !37, i32 0, metadata !1649} ; [ DW_TAG_arg_variable ] [df] [line 707]
!1649 = metadata !{i32 717, i32 0, metadata !1650, null}
!1650 = metadata !{i32 786443, metadata !25, metadata !302, i32 716, i32 0, i32 154} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1651 = metadata !{i32 707, i32 0, metadata !638, metadata !1649}
!1652 = metadata !{i32 786689, metadata !638, metadata !"owner", metadata !26, i32 33555139, metadata !293, i32 0, metadata !1649} ; [ DW_TAG_arg_variable ] [owner] [line 707]
!1653 = metadata !{i32 786689, metadata !638, metadata !"group", metadata !26, i32 50332355, metadata !294, i32 0, metadata !1649} ; [ DW_TAG_arg_variable ] [group] [line 707]
!1654 = metadata !{i32 708, i32 0, metadata !638, metadata !1649}
!1655 = metadata !{i32 709, i32 0, metadata !638, metadata !1649}
!1656 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1657} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1657 = metadata !{i32 719, i32 0, metadata !301, null}
!1658 = metadata !{i32 1428, i32 0, metadata !613, metadata !1657}
!1659 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1660} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1660 = metadata !{i32 1429, i32 0, metadata !613, metadata !1657}
!1661 = metadata !{i32 1415, i32 0, metadata !632, metadata !1660}
!1662 = metadata !{i32 1417, i32 0, metadata !632, metadata !1660}
!1663 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1660} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1664 = metadata !{i32 1418, i32 0, metadata !632, metadata !1660}
!1665 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1657} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1666 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1657} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1667 = metadata !{i32 1432, i32 0, metadata !622, metadata !1657}
!1668 = metadata !{i32 1433, i32 0, metadata !621, metadata !1657}
!1669 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1657} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1670 = metadata !{i32 1434, i32 0, metadata !625, metadata !1657}
!1671 = metadata !{i32 1435, i32 0, metadata !734, metadata !1657}
!1672 = metadata !{i32 1436, i32 0, metadata !737, metadata !1657}
!1673 = metadata !{i32 1437, i32 0, metadata !737, metadata !1657}
!1674 = metadata !{i32 1439, i32 0, metadata !740, metadata !1657}
!1675 = metadata !{i32 1440, i32 0, metadata !740, metadata !1657}
!1676 = metadata !{i32 1442, i32 0, metadata !624, metadata !1657}
!1677 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1657} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1678 = metadata !{i32 1443, i32 0, metadata !624, metadata !1657}
!1679 = metadata !{i32 1444, i32 0, metadata !624, metadata !1657}
!1680 = metadata !{i32 1445, i32 0, metadata !748, metadata !1657}
!1681 = metadata !{i32 720, i32 0, metadata !1682, null}
!1682 = metadata !{i32 786443, metadata !25, metadata !301, i32 720, i32 0, i32 156} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1683 = metadata !{i32 721, i32 0, metadata !1682, null}
!1684 = metadata !{i32 724, i32 0, metadata !290, null}
!1685 = metadata !{i32 726, i32 0, metadata !303, null}
!1686 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1687} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1687 = metadata !{i32 727, i32 0, metadata !303, null}
!1688 = metadata !{i32 63, i32 0, metadata !651, metadata !1687}
!1689 = metadata !{i32 64, i32 0, metadata !658, metadata !1687}
!1690 = metadata !{i32 65, i32 0, metadata !657, metadata !1687}
!1691 = metadata !{i32 66, i32 0, metadata !877, metadata !1687}
!1692 = metadata !{i32 729, i32 0, metadata !1693, null}
!1693 = metadata !{i32 786443, metadata !25, metadata !303, i32 729, i32 0, i32 157} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1694 = metadata !{i32 730, i32 0, metadata !1695, null}
!1695 = metadata !{i32 786443, metadata !25, metadata !1693, i32 729, i32 0, i32 158} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1696 = metadata !{i32 731, i32 0, metadata !1695, null}
!1697 = metadata !{i32 734, i32 0, metadata !313, null}
!1698 = metadata !{i32 786689, metadata !638, metadata !"df", metadata !26, i32 16777923, metadata !37, i32 0, metadata !1699} ; [ DW_TAG_arg_variable ] [df] [line 707]
!1699 = metadata !{i32 735, i32 0, metadata !1700, null}
!1700 = metadata !{i32 786443, metadata !25, metadata !313, i32 734, i32 0, i32 160} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1701 = metadata !{i32 707, i32 0, metadata !638, metadata !1699}
!1702 = metadata !{i32 786689, metadata !638, metadata !"owner", metadata !26, i32 33555139, metadata !293, i32 0, metadata !1699} ; [ DW_TAG_arg_variable ] [owner] [line 707]
!1703 = metadata !{i32 786689, metadata !638, metadata !"group", metadata !26, i32 50332355, metadata !294, i32 0, metadata !1699} ; [ DW_TAG_arg_variable ] [group] [line 707]
!1704 = metadata !{i32 708, i32 0, metadata !638, metadata !1699}
!1705 = metadata !{i32 709, i32 0, metadata !638, metadata !1699}
!1706 = metadata !{i32 737, i32 0, metadata !312, null}
!1707 = metadata !{i32 738, i32 0, metadata !1708, null}
!1708 = metadata !{i32 786443, metadata !25, metadata !312, i32 738, i32 0, i32 162} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1709 = metadata !{i32 739, i32 0, metadata !1708, null}
!1710 = metadata !{i32 742, i32 0, metadata !303, null}
!1711 = metadata !{i32 744, i32 0, metadata !314, null}
!1712 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !1713} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!1713 = metadata !{i32 746, i32 0, metadata !314, null}
!1714 = metadata !{i32 39, i32 0, metadata !666, metadata !1713}
!1715 = metadata !{i32 40, i32 0, metadata !666, metadata !1713}
!1716 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !1713} ; [ DW_TAG_auto_variable ] [c] [line 40]
!1717 = metadata !{i32 43, i32 0, metadata !699, metadata !1713}
!1718 = metadata !{i32 46, i32 0, metadata !677, metadata !1713}
!1719 = metadata !{i32 47, i32 0, metadata !675, metadata !1713}
!1720 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !1713} ; [ DW_TAG_auto_variable ] [i] [line 41]
!1721 = metadata !{i32 48, i32 0, metadata !674, metadata !1713}
!1722 = metadata !{i32 49, i32 0, metadata !710, metadata !1713}
!1723 = metadata !{i32 748, i32 0, metadata !322, null}
!1724 = metadata !{i32 786689, metadata !638, metadata !"df", metadata !26, i32 16777923, metadata !37, i32 0, metadata !1725} ; [ DW_TAG_arg_variable ] [df] [line 707]
!1725 = metadata !{i32 749, i32 0, metadata !1726, null}
!1726 = metadata !{i32 786443, metadata !25, metadata !322, i32 748, i32 0, i32 164} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1727 = metadata !{i32 707, i32 0, metadata !638, metadata !1725}
!1728 = metadata !{i32 786689, metadata !638, metadata !"owner", metadata !26, i32 33555139, metadata !293, i32 0, metadata !1725} ; [ DW_TAG_arg_variable ] [owner] [line 707]
!1729 = metadata !{i32 786689, metadata !638, metadata !"group", metadata !26, i32 50332355, metadata !294, i32 0, metadata !1725} ; [ DW_TAG_arg_variable ] [group] [line 707]
!1730 = metadata !{i32 708, i32 0, metadata !638, metadata !1725}
!1731 = metadata !{i32 709, i32 0, metadata !638, metadata !1725}
!1732 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !1733} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!1733 = metadata !{i32 751, i32 0, metadata !321, null}
!1734 = metadata !{i32 1428, i32 0, metadata !613, metadata !1733}
!1735 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !1736} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!1736 = metadata !{i32 1429, i32 0, metadata !613, metadata !1733}
!1737 = metadata !{i32 1415, i32 0, metadata !632, metadata !1736}
!1738 = metadata !{i32 1417, i32 0, metadata !632, metadata !1736}
!1739 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !1736} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!1740 = metadata !{i32 1418, i32 0, metadata !632, metadata !1736}
!1741 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !1733} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!1742 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !1733} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!1743 = metadata !{i32 1432, i32 0, metadata !622, metadata !1733}
!1744 = metadata !{i32 1433, i32 0, metadata !621, metadata !1733}
!1745 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !1733} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!1746 = metadata !{i32 1434, i32 0, metadata !625, metadata !1733}
!1747 = metadata !{i32 1435, i32 0, metadata !734, metadata !1733}
!1748 = metadata !{i32 1436, i32 0, metadata !737, metadata !1733}
!1749 = metadata !{i32 1437, i32 0, metadata !737, metadata !1733}
!1750 = metadata !{i32 1439, i32 0, metadata !740, metadata !1733}
!1751 = metadata !{i32 1440, i32 0, metadata !740, metadata !1733}
!1752 = metadata !{i32 1442, i32 0, metadata !624, metadata !1733}
!1753 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !1733} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!1754 = metadata !{i32 1443, i32 0, metadata !624, metadata !1733}
!1755 = metadata !{i32 1444, i32 0, metadata !624, metadata !1733}
!1756 = metadata !{i32 1445, i32 0, metadata !748, metadata !1733}
!1757 = metadata !{i32 752, i32 0, metadata !1758, null}
!1758 = metadata !{i32 786443, metadata !25, metadata !321, i32 752, i32 0, i32 166} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1759 = metadata !{i32 753, i32 0, metadata !1758, null}
!1760 = metadata !{i32 756, i32 0, metadata !314, null}
!1761 = metadata !{i32 758, i32 0, metadata !323, null}
!1762 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1763} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1763 = metadata !{i32 759, i32 0, metadata !323, null}
!1764 = metadata !{i32 63, i32 0, metadata !651, metadata !1763}
!1765 = metadata !{i32 64, i32 0, metadata !658, metadata !1763}
!1766 = metadata !{i32 65, i32 0, metadata !657, metadata !1763}
!1767 = metadata !{i32 66, i32 0, metadata !877, metadata !1763}
!1768 = metadata !{i32 761, i32 0, metadata !1769, null}
!1769 = metadata !{i32 786443, metadata !25, metadata !323, i32 761, i32 0, i32 167} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1770 = metadata !{i32 762, i32 0, metadata !1771, null}
!1771 = metadata !{i32 786443, metadata !25, metadata !1769, i32 761, i32 0, i32 168} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1772 = metadata !{i32 763, i32 0, metadata !1771, null}
!1773 = metadata !{i32 766, i32 0, metadata !332, null}
!1774 = metadata !{i32 768, i32 0, metadata !331, null}
!1775 = metadata !{i32 772, i32 0, metadata !1776, null}
!1776 = metadata !{i32 786443, metadata !25, metadata !331, i32 772, i32 0, i32 171} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1777 = metadata !{i32 773, i32 0, metadata !1776, null}
!1778 = metadata !{i32 777, i32 0, metadata !323, null}
!1779 = metadata !{i32 778, i32 0, metadata !323, null}
!1780 = metadata !{i32 779, i32 0, metadata !323, null}
!1781 = metadata !{i32 781, i32 0, metadata !333, null}
!1782 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1783} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1783 = metadata !{i32 783, i32 0, metadata !333, null}
!1784 = metadata !{i32 63, i32 0, metadata !651, metadata !1783}
!1785 = metadata !{i32 64, i32 0, metadata !658, metadata !1783}
!1786 = metadata !{i32 65, i32 0, metadata !657, metadata !1783}
!1787 = metadata !{i32 66, i32 0, metadata !877, metadata !1783}
!1788 = metadata !{i32 785, i32 0, metadata !333, null}
!1789 = metadata !{i32 787, i32 0, metadata !1790, null}
!1790 = metadata !{i32 786443, metadata !25, metadata !333, i32 787, i32 0, i32 172} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1791 = metadata !{i32 788, i32 0, metadata !1792, null}
!1792 = metadata !{i32 786443, metadata !25, metadata !1790, i32 787, i32 0, i32 173} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1793 = metadata !{i32 789, i32 0, metadata !1792, null}
!1794 = metadata !{i32 792, i32 0, metadata !1795, null}
!1795 = metadata !{i32 786443, metadata !25, metadata !333, i32 792, i32 0, i32 174} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1796 = metadata !{metadata !702, metadata !704, i64 72}
!1797 = metadata !{i32 793, i32 0, metadata !1798, null}
!1798 = metadata !{i32 786443, metadata !25, metadata !1795, i32 792, i32 0, i32 175} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1799 = metadata !{i32 794, i32 0, metadata !1798, null}
!1800 = metadata !{i32 795, i32 0, metadata !1798, null}
!1801 = metadata !{i32 798, i32 0, metadata !342, null}
!1802 = metadata !{i32 799, i32 0, metadata !1803, null}
!1803 = metadata !{i32 786443, metadata !25, metadata !342, i32 798, i32 0, i32 177} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1804 = metadata !{i32 800, i32 0, metadata !1803, null}
!1805 = metadata !{i32 801, i32 0, metadata !1803, null}
!1806 = metadata !{i32 804, i32 0, metadata !341, null}
!1807 = metadata !{i32 808, i32 0, metadata !1808, null}
!1808 = metadata !{i32 786443, metadata !25, metadata !341, i32 808, i32 0, i32 179} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1809 = metadata !{i32 809, i32 0, metadata !1808, null}
!1810 = metadata !{i32 812, i32 0, metadata !333, null}
!1811 = metadata !{i32 814, i32 0, metadata !343, null}
!1812 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1813} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1813 = metadata !{i32 815, i32 0, metadata !343, null}
!1814 = metadata !{i32 63, i32 0, metadata !651, metadata !1813}
!1815 = metadata !{i32 64, i32 0, metadata !658, metadata !1813}
!1816 = metadata !{i32 65, i32 0, metadata !657, metadata !1813}
!1817 = metadata !{i32 66, i32 0, metadata !877, metadata !1813}
!1818 = metadata !{i32 817, i32 0, metadata !1819, null}
!1819 = metadata !{i32 786443, metadata !25, metadata !343, i32 817, i32 0, i32 180} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1820 = metadata !{i32 818, i32 0, metadata !1821, null}
!1821 = metadata !{i32 786443, metadata !25, metadata !1819, i32 817, i32 0, i32 181} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1822 = metadata !{i32 819, i32 0, metadata !1821, null}
!1823 = metadata !{i32 822, i32 0, metadata !369, null}
!1824 = metadata !{i32 823, i32 0, metadata !1825, null}
!1825 = metadata !{i32 786443, metadata !25, metadata !369, i32 822, i32 0, i32 183} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1826 = metadata !{i32 824, i32 0, metadata !1825, null}
!1827 = metadata !{i32 825, i32 0, metadata !1825, null}
!1828 = metadata !{i32 827, i32 0, metadata !367, null}
!1829 = metadata !{i32 829, i32 0, metadata !366, null}
!1830 = metadata !{i32 832, i32 0, metadata !366, null}
!1831 = metadata !{i32 833, i32 0, metadata !1832, null}
!1832 = metadata !{i32 786443, metadata !25, metadata !366, i32 833, i32 0, i32 187} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1833 = metadata !{i32 838, i32 0, metadata !374, null}
!1834 = metadata !{i32 835, i32 0, metadata !1835, null}
!1835 = metadata !{i32 786443, metadata !25, metadata !1832, i32 834, i32 0, i32 188} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1836 = metadata !{i32 836, i32 0, metadata !1835, null}
!1837 = metadata !{i32 839, i32 0, metadata !373, null}
!1838 = metadata !{i32 840, i32 0, metadata !373, null}
!1839 = metadata !{metadata !1840, metadata !715, i64 0}
!1840 = metadata !{metadata !"dirent64", metadata !715, i64 0, metadata !715, i64 8, metadata !1841, i64 16, metadata !695, i64 18, metadata !695, i64 19}
!1841 = metadata !{metadata !"short", metadata !695, i64 0}
!1842 = metadata !{i32 841, i32 0, metadata !373, null}
!1843 = metadata !{metadata !1840, metadata !1841, i64 16}
!1844 = metadata !{i32 842, i32 0, metadata !373, null}
!1845 = metadata !{metadata !1840, metadata !695, i64 18}
!1846 = metadata !{i32 843, i32 0, metadata !373, null}
!1847 = metadata !{i32 844, i32 0, metadata !373, null}
!1848 = metadata !{i32 845, i32 0, metadata !373, null}
!1849 = metadata !{metadata !1840, metadata !715, i64 8}
!1850 = metadata !{i32 846, i32 0, metadata !373, null}
!1851 = metadata !{i32 847, i32 0, metadata !373, null}
!1852 = metadata !{i32 851, i32 0, metadata !366, null}
!1853 = metadata !{i32 852, i32 0, metadata !366, null}
!1854 = metadata !{i32 853, i32 0, metadata !366, null}
!1855 = metadata !{i32 854, i32 0, metadata !366, null}
!1856 = metadata !{i32 855, i32 0, metadata !366, null}
!1857 = metadata !{i32 856, i32 0, metadata !366, null}
!1858 = metadata !{i32 857, i32 0, metadata !366, null}
!1859 = metadata !{i32 858, i32 0, metadata !366, null}
!1860 = metadata !{i32 860, i32 0, metadata !366, null}
!1861 = metadata !{i32 862, i32 0, metadata !376, null}
!1862 = metadata !{i32 864, i32 0, metadata !376, null}
!1863 = metadata !{i32 873, i32 0, metadata !376, null}
!1864 = metadata !{i32 874, i32 0, metadata !376, null}
!1865 = metadata !{i32 875, i32 0, metadata !376, null}
!1866 = metadata !{i32 876, i32 0, metadata !376, null}
!1867 = metadata !{i32 877, i32 0, metadata !381, null}
!1868 = metadata !{i32 878, i32 0, metadata !1869, null}
!1869 = metadata !{i32 786443, metadata !25, metadata !381, i32 877, i32 0, i32 193} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1870 = metadata !{i32 879, i32 0, metadata !1869, null}
!1871 = metadata !{i32 880, i32 0, metadata !380, null}
!1872 = metadata !{i32 881, i32 0, metadata !380, null}
!1873 = metadata !{i32 885, i32 0, metadata !380, null}
!1874 = metadata !{i32 886, i32 0, metadata !383, null}
!1875 = metadata !{i32 887, i32 0, metadata !383, null}
!1876 = metadata !{i32 888, i32 0, metadata !383, null}
!1877 = metadata !{i32 895, i32 0, metadata !343, null}
!1878 = metadata !{i32 898, i32 0, metadata !384, null}
!1879 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !1880} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!1880 = metadata !{i32 902, i32 0, metadata !384, null}
!1881 = metadata !{i32 63, i32 0, metadata !651, metadata !1880}
!1882 = metadata !{i32 64, i32 0, metadata !658, metadata !1880}
!1883 = metadata !{i32 65, i32 0, metadata !657, metadata !1880}
!1884 = metadata !{i32 66, i32 0, metadata !877, metadata !1880}
!1885 = metadata !{i32 903, i32 0, metadata !384, null}
!1886 = metadata !{i32 910, i32 0, metadata !1887, null}
!1887 = metadata !{i32 786443, metadata !25, metadata !384, i32 910, i32 0, i32 196} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1888 = metadata !{i32 911, i32 0, metadata !1889, null}
!1889 = metadata !{i32 786443, metadata !25, metadata !1887, i32 910, i32 0, i32 197} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1890 = metadata !{i32 912, i32 0, metadata !1889, null}
!1891 = metadata !{i32 915, i32 0, metadata !384, null}
!1892 = metadata !{i32 916, i32 0, metadata !384, null}
!1893 = metadata !{i32 917, i32 0, metadata !384, null}
!1894 = metadata !{i32 919, i32 0, metadata !408, null}
!1895 = metadata !{i32 920, i32 0, metadata !407, null}
!1896 = metadata !{i32 922, i32 0, metadata !407, null}
!1897 = metadata !{i32 926, i32 0, metadata !410, null}
!1898 = metadata !{i32 929, i32 0, metadata !1899, null}
!1899 = metadata !{i32 786443, metadata !25, metadata !410, i32 929, i32 0, i32 202} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1900 = metadata !{metadata !1901, metadata !703, i64 24}
!1901 = metadata !{metadata !"stat", metadata !715, i64 0, metadata !715, i64 8, metadata !715, i64 16, metadata !703, i64 24, metadata !703, i64 28, metadata !703, i64 32, metadata !703, i64 36, metadata !715, i64 40, metadata !715, i64 48, metadata !715, i64 56, metadata !715, i64 64, metadata !716, i64 72, metadata !716, i64 88, metadata !716, i64 104, metadata !695, i64 120}
!1902 = metadata !{i32 932, i32 0, metadata !1903, null}
!1903 = metadata !{i32 786443, metadata !25, metadata !1899, i32 929, i32 0, i32 203} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1904 = metadata !{metadata !1905, metadata !703, i64 0}
!1905 = metadata !{metadata !"termios", metadata !703, i64 0, metadata !703, i64 4, metadata !703, i64 8, metadata !703, i64 12, metadata !695, i64 16, metadata !695, i64 17, metadata !703, i64 52, metadata !703, i64 56}
!1906 = metadata !{i32 933, i32 0, metadata !1903, null}
!1907 = metadata !{metadata !1905, metadata !703, i64 4}
!1908 = metadata !{i32 934, i32 0, metadata !1903, null}
!1909 = metadata !{metadata !1905, metadata !703, i64 8}
!1910 = metadata !{i32 935, i32 0, metadata !1903, null}
!1911 = metadata !{metadata !1905, metadata !703, i64 12}
!1912 = metadata !{i32 936, i32 0, metadata !1903, null}
!1913 = metadata !{metadata !1905, metadata !695, i64 16}
!1914 = metadata !{i32 937, i32 0, metadata !1903, null}
!1915 = metadata !{i32 938, i32 0, metadata !1903, null}
!1916 = metadata !{i32 939, i32 0, metadata !1903, null}
!1917 = metadata !{i32 940, i32 0, metadata !1903, null}
!1918 = metadata !{i32 941, i32 0, metadata !1903, null}
!1919 = metadata !{i32 942, i32 0, metadata !1903, null}
!1920 = metadata !{i32 943, i32 0, metadata !1903, null}
!1921 = metadata !{i32 944, i32 0, metadata !1903, null}
!1922 = metadata !{i32 945, i32 0, metadata !1903, null}
!1923 = metadata !{i32 946, i32 0, metadata !1903, null}
!1924 = metadata !{i32 947, i32 0, metadata !1903, null}
!1925 = metadata !{i32 948, i32 0, metadata !1903, null}
!1926 = metadata !{i32 949, i32 0, metadata !1903, null}
!1927 = metadata !{i32 950, i32 0, metadata !1903, null}
!1928 = metadata !{i32 951, i32 0, metadata !1903, null}
!1929 = metadata !{i32 952, i32 0, metadata !1903, null}
!1930 = metadata !{i32 953, i32 0, metadata !1903, null}
!1931 = metadata !{i32 954, i32 0, metadata !1903, null}
!1932 = metadata !{i32 955, i32 0, metadata !1903, null}
!1933 = metadata !{i32 956, i32 0, metadata !1903, null}
!1934 = metadata !{i32 958, i32 0, metadata !1935, null}
!1935 = metadata !{i32 786443, metadata !25, metadata !1899, i32 957, i32 0, i32 204} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1936 = metadata !{i32 959, i32 0, metadata !1935, null}
!1937 = metadata !{i32 964, i32 0, metadata !1938, null}
!1938 = metadata !{i32 786443, metadata !25, metadata !411, i32 962, i32 0, i32 205} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1939 = metadata !{i32 965, i32 0, metadata !1940, null}
!1940 = metadata !{i32 786443, metadata !25, metadata !1938, i32 965, i32 0, i32 206} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1941 = metadata !{i32 968, i32 0, metadata !1942, null}
!1942 = metadata !{i32 786443, metadata !25, metadata !1940, i32 967, i32 0, i32 208} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1943 = metadata !{i32 969, i32 0, metadata !1942, null}
!1944 = metadata !{i32 974, i32 0, metadata !1945, null}
!1945 = metadata !{i32 786443, metadata !25, metadata !411, i32 972, i32 0, i32 209} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1946 = metadata !{i32 975, i32 0, metadata !1947, null}
!1947 = metadata !{i32 786443, metadata !25, metadata !1945, i32 975, i32 0, i32 210} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1948 = metadata !{i32 978, i32 0, metadata !1949, null}
!1949 = metadata !{i32 786443, metadata !25, metadata !1947, i32 977, i32 0, i32 212} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1950 = metadata !{i32 979, i32 0, metadata !1949, null}
!1951 = metadata !{i32 984, i32 0, metadata !1952, null}
!1952 = metadata !{i32 786443, metadata !25, metadata !411, i32 982, i32 0, i32 213} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1953 = metadata !{i32 985, i32 0, metadata !1954, null}
!1954 = metadata !{i32 786443, metadata !25, metadata !1952, i32 985, i32 0, i32 214} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1955 = metadata !{i32 988, i32 0, metadata !1956, null}
!1956 = metadata !{i32 786443, metadata !25, metadata !1954, i32 987, i32 0, i32 216} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1957 = metadata !{i32 989, i32 0, metadata !1956, null}
!1958 = metadata !{i32 994, i32 0, metadata !431, null}
!1959 = metadata !{metadata !1960, metadata !1841, i64 0}
!1960 = metadata !{metadata !"winsize", metadata !1841, i64 0, metadata !1841, i64 2, metadata !1841, i64 4, metadata !1841, i64 6}
!1961 = metadata !{i32 995, i32 0, metadata !431, null}
!1962 = metadata !{metadata !1960, metadata !1841, i64 2}
!1963 = metadata !{i32 996, i32 0, metadata !431, null}
!1964 = metadata !{i32 997, i32 0, metadata !1965, null}
!1965 = metadata !{i32 786443, metadata !25, metadata !431, i32 997, i32 0, i32 218} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1966 = metadata !{i32 1000, i32 0, metadata !1967, null}
!1967 = metadata !{i32 786443, metadata !25, metadata !1965, i32 999, i32 0, i32 220} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1968 = metadata !{i32 1001, i32 0, metadata !1967, null}
!1969 = metadata !{i32 1006, i32 0, metadata !1970, null}
!1970 = metadata !{i32 786443, metadata !25, metadata !411, i32 1004, i32 0, i32 221} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1971 = metadata !{i32 1007, i32 0, metadata !1972, null}
!1972 = metadata !{i32 786443, metadata !25, metadata !1970, i32 1007, i32 0, i32 222} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1973 = metadata !{i32 1008, i32 0, metadata !1974, null}
!1974 = metadata !{i32 786443, metadata !25, metadata !1972, i32 1007, i32 0, i32 223} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1975 = metadata !{i32 1009, i32 0, metadata !1974, null}
!1976 = metadata !{i32 1011, i32 0, metadata !1977, null}
!1977 = metadata !{i32 786443, metadata !25, metadata !1972, i32 1010, i32 0, i32 224} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1978 = metadata !{i32 1012, i32 0, metadata !1977, null}
!1979 = metadata !{i32 1016, i32 0, metadata !441, null}
!1980 = metadata !{i32 1017, i32 0, metadata !441, null}
!1981 = metadata !{i32 1018, i32 0, metadata !1982, null}
!1982 = metadata !{i32 786443, metadata !25, metadata !441, i32 1018, i32 0, i32 226} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1983 = metadata !{i32 1019, i32 0, metadata !1984, null}
!1984 = metadata !{i32 786443, metadata !25, metadata !1985, i32 1019, i32 0, i32 228} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1985 = metadata !{i32 786443, metadata !25, metadata !1982, i32 1018, i32 0, i32 227} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1986 = metadata !{i32 1020, i32 0, metadata !1987, null}
!1987 = metadata !{i32 786443, metadata !25, metadata !1984, i32 1019, i32 0, i32 229} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1988 = metadata !{i32 1021, i32 0, metadata !1987, null}
!1989 = metadata !{i32 1024, i32 0, metadata !1985, null}
!1990 = metadata !{i32 1026, i32 0, metadata !1991, null}
!1991 = metadata !{i32 786443, metadata !25, metadata !1982, i32 1025, i32 0, i32 231} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1992 = metadata !{i32 1027, i32 0, metadata !1991, null}
!1993 = metadata !{i32 1031, i32 0, metadata !1994, null}
!1994 = metadata !{i32 786443, metadata !25, metadata !411, i32 1030, i32 0, i32 232} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!1995 = metadata !{i32 1032, i32 0, metadata !1994, null}
!1996 = metadata !{i32 1033, i32 0, metadata !1994, null}
!1997 = metadata !{i32 1036, i32 0, metadata !411, null}
!1998 = metadata !{i32 1037, i32 0, metadata !411, null}
!1999 = metadata !{i32 1038, i32 0, metadata !411, null}
!2000 = metadata !{i32 1041, i32 0, metadata !444, null}
!2001 = metadata !{i32 1042, i32 0, metadata !2002, null}
!2002 = metadata !{i32 786443, metadata !25, metadata !444, i32 1042, i32 0, i32 234} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2003 = metadata !{i32 1043, i32 0, metadata !2002, null}
!2004 = metadata !{i32 1046, i32 0, metadata !384, null}
!2005 = metadata !{i32 1048, i32 0, metadata !445, null}
!2006 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2007} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2007 = metadata !{i32 1049, i32 0, metadata !445, null}
!2008 = metadata !{i32 63, i32 0, metadata !651, metadata !2007}
!2009 = metadata !{i32 64, i32 0, metadata !658, metadata !2007}
!2010 = metadata !{i32 65, i32 0, metadata !657, metadata !2007}
!2011 = metadata !{i32 66, i32 0, metadata !877, metadata !2007}
!2012 = metadata !{i32 1050, i32 0, metadata !445, null}
!2013 = metadata !{i32 1053, i32 0, metadata !2014, null}
!2014 = metadata !{i32 786443, metadata !25, metadata !445, i32 1053, i32 0, i32 235} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2015 = metadata !{i32 1054, i32 0, metadata !2016, null}
!2016 = metadata !{i32 786443, metadata !25, metadata !2014, i32 1053, i32 0, i32 236} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2017 = metadata !{i32 1055, i32 0, metadata !2016, null}
!2018 = metadata !{i32 1058, i32 0, metadata !2019, null}
!2019 = metadata !{i32 786443, metadata !25, metadata !445, i32 1058, i32 0, i32 237} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2020 = metadata !{i32 1062, i32 0, metadata !2021, null}
!2021 = metadata !{i32 786443, metadata !25, metadata !2019, i32 1061, i32 0, i32 239} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2022 = metadata !{i32 1063, i32 0, metadata !2021, null}
!2023 = metadata !{i32 1064, i32 0, metadata !2021, null}
!2024 = metadata !{i32 1067, i32 0, metadata !458, null}
!2025 = metadata !{i32 1068, i32 0, metadata !457, null}
!2026 = metadata !{i32 1070, i32 0, metadata !455, null}
!2027 = metadata !{i32 1071, i32 0, metadata !2028, null}
!2028 = metadata !{i32 786443, metadata !25, metadata !455, i32 1071, i32 0, i32 244} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2029 = metadata !{i32 1}
!2030 = metadata !{i32 1072, i32 0, metadata !2028, null}
!2031 = metadata !{i32 1073, i32 0, metadata !455, null}
!2032 = metadata !{i32 1076, i32 0, metadata !2033, null}
!2033 = metadata !{i32 786443, metadata !25, metadata !456, i32 1075, i32 0, i32 245} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2034 = metadata !{i32 1077, i32 0, metadata !2035, null}
!2035 = metadata !{i32 786443, metadata !25, metadata !2033, i32 1077, i32 0, i32 246} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2036 = metadata !{i32 1078, i32 0, metadata !2035, null}
!2037 = metadata !{i32 1079, i32 0, metadata !2033, null}
!2038 = metadata !{i32 1091, i32 0, metadata !456, null}
!2039 = metadata !{i32 1092, i32 0, metadata !456, null}
!2040 = metadata !{i32 1093, i32 0, metadata !456, null}
!2041 = metadata !{i32 1096, i32 0, metadata !460, null}
!2042 = metadata !{i32 1097, i32 0, metadata !2043, null}
!2043 = metadata !{i32 786443, metadata !25, metadata !460, i32 1097, i32 0, i32 249} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2044 = metadata !{i32 1098, i32 0, metadata !2043, null}
!2045 = metadata !{i32 1101, i32 0, metadata !445, null}
!2046 = metadata !{i32 1103, i32 0, metadata !461, null}
!2047 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !2048} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!2048 = metadata !{i32 1104, i32 0, metadata !461, null}
!2049 = metadata !{i32 39, i32 0, metadata !666, metadata !2048}
!2050 = metadata !{i32 40, i32 0, metadata !666, metadata !2048}
!2051 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !2048} ; [ DW_TAG_auto_variable ] [c] [line 40]
!2052 = metadata !{i32 43, i32 0, metadata !699, metadata !2048}
!2053 = metadata !{i32 46, i32 0, metadata !677, metadata !2048}
!2054 = metadata !{i32 47, i32 0, metadata !675, metadata !2048}
!2055 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !2048} ; [ DW_TAG_auto_variable ] [i] [line 41]
!2056 = metadata !{i32 48, i32 0, metadata !674, metadata !2048}
!2057 = metadata !{i32 49, i32 0, metadata !710, metadata !2048}
!2058 = metadata !{i32 1105, i32 0, metadata !2059, null}
!2059 = metadata !{i32 786443, metadata !25, metadata !461, i32 1105, i32 0, i32 250} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2060 = metadata !{i32 1107, i32 0, metadata !2061, null}
!2061 = metadata !{i32 786443, metadata !25, metadata !2059, i32 1105, i32 0, i32 251} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2062 = metadata !{i32 1108, i32 0, metadata !2061, null}
!2063 = metadata !{i32 1109, i32 0, metadata !2061, null}
!2064 = metadata !{i32 786689, metadata !613, metadata !"s", metadata !26, i32 16778644, metadata !30, i32 0, metadata !2065} ; [ DW_TAG_arg_variable ] [s] [line 1428]
!2065 = metadata !{i32 1113, i32 0, metadata !499, null}
!2066 = metadata !{i32 1428, i32 0, metadata !613, metadata !2065}
!2067 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !2068} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!2068 = metadata !{i32 1429, i32 0, metadata !613, metadata !2065}
!2069 = metadata !{i32 1415, i32 0, metadata !632, metadata !2068}
!2070 = metadata !{i32 1417, i32 0, metadata !632, metadata !2068}
!2071 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !2068} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!2072 = metadata !{i32 1418, i32 0, metadata !632, metadata !2068}
!2073 = metadata !{i32 786688, metadata !613, metadata !"sc", metadata !26, i32 1429, metadata !44, i32 0, metadata !2065} ; [ DW_TAG_auto_variable ] [sc] [line 1429]
!2074 = metadata !{i32 786688, metadata !613, metadata !"i", metadata !26, i32 1430, metadata !42, i32 0, metadata !2065} ; [ DW_TAG_auto_variable ] [i] [line 1430]
!2075 = metadata !{i32 1432, i32 0, metadata !622, metadata !2065}
!2076 = metadata !{i32 1433, i32 0, metadata !621, metadata !2065}
!2077 = metadata !{i32 786688, metadata !621, metadata !"c", metadata !26, i32 1433, metadata !32, i32 0, metadata !2065} ; [ DW_TAG_auto_variable ] [c] [line 1433]
!2078 = metadata !{i32 1434, i32 0, metadata !625, metadata !2065}
!2079 = metadata !{i32 1435, i32 0, metadata !734, metadata !2065}
!2080 = metadata !{i32 1436, i32 0, metadata !737, metadata !2065}
!2081 = metadata !{i32 1437, i32 0, metadata !737, metadata !2065}
!2082 = metadata !{i32 1439, i32 0, metadata !740, metadata !2065}
!2083 = metadata !{i32 1440, i32 0, metadata !740, metadata !2065}
!2084 = metadata !{i32 1442, i32 0, metadata !624, metadata !2065}
!2085 = metadata !{i32 786688, metadata !624, metadata !"cc", metadata !26, i32 1442, metadata !32, i32 0, metadata !2065} ; [ DW_TAG_auto_variable ] [cc] [line 1442]
!2086 = metadata !{i32 1443, i32 0, metadata !624, metadata !2065}
!2087 = metadata !{i32 1444, i32 0, metadata !624, metadata !2065}
!2088 = metadata !{i32 1445, i32 0, metadata !748, metadata !2065}
!2089 = metadata !{i32 1114, i32 0, metadata !2090, null}
!2090 = metadata !{i32 786443, metadata !25, metadata !499, i32 1114, i32 0, i32 253} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2091 = metadata !{i32 1115, i32 0, metadata !2090, null}
!2092 = metadata !{i32 1118, i32 0, metadata !461, null}
!2093 = metadata !{i32 1120, i32 0, metadata !500, null}
!2094 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2095} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2095 = metadata !{i32 1121, i32 0, metadata !500, null}
!2096 = metadata !{i32 63, i32 0, metadata !651, metadata !2095}
!2097 = metadata !{i32 64, i32 0, metadata !658, metadata !2095}
!2098 = metadata !{i32 65, i32 0, metadata !657, metadata !2095}
!2099 = metadata !{i32 66, i32 0, metadata !877, metadata !2095}
!2100 = metadata !{i32 1123, i32 0, metadata !2101, null}
!2101 = metadata !{i32 786443, metadata !25, metadata !500, i32 1123, i32 0, i32 254} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2102 = metadata !{i32 1124, i32 0, metadata !2103, null}
!2103 = metadata !{i32 786443, metadata !25, metadata !2101, i32 1123, i32 0, i32 255} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2104 = metadata !{i32 1125, i32 0, metadata !2103, null}
!2105 = metadata !{i32 1128, i32 0, metadata !509, null}
!2106 = metadata !{i32 1129, i32 0, metadata !2107, null}
!2107 = metadata !{i32 786443, metadata !25, metadata !509, i32 1128, i32 0, i32 257} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2108 = metadata !{i32 1130, i32 0, metadata !2107, null}
!2109 = metadata !{i32 1131, i32 0, metadata !2107, null}
!2110 = metadata !{i32 1133, i32 0, metadata !508, null}
!2111 = metadata !{i32 1134, i32 0, metadata !2112, null}
!2112 = metadata !{i32 786443, metadata !25, metadata !508, i32 1134, i32 0, i32 259} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2113 = metadata !{i32 1135, i32 0, metadata !2112, null}
!2114 = metadata !{i32 1138, i32 0, metadata !500, null}
!2115 = metadata !{i32 1140, i32 0, metadata !510, null}
!2116 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2117} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2117 = metadata !{i32 1141, i32 0, metadata !510, null}
!2118 = metadata !{i32 63, i32 0, metadata !651, metadata !2117}
!2119 = metadata !{i32 64, i32 0, metadata !658, metadata !2117}
!2120 = metadata !{i32 65, i32 0, metadata !657, metadata !2117}
!2121 = metadata !{i32 66, i32 0, metadata !877, metadata !2117}
!2122 = metadata !{i32 1143, i32 0, metadata !517, null}
!2123 = metadata !{i32 1144, i32 0, metadata !2124, null}
!2124 = metadata !{i32 786443, metadata !25, metadata !517, i32 1143, i32 0, i32 261} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2125 = metadata !{i32 1145, i32 0, metadata !2124, null}
!2126 = metadata !{i32 1146, i32 0, metadata !516, null}
!2127 = metadata !{i32 1149, i32 0, metadata !515, null}
!2128 = metadata !{i32 1150, i32 0, metadata !2129, null}
!2129 = metadata !{i32 786443, metadata !25, metadata !515, i32 1150, i32 0, i32 265} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2130 = metadata !{i32 1151, i32 0, metadata !2129, null}
!2131 = metadata !{i32 1154, i32 0, metadata !510, null}
!2132 = metadata !{i32 1156, i32 0, metadata !518, null}
!2133 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2134} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2134 = metadata !{i32 1157, i32 0, metadata !518, null}
!2135 = metadata !{i32 63, i32 0, metadata !651, metadata !2134}
!2136 = metadata !{i32 64, i32 0, metadata !658, metadata !2134}
!2137 = metadata !{i32 65, i32 0, metadata !657, metadata !2134}
!2138 = metadata !{i32 66, i32 0, metadata !877, metadata !2134}
!2139 = metadata !{i32 1159, i32 0, metadata !525, null}
!2140 = metadata !{i32 1160, i32 0, metadata !2141, null}
!2141 = metadata !{i32 786443, metadata !25, metadata !525, i32 1159, i32 0, i32 267} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2142 = metadata !{i32 1161, i32 0, metadata !2141, null}
!2143 = metadata !{i32 1163, i32 0, metadata !524, null}
!2144 = metadata !{i32 1164, i32 0, metadata !2145, null}
!2145 = metadata !{i32 786443, metadata !25, metadata !524, i32 1164, i32 0, i32 269} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2146 = metadata !{i32 786689, metadata !160, metadata !"fd", metadata !26, i32 16777519, metadata !29, i32 0, metadata !2144} ; [ DW_TAG_arg_variable ] [fd] [line 303]
!2147 = metadata !{i32 303, i32 0, metadata !160, metadata !2144}
!2148 = metadata !{i32 786688, metadata !160, metadata !"r", metadata !26, i32 306, metadata !29, i32 0, metadata !2144} ; [ DW_TAG_auto_variable ] [r] [line 306]
!2149 = metadata !{i32 306, i32 0, metadata !160, metadata !2144}
!2150 = metadata !{i32 308, i32 0, metadata !160, metadata !2144}
!2151 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2152} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2152 = metadata !{i32 310, i32 0, metadata !160, metadata !2144}
!2153 = metadata !{i32 63, i32 0, metadata !651, metadata !2152}
!2154 = metadata !{i32 64, i32 0, metadata !658, metadata !2152}
!2155 = metadata !{i32 311, i32 0, metadata !1090, metadata !2144}
!2156 = metadata !{i32 786688, metadata !160, metadata !"f", metadata !26, i32 305, metadata !105, i32 0, metadata !2144} ; [ DW_TAG_auto_variable ] [f] [line 305]
!2157 = metadata !{i32 312, i32 0, metadata !1092, metadata !2144}
!2158 = metadata !{i32 313, i32 0, metadata !1092, metadata !2144}
!2159 = metadata !{i32 316, i32 0, metadata !1095, metadata !2144}
!2160 = metadata !{i32 317, i32 0, metadata !1099, metadata !2144}
!2161 = metadata !{i32 318, i32 0, metadata !1099, metadata !2144}
!2162 = metadata !{i32 319, i32 0, metadata !1099, metadata !2144}
!2163 = metadata !{i32 330, i32 0, metadata !160, metadata !2144}
!2164 = metadata !{i32 332, i32 0, metadata !160, metadata !2144}
!2165 = metadata !{i32 1168, i32 0, metadata !524, null}
!2166 = metadata !{i64 0, i64 4, metadata !752, i64 4, i64 4, metadata !752, i64 8, i64 8, metadata !2167, i64 16, i64 8, metadata !2168}
!2167 = metadata !{metadata !715, metadata !715, i64 0}
!2168 = metadata !{metadata !704, metadata !704, i64 0}
!2169 = metadata !{i32 1170, i32 0, metadata !524, null}
!2170 = metadata !{i32 1177, i32 0, metadata !524, null}
!2171 = metadata !{i32 1179, i32 0, metadata !518, null}
!2172 = metadata !{i32 1181, i32 0, metadata !526, null}
!2173 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2174} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2174 = metadata !{i32 1182, i32 0, metadata !526, null}
!2175 = metadata !{i32 63, i32 0, metadata !651, metadata !2174}
!2176 = metadata !{i32 64, i32 0, metadata !658, metadata !2174}
!2177 = metadata !{i32 65, i32 0, metadata !657, metadata !2174}
!2178 = metadata !{i32 66, i32 0, metadata !877, metadata !2174}
!2179 = metadata !{i32 1183, i32 0, metadata !532, null}
!2180 = metadata !{i32 1184, i32 0, metadata !2181, null}
!2181 = metadata !{i32 786443, metadata !25, metadata !532, i32 1183, i32 0, i32 271} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2182 = metadata !{i32 1185, i32 0, metadata !2181, null}
!2183 = metadata !{i32 1188, i32 0, metadata !2184, null}
!2184 = metadata !{i32 786443, metadata !25, metadata !531, i32 1188, i32 0, i32 273} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2185 = metadata !{i32 1189, i32 0, metadata !2186, null}
!2186 = metadata !{i32 786443, metadata !25, metadata !2184, i32 1189, i32 0, i32 274} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2187 = metadata !{i32 1191, i32 0, metadata !2188, null}
!2188 = metadata !{i32 786443, metadata !25, metadata !531, i32 1191, i32 0, i32 275} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2189 = metadata !{i32 1192, i32 0, metadata !2190, null}
!2190 = metadata !{i32 786443, metadata !25, metadata !2188, i32 1191, i32 0, i32 276} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2191 = metadata !{i32 1193, i32 0, metadata !2190, null}
!2192 = metadata !{i32 1195, i32 0, metadata !2193, null}
!2193 = metadata !{i32 786443, metadata !25, metadata !2188, i32 1194, i32 0, i32 277} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2194 = metadata !{i32 1198, i32 0, metadata !526, null}
!2195 = metadata !{i32 1200, i32 0, metadata !533, null}
!2196 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !2197} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!2197 = metadata !{i32 1201, i32 0, metadata !533, null}
!2198 = metadata !{i32 39, i32 0, metadata !666, metadata !2197}
!2199 = metadata !{i32 40, i32 0, metadata !666, metadata !2197}
!2200 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !2197} ; [ DW_TAG_auto_variable ] [c] [line 40]
!2201 = metadata !{i32 43, i32 0, metadata !699, metadata !2197}
!2202 = metadata !{i32 46, i32 0, metadata !677, metadata !2197}
!2203 = metadata !{i32 47, i32 0, metadata !675, metadata !2197}
!2204 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !2197} ; [ DW_TAG_auto_variable ] [i] [line 41]
!2205 = metadata !{i32 48, i32 0, metadata !674, metadata !2197}
!2206 = metadata !{i32 49, i32 0, metadata !710, metadata !2197}
!2207 = metadata !{i32 1202, i32 0, metadata !2208, null}
!2208 = metadata !{i32 786443, metadata !25, metadata !533, i32 1202, i32 0, i32 278} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2209 = metadata !{i32 1204, i32 0, metadata !2210, null}
!2210 = metadata !{i32 786443, metadata !25, metadata !2211, i32 1204, i32 0, i32 280} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2211 = metadata !{i32 786443, metadata !25, metadata !2208, i32 1202, i32 0, i32 279} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2212 = metadata !{i32 1205, i32 0, metadata !2213, null}
!2213 = metadata !{i32 786443, metadata !25, metadata !2210, i32 1204, i32 0, i32 281} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2214 = metadata !{i32 1206, i32 0, metadata !2213, null}
!2215 = metadata !{i32 1208, i32 0, metadata !2216, null}
!2216 = metadata !{i32 786443, metadata !25, metadata !2210, i32 1207, i32 0, i32 282} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2217 = metadata !{i32 1209, i32 0, metadata !2216, null}
!2218 = metadata !{i32 1213, i32 0, metadata !533, null}
!2219 = metadata !{i32 1214, i32 0, metadata !533, null}
!2220 = metadata !{i32 1215, i32 0, metadata !533, null}
!2221 = metadata !{i32 1216, i32 0, metadata !533, null}
!2222 = metadata !{i32 1218, i32 0, metadata !537, null}
!2223 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !2224} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!2224 = metadata !{i32 1219, i32 0, metadata !537, null}
!2225 = metadata !{i32 39, i32 0, metadata !666, metadata !2224}
!2226 = metadata !{i32 40, i32 0, metadata !666, metadata !2224}
!2227 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !2224} ; [ DW_TAG_auto_variable ] [c] [line 40]
!2228 = metadata !{i32 43, i32 0, metadata !699, metadata !2224}
!2229 = metadata !{i32 46, i32 0, metadata !677, metadata !2224}
!2230 = metadata !{i32 47, i32 0, metadata !675, metadata !2224}
!2231 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !2224} ; [ DW_TAG_auto_variable ] [i] [line 41]
!2232 = metadata !{i32 48, i32 0, metadata !674, metadata !2224}
!2233 = metadata !{i32 49, i32 0, metadata !710, metadata !2224}
!2234 = metadata !{i32 1220, i32 0, metadata !2235, null}
!2235 = metadata !{i32 786443, metadata !25, metadata !537, i32 1220, i32 0, i32 283} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2236 = metadata !{i32 1222, i32 0, metadata !2237, null}
!2237 = metadata !{i32 786443, metadata !25, metadata !2238, i32 1222, i32 0, i32 285} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2238 = metadata !{i32 786443, metadata !25, metadata !2235, i32 1220, i32 0, i32 284} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2239 = metadata !{i32 1223, i32 0, metadata !2240, null}
!2240 = metadata !{i32 786443, metadata !25, metadata !2237, i32 1222, i32 0, i32 286} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2241 = metadata !{i32 1224, i32 0, metadata !2240, null}
!2242 = metadata !{i32 1225, i32 0, metadata !2243, null}
!2243 = metadata !{i32 786443, metadata !25, metadata !2237, i32 1225, i32 0, i32 287} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2244 = metadata !{i32 1226, i32 0, metadata !2245, null}
!2245 = metadata !{i32 786443, metadata !25, metadata !2243, i32 1225, i32 0, i32 288} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2246 = metadata !{i32 1227, i32 0, metadata !2245, null}
!2247 = metadata !{i32 1229, i32 0, metadata !2248, null}
!2248 = metadata !{i32 786443, metadata !25, metadata !2243, i32 1228, i32 0, i32 289} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2249 = metadata !{i32 1230, i32 0, metadata !2248, null}
!2250 = metadata !{i32 1234, i32 0, metadata !537, null}
!2251 = metadata !{i32 1235, i32 0, metadata !537, null}
!2252 = metadata !{i32 1236, i32 0, metadata !537, null}
!2253 = metadata !{i32 1237, i32 0, metadata !537, null}
!2254 = metadata !{i32 1239, i32 0, metadata !541, null}
!2255 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !2256} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!2256 = metadata !{i32 1242, i32 0, metadata !541, null}
!2257 = metadata !{i32 39, i32 0, metadata !666, metadata !2256}
!2258 = metadata !{i32 40, i32 0, metadata !666, metadata !2256}
!2259 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !2256} ; [ DW_TAG_auto_variable ] [c] [line 40]
!2260 = metadata !{i32 43, i32 0, metadata !699, metadata !2256}
!2261 = metadata !{i32 46, i32 0, metadata !677, metadata !2256}
!2262 = metadata !{i32 47, i32 0, metadata !675, metadata !2256}
!2263 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !2256} ; [ DW_TAG_auto_variable ] [i] [line 41]
!2264 = metadata !{i32 48, i32 0, metadata !674, metadata !2256}
!2265 = metadata !{i32 49, i32 0, metadata !710, metadata !2256}
!2266 = metadata !{i32 1243, i32 0, metadata !2267, null}
!2267 = metadata !{i32 786443, metadata !25, metadata !541, i32 1243, i32 0, i32 290} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2268 = metadata !{i32 1245, i32 0, metadata !2269, null}
!2269 = metadata !{i32 786443, metadata !25, metadata !2270, i32 1245, i32 0, i32 292} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2270 = metadata !{i32 786443, metadata !25, metadata !2267, i32 1243, i32 0, i32 291} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2271 = metadata !{i32 1246, i32 0, metadata !2272, null}
!2272 = metadata !{i32 786443, metadata !25, metadata !2269, i32 1245, i32 0, i32 293} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2273 = metadata !{i32 1247, i32 0, metadata !2272, null}
!2274 = metadata !{i32 1248, i32 0, metadata !2275, null}
!2275 = metadata !{i32 786443, metadata !25, metadata !2269, i32 1248, i32 0, i32 294} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2276 = metadata !{i32 1249, i32 0, metadata !2277, null}
!2277 = metadata !{i32 786443, metadata !25, metadata !2275, i32 1248, i32 0, i32 295} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2278 = metadata !{i32 1250, i32 0, metadata !2277, null}
!2279 = metadata !{i32 1252, i32 0, metadata !2280, null}
!2280 = metadata !{i32 786443, metadata !25, metadata !2275, i32 1251, i32 0, i32 296} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2281 = metadata !{i32 1253, i32 0, metadata !2280, null}
!2282 = metadata !{i32 1257, i32 0, metadata !541, null}
!2283 = metadata !{i32 1258, i32 0, metadata !541, null}
!2284 = metadata !{i32 1259, i32 0, metadata !541, null}
!2285 = metadata !{i32 1260, i32 0, metadata !541, null}
!2286 = metadata !{i32 1262, i32 0, metadata !549, null}
!2287 = metadata !{i32 786689, metadata !666, metadata !"pathname", metadata !26, i32 16777255, metadata !30, i32 0, metadata !2288} ; [ DW_TAG_arg_variable ] [pathname] [line 39]
!2288 = metadata !{i32 1263, i32 0, metadata !549, null}
!2289 = metadata !{i32 39, i32 0, metadata !666, metadata !2288}
!2290 = metadata !{i32 40, i32 0, metadata !666, metadata !2288}
!2291 = metadata !{i32 786688, metadata !666, metadata !"c", metadata !26, i32 40, metadata !32, i32 0, metadata !2288} ; [ DW_TAG_auto_variable ] [c] [line 40]
!2292 = metadata !{i32 43, i32 0, metadata !699, metadata !2288}
!2293 = metadata !{i32 46, i32 0, metadata !677, metadata !2288}
!2294 = metadata !{i32 47, i32 0, metadata !675, metadata !2288}
!2295 = metadata !{i32 786688, metadata !666, metadata !"i", metadata !26, i32 41, metadata !42, i32 0, metadata !2288} ; [ DW_TAG_auto_variable ] [i] [line 41]
!2296 = metadata !{i32 48, i32 0, metadata !674, metadata !2288}
!2297 = metadata !{i32 49, i32 0, metadata !710, metadata !2288}
!2298 = metadata !{i32 1264, i32 0, metadata !559, null}
!2299 = metadata !{i32 1267, i32 0, metadata !2300, null}
!2300 = metadata !{i32 786443, metadata !25, metadata !2301, i32 1267, i32 0, i32 299} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2301 = metadata !{i32 786443, metadata !25, metadata !559, i32 1264, i32 0, i32 298} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2302 = metadata !{i32 1268, i32 0, metadata !2303, null}
!2303 = metadata !{i32 786443, metadata !25, metadata !2300, i32 1267, i32 0, i32 300} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2304 = metadata !{i32 1269, i32 0, metadata !2305, null}
!2305 = metadata !{i32 786443, metadata !25, metadata !2303, i32 1269, i32 0, i32 301} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2306 = metadata !{i32 1270, i32 0, metadata !2307, null}
!2307 = metadata !{i32 786443, metadata !25, metadata !2303, i32 1270, i32 0, i32 302} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2308 = metadata !{i32 1271, i32 0, metadata !2309, null}
!2309 = metadata !{i32 786443, metadata !25, metadata !2303, i32 1271, i32 0, i32 303} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2310 = metadata !{i32 1272, i32 0, metadata !2311, null}
!2311 = metadata !{i32 786443, metadata !25, metadata !2303, i32 1272, i32 0, i32 304} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2312 = metadata !{i32 1273, i32 0, metadata !2303, null}
!2313 = metadata !{i32 1275, i32 0, metadata !2314, null}
!2314 = metadata !{i32 786443, metadata !25, metadata !2300, i32 1274, i32 0, i32 305} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2315 = metadata !{i32 1276, i32 0, metadata !2314, null}
!2316 = metadata !{i32 1279, i32 0, metadata !558, null}
!2317 = metadata !{i32 1280, i32 0, metadata !2318, null}
!2318 = metadata !{i32 786443, metadata !25, metadata !558, i32 1280, i32 0, i32 307} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2319 = metadata !{i32 1281, i32 0, metadata !2318, null}
!2320 = metadata !{i32 1282, i32 0, metadata !558, null}
!2321 = metadata !{i32 1284, i32 0, metadata !549, null}
!2322 = metadata !{i32 1294, i32 0, metadata !560, null}
!2323 = metadata !{i32 1295, i32 0, metadata !560, null}
!2324 = metadata !{i32 1296, i32 0, metadata !560, null}
!2325 = metadata !{i32 1297, i32 0, metadata !560, null}
!2326 = metadata !{i32 1299, i32 0, metadata !2327, null}
!2327 = metadata !{i32 786443, metadata !25, metadata !560, i32 1299, i32 0, i32 308} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2328 = metadata !{i32 1300, i32 0, metadata !2329, null}
!2329 = metadata !{i32 786443, metadata !25, metadata !2327, i32 1299, i32 0, i32 309} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2330 = metadata !{i64 0, i64 128, metadata !694}
!2331 = metadata !{i32 1301, i32 0, metadata !2329, null}
!2332 = metadata !{i32 1302, i32 0, metadata !2329, null}
!2333 = metadata !{i32 1303, i32 0, metadata !2334, null}
!2334 = metadata !{i32 786443, metadata !25, metadata !2327, i32 1302, i32 0, i32 310} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2335 = metadata !{i32 1306, i32 0, metadata !2336, null}
!2336 = metadata !{i32 786443, metadata !25, metadata !560, i32 1306, i32 0, i32 311} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2337 = metadata !{i32 1307, i32 0, metadata !2338, null}
!2338 = metadata !{i32 786443, metadata !25, metadata !2336, i32 1306, i32 0, i32 312} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2339 = metadata !{i32 1308, i32 0, metadata !2338, null}
!2340 = metadata !{i32 1309, i32 0, metadata !2338, null}
!2341 = metadata !{i32 1310, i32 0, metadata !2342, null}
!2342 = metadata !{i32 786443, metadata !25, metadata !2336, i32 1309, i32 0, i32 313} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2343 = metadata !{i32 1313, i32 0, metadata !2344, null}
!2344 = metadata !{i32 786443, metadata !25, metadata !560, i32 1313, i32 0, i32 314} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2345 = metadata !{i32 1314, i32 0, metadata !2346, null}
!2346 = metadata !{i32 786443, metadata !25, metadata !2344, i32 1313, i32 0, i32 315} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2347 = metadata !{i32 1315, i32 0, metadata !2346, null}
!2348 = metadata !{i32 1316, i32 0, metadata !2346, null}
!2349 = metadata !{i32 1317, i32 0, metadata !2350, null}
!2350 = metadata !{i32 786443, metadata !25, metadata !2344, i32 1316, i32 0, i32 316} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2351 = metadata !{i32 1320, i32 0, metadata !560, null}
!2352 = metadata !{i32 1321, i32 0, metadata !560, null}
!2353 = metadata !{i32 1322, i32 0, metadata !560, null}
!2354 = metadata !{i32 1325, i32 0, metadata !593, null}
!2355 = metadata !{i32 1326, i32 0, metadata !591, null}
!2356 = metadata !{i32 undef}
!2357 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2358} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2358 = metadata !{i32 1327, i32 0, metadata !590, null}
!2359 = metadata !{i32 63, i32 0, metadata !651, metadata !2358}
!2360 = metadata !{i32 64, i32 0, metadata !658, metadata !2358}
!2361 = metadata !{i32 66, i32 0, metadata !877, metadata !2358}
!2362 = metadata !{i32 65, i32 0, metadata !657, metadata !2358}
!2363 = metadata !{i32 1328, i32 0, metadata !2364, null}
!2364 = metadata !{i32 786443, metadata !25, metadata !590, i32 1328, i32 0, i32 321} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2365 = metadata !{i32 1329, i32 0, metadata !2366, null}
!2366 = metadata !{i32 786443, metadata !25, metadata !2364, i32 1328, i32 0, i32 322} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2367 = metadata !{i32 1330, i32 0, metadata !2366, null}
!2368 = metadata !{i32 1331, i32 0, metadata !2369, null}
!2369 = metadata !{i32 786443, metadata !25, metadata !2364, i32 1331, i32 0, i32 323} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2370 = metadata !{i32 1333, i32 0, metadata !2371, null}
!2371 = metadata !{i32 786443, metadata !25, metadata !2372, i32 1333, i32 0, i32 325} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2372 = metadata !{i32 786443, metadata !25, metadata !2369, i32 1331, i32 0, i32 324} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2373 = metadata !{i32 1334, i32 0, metadata !2374, null}
!2374 = metadata !{i32 786443, metadata !25, metadata !2372, i32 1334, i32 0, i32 326} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2375 = metadata !{i32 1335, i32 0, metadata !2376, null}
!2376 = metadata !{i32 786443, metadata !25, metadata !2372, i32 1335, i32 0, i32 327} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2377 = metadata !{i32 1336, i32 0, metadata !2372, null}
!2378 = metadata !{i32 1337, i32 0, metadata !2372, null}
!2379 = metadata !{i32 1338, i32 0, metadata !2380, null}
!2380 = metadata !{i32 786443, metadata !25, metadata !2381, i32 1338, i32 0, i32 329} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2381 = metadata !{i32 786443, metadata !25, metadata !2369, i32 1337, i32 0, i32 328} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2382 = metadata !{i32 1339, i32 0, metadata !2383, null}
!2383 = metadata !{i32 786443, metadata !25, metadata !2381, i32 1339, i32 0, i32 330} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2384 = metadata !{i32 1340, i32 0, metadata !2385, null}
!2385 = metadata !{i32 786443, metadata !25, metadata !2381, i32 1340, i32 0, i32 331} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2386 = metadata !{i32 1341, i32 0, metadata !2387, null}
!2387 = metadata !{i32 786443, metadata !25, metadata !2381, i32 1341, i32 0, i32 332} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2388 = metadata !{i32 1346, i32 0, metadata !596, null}
!2389 = metadata !{i32 1349, i32 0, metadata !595, null}
!2390 = metadata !{i32 1350, i32 0, metadata !595, null}
!2391 = metadata !{i32 1353, i32 0, metadata !602, null}
!2392 = metadata !{i32 1356, i32 0, metadata !2393, null}
!2393 = metadata !{i32 786443, metadata !25, metadata !2394, i32 1356, i32 0, i32 337} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2394 = metadata !{i32 786443, metadata !25, metadata !602, i32 1353, i32 0, i32 336} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2395 = metadata !{i32 1357, i32 0, metadata !2396, null}
!2396 = metadata !{i32 786443, metadata !25, metadata !2393, i32 1356, i32 0, i32 338} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2397 = metadata !{i32 1358, i32 0, metadata !2396, null}
!2398 = metadata !{i32 1361, i32 0, metadata !601, null}
!2399 = metadata !{i32 1364, i32 0, metadata !600, null}
!2400 = metadata !{i32 786689, metadata !651, metadata !"fd", metadata !26, i32 16777279, metadata !29, i32 0, metadata !2401} ; [ DW_TAG_arg_variable ] [fd] [line 63]
!2401 = metadata !{i32 1365, i32 0, metadata !599, null}
!2402 = metadata !{i32 63, i32 0, metadata !651, metadata !2401}
!2403 = metadata !{i32 64, i32 0, metadata !658, metadata !2401}
!2404 = metadata !{i32 66, i32 0, metadata !877, metadata !2401}
!2405 = metadata !{i32 65, i32 0, metadata !657, metadata !2401}
!2406 = metadata !{i32 1366, i32 0, metadata !2407, null}
!2407 = metadata !{i32 786443, metadata !25, metadata !599, i32 1366, i32 0, i32 342} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2408 = metadata !{i32 1367, i32 0, metadata !2409, null}
!2409 = metadata !{i32 786443, metadata !25, metadata !2410, i32 1367, i32 0, i32 344} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2410 = metadata !{i32 786443, metadata !25, metadata !2407, i32 1366, i32 0, i32 343} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2411 = metadata !{i32 1368, i32 0, metadata !2412, null}
!2412 = metadata !{i32 786443, metadata !25, metadata !2410, i32 1368, i32 0, i32 345} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2413 = metadata !{i32 1369, i32 0, metadata !2414, null}
!2414 = metadata !{i32 786443, metadata !25, metadata !2410, i32 1369, i32 0, i32 346} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2415 = metadata !{i32 1376, i32 0, metadata !560, null}
!2416 = metadata !{i32 1380, i32 0, metadata !603, null}
!2417 = metadata !{i32 1384, i32 0, metadata !603, null}
!2418 = metadata !{i32 1386, i32 0, metadata !2419, null}
!2419 = metadata !{i32 786443, metadata !25, metadata !603, i32 1386, i32 0, i32 347} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2420 = metadata !{metadata !702, metadata !704, i64 80}
!2421 = metadata !{i32 1387, i32 0, metadata !2422, null}
!2422 = metadata !{i32 786443, metadata !25, metadata !2419, i32 1386, i32 0, i32 348} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2423 = metadata !{i32 1388, i32 0, metadata !2422, null}
!2424 = metadata !{i32 1389, i32 0, metadata !2422, null}
!2425 = metadata !{i32 1392, i32 0, metadata !2426, null}
!2426 = metadata !{i32 786443, metadata !25, metadata !603, i32 1392, i32 0, i32 349} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2427 = metadata !{i32 1393, i32 0, metadata !2428, null}
!2428 = metadata !{i32 786443, metadata !25, metadata !2429, i32 1393, i32 0, i32 351} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2429 = metadata !{i32 786443, metadata !25, metadata !2426, i32 1392, i32 0, i32 350} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2430 = metadata !{i64 1024}
!2431 = metadata !{i32 1394, i32 0, metadata !2428, null}
!2432 = metadata !{i32 1395, i32 0, metadata !2429, null}
!2433 = metadata !{i32 1396, i32 0, metadata !2429, null}
!2434 = metadata !{i32 786689, metadata !632, metadata !"p", metadata !26, i32 16778631, metadata !185, i32 0, metadata !2435} ; [ DW_TAG_arg_variable ] [p] [line 1415]
!2435 = metadata !{i32 1398, i32 0, metadata !603, null}
!2436 = metadata !{i32 1415, i32 0, metadata !632, metadata !2435}
!2437 = metadata !{i32 1417, i32 0, metadata !632, metadata !2435}
!2438 = metadata !{i32 786688, metadata !632, metadata !"pc", metadata !26, i32 1417, metadata !44, i32 0, metadata !2435} ; [ DW_TAG_auto_variable ] [pc] [line 1417]
!2439 = metadata !{i32 1418, i32 0, metadata !632, metadata !2435}
!2440 = metadata !{i32 786689, metadata !626, metadata !"s", metadata !26, i32 16778638, metadata !173, i32 0, metadata !2441} ; [ DW_TAG_arg_variable ] [s] [line 1422]
!2441 = metadata !{i32 1399, i32 0, metadata !603, null}
!2442 = metadata !{i32 1422, i32 0, metadata !626, metadata !2441}
!2443 = metadata !{i32 1423, i32 0, metadata !626, metadata !2441}
!2444 = metadata !{i32 786688, metadata !626, metadata !"sc", metadata !26, i32 1423, metadata !173, i32 0, metadata !2441} ; [ DW_TAG_auto_variable ] [sc] [line 1423]
!2445 = metadata !{i32 1424, i32 0, metadata !626, metadata !2441}
!2446 = metadata !{i32 1403, i32 0, metadata !603, null}
!2447 = metadata !{i32 1404, i32 0, metadata !603, null}
!2448 = metadata !{i32 1405, i32 0, metadata !2449, null}
!2449 = metadata !{i32 786443, metadata !25, metadata !603, i32 1405, i32 0, i32 352} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2450 = metadata !{i32 1406, i32 0, metadata !2451, null}
!2451 = metadata !{i32 786443, metadata !25, metadata !2449, i32 1405, i32 0, i32 353} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2452 = metadata !{i32 1407, i32 0, metadata !2451, null}
!2453 = metadata !{i32 1411, i32 0, metadata !603, null}
!2454 = metadata !{i32 1457, i32 0, metadata !610, null}
!2455 = metadata !{i32 1458, i32 0, metadata !2456, null}
!2456 = metadata !{i32 786443, metadata !25, metadata !610, i32 1458, i32 0, i32 354} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2457 = metadata !{i32 1459, i32 0, metadata !2458, null}
!2458 = metadata !{i32 786443, metadata !25, metadata !2456, i32 1458, i32 0, i32 355} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2459 = metadata !{i32 1460, i32 0, metadata !2458, null}
!2460 = metadata !{i32 1463, i32 0, metadata !2461, null}
!2461 = metadata !{i32 786443, metadata !25, metadata !610, i32 1463, i32 0, i32 356} ; [ DW_TAG_lexical_block ] [/home/tannguyen/Dropbox/NUS/Test_Merge/TracerX_Taint/runtime/POSIX/fd.c]
!2462 = metadata !{i32 1467, i32 0, metadata !610, null}
!2463 = metadata !{i32 1468, i32 0, metadata !610, null}
!2464 = metadata !{i32 1469, i32 0, metadata !610, null}
!2465 = metadata !{i32 1470, i32 0, metadata !610, null}
