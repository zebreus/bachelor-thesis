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

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #0

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #2

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #1

; Function Attrs: nonlazybind
declare i32 @rust_eh_personality(...) unnamed_addr #3

; Function Attrs: nocallback nofree nounwind willreturn memory(argmem: write)
declare void @llvm.memset.p0i8.i64(i8* nocapture writeonly, i8, i64, i1 immarg) #4

; Function Attrs: minsize nounwind nonlazybind optsize
define void @_ZN11rust_keccak16keccak_idiomatic6keccak17h5aa4472b1ac1c5dbE(i64* noundef %a) unnamed_addr #5 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
start:
  %c.i32 = alloca [5 x i64], align 8
  %temp_a.i = alloca [25 x i64], align 8
  %d.i = alloca [5 x i64], align 8
  %c.i = alloca [5 x i64], align 8
  %0 = icmp ne i64* %a, null
  tail call void @llvm.assume(i1 %0)
  %1 = bitcast [5 x i64]* %c.i to i8*
  %2 = bitcast [5 x i64]* %d.i to i8*
  %3 = bitcast [25 x i64]* %temp_a.i to i8*
  %4 = bitcast [5 x i64]* %c.i32 to i8*
  br label %bb3

bb3:                                              ; preds = %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit, %start
  %iter.sroa.0.0 = phi i64 [ 0, %start ], [ %51, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %exitcond.not = icmp eq i64 %iter.sroa.0.0, 24
  br i1 %exitcond.not, label %bb7, label %bb5

bb7:                                              ; preds = %bb3
  ret void

bb5:                                              ; preds = %bb3
  tail call void @llvm.experimental.noalias.scope.decl(metadata !2)
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %1), !noalias !2
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %1, i8 0, i64 40, i1 false), !noalias !2
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %2), !noalias !2
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %2, i8 0, i64 40, i1 false), !noalias !2
  br label %bb2.i

bb2.loopexit.i:                                   ; preds = %bb9.i
  %5 = add nuw nsw i64 %iter.sroa.0.0.i, 1
  %6 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %iter.sroa.0.0.i
  store i64 %storemerge.i, i64* %6, align 8, !noalias !2
  br label %bb2.i

bb2.i:                                            ; preds = %bb2.loopexit.i, %bb5
  %iter.sroa.0.0.i = phi i64 [ 0, %bb5 ], [ %5, %bb2.loopexit.i ]
  %exitcond123.not.i = icmp eq i64 %iter.sroa.0.0.i, 5
  br i1 %exitcond123.not.i, label %bb17.i, label %bb7.i

bb7.i:                                            ; preds = %bb2.i
  %_22.i = urem i64 %iter.sroa.0.0.i, 5
  br label %bb9.i

bb9.i:                                            ; preds = %bb15.i, %bb7.i
  %storemerge.i = phi i64 [ 0, %bb7.i ], [ %9, %bb15.i ]
  %iter1.sroa.0.0.i = phi i64 [ 0, %bb7.i ], [ %7, %bb15.i ]
  %exitcond.not.i = icmp eq i64 %iter1.sroa.0.0.i, 5
  br i1 %exitcond.not.i, label %bb2.loopexit.i, label %bb15.i

bb15.i:                                           ; preds = %bb9.i
  %7 = add nuw nsw i64 %iter1.sroa.0.0.i, 1
  %_24.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i to i8
  %_24116.i = urem i8 %_24.lhs.trunc.i, 5
  %narrow122.i = mul nuw nsw i8 %_24116.i, 5
  %_23.i = zext i8 %narrow122.i to i64
  %_21.i = add nuw nsw i64 %_22.i, %_23.i
  %8 = getelementptr inbounds i64, i64* %a, i64 %_21.i
  %_20.i = load i64, i64* %8, align 8, !alias.scope !2, !noundef !5
  %9 = xor i64 %_20.i, %storemerge.i
  br label %bb9.i

bb17.i:                                           ; preds = %bb27.i, %bb2.i
  %iter2.sroa.0.0.i = phi i64 [ %10, %bb27.i ], [ 0, %bb2.i ]
  %exitcond124.not.i = icmp eq i64 %iter2.sroa.0.0.i, 5
  br i1 %exitcond124.not.i, label %bb29.i, label %bb27.i

bb27.i:                                           ; preds = %bb17.i
  %10 = add nuw nsw i64 %iter2.sroa.0.0.i, 1
  %11 = trunc i64 %iter2.sroa.0.0.i to i8
  %_40.lhs.trunc.i = add i8 %11, 1
  %_40117.i = urem i8 %_40.lhs.trunc.i, 5
  %_40.zext.i = zext i8 %_40117.i to i64
  %12 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_40.zext.i
  %_39.i = load i64, i64* %12, align 8, !noalias !2, !noundef !5
  %_3658.i = tail call i64 @llvm.fshl.i64(i64 %_39.i, i64 %_39.i, i64 1)
  %_53.lhs.trunc.i = add i8 %11, 4
  %_53118.i = urem i8 %_53.lhs.trunc.i, 5
  %_53.zext.i = zext i8 %_53118.i to i64
  %13 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_53.zext.i
  %_52.i = load i64, i64* %13, align 8, !noalias !2, !noundef !5
  %14 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter2.sroa.0.0.i
  %15 = xor i64 %_3658.i, %_52.i
  store i64 %15, i64* %14, align 8, !noalias !2
  br label %bb17.i

bb29.loopexit.i:                                  ; preds = %bb35.i
  %16 = add nuw nsw i64 %iter3.sroa.0.0.i, 1
  br label %bb29.i

bb29.i:                                           ; preds = %bb29.loopexit.i, %bb17.i
  %iter3.sroa.0.0.i = phi i64 [ %16, %bb29.loopexit.i ], [ 0, %bb17.i ]
  %exitcond126.not.i = icmp eq i64 %iter3.sroa.0.0.i, 5
  br i1 %exitcond126.not.i, label %_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE.exit, label %bb31.i

bb31.i:                                           ; preds = %bb29.i
  %_77.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i to i8
  %_77119.i = urem i8 %_77.lhs.trunc.i, 5
  %17 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter3.sroa.0.0.i
  %_73.i = load i64, i64* %17, align 8, !noalias !2, !noundef !5
  br label %bb35.i

bb35.i:                                           ; preds = %bb41.i, %bb31.i
  %iter4.sroa.0.0.i = phi i64 [ 0, %bb31.i ], [ %18, %bb41.i ]
  %exitcond125.not.i = icmp eq i64 %iter4.sroa.0.0.i, 5
  br i1 %exitcond125.not.i, label %bb29.loopexit.i, label %bb41.i

bb41.i:                                           ; preds = %bb35.i
  %18 = add nuw nsw i64 %iter4.sroa.0.0.i, 1
  %_79.lhs.trunc.i = trunc i64 %iter4.sroa.0.0.i to i8
  %_79120.i = urem i8 %_79.lhs.trunc.i, 5
  %narrow.i = mul nuw nsw i8 %_79120.i, 5
  %narrow121.i = add nuw nsw i8 %narrow.i, %_77119.i
  %_76.i = zext i8 %narrow121.i to i64
  %19 = getelementptr inbounds i64, i64* %a, i64 %_76.i
  %20 = load i64, i64* %19, align 8, !alias.scope !2, !noundef !5
  %21 = xor i64 %20, %_73.i
  store i64 %21, i64* %19, align 8, !alias.scope !2
  br label %bb35.i

_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE.exit: ; preds = %bb29.i
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %2), !noalias !2
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %1), !noalias !2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !6)
  br label %bb2.i10

bb2.loopexit.i8:                                  ; preds = %bb8.i
  %22 = add nuw nsw i64 %iter.sroa.0.0.i9, 1
  br label %bb2.i10

bb2.i10:                                          ; preds = %bb2.loopexit.i8, %_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE.exit
  %iter.sroa.0.0.i9 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE.exit ], [ %22, %bb2.loopexit.i8 ]
  %exitcond43.not.i = icmp eq i64 %iter.sroa.0.0.i9, 5
  br i1 %exitcond43.not.i, label %_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E.exit, label %bb4.i

bb4.i:                                            ; preds = %bb2.i10
  %_20.i11 = urem i64 %iter.sroa.0.0.i9, 5
  br label %bb8.i

bb8.i:                                            ; preds = %bb24.i, %bb4.i
  %iter1.sroa.0.0.i12 = phi i64 [ 0, %bb4.i ], [ %23, %bb24.i ]
  %exitcond.not.i13 = icmp eq i64 %iter1.sroa.0.0.i12, 5
  br i1 %exitcond.not.i13, label %bb2.loopexit.i8, label %bb10.i

bb10.i:                                           ; preds = %bb8.i
  %23 = add nuw nsw i64 %iter1.sroa.0.0.i12, 1
  %_22.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i12 to i8
  %_2242.i = urem i8 %_22.lhs.trunc.i, 5
  %narrow.i14 = mul nuw nsw i8 %_2242.i, 5
  %_21.i15 = zext i8 %narrow.i14 to i64
  %_19.i = add nuw nsw i64 %_20.i11, %_21.i15
  %24 = getelementptr inbounds <{ [25 x i8] }>, <{ [25 x i8] }>* @anon.81d2408192f774ffc0f511fc69066f5d.0, i64 0, i32 0, i64 %_19.i
  %_17.i = load i8, i8* %24, align 1, !noalias !6, !noundef !5
  %25 = icmp eq i8 %_17.i, 0
  %26 = getelementptr inbounds i64, i64* %a, i64 %_19.i
  %27 = load i64, i64* %26, align 8, !alias.scope !6
  br i1 %25, label %bb24.i, label %bb15.i16

bb15.i16:                                         ; preds = %bb10.i
  %28 = and i8 %_17.i, 63
  %29 = zext i8 %28 to i64
  %_25.i = shl i64 %27, %29
  %_51.i = sub i8 0, %_17.i
  %30 = and i8 %_51.i, 63
  %31 = zext i8 %30 to i64
  %_42.i = lshr i64 %27, %31
  %32 = xor i64 %_25.i, %_42.i
  br label %bb24.i

bb24.i:                                           ; preds = %bb15.i16, %bb10.i
  %_16.0.i = phi i64 [ %32, %bb15.i16 ], [ %27, %bb10.i ]
  store i64 %_16.0.i, i64* %26, align 8, !alias.scope !6
  br label %bb8.i

_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E.exit: ; preds = %bb2.i10
  tail call void @llvm.experimental.noalias.scope.decl(metadata !9)
  call void @llvm.lifetime.start.p0i8(i64 200, i8* nonnull %3), !noalias !9
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(200) %3, i8 0, i64 200, i1 false), !noalias !9
  br label %bb2.i19

bb2.loopexit.i17:                                 ; preds = %bb8.i24
  %33 = add nuw nsw i64 %iter.sroa.0.0.i18, 1
  br label %bb2.i19

bb2.i19:                                          ; preds = %bb2.loopexit.i17, %_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E.exit
  %iter.sroa.0.0.i18 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E.exit ], [ %33, %bb2.loopexit.i17 ]
  %exitcond88.not.i = icmp eq i64 %iter.sroa.0.0.i18, 5
  br i1 %exitcond88.not.i, label %bb16.i, label %bb4.i21

bb4.i21:                                          ; preds = %bb2.i19
  %_19.i20 = urem i64 %iter.sroa.0.0.i18, 5
  br label %bb8.i24

bb8.i24:                                          ; preds = %bb10.i28, %bb4.i21
  %iter1.sroa.0.0.i22 = phi i64 [ 0, %bb4.i21 ], [ %34, %bb10.i28 ]
  %exitcond.not.i23 = icmp eq i64 %iter1.sroa.0.0.i22, 5
  br i1 %exitcond.not.i23, label %bb2.loopexit.i17, label %bb10.i28

bb10.i28:                                         ; preds = %bb8.i24
  %34 = add nuw nsw i64 %iter1.sroa.0.0.i22, 1
  %_21.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i22 to i8
  %_2186.i = urem i8 %_21.lhs.trunc.i, 5
  %narrow.i25 = mul nuw nsw i8 %_2186.i, 5
  %_20.i26 = zext i8 %narrow.i25 to i64
  %_18.i = add nuw nsw i64 %_19.i20, %_20.i26
  %35 = getelementptr inbounds i64, i64* %a, i64 %_18.i
  %_17.i27 = load i64, i64* %35, align 8, !alias.scope !9, !noundef !5
  %36 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_18.i
  store i64 %_17.i27, i64* %36, align 8, !noalias !9
  br label %bb8.i24

bb16.loopexit.i:                                  ; preds = %bb22.i
  %37 = add nuw nsw i64 %iter2.sroa.0.0.i29, 1
  br label %bb16.i

bb16.i:                                           ; preds = %bb16.loopexit.i, %bb2.i19
  %iter2.sroa.0.0.i29 = phi i64 [ %37, %bb16.loopexit.i ], [ 0, %bb2.i19 ]
  %exitcond90.not.i = icmp eq i64 %iter2.sroa.0.0.i29, 5
  br i1 %exitcond90.not.i, label %_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE.exit, label %bb18.i

bb18.i:                                           ; preds = %bb16.i
  %_59.i = shl nuw i64 %iter2.sroa.0.0.i29, 1
  %_46.i = urem i64 %iter2.sroa.0.0.i29, 5
  br label %bb22.i

bb22.i:                                           ; preds = %bb28.i, %bb18.i
  %iter3.sroa.0.0.i30 = phi i64 [ 0, %bb18.i ], [ %38, %bb28.i ]
  %exitcond89.not.i = icmp eq i64 %iter3.sroa.0.0.i30, 5
  br i1 %exitcond89.not.i, label %bb16.loopexit.i, label %bb28.i

bb28.i:                                           ; preds = %bb22.i
  %38 = add nuw nsw i64 %iter3.sroa.0.0.i30, 1
  %_48.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i30 to i8
  %_4887.i = urem i8 %_48.lhs.trunc.i, 5
  %_48.zext.i = zext i8 %_4887.i to i64
  %_60.i = mul nuw nsw i64 %iter3.sroa.0.0.i30, 3
  %_58.i = add nuw nsw i64 %_60.i, %_59.i
  %_57.i = urem i64 %_58.i, 5
  %_56.i = mul nuw nsw i64 %_57.i, 5
  %_51.i31 = add nuw nsw i64 %_56.i, %_48.zext.i
  %_47.i = mul nuw nsw i64 %_48.zext.i, 5
  %_45.i = add nuw nsw i64 %_47.i, %_46.i
  %39 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_45.i
  %_44.i = load i64, i64* %39, align 8, !noalias !9, !noundef !5
  %40 = getelementptr inbounds i64, i64* %a, i64 %_51.i31
  store i64 %_44.i, i64* %40, align 8, !alias.scope !9
  br label %bb22.i

_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE.exit: ; preds = %bb16.i
  call void @llvm.lifetime.end.p0i8(i64 200, i8* nonnull %3), !noalias !9
  tail call void @llvm.experimental.noalias.scope.decl(metadata !12)
  br label %bb2.i34

bb2.i34:                                          ; preds = %bb22.i47, %_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE.exit
  %iter.sroa.0.0.i33 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE.exit ], [ %47, %bb22.i47 ]
  %exitcond69.not.i = icmp eq i64 %iter.sroa.0.0.i33, 5
  br i1 %exitcond69.not.i, label %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit, label %bb4.i37

bb4.i37:                                          ; preds = %bb2.i34
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %4), !noalias !12
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(40) %4, i8 0, i64 40, i1 false), !noalias !12
  %_21.i35 = urem i64 %iter.sroa.0.0.i33, 5
  %_20.i36 = mul nuw nsw i64 %_21.i35, 5
  br label %bb8.i40

bb8.i40:                                          ; preds = %bb16.i44, %bb4.i37
  %iter1.sroa.0.0.i38 = phi i64 [ 0, %bb4.i37 ], [ %41, %bb16.i44 ]
  %exitcond.not.i39 = icmp eq i64 %iter1.sroa.0.0.i38, 5
  br i1 %exitcond.not.i39, label %bb18.i46, label %bb16.i44

bb16.i44:                                         ; preds = %bb8.i40
  %41 = add nuw nsw i64 %iter1.sroa.0.0.i38, 1
  %_19.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i38 to i8
  %_1964.i = urem i8 %_19.lhs.trunc.i, 5
  %_19.zext.i = zext i8 %_1964.i to i64
  %_18.i41 = add nuw nsw i64 %_20.i36, %_19.zext.i
  %42 = getelementptr inbounds i64, i64* %a, i64 %_18.i41
  %_17.i42 = load i64, i64* %42, align 8, !alias.scope !12, !noundef !5
  %_28.lhs.trunc.i = add i8 %_19.lhs.trunc.i, 1
  %_2865.i = urem i8 %_28.lhs.trunc.i, 5
  %_28.zext.i = zext i8 %_2865.i to i64
  %_27.i = add nuw nsw i64 %_20.i36, %_28.zext.i
  %43 = getelementptr inbounds i64, i64* %a, i64 %_27.i
  %_26.i = load i64, i64* %43, align 8, !alias.scope !12, !noundef !5
  %_25.i43 = xor i64 %_26.i, -1
  %_36.lhs.trunc.i = add i8 %_19.lhs.trunc.i, 2
  %_3666.i = urem i8 %_36.lhs.trunc.i, 5
  %_36.zext.i = zext i8 %_3666.i to i64
  %_35.i = add nuw nsw i64 %_20.i36, %_36.zext.i
  %44 = getelementptr inbounds i64, i64* %a, i64 %_35.i
  %_34.i = load i64, i64* %44, align 8, !alias.scope !12, !noundef !5
  %_24.i = and i64 %_34.i, %_25.i43
  %45 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i32, i64 0, i64 %iter1.sroa.0.0.i38
  %46 = xor i64 %_24.i, %_17.i42
  store i64 %46, i64* %45, align 8, !noalias !12
  br label %bb8.i40

bb18.i46:                                         ; preds = %bb24.i49, %bb8.i40
  %iter2.sroa.0.0.i45 = phi i64 [ %48, %bb24.i49 ], [ 0, %bb8.i40 ]
  %exitcond68.not.i = icmp eq i64 %iter2.sroa.0.0.i45, 5
  br i1 %exitcond68.not.i, label %bb22.i47, label %bb24.i49

bb22.i47:                                         ; preds = %bb18.i46
  %47 = add nuw nsw i64 %iter.sroa.0.0.i33, 1
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %4), !noalias !12
  br label %bb2.i34

bb24.i49:                                         ; preds = %bb18.i46
  %48 = add nuw nsw i64 %iter2.sroa.0.0.i45, 1
  %_55.lhs.trunc.i = trunc i64 %iter2.sroa.0.0.i45 to i8
  %_5567.i = urem i8 %_55.lhs.trunc.i, 5
  %_55.zext.i = zext i8 %_5567.i to i64
  %_54.i = add nuw nsw i64 %_20.i36, %_55.zext.i
  %49 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i32, i64 0, i64 %iter2.sroa.0.0.i45
  %_51.i48 = load i64, i64* %49, align 8, !noalias !12, !noundef !5
  %50 = getelementptr inbounds i64, i64* %a, i64 %_54.i
  store i64 %_51.i48, i64* %50, align 8, !alias.scope !12
  br label %bb18.i46

_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit: ; preds = %bb2.i34
  tail call void @llvm.experimental.noalias.scope.decl(metadata !15)
  %51 = add nuw nsw i64 %iter.sroa.0.0, 1
  %52 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.81d2408192f774ffc0f511fc69066f5d.1 to [24 x i64]*), i64 0, i64 %iter.sroa.0.0
  %_3.i = load i64, i64* %52, align 8, !noalias !15, !noundef !5
  %53 = load i64, i64* %a, align 8, !alias.scope !15, !noundef !5
  %54 = xor i64 %53, %_3.i
  store i64 %54, i64* %a, align 8, !alias.scope !15
  br label %bb3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.experimental.noalias.scope.decl(metadata) #0

; Function Attrs: minsize nounwind nonlazybind optsize
define void @keccak(i64* noundef %input_pointer) unnamed_addr #5 {
start:
  tail call void @_ZN11rust_keccak16keccak_idiomatic6keccak17h5aa4472b1ac1c5dbE(i64* noundef %input_pointer) #6
  ret void
}

attributes #0 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #1 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nonlazybind "target-cpu"="generic" }
attributes #4 = { nocallback nofree nounwind willreturn memory(argmem: write) }
attributes #5 = { minsize nounwind nonlazybind optsize "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #6 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{!3}
!3 = distinct !{!3, !4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE: %a"}
!4 = distinct !{!4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE"}
!5 = !{}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E: %a"}
!8 = distinct !{!8, !"_ZN11rust_keccak16keccak_idiomatic3rho17ha1cd5cc70e861804E"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE: %a"}
!11 = distinct !{!11, !"_ZN11rust_keccak16keccak_idiomatic2pi17hf71d33afef143edbE"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_ZN11rust_keccak16keccak_idiomatic3chi17h43705a6eace343b2E: %a"}
!14 = distinct !{!14, !"_ZN11rust_keccak16keccak_idiomatic3chi17h43705a6eace343b2E"}
!15 = !{!16}
!16 = distinct !{!16, !17, !"_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E: %a"}
!17 = distinct !{!17, !"_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E"}
