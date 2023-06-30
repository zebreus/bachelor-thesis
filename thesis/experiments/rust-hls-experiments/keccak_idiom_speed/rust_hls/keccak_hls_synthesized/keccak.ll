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
@anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.0 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8

; Function Attrs: nonlazybind
declare i32 @rust_eh_personality(...) unnamed_addr #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #2

; Function Attrs: nounwind nonlazybind
define void @_ZN11rust_keccak16keccak_idiomatic6keccak17h94ae4a3f782890efE(i64* noundef %a) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
start:
  %0 = icmp ne i64* %a, null
  tail call void @llvm.assume(i1 %0)
  %_30.pre = load i64, i64* %a, align 8
  %.phi.trans.insert = getelementptr inbounds i64, i64* %a, i64 15
  %_30.3.pre = load i64, i64* %.phi.trans.insert, align 8
  %.phi.trans.insert775 = getelementptr inbounds i64, i64* %a, i64 20
  %_30.4.pre = load i64, i64* %.phi.trans.insert775, align 8
  %.phi.trans.insert777 = getelementptr inbounds i64, i64* %a, i64 16
  %_30.3.1.pre = load i64, i64* %.phi.trans.insert777, align 8
  %.phi.trans.insert779 = getelementptr inbounds i64, i64* %a, i64 21
  %_30.4.1.pre = load i64, i64* %.phi.trans.insert779, align 8
  %.phi.trans.insert781 = getelementptr inbounds i64, i64* %a, i64 17
  %_30.3.2.pre = load i64, i64* %.phi.trans.insert781, align 8
  %.phi.trans.insert783 = getelementptr inbounds i64, i64* %a, i64 22
  %_30.4.2.pre = load i64, i64* %.phi.trans.insert783, align 8
  %.phi.trans.insert785 = getelementptr inbounds i64, i64* %a, i64 18
  %_30.3.3.pre = load i64, i64* %.phi.trans.insert785, align 8
  %.phi.trans.insert787 = getelementptr inbounds i64, i64* %a, i64 23
  %_30.4.3.pre = load i64, i64* %.phi.trans.insert787, align 8
  %.phi.trans.insert789 = getelementptr inbounds i64, i64* %a, i64 5
  %_30.1.pre = load i64, i64* %.phi.trans.insert789, align 8
  %.phi.trans.insert791 = getelementptr inbounds i64, i64* %a, i64 10
  %_30.2.pre = load i64, i64* %.phi.trans.insert791, align 8
  %.phi.trans.insert793 = getelementptr inbounds i64, i64* %a, i64 1
  %_30.1406.pre = load i64, i64* %.phi.trans.insert793, align 8
  %.phi.trans.insert795 = getelementptr inbounds i64, i64* %a, i64 6
  %_30.1.1.pre = load i64, i64* %.phi.trans.insert795, align 8
  %.phi.trans.insert797 = getelementptr inbounds i64, i64* %a, i64 11
  %_30.2.1.pre = load i64, i64* %.phi.trans.insert797, align 8
  %.phi.trans.insert799 = getelementptr inbounds i64, i64* %a, i64 2
  %_30.2407.pre = load i64, i64* %.phi.trans.insert799, align 8
  %.phi.trans.insert801 = getelementptr inbounds i64, i64* %a, i64 7
  %_30.1.2.pre = load i64, i64* %.phi.trans.insert801, align 8
  %.phi.trans.insert803 = getelementptr inbounds i64, i64* %a, i64 12
  %_30.2.2.pre = load i64, i64* %.phi.trans.insert803, align 8
  %.phi.trans.insert805 = getelementptr inbounds i64, i64* %a, i64 3
  %_30.3408.pre = load i64, i64* %.phi.trans.insert805, align 8
  %.phi.trans.insert807 = getelementptr inbounds i64, i64* %a, i64 8
  %_30.1.3.pre = load i64, i64* %.phi.trans.insert807, align 8
  %.phi.trans.insert809 = getelementptr inbounds i64, i64* %a, i64 13
  %_30.2.3.pre = load i64, i64* %.phi.trans.insert809, align 8
  %.phi.trans.insert811 = getelementptr inbounds i64, i64* %a, i64 4
  %_30.4409.pre = load i64, i64* %.phi.trans.insert811, align 8
  %.phi.trans.insert813 = getelementptr inbounds i64, i64* %a, i64 9
  %_30.1.4.pre = load i64, i64* %.phi.trans.insert813, align 8
  %1 = getelementptr inbounds i64, i64* %a, i64 14
  %2 = getelementptr inbounds i64, i64* %a, i64 19
  %3 = getelementptr inbounds i64, i64* %a, i64 24
  %.promoted = load i64, i64* %1, align 8
  %.promoted815 = load i64, i64* %2, align 8
  %.promoted817 = load i64, i64* %3, align 8
  %a.promoted = load i64, i64* %a, align 8
  %.phi.trans.insert.promoted = load i64, i64* %.phi.trans.insert, align 8
  %.phi.trans.insert775.promoted = load i64, i64* %.phi.trans.insert775, align 8
  %.phi.trans.insert777.promoted = load i64, i64* %.phi.trans.insert777, align 8
  %.phi.trans.insert779.promoted = load i64, i64* %.phi.trans.insert779, align 8
  %.phi.trans.insert781.promoted = load i64, i64* %.phi.trans.insert781, align 8
  %.phi.trans.insert783.promoted = load i64, i64* %.phi.trans.insert783, align 8
  %.phi.trans.insert785.promoted = load i64, i64* %.phi.trans.insert785, align 8
  %.phi.trans.insert787.promoted = load i64, i64* %.phi.trans.insert787, align 8
  br label %bb101

bb5:                                              ; preds = %bb101
  store i64 %104, i64* %1, align 8
  store i64 %109, i64* %2, align 8
  store i64 %114, i64* %3, align 8
  store i64 %117, i64* %a, align 8
  store i64 %105, i64* %.phi.trans.insert, align 8
  store i64 %110, i64* %.phi.trans.insert775, align 8
  store i64 %106, i64* %.phi.trans.insert777, align 8
  store i64 %111, i64* %.phi.trans.insert779, align 8
  store i64 %107, i64* %.phi.trans.insert781, align 8
  store i64 %112, i64* %.phi.trans.insert783, align 8
  store i64 %108, i64* %.phi.trans.insert785, align 8
  store i64 %113, i64* %.phi.trans.insert787, align 8
  store i64 %91, i64* %.phi.trans.insert793, align 8
  store i64 %92, i64* %.phi.trans.insert799, align 8
  store i64 %93, i64* %.phi.trans.insert805, align 8
  store i64 %94, i64* %.phi.trans.insert811, align 8
  store i64 %95, i64* %.phi.trans.insert789, align 8
  store i64 %96, i64* %.phi.trans.insert795, align 8
  store i64 %97, i64* %.phi.trans.insert801, align 8
  store i64 %98, i64* %.phi.trans.insert807, align 8
  store i64 %99, i64* %.phi.trans.insert813, align 8
  store i64 %100, i64* %.phi.trans.insert791, align 8
  store i64 %101, i64* %.phi.trans.insert797, align 8
  store i64 %102, i64* %.phi.trans.insert803, align 8
  store i64 %103, i64* %.phi.trans.insert809, align 8
  ret void

bb101:                                            ; preds = %bb101, %start
  %4 = phi i64 [ %.phi.trans.insert787.promoted, %start ], [ %113, %bb101 ]
  %5 = phi i64 [ %.phi.trans.insert785.promoted, %start ], [ %108, %bb101 ]
  %6 = phi i64 [ %.phi.trans.insert783.promoted, %start ], [ %112, %bb101 ]
  %7 = phi i64 [ %.phi.trans.insert781.promoted, %start ], [ %107, %bb101 ]
  %8 = phi i64 [ %.phi.trans.insert779.promoted, %start ], [ %111, %bb101 ]
  %9 = phi i64 [ %.phi.trans.insert777.promoted, %start ], [ %106, %bb101 ]
  %10 = phi i64 [ %.phi.trans.insert775.promoted, %start ], [ %110, %bb101 ]
  %11 = phi i64 [ %.phi.trans.insert.promoted, %start ], [ %105, %bb101 ]
  %12 = phi i64 [ %a.promoted, %start ], [ %117, %bb101 ]
  %13 = phi i64 [ %.promoted817, %start ], [ %114, %bb101 ]
  %14 = phi i64 [ %.promoted815, %start ], [ %109, %bb101 ]
  %15 = phi i64 [ %.promoted, %start ], [ %104, %bb101 ]
  %_30.1.4 = phi i64 [ %_30.1.4.pre, %start ], [ %99, %bb101 ]
  %_30.4409 = phi i64 [ %_30.4409.pre, %start ], [ %94, %bb101 ]
  %_30.2.3 = phi i64 [ %_30.2.3.pre, %start ], [ %103, %bb101 ]
  %_30.1.3 = phi i64 [ %_30.1.3.pre, %start ], [ %98, %bb101 ]
  %_30.3408 = phi i64 [ %_30.3408.pre, %start ], [ %93, %bb101 ]
  %_30.2.2 = phi i64 [ %_30.2.2.pre, %start ], [ %102, %bb101 ]
  %_30.1.2 = phi i64 [ %_30.1.2.pre, %start ], [ %97, %bb101 ]
  %_30.2407 = phi i64 [ %_30.2407.pre, %start ], [ %92, %bb101 ]
  %_30.2.1 = phi i64 [ %_30.2.1.pre, %start ], [ %101, %bb101 ]
  %_30.1.1 = phi i64 [ %_30.1.1.pre, %start ], [ %96, %bb101 ]
  %_30.1406 = phi i64 [ %_30.1406.pre, %start ], [ %91, %bb101 ]
  %_30.2 = phi i64 [ %_30.2.pre, %start ], [ %100, %bb101 ]
  %_30.1 = phi i64 [ %_30.1.pre, %start ], [ %95, %bb101 ]
  %_30.4.3 = phi i64 [ %_30.4.3.pre, %start ], [ %113, %bb101 ]
  %_30.3.3 = phi i64 [ %_30.3.3.pre, %start ], [ %108, %bb101 ]
  %_30.4.2 = phi i64 [ %_30.4.2.pre, %start ], [ %112, %bb101 ]
  %_30.3.2 = phi i64 [ %_30.3.2.pre, %start ], [ %107, %bb101 ]
  %_30.4.1 = phi i64 [ %_30.4.1.pre, %start ], [ %111, %bb101 ]
  %_30.3.1 = phi i64 [ %_30.3.1.pre, %start ], [ %106, %bb101 ]
  %_30.4 = phi i64 [ %_30.4.pre, %start ], [ %110, %bb101 ]
  %_30.3 = phi i64 [ %_30.3.pre, %start ], [ %105, %bb101 ]
  %_30 = phi i64 [ %_30.pre, %start ], [ %117, %bb101 ]
  %iter.sroa.0.0404 = phi i64 [ 0, %start ], [ %115, %bb101 ]
  %16 = xor i64 %_30, %_30.1
  %17 = xor i64 %16, %_30.2
  %18 = xor i64 %17, %_30.3
  %19 = xor i64 %18, %_30.4
  %20 = xor i64 %_30.1406, %_30.1.1
  %21 = xor i64 %20, %_30.2.1
  %22 = xor i64 %21, %_30.3.1
  %23 = xor i64 %22, %_30.4.1
  %24 = xor i64 %_30.2407, %_30.1.2
  %25 = xor i64 %24, %_30.2.2
  %26 = xor i64 %25, %_30.3.2
  %27 = xor i64 %26, %_30.4.2
  %28 = xor i64 %_30.3408, %_30.1.3
  %29 = xor i64 %28, %_30.2.3
  %30 = xor i64 %29, %_30.3.3
  %31 = xor i64 %30, %_30.4.3
  %32 = xor i64 %_30.4409, %_30.1.4
  %33 = xor i64 %32, %15
  %34 = xor i64 %33, %14
  %35 = xor i64 %34, %13
  %_45184 = tail call i64 @llvm.fshl.i64(i64 %23, i64 %23, i64 1)
  %36 = xor i64 %_45184, %35
  %_45184.1 = tail call i64 @llvm.fshl.i64(i64 %27, i64 %27, i64 1)
  %37 = xor i64 %_45184.1, %19
  %_45184.2 = tail call i64 @llvm.fshl.i64(i64 %31, i64 %31, i64 1)
  %38 = xor i64 %_45184.2, %23
  %_45184.3 = tail call i64 @llvm.fshl.i64(i64 %35, i64 %35, i64 1)
  %39 = xor i64 %_45184.3, %27
  %_45184.4 = tail call i64 @llvm.fshl.i64(i64 %19, i64 %19, i64 1)
  %40 = xor i64 %_45184.4, %31
  %41 = xor i64 %12, %36
  %42 = xor i64 %_30.1, %36
  %43 = xor i64 %_30.2, %36
  %44 = xor i64 %11, %36
  %45 = xor i64 %10, %36
  %46 = xor i64 %_30.1406, %37
  %47 = xor i64 %_30.1.1, %37
  %48 = xor i64 %_30.2.1, %37
  %49 = xor i64 %9, %37
  %50 = xor i64 %8, %37
  %51 = xor i64 %_30.2407, %38
  %52 = xor i64 %_30.1.2, %38
  %53 = xor i64 %_30.2.2, %38
  %54 = xor i64 %7, %38
  %55 = xor i64 %6, %38
  %56 = xor i64 %_30.3408, %39
  %57 = xor i64 %_30.1.3, %39
  %58 = xor i64 %_30.2.3, %39
  %59 = xor i64 %5, %39
  %60 = xor i64 %4, %39
  %61 = xor i64 %_30.4409, %40
  %62 = xor i64 %_30.1.4, %40
  %63 = xor i64 %15, %40
  %64 = xor i64 %14, %40
  %65 = xor i64 %13, %40
  %66 = tail call i64 @llvm.fshl.i64(i64 %42, i64 %42, i64 36)
  %67 = tail call i64 @llvm.fshl.i64(i64 %43, i64 %43, i64 3)
  %68 = tail call i64 @llvm.fshl.i64(i64 %44, i64 %44, i64 41)
  %69 = tail call i64 @llvm.fshl.i64(i64 %45, i64 %45, i64 18)
  %70 = tail call i64 @llvm.fshl.i64(i64 %46, i64 %46, i64 1)
  %71 = tail call i64 @llvm.fshl.i64(i64 %47, i64 %47, i64 44)
  %72 = tail call i64 @llvm.fshl.i64(i64 %48, i64 %48, i64 10)
  %73 = tail call i64 @llvm.fshl.i64(i64 %49, i64 %49, i64 45)
  %74 = tail call i64 @llvm.fshl.i64(i64 %50, i64 %50, i64 2)
  %75 = tail call i64 @llvm.fshl.i64(i64 %51, i64 %51, i64 62)
  %76 = tail call i64 @llvm.fshl.i64(i64 %52, i64 %52, i64 6)
  %77 = tail call i64 @llvm.fshl.i64(i64 %53, i64 %53, i64 43)
  %78 = tail call i64 @llvm.fshl.i64(i64 %54, i64 %54, i64 15)
  %79 = tail call i64 @llvm.fshl.i64(i64 %55, i64 %55, i64 61)
  %80 = tail call i64 @llvm.fshl.i64(i64 %56, i64 %56, i64 28)
  %81 = tail call i64 @llvm.fshl.i64(i64 %57, i64 %57, i64 55)
  %82 = tail call i64 @llvm.fshl.i64(i64 %58, i64 %58, i64 25)
  %83 = tail call i64 @llvm.fshl.i64(i64 %59, i64 %59, i64 21)
  %84 = tail call i64 @llvm.fshl.i64(i64 %60, i64 %60, i64 56)
  %85 = tail call i64 @llvm.fshl.i64(i64 %61, i64 %61, i64 27)
  %86 = tail call i64 @llvm.fshl.i64(i64 %62, i64 %62, i64 20)
  %87 = tail call i64 @llvm.fshl.i64(i64 %63, i64 %63, i64 39)
  %88 = tail call i64 @llvm.fshl.i64(i64 %64, i64 %64, i64 8)
  %89 = tail call i64 @llvm.fshl.i64(i64 %65, i64 %65, i64 14)
  %_198 = xor i64 %71, -1
  %_197 = and i64 %77, %_198
  %90 = xor i64 %_197, %41
  %_198.1 = xor i64 %77, -1
  %_197.1 = and i64 %83, %_198.1
  %91 = xor i64 %_197.1, %71
  %_198.2 = xor i64 %83, -1
  %_197.2 = and i64 %89, %_198.2
  %92 = xor i64 %_197.2, %77
  %_198.3 = xor i64 %89, -1
  %_197.3 = and i64 %41, %_198.3
  %93 = xor i64 %_197.3, %83
  %_198.4 = xor i64 %41, -1
  %_197.4 = and i64 %71, %_198.4
  %94 = xor i64 %_197.4, %89
  %_198.1465 = xor i64 %86, -1
  %_197.1468 = and i64 %67, %_198.1465
  %95 = xor i64 %_197.1468, %80
  %_198.1.1 = xor i64 %67, -1
  %_197.1.1 = and i64 %73, %_198.1.1
  %96 = xor i64 %_197.1.1, %86
  %_198.2.1 = xor i64 %73, -1
  %_197.2.1 = and i64 %79, %_198.2.1
  %97 = xor i64 %_197.2.1, %67
  %_198.3.1 = xor i64 %79, -1
  %_197.3.1 = and i64 %80, %_198.3.1
  %98 = xor i64 %_197.3.1, %73
  %_198.4.1 = xor i64 %80, -1
  %_197.4.1 = and i64 %86, %_198.4.1
  %99 = xor i64 %_197.4.1, %79
  %_198.2473 = xor i64 %76, -1
  %_197.2476 = and i64 %82, %_198.2473
  %100 = xor i64 %_197.2476, %70
  %_198.1.2 = xor i64 %82, -1
  %_197.1.2 = and i64 %88, %_198.1.2
  %101 = xor i64 %_197.1.2, %76
  %_198.2.2 = xor i64 %88, -1
  %_197.2.2 = and i64 %69, %_198.2.2
  %102 = xor i64 %_197.2.2, %82
  %_198.3.2 = xor i64 %69, -1
  %_197.3.2 = and i64 %70, %_198.3.2
  %103 = xor i64 %_197.3.2, %88
  %_198.4.2 = xor i64 %70, -1
  %_197.4.2 = and i64 %76, %_198.4.2
  %104 = xor i64 %_197.4.2, %69
  %_198.3481 = xor i64 %66, -1
  %_197.3483 = and i64 %72, %_198.3481
  %105 = xor i64 %_197.3483, %85
  %_198.1.3 = xor i64 %72, -1
  %_197.1.3 = and i64 %78, %_198.1.3
  %106 = xor i64 %_197.1.3, %66
  %_198.2.3 = xor i64 %78, -1
  %_197.2.3 = and i64 %84, %_198.2.3
  %107 = xor i64 %_197.2.3, %72
  %_198.3.3 = xor i64 %84, -1
  %_197.3.3 = and i64 %85, %_198.3.3
  %108 = xor i64 %_197.3.3, %78
  %_198.4.3 = xor i64 %85, -1
  %_197.4.3 = and i64 %66, %_198.4.3
  %109 = xor i64 %_197.4.3, %84
  %_198.4487 = xor i64 %81, -1
  %_197.4490 = and i64 %87, %_198.4487
  %110 = xor i64 %_197.4490, %75
  %_198.1.4 = xor i64 %87, -1
  %_197.1.4 = and i64 %68, %_198.1.4
  %111 = xor i64 %_197.1.4, %81
  %_198.2.4 = xor i64 %68, -1
  %_197.2.4 = and i64 %74, %_198.2.4
  %112 = xor i64 %_197.2.4, %87
  %_198.3.4 = xor i64 %74, -1
  %_197.3.4 = and i64 %75, %_198.3.4
  %113 = xor i64 %_197.3.4, %68
  %_198.4.4 = xor i64 %75, -1
  %_197.4.4 = and i64 %81, %_198.4.4
  %114 = xor i64 %_197.4.4, %74
  %115 = add nuw nsw i64 %iter.sroa.0.0404, 1
  %116 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.0 to [24 x i64]*), i64 0, i64 %iter.sroa.0.0404
  %_232 = load i64, i64* %116, align 8, !noundef !2
  %117 = xor i64 %90, %_232
  %exitcond.not = icmp eq i64 %115, 24
  br i1 %exitcond.not, label %bb5, label %bb101
}

; Function Attrs: nounwind nonlazybind
define void @keccak(i64* noundef %input_pointer) unnamed_addr #3 {
start:
  tail call void @_ZN11rust_keccak16keccak_idiomatic6keccak17h94ae4a3f782890efE(i64* noundef %input_pointer) #4
  ret void
}

attributes #0 = { nonlazybind "target-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #3 = { nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #4 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
