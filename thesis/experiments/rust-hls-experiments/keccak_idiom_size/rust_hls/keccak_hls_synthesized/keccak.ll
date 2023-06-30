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
@anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.0 = hidden unnamed_addr constant <{ [25 x i8] }> <{ [25 x i8] c"\00\01>\1C\1B$,\067\14\03\0A+\19')-\0F\15\08\12\02=8\0E" }>, align 1
@anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.1 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8

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
define void @_ZN11rust_keccak16keccak_idiomatic6keccak17h94ae4a3f782890efE(i64* noundef %a) unnamed_addr #5 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
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

bb3:                                              ; preds = %_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E.exit, %start
  %iter.sroa.0.0 = phi i64 [ 0, %start ], [ %51, %_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E.exit ]
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
  %exitcond121.not.i = icmp eq i64 %iter.sroa.0.0.i, 5
  br i1 %exitcond121.not.i, label %bb17.i, label %bb7.i

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
  %_24114.i = urem i8 %_24.lhs.trunc.i, 5
  %narrow120.i = mul nuw nsw i8 %_24114.i, 5
  %_23.i = zext i8 %narrow120.i to i64
  %_21.i = add nuw nsw i64 %_22.i, %_23.i
  %8 = getelementptr inbounds i64, i64* %a, i64 %_21.i
  %_20.i = load i64, i64* %8, align 8, !alias.scope !2, !noundef !5
  %9 = xor i64 %_20.i, %storemerge.i
  br label %bb9.i

bb17.i:                                           ; preds = %bb25.i, %bb2.i
  %iter2.sroa.0.0.i = phi i64 [ %10, %bb25.i ], [ 0, %bb2.i ]
  %exitcond122.not.i = icmp eq i64 %iter2.sroa.0.0.i, 5
  br i1 %exitcond122.not.i, label %bb27.i, label %bb25.i

bb25.i:                                           ; preds = %bb17.i
  %10 = add nuw nsw i64 %iter2.sroa.0.0.i, 1
  %11 = trunc i64 %iter2.sroa.0.0.i to i8
  %_38.lhs.trunc.i = add i8 %11, 1
  %_38115.i = urem i8 %_38.lhs.trunc.i, 5
  %_38.zext.i = zext i8 %_38115.i to i64
  %12 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_38.zext.i
  %_37.i = load i64, i64* %12, align 8, !noalias !2, !noundef !5
  %13 = tail call i64 @llvm.fshl.i64(i64 %_37.i, i64 %_37.i, i64 1)
  %_43.lhs.trunc.i = add i8 %11, 4
  %_43116.i = urem i8 %_43.lhs.trunc.i, 5
  %_43.zext.i = zext i8 %_43116.i to i64
  %14 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i, i64 0, i64 %_43.zext.i
  %_42.i = load i64, i64* %14, align 8, !noalias !2, !noundef !5
  %15 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter2.sroa.0.0.i
  %16 = xor i64 %13, %_42.i
  store i64 %16, i64* %15, align 8, !noalias !2
  br label %bb17.i

bb27.loopexit.i:                                  ; preds = %bb33.i
  %17 = add nuw nsw i64 %iter3.sroa.0.0.i, 1
  br label %bb27.i

bb27.i:                                           ; preds = %bb27.loopexit.i, %bb17.i
  %iter3.sroa.0.0.i = phi i64 [ %17, %bb27.loopexit.i ], [ 0, %bb17.i ]
  %exitcond124.not.i = icmp eq i64 %iter3.sroa.0.0.i, 5
  br i1 %exitcond124.not.i, label %_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E.exit, label %bb29.i

bb29.i:                                           ; preds = %bb27.i
  %_67.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i to i8
  %_67117.i = urem i8 %_67.lhs.trunc.i, 5
  %18 = getelementptr inbounds [5 x i64], [5 x i64]* %d.i, i64 0, i64 %iter3.sroa.0.0.i
  %_63.i = load i64, i64* %18, align 8, !noalias !2, !noundef !5
  br label %bb33.i

bb33.i:                                           ; preds = %bb39.i, %bb29.i
  %iter4.sroa.0.0.i = phi i64 [ 0, %bb29.i ], [ %19, %bb39.i ]
  %exitcond123.not.i = icmp eq i64 %iter4.sroa.0.0.i, 5
  br i1 %exitcond123.not.i, label %bb27.loopexit.i, label %bb39.i

bb39.i:                                           ; preds = %bb33.i
  %19 = add nuw nsw i64 %iter4.sroa.0.0.i, 1
  %_69.lhs.trunc.i = trunc i64 %iter4.sroa.0.0.i to i8
  %_69118.i = urem i8 %_69.lhs.trunc.i, 5
  %narrow.i = mul nuw nsw i8 %_69118.i, 5
  %narrow119.i = add nuw nsw i8 %narrow.i, %_67117.i
  %_66.i = zext i8 %narrow119.i to i64
  %20 = getelementptr inbounds i64, i64* %a, i64 %_66.i
  %21 = load i64, i64* %20, align 8, !alias.scope !2, !noundef !5
  %22 = xor i64 %21, %_63.i
  store i64 %22, i64* %20, align 8, !alias.scope !2
  br label %bb33.i

_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E.exit: ; preds = %bb27.i
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %2), !noalias !2
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %1), !noalias !2
  tail call void @llvm.experimental.noalias.scope.decl(metadata !6)
  br label %bb2.i11

bb2.loopexit.i9:                                  ; preds = %bb8.i
  %23 = add nuw nsw i64 %iter.sroa.0.0.i10, 1
  br label %bb2.i11

bb2.i11:                                          ; preds = %bb2.loopexit.i9, %_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E.exit
  %iter.sroa.0.0.i10 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E.exit ], [ %23, %bb2.loopexit.i9 ]
  %exitcond38.not.i = icmp eq i64 %iter.sroa.0.0.i10, 5
  br i1 %exitcond38.not.i, label %_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E.exit, label %bb4.i

bb4.i:                                            ; preds = %bb2.i11
  %_19.i = urem i64 %iter.sroa.0.0.i10, 5
  br label %bb8.i

bb8.i:                                            ; preds = %_ZN11rust_keccak16keccak_idiomatic5rol6417he1045d5f1afa5ae6E.exit.i, %bb4.i
  %iter1.sroa.0.0.i12 = phi i64 [ 0, %bb4.i ], [ %24, %_ZN11rust_keccak16keccak_idiomatic5rol6417he1045d5f1afa5ae6E.exit.i ]
  %exitcond.not.i13 = icmp eq i64 %iter1.sroa.0.0.i12, 5
  br i1 %exitcond.not.i13, label %bb2.loopexit.i9, label %bb10.i

bb10.i:                                           ; preds = %bb8.i
  %24 = add nuw nsw i64 %iter1.sroa.0.0.i12, 1
  %_21.lhs.trunc.i = trunc i64 %iter1.sroa.0.0.i12 to i8
  %_2137.i = urem i8 %_21.lhs.trunc.i, 5
  %narrow.i14 = mul nuw nsw i8 %_2137.i, 5
  %_20.i15 = zext i8 %narrow.i14 to i64
  %_18.i = add nuw nsw i64 %_19.i, %_20.i15
  %25 = getelementptr inbounds i64, i64* %a, i64 %_18.i
  %_17.i = load i64, i64* %25, align 8, !alias.scope !6, !noundef !5
  %26 = getelementptr inbounds <{ [25 x i8] }>, <{ [25 x i8] }>* @anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.0, i64 0, i32 0, i64 %_18.i
  %_24.i = load i8, i8* %26, align 1, !noalias !6, !noundef !5
  %27 = icmp eq i8 %_24.i, 0
  br i1 %27, label %_ZN11rust_keccak16keccak_idiomatic5rol6417he1045d5f1afa5ae6E.exit.i, label %bb1.i.i

bb1.i.i:                                          ; preds = %bb10.i
  %28 = and i8 %_24.i, 63
  %29 = zext i8 %28 to i64
  %_3.i.i = shl i64 %_17.i, %29
  %_5.i.i = sub i8 0, %_24.i
  %30 = and i8 %_5.i.i, 63
  %31 = zext i8 %30 to i64
  %_4.i.i = lshr i64 %_17.i, %31
  %32 = xor i64 %_3.i.i, %_4.i.i
  br label %_ZN11rust_keccak16keccak_idiomatic5rol6417he1045d5f1afa5ae6E.exit.i

_ZN11rust_keccak16keccak_idiomatic5rol6417he1045d5f1afa5ae6E.exit.i: ; preds = %bb1.i.i, %bb10.i
  %.0.i.i = phi i64 [ %32, %bb1.i.i ], [ %_17.i, %bb10.i ]
  store i64 %.0.i.i, i64* %25, align 8, !alias.scope !6
  br label %bb8.i

_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E.exit: ; preds = %bb2.i11
  tail call void @llvm.experimental.noalias.scope.decl(metadata !9)
  call void @llvm.lifetime.start.p0i8(i64 200, i8* nonnull %3), !noalias !9
  call void @llvm.memset.p0i8.i64(i8* noundef nonnull align 8 dereferenceable(200) %3, i8 0, i64 200, i1 false), !noalias !9
  br label %bb2.i18

bb2.loopexit.i16:                                 ; preds = %bb8.i23
  %33 = add nuw nsw i64 %iter.sroa.0.0.i17, 1
  br label %bb2.i18

bb2.i18:                                          ; preds = %bb2.loopexit.i16, %_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E.exit
  %iter.sroa.0.0.i17 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E.exit ], [ %33, %bb2.loopexit.i16 ]
  %exitcond88.not.i = icmp eq i64 %iter.sroa.0.0.i17, 5
  br i1 %exitcond88.not.i, label %bb16.i, label %bb4.i20

bb4.i20:                                          ; preds = %bb2.i18
  %_19.i19 = urem i64 %iter.sroa.0.0.i17, 5
  br label %bb8.i23

bb8.i23:                                          ; preds = %bb10.i29, %bb4.i20
  %iter1.sroa.0.0.i21 = phi i64 [ 0, %bb4.i20 ], [ %34, %bb10.i29 ]
  %exitcond.not.i22 = icmp eq i64 %iter1.sroa.0.0.i21, 5
  br i1 %exitcond.not.i22, label %bb2.loopexit.i16, label %bb10.i29

bb10.i29:                                         ; preds = %bb8.i23
  %34 = add nuw nsw i64 %iter1.sroa.0.0.i21, 1
  %_21.lhs.trunc.i24 = trunc i64 %iter1.sroa.0.0.i21 to i8
  %_2186.i = urem i8 %_21.lhs.trunc.i24, 5
  %narrow.i25 = mul nuw nsw i8 %_2186.i, 5
  %_20.i26 = zext i8 %narrow.i25 to i64
  %_18.i27 = add nuw nsw i64 %_19.i19, %_20.i26
  %35 = getelementptr inbounds i64, i64* %a, i64 %_18.i27
  %_17.i28 = load i64, i64* %35, align 8, !alias.scope !9, !noundef !5
  %36 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_18.i27
  store i64 %_17.i28, i64* %36, align 8, !noalias !9
  br label %bb8.i23

bb16.loopexit.i:                                  ; preds = %bb22.i
  %37 = add nuw nsw i64 %iter2.sroa.0.0.i30, 1
  br label %bb16.i

bb16.i:                                           ; preds = %bb16.loopexit.i, %bb2.i18
  %iter2.sroa.0.0.i30 = phi i64 [ %37, %bb16.loopexit.i ], [ 0, %bb2.i18 ]
  %exitcond90.not.i = icmp eq i64 %iter2.sroa.0.0.i30, 5
  br i1 %exitcond90.not.i, label %_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E.exit, label %bb18.i

bb18.i:                                           ; preds = %bb16.i
  %_59.i = shl nuw i64 %iter2.sroa.0.0.i30, 1
  %_46.i = urem i64 %iter2.sroa.0.0.i30, 5
  br label %bb22.i

bb22.i:                                           ; preds = %bb28.i, %bb18.i
  %iter3.sroa.0.0.i31 = phi i64 [ 0, %bb18.i ], [ %38, %bb28.i ]
  %exitcond89.not.i = icmp eq i64 %iter3.sroa.0.0.i31, 5
  br i1 %exitcond89.not.i, label %bb16.loopexit.i, label %bb28.i

bb28.i:                                           ; preds = %bb22.i
  %38 = add nuw nsw i64 %iter3.sroa.0.0.i31, 1
  %_48.lhs.trunc.i = trunc i64 %iter3.sroa.0.0.i31 to i8
  %_4887.i = urem i8 %_48.lhs.trunc.i, 5
  %_48.zext.i = zext i8 %_4887.i to i64
  %_60.i = mul nuw nsw i64 %iter3.sroa.0.0.i31, 3
  %_58.i = add nuw nsw i64 %_60.i, %_59.i
  %_57.i = urem i64 %_58.i, 5
  %_56.i = mul nuw nsw i64 %_57.i, 5
  %_51.i = add nuw nsw i64 %_56.i, %_48.zext.i
  %_47.i = mul nuw nsw i64 %_48.zext.i, 5
  %_45.i = add nuw nsw i64 %_47.i, %_46.i
  %39 = getelementptr inbounds [25 x i64], [25 x i64]* %temp_a.i, i64 0, i64 %_45.i
  %_44.i = load i64, i64* %39, align 8, !noalias !9, !noundef !5
  %40 = getelementptr inbounds i64, i64* %a, i64 %_51.i
  store i64 %_44.i, i64* %40, align 8, !alias.scope !9
  br label %bb22.i

_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E.exit: ; preds = %bb16.i
  call void @llvm.lifetime.end.p0i8(i64 200, i8* nonnull %3), !noalias !9
  tail call void @llvm.experimental.noalias.scope.decl(metadata !12)
  br label %bb2.i34

bb2.i34:                                          ; preds = %bb22.i47, %_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E.exit
  %iter.sroa.0.0.i33 = phi i64 [ 0, %_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E.exit ], [ %47, %bb22.i47 ]
  %exitcond69.not.i = icmp eq i64 %iter.sroa.0.0.i33, 5
  br i1 %exitcond69.not.i, label %_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E.exit, label %bb4.i37

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
  %_25.i = xor i64 %_26.i, -1
  %_36.lhs.trunc.i = add i8 %_19.lhs.trunc.i, 2
  %_3666.i = urem i8 %_36.lhs.trunc.i, 5
  %_36.zext.i = zext i8 %_3666.i to i64
  %_35.i = add nuw nsw i64 %_20.i36, %_36.zext.i
  %44 = getelementptr inbounds i64, i64* %a, i64 %_35.i
  %_34.i = load i64, i64* %44, align 8, !alias.scope !12, !noundef !5
  %_24.i43 = and i64 %_34.i, %_25.i
  %45 = getelementptr inbounds [5 x i64], [5 x i64]* %c.i32, i64 0, i64 %iter1.sroa.0.0.i38
  %46 = xor i64 %_24.i43, %_17.i42
  store i64 %46, i64* %45, align 8, !noalias !12
  br label %bb8.i40

bb18.i46:                                         ; preds = %bb24.i, %bb8.i40
  %iter2.sroa.0.0.i45 = phi i64 [ %48, %bb24.i ], [ 0, %bb8.i40 ]
  %exitcond68.not.i = icmp eq i64 %iter2.sroa.0.0.i45, 5
  br i1 %exitcond68.not.i, label %bb22.i47, label %bb24.i

bb22.i47:                                         ; preds = %bb18.i46
  %47 = add nuw nsw i64 %iter.sroa.0.0.i33, 1
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %4), !noalias !12
  br label %bb2.i34

bb24.i:                                           ; preds = %bb18.i46
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

_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E.exit: ; preds = %bb2.i34
  tail call void @llvm.experimental.noalias.scope.decl(metadata !15)
  %51 = add nuw nsw i64 %iter.sroa.0.0, 1
  %52 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.1 to [24 x i64]*), i64 0, i64 %iter.sroa.0.0
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
  tail call void @_ZN11rust_keccak16keccak_idiomatic6keccak17h94ae4a3f782890efE(i64* noundef %input_pointer) #6
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
!3 = distinct !{!3, !4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E: %a"}
!4 = distinct !{!4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h70a5252a1f2f3d59E"}
!5 = !{}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E: %a"}
!8 = distinct !{!8, !"_ZN11rust_keccak16keccak_idiomatic3rho17h560c05023570bc33E"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E: %a"}
!11 = distinct !{!11, !"_ZN11rust_keccak16keccak_idiomatic2pi17h119626c67e9bfe43E"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_ZN11rust_keccak16keccak_idiomatic3chi17hc6a89d3076a7e567E: %a"}
!14 = distinct !{!14, !"_ZN11rust_keccak16keccak_idiomatic3chi17hc6a89d3076a7e567E"}
!15 = !{!16}
!16 = distinct !{!16, !17, !"_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E: %a"}
!17 = distinct !{!17, !"_ZN11rust_keccak16keccak_idiomatic4iota17h5f6a00076c94dae0E"}
