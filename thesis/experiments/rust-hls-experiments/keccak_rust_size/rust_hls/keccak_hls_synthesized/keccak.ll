; ModuleID = '<stdin>'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"unwind::libunwind::_Unwind_Exception" = type { i64, void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [2 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

@alloc400 = hidden unnamed_addr constant <{ [65 x i8] }> <{ [65 x i8] c"A round_count greater than KECCAK_F_ROUND_COUNT is not supported!" }>, align 1
@alloc407 = hidden unnamed_addr constant <{ [85 x i8] }> <{ [85 x i8] c"/home/lennart/.cargo/registry/src/github.com-1ecc6299db9ec823/keccak-0.1.4/src/lib.rs" }>, align 1
@alloc395 = hidden unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [85 x i8] }>, <{ [85 x i8] }>* @alloc407, i32 0, i32 0, i32 0), [16 x i8] c"U\00\00\00\00\00\00\00\EB\00\00\00\09\00\00\00" }>, align 8
@alloc331 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8
@alloc397 = hidden unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [85 x i8] }>, <{ [85 x i8] }>* @alloc407, i32 0, i32 0, i32 0), [16 x i8] c"U\00\00\00\00\00\00\00\F0\00\00\00\19\00\00\00" }>, align 8
@anon.81d2408192f774ffc0f511fc69066f5d.0 = hidden unnamed_addr constant <{ [25 x i8] }> <{ [25 x i8] c"\00\01>\1C\1B$,\067\14\03\0A+\19')-\0F\15\08\12\02=8\0E" }>, align 1
@anon.81d2408192f774ffc0f511fc69066f5d.1 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8




; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #0

; Function Attrs: nonlazybind
declare i32 @rust_eh_personality(...) unnamed_addr #2

; Function Attrs: minsize nounwind nonlazybind optsize
define void @_ZN11rust_keccak6keccak6keccak17h2679fb9ef1213577E(i64* nocapture noundef %a) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
start:
  %c.i32 = alloca [5 x i64], align 8
  %temp_a.i = alloca [25 x i64], align 8
  %d.i = alloca [5 x i64], align 8
  %c.i = alloca [5 x i64], align 8
  %0 = bitcast [5 x i64]* %c.i to i8*
  %1 = bitcast [5 x i64]* %d.i to i8*
  %2 = bitcast [25 x i64]* %temp_a.i to i8*
  %3 = bitcast [5 x i64]* %c.i32 to i8*
  br label %bb2

bb2:                                              ; preds = %_ZN11rust_keccak6keccak4iota17h5c260f57d9577ed6E.exit, %start
  %iter.sroa.0.0 = phi i64 [ 0, %start ], [ %50, %_ZN11rust_keccak6keccak4iota17h5c260f57d9577ed6E.exit ]
  %exitcond.not = icmp eq i64 %iter.sroa.0.0, 24
  br i1 %exitcond.not, label %bb6, label %bb4

bb6:                                              ; preds = %bb2
  ret void

bb4:                                              ; preds = %bb2
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %0)
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %0, i8 0, i64 40, i1 false)
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %1)
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %1, i8 0, i64 40, i1 false)
  br label %bb2.i

bb2.loopexit.i:                                   ; preds = %bb9.i
  %4 = add nuw nsw i64 %iter.sroa.0.0.i, 1
  %5 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %iter.sroa.0.0.i
  store i64 %storemerge.i, i64* %5, align 8
  br label %bb2.i

bb2.i:                                            ; preds = %bb2.loopexit.i, %bb4
  %iter.sroa.0.0.i = phi i64 [ 0, %bb4 ], [ %4, %bb2.loopexit.i ]
  %exitcond121.not.i = icmp eq i64 %iter.sroa.0.0.i, 5
  br i1 %exitcond121.not.i, label %bb17.i, label %bb7.i

bb7.i:                                            ; preds = %bb2.i
  %_23.i = urem i64 %iter.sroa.0.0.i, 5
  br label %bb9.i

bb9.i:                                            ; preds = %bb11.i, %bb7.i
  %storemerge.i = phi i64 [ 0, %bb7.i ], [ %8, %bb11.i ]
  %iter1.sroa.0.0.i = phi i64 [ 0, %bb7.i ], [ %6, %bb11.i ]
  %exitcond.not.i = icmp eq i64 %iter1.sroa.0.0.i, 5
  br i1 %exitcond.not.i, label %bb2.loopexit.i, label %bb11.i

bb11.i:                                           ; preds = %bb9.i
  %6 = add nuw nsw i64 %iter1.sroa.0.0.i, 1
  %_25.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i to i8
  %_25114.i = urem i8 %_25.lhs.trunc.i, 5
  %narrow120.i = mul nuw nsw i8 %_25114.i, 5
  %_24.i = zext i8 %narrow120.i to i64
  %_22.i = add nuw nsw i64 %_23.i, %_24.i
  %7 = getelementptr inbounds i64, i64* %a, i64 %_22.i
  %_20.i = load i64, i64* %7, align 8, !noundef !2
  %8 = xor i64 %_20.i, %storemerge.i
  br label %bb9.i

bb17.i:                                           ; preds = %bb27.i, %bb2.i
  %iter2.sroa.0.0.i = phi i64 [ %9, %bb27.i ], [ 0, %bb2.i ]
  %exitcond122.not.i = icmp eq i64 %iter2.sroa.0.0.i, 5
  br i1 %exitcond122.not.i, label %bb29.i, label %bb27.i

bb27.i:                                           ; preds = %bb17.i
  %9 = add nuw nsw i64 %iter2.sroa.0.0.i, 1
  %10 = trunc i64 %iter2.sroa.0.0.i to i8
  %_39.lhs.trunc.i = add i8 %10, 1
  %_39115.i = urem i8 %_39.lhs.trunc.i, 5
  %_39.zext.i = zext i8 %_39115.i to i64
  %11 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_39.zext.i
  %_38.i = load i64, i64* %11, align 8, !noundef !2
  %_3556.i = tail call i64 @llvm.fshl.i64(i64 %_38.i, i64 %_38.i, i64 1)
  %_52.lhs.trunc.i = add i8 %10, 4
  %_52116.i = urem i8 %_52.lhs.trunc.i, 5
  %_52.zext.i = zext i8 %_52116.i to i64
  %12 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_52.zext.i
  %_51.i = load i64, i64* %12, align 8, !noundef !2
  %13 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter2.sroa.0.0.i
  %14 = xor i64 %_3556.i, %_51.i
  store i64 %14, i64* %13, align 8
  br label %bb17.i

bb29.loopexit.i:                                  ; preds = %bb35.i
  %15 = add nuw nsw i64 %iter3.sroa.0.0.i, 1
  br label %bb29.i

bb29.i:                                           ; preds = %bb29.loopexit.i, %bb17.i
  %iter3.sroa.0.0.i = phi i64 [ %15, %bb29.loopexit.i ], [ 0, %bb17.i ]
  %exitcond124.not.i = icmp eq i64 %iter3.sroa.0.0.i, 5
  br i1 %exitcond124.not.i, label %_ZN11rust_keccak6keccak5theta17h45602c6d645df8e6E.exit, label %bb31.i

bb31.i:                                           ; preds = %bb29.i
  %16 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter3.sroa.0.0.i
  %_72.i = load i64, i64* %16, align 8, !noundef !2
  %_77.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i to i8
  %_77117.i = urem i8 %_77.lhs.trunc.i, 5
  br label %bb35.i

bb35.i:                                           ; preds = %bb40.i, %bb31.i
  %iter4.sroa.0.0.i = phi i64 [ 0, %bb31.i ], [ %17, %bb40.i ]
  %exitcond123.not.i = icmp eq i64 %iter4.sroa.0.0.i, 5
  br i1 %exitcond123.not.i, label %bb29.loopexit.i, label %bb40.i

bb40.i:                                           ; preds = %bb35.i
  %17 = add nuw nsw i64 %iter4.sroa.0.0.i, 1
  %_79.lhs.trunc.i = trunc i64 %iter4.sroa.0.0.i to i8
  %_79118.i = urem i8 %_79.lhs.trunc.i, 5
  %narrow.i = mul nuw nsw i8 %_79118.i, 5
  %narrow119.i = add nuw nsw i8 %narrow.i, %_77117.i
  %_76.i = zext i8 %narrow119.i to i64
  %18 = getelementptr inbounds i64, i64* %a, i64 %_76.i
  %19 = load i64, i64* %18, align 8, !noundef !2
  %20 = xor i64 %19, %_72.i
  store i64 %20, i64* %18, align 8
  br label %bb35.i

_ZN11rust_keccak6keccak5theta17h45602c6d645df8e6E.exit: ; preds = %bb29.i
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %1)
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %0)
  br label %bb2.i9

bb2.loopexit.i7:                                  ; preds = %bb8.i
  %21 = add nuw nsw i64 %iter.sroa.0.0.i8, 1
  br label %bb2.i9

bb2.i9:                                           ; preds = %bb2.loopexit.i7, %_ZN11rust_keccak6keccak5theta17h45602c6d645df8e6E.exit
  %iter.sroa.0.0.i8 = phi i64 [ 0, %_ZN11rust_keccak6keccak5theta17h45602c6d645df8e6E.exit ], [ %21, %bb2.loopexit.i7 ]
  %exitcond39.not.i = icmp eq i64 %iter.sroa.0.0.i8, 5
  br i1 %exitcond39.not.i, label %_ZN11rust_keccak6keccak3rho17h8a75f9f4ad274235E.exit, label %bb4.i

bb4.i:                                            ; preds = %bb2.i9
  %_20.i10 = urem i64 %iter.sroa.0.0.i8, 5
  br label %bb8.i

bb8.i:                                            ; preds = %bb23.i, %bb4.i
  %iter1.sroa.0.0.i11 = phi i64 [ 0, %bb4.i ], [ %22, %bb23.i ]
  %exitcond.not.i12 = icmp eq i64 %iter1.sroa.0.0.i11, 5
  br i1 %exitcond.not.i12, label %bb2.loopexit.i7, label %bb10.i

bb10.i:                                           ; preds = %bb8.i
  %22 = add nuw nsw i64 %iter1.sroa.0.0.i11, 1
  %_22.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i11 to i8
  %_2238.i = urem i8 %_22.lhs.trunc.i, 5
  %narrow.i13 = mul nuw nsw i8 %_2238.i, 5
  %_21.i = zext i8 %narrow.i13 to i64
  %_19.i = add nuw nsw i64 %_20.i10, %_21.i
  %23 = getelementptr inbounds <{ [25 x i8] }>, <{ [25 x i8] }>* @anon.81d2408192f774ffc0f511fc69066f5d.0, i64 0, i32 0, i64 %_19.i
  %_17.i = load i8, i8* %23, align 1, !noundef !2
  %24 = icmp eq i8 %_17.i, 0
  %25 = getelementptr inbounds i64, i64* %a, i64 %_19.i
  %26 = load i64, i64* %25, align 8
  br i1 %24, label %bb23.i, label %bb14.i

bb14.i:                                           ; preds = %bb10.i
  %27 = and i8 %_17.i, 63
  %28 = zext i8 %27 to i64
  %_25.i = shl i64 %26, %28
  %_49.i = sub i8 0, %_17.i
  %29 = and i8 %_49.i, 63
  %30 = zext i8 %29 to i64
  %_41.i = lshr i64 %26, %30
  %31 = xor i64 %_25.i, %_41.i
  br label %bb23.i

bb23.i:                                           ; preds = %bb14.i, %bb10.i
  %_16.0.i = phi i64 [ %31, %bb14.i ], [ %26, %bb10.i ]
  store i64 %_16.0.i, i64* %25, align 8
  br label %bb8.i

_ZN11rust_keccak6keccak3rho17h8a75f9f4ad274235E.exit: ; preds = %bb2.i9
  call void @llvm.lifetime.start.p0i8(i64 200, i8* nonnull %2)
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(200) %2, i8 0, i64 200, i1 false)
  br label %bb2.i16

bb2.loopexit.i14:                                 ; preds = %bb8.i21
  %32 = add nuw nsw i64 %iter.sroa.0.0.i15, 1
  br label %bb2.i16

bb2.i16:                                          ; preds = %bb2.loopexit.i14, %_ZN11rust_keccak6keccak3rho17h8a75f9f4ad274235E.exit
  %iter.sroa.0.0.i15 = phi i64 [ 0, %_ZN11rust_keccak6keccak3rho17h8a75f9f4ad274235E.exit ], [ %32, %bb2.loopexit.i14 ]
  %exitcond86.not.i = icmp eq i64 %iter.sroa.0.0.i15, 5
  br i1 %exitcond86.not.i, label %bb16.i, label %bb4.i18

bb4.i18:                                          ; preds = %bb2.i16
  %_20.i17 = urem i64 %iter.sroa.0.0.i15, 5
  br label %bb8.i21

bb8.i21:                                          ; preds = %bb10.i27, %bb4.i18
  %iter1.sroa.0.0.i19 = phi i64 [ 0, %bb4.i18 ], [ %33, %bb10.i27 ]
  %exitcond.not.i20 = icmp eq i64 %iter1.sroa.0.0.i19, 5
  br i1 %exitcond.not.i20, label %bb2.loopexit.i14, label %bb10.i27

bb10.i27:                                         ; preds = %bb8.i21
  %33 = add nuw nsw i64 %iter1.sroa.0.0.i19, 1
  %_22.lhs.trunc.i22 = trunc i64 %iter1.sroa.0.0.i19 to i8
  %_2284.i = urem i8 %_22.lhs.trunc.i22, 5
  %narrow.i23 = mul nuw nsw i8 %_2284.i, 5
  %_21.i24 = zext i8 %narrow.i23 to i64
  %_19.i25 = add nuw nsw i64 %_20.i17, %_21.i24
  %34 = getelementptr inbounds i64, i64* %a, i64 %_19.i25
  %_17.i26 = load i64, i64* %34, align 8, !noundef !2
  %35 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_19.i25
  store i64 %_17.i26, i64* %35, align 8
  br label %bb8.i21

bb16.loopexit.i:                                  ; preds = %bb22.i
  %36 = add nuw nsw i64 %iter2.sroa.0.0.i28, 1
  br label %bb16.i

bb16.i:                                           ; preds = %bb16.loopexit.i, %bb2.i16
  %iter2.sroa.0.0.i28 = phi i64 [ %36, %bb16.loopexit.i ], [ 0, %bb2.i16 ]
  %exitcond88.not.i = icmp eq i64 %iter2.sroa.0.0.i28, 5
  br i1 %exitcond88.not.i, label %_ZN11rust_keccak6keccak2pi17h1b51896275110770E.exit, label %bb18.i

bb18.i:                                           ; preds = %bb16.i
  %_45.i = urem i64 %iter2.sroa.0.0.i28, 5
  %_59.i = shl nuw i64 %iter2.sroa.0.0.i28, 1
  br label %bb22.i

bb22.i:                                           ; preds = %bb27.i31, %bb18.i
  %iter3.sroa.0.0.i29 = phi i64 [ 0, %bb18.i ], [ %37, %bb27.i31 ]
  %exitcond87.not.i = icmp eq i64 %iter3.sroa.0.0.i29, 5
  br i1 %exitcond87.not.i, label %bb16.loopexit.i, label %bb27.i31

bb27.i31:                                         ; preds = %bb22.i
  %37 = add nuw nsw i64 %iter3.sroa.0.0.i29, 1
  %_47.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i29 to i8
  %_4785.i = urem i8 %_47.lhs.trunc.i, 5
  %_47.zext.i = zext i8 %_4785.i to i64
  %_46.i = mul nuw nsw i64 %_47.zext.i, 5
  %_44.i = add nuw nsw i64 %_46.i, %_45.i
  %38 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_44.i
  %_43.i = load i64, i64* %38, align 8, !noundef !2
  %_60.i = mul nuw nsw i64 %iter3.sroa.0.0.i29, 3
  %_58.i = add nuw nsw i64 %_60.i, %_59.i
  %_57.i = urem i64 %_58.i, 5
  %_56.i = mul nuw nsw i64 %_57.i, 5
  %_51.i30 = add nuw nsw i64 %_56.i, %_47.zext.i
  %39 = getelementptr inbounds i64, i64* %a, i64 %_51.i30
  store i64 %_43.i, i64* %39, align 8
  br label %bb22.i

_ZN11rust_keccak6keccak2pi17h1b51896275110770E.exit: ; preds = %bb16.i
  call void @llvm.lifetime.end.p0i8(i64 200, i8* nonnull %2)
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %3)
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %3, i8 0, i64 40, i1 false)
  br label %bb2.i35

bb2.loopexit.i33:                                 ; preds = %bb18.i49
  %40 = add nuw nsw i64 %iter.sroa.0.0.i34, 1
  br label %bb2.i35

bb2.i35:                                          ; preds = %bb2.loopexit.i33, %_ZN11rust_keccak6keccak2pi17h1b51896275110770E.exit
  %iter.sroa.0.0.i34 = phi i64 [ 0, %_ZN11rust_keccak6keccak2pi17h1b51896275110770E.exit ], [ %40, %bb2.loopexit.i33 ]
  %exitcond65.not.i = icmp eq i64 %iter.sroa.0.0.i34, 5
  br i1 %exitcond65.not.i, label %_ZN11rust_keccak6keccak4iota17h5c260f57d9577ed6E.exit, label %bb4.i38

bb4.i38:                                          ; preds = %bb2.i35
  %_22.i36 = urem i64 %iter.sroa.0.0.i34, 5
  %_21.i37 = mul nuw nsw i64 %_22.i36, 5
  br label %bb8.i41

bb8.i41:                                          ; preds = %bb16.i47, %bb4.i38
  %iter1.sroa.0.0.i39 = phi i64 [ 0, %bb4.i38 ], [ %41, %bb16.i47 ]
  %exitcond.not.i40 = icmp eq i64 %iter1.sroa.0.0.i39, 5
  br i1 %exitcond.not.i40, label %bb18.i49, label %bb16.i47

bb16.i47:                                         ; preds = %bb8.i41
  %41 = add nuw nsw i64 %iter1.sroa.0.0.i39, 1
  %_20.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i39 to i8
  %_2060.i = urem i8 %_20.lhs.trunc.i, 5
  %_20.zext.i = zext i8 %_2060.i to i64
  %_19.i42 = add nuw nsw i64 %_21.i37, %_20.zext.i
  %42 = getelementptr inbounds i64, i64* %a, i64 %_19.i42
  %_17.i43 = load i64, i64* %42, align 8, !noundef !2
  %_28.lhs.trunc.i = add i8 %_20.lhs.trunc.i, 1
  %_2861.i = urem i8 %_28.lhs.trunc.i, 5
  %_28.zext.i = zext i8 %_2861.i to i64
  %_27.i = add nuw nsw i64 %_21.i37, %_28.zext.i
  %43 = getelementptr inbounds i64, i64* %a, i64 %_27.i
  %_25.i44 = load i64, i64* %43, align 8, !noundef !2
  %_35.lhs.trunc.i = add i8 %_20.lhs.trunc.i, 2
  %_3562.i = urem i8 %_35.lhs.trunc.i, 5
  %_35.zext.i = zext i8 %_3562.i to i64
  %_34.i = add nuw nsw i64 %_21.i37, %_35.zext.i
  %44 = getelementptr inbounds i64, i64* %a, i64 %_34.i
  %_24.i45 = xor i64 %_25.i44, -1
  %_32.i = load i64, i64* %44, align 8, !noundef !2
  %_23.i46 = and i64 %_32.i, %_24.i45
  %45 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i32, i64 0, i64 %iter1.sroa.0.0.i39
  %46 = xor i64 %_23.i46, %_17.i43
  store i64 %46, i64* %45, align 8
  br label %bb8.i41

bb18.i49:                                         ; preds = %bb23.i50, %bb8.i41
  %iter2.sroa.0.0.i48 = phi i64 [ %47, %bb23.i50 ], [ 0, %bb8.i41 ]
  %exitcond64.not.i = icmp eq i64 %iter2.sroa.0.0.i48, 5
  br i1 %exitcond64.not.i, label %bb2.loopexit.i33, label %bb23.i50

bb23.i50:                                         ; preds = %bb18.i49
  %47 = add nuw nsw i64 %iter2.sroa.0.0.i48, 1
  %48 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i32, i64 0, i64 %iter2.sroa.0.0.i48
  %_48.i = load i64, i64* %48, align 8, !noundef !2
  %_53.lhs.trunc.i = trunc i64 %iter2.sroa.0.0.i48 to i8
  %_5363.i = urem i8 %_53.lhs.trunc.i, 5
  %_53.zext.i = zext i8 %_5363.i to i64
  %_52.i = add nuw nsw i64 %_21.i37, %_53.zext.i
  %49 = getelementptr inbounds i64, i64* %a, i64 %_52.i
  store i64 %_48.i, i64* %49, align 8
  br label %bb18.i49

_ZN11rust_keccak6keccak4iota17h5c260f57d9577ed6E.exit: ; preds = %bb2.i35
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %3)
  %50 = add nuw nsw i64 %iter.sroa.0.0, 1
  %51 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.81d2408192f774ffc0f511fc69066f5d.1 to [24 x i64]*), i64 0, i64 %iter.sroa.0.0
  %_3.i = load i64, i64* %51, align 8, !noundef !2
  %52 = load i64, i64* %a, align 8, !noundef !2
  %53 = xor i64 %52, %_3.i
  store i64 %53, i64* %a, align 8
  br label %bb2
}

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: minsize nounwind nonlazybind optsize
define void @keccak(i64* noundef %input_pointer) unnamed_addr #3 {
start:
  tail call void @_ZN11rust_keccak6keccak6keccak17h2679fb9ef1213577E(i64* noundef %input_pointer) #5
  ret void
}

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nonlazybind "target-cpu"="generic" }
attributes #3 = { minsize nounwind nonlazybind optsize "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
