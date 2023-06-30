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
@anon.81d2408192f774ffc0f511fc69066f5d.0 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8

; Function Attrs: nonlazybind
declare i32 @rust_eh_personality(...) unnamed_addr #0

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #1

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #2

; Function Attrs: nounwind nonlazybind
define void @_ZN11rust_keccak16keccak_idiomatic6keccak17h5aa4472b1ac1c5dbE(i64* noundef %a) unnamed_addr #3 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
start:
  %0 = icmp ne i64* %a, null
  tail call void @llvm.assume(i1 %0)
  %1 = getelementptr inbounds i64, i64* %a, i64 5
  %2 = getelementptr inbounds i64, i64* %a, i64 10
  %3 = getelementptr inbounds i64, i64* %a, i64 15
  %4 = getelementptr inbounds i64, i64* %a, i64 20
  %5 = getelementptr inbounds i64, i64* %a, i64 1
  %6 = getelementptr inbounds i64, i64* %a, i64 6
  %7 = getelementptr inbounds i64, i64* %a, i64 11
  %8 = getelementptr inbounds i64, i64* %a, i64 16
  %9 = getelementptr inbounds i64, i64* %a, i64 21
  %10 = getelementptr inbounds i64, i64* %a, i64 2
  %11 = getelementptr inbounds i64, i64* %a, i64 7
  %12 = getelementptr inbounds i64, i64* %a, i64 12
  %13 = getelementptr inbounds i64, i64* %a, i64 17
  %14 = getelementptr inbounds i64, i64* %a, i64 22
  %15 = getelementptr inbounds i64, i64* %a, i64 3
  %16 = getelementptr inbounds i64, i64* %a, i64 8
  %17 = getelementptr inbounds i64, i64* %a, i64 13
  %18 = getelementptr inbounds i64, i64* %a, i64 18
  %19 = getelementptr inbounds i64, i64* %a, i64 23
  %20 = getelementptr inbounds i64, i64* %a, i64 4
  %21 = getelementptr inbounds i64, i64* %a, i64 9
  %22 = getelementptr inbounds i64, i64* %a, i64 14
  %23 = getelementptr inbounds i64, i64* %a, i64 19
  %24 = getelementptr inbounds i64, i64* %a, i64 24
  %_18.i.pre = load i64, i64* %a, align 8, !alias.scope !2
  %_18.1.i.pre = load i64, i64* %1, align 8, !alias.scope !2
  %_18.2.i.pre = load i64, i64* %2, align 8, !alias.scope !2
  %_18.3.i.pre = load i64, i64* %3, align 8, !alias.scope !2
  %_18.4.i.pre = load i64, i64* %4, align 8, !alias.scope !2
  %_18.1120.i.pre = load i64, i64* %5, align 8, !alias.scope !2
  %_18.1.1.i.pre = load i64, i64* %6, align 8, !alias.scope !2
  %_18.2.1.i.pre = load i64, i64* %7, align 8, !alias.scope !2
  %_18.3.1.i.pre = load i64, i64* %8, align 8, !alias.scope !2
  %_18.4.1.i.pre = load i64, i64* %9, align 8, !alias.scope !2
  %_18.2121.i.pre = load i64, i64* %10, align 8, !alias.scope !2
  %_18.1.2.i.pre = load i64, i64* %11, align 8, !alias.scope !2
  %_18.2.2.i.pre = load i64, i64* %12, align 8, !alias.scope !2
  %_18.3.2.i.pre = load i64, i64* %13, align 8, !alias.scope !2
  %_18.4.2.i.pre = load i64, i64* %14, align 8, !alias.scope !2
  %_18.3122.i.pre = load i64, i64* %15, align 8, !alias.scope !2
  %_18.1.3.i.pre = load i64, i64* %16, align 8, !alias.scope !2
  %_18.2.3.i.pre = load i64, i64* %17, align 8, !alias.scope !2
  %_18.3.3.i.pre = load i64, i64* %18, align 8, !alias.scope !2
  %_18.4.3.i.pre = load i64, i64* %19, align 8, !alias.scope !2
  %_18.4123.i.pre = load i64, i64* %20, align 8, !alias.scope !2
  %_18.1.4.i.pre = load i64, i64* %21, align 8, !alias.scope !2
  %_18.2.4.i.pre = load i64, i64* %22, align 8, !alias.scope !2
  %_18.3.4.i.pre = load i64, i64* %23, align 8, !alias.scope !2
  %_18.4.4.i.pre = load i64, i64* %24, align 8, !alias.scope !2
  br label %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit

bb5:                                              ; preds = %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit
  store i64 %100, i64* %5, align 8, !alias.scope !5
  store i64 %101, i64* %10, align 8, !alias.scope !5
  store i64 %102, i64* %15, align 8, !alias.scope !5
  store i64 %103, i64* %20, align 8, !alias.scope !5
  store i64 %104, i64* %1, align 8, !alias.scope !5
  store i64 %105, i64* %6, align 8, !alias.scope !5
  store i64 %106, i64* %11, align 8, !alias.scope !5
  store i64 %107, i64* %16, align 8, !alias.scope !5
  store i64 %108, i64* %21, align 8, !alias.scope !5
  store i64 %109, i64* %2, align 8, !alias.scope !5
  store i64 %110, i64* %7, align 8, !alias.scope !5
  store i64 %111, i64* %12, align 8, !alias.scope !5
  store i64 %112, i64* %17, align 8, !alias.scope !5
  store i64 %113, i64* %22, align 8, !alias.scope !5
  store i64 %114, i64* %3, align 8, !alias.scope !5
  store i64 %115, i64* %8, align 8, !alias.scope !5
  store i64 %116, i64* %13, align 8, !alias.scope !5
  store i64 %117, i64* %18, align 8, !alias.scope !5
  store i64 %118, i64* %23, align 8, !alias.scope !5
  store i64 %119, i64* %4, align 8, !alias.scope !5
  store i64 %120, i64* %9, align 8, !alias.scope !5
  store i64 %121, i64* %14, align 8, !alias.scope !5
  store i64 %122, i64* %19, align 8, !alias.scope !5
  store i64 %123, i64* %24, align 8, !alias.scope !5
  store i64 %126, i64* %a, align 8, !alias.scope !8
  ret void

_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit: ; preds = %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit, %start
  %_18.4.4.i = phi i64 [ %_18.4.4.i.pre, %start ], [ %123, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3.4.i = phi i64 [ %_18.3.4.i.pre, %start ], [ %118, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2.4.i = phi i64 [ %_18.2.4.i.pre, %start ], [ %113, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1.4.i = phi i64 [ %_18.1.4.i.pre, %start ], [ %108, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.4123.i = phi i64 [ %_18.4123.i.pre, %start ], [ %103, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.4.3.i = phi i64 [ %_18.4.3.i.pre, %start ], [ %122, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3.3.i = phi i64 [ %_18.3.3.i.pre, %start ], [ %117, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2.3.i = phi i64 [ %_18.2.3.i.pre, %start ], [ %112, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1.3.i = phi i64 [ %_18.1.3.i.pre, %start ], [ %107, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3122.i = phi i64 [ %_18.3122.i.pre, %start ], [ %102, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.4.2.i = phi i64 [ %_18.4.2.i.pre, %start ], [ %121, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3.2.i = phi i64 [ %_18.3.2.i.pre, %start ], [ %116, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2.2.i = phi i64 [ %_18.2.2.i.pre, %start ], [ %111, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1.2.i = phi i64 [ %_18.1.2.i.pre, %start ], [ %106, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2121.i = phi i64 [ %_18.2121.i.pre, %start ], [ %101, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.4.1.i = phi i64 [ %_18.4.1.i.pre, %start ], [ %120, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3.1.i = phi i64 [ %_18.3.1.i.pre, %start ], [ %115, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2.1.i = phi i64 [ %_18.2.1.i.pre, %start ], [ %110, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1.1.i = phi i64 [ %_18.1.1.i.pre, %start ], [ %105, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1120.i = phi i64 [ %_18.1120.i.pre, %start ], [ %100, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.4.i = phi i64 [ %_18.4.i.pre, %start ], [ %119, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.3.i = phi i64 [ %_18.3.i.pre, %start ], [ %114, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.2.i = phi i64 [ %_18.2.i.pre, %start ], [ %109, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.1.i = phi i64 [ %_18.1.i.pre, %start ], [ %104, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %_18.i = phi i64 [ %_18.i.pre, %start ], [ %126, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %iter.sroa.0.024 = phi i64 [ 0, %start ], [ %124, %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit ]
  %25 = xor i64 %_18.1.i, %_18.i
  %26 = xor i64 %25, %_18.2.i
  %27 = xor i64 %26, %_18.3.i
  %28 = xor i64 %27, %_18.4.i
  %29 = xor i64 %_18.1.1.i, %_18.1120.i
  %30 = xor i64 %29, %_18.2.1.i
  %31 = xor i64 %30, %_18.3.1.i
  %32 = xor i64 %31, %_18.4.1.i
  %33 = xor i64 %_18.1.2.i, %_18.2121.i
  %34 = xor i64 %33, %_18.2.2.i
  %35 = xor i64 %34, %_18.3.2.i
  %36 = xor i64 %35, %_18.4.2.i
  %37 = xor i64 %_18.1.3.i, %_18.3122.i
  %38 = xor i64 %37, %_18.2.3.i
  %39 = xor i64 %38, %_18.3.3.i
  %40 = xor i64 %39, %_18.4.3.i
  %41 = xor i64 %_18.1.4.i, %_18.4123.i
  %42 = xor i64 %41, %_18.2.4.i
  %43 = xor i64 %42, %_18.3.4.i
  %44 = xor i64 %43, %_18.4.4.i
  %_3349.i = tail call i64 @llvm.fshl.i64(i64 %32, i64 %32, i64 1)
  %45 = xor i64 %44, %_3349.i
  %_3349.1.i = tail call i64 @llvm.fshl.i64(i64 %36, i64 %36, i64 1)
  %46 = xor i64 %_3349.1.i, %28
  %_3349.2.i = tail call i64 @llvm.fshl.i64(i64 %40, i64 %40, i64 1)
  %47 = xor i64 %_3349.2.i, %32
  %_3349.3.i = tail call i64 @llvm.fshl.i64(i64 %44, i64 %44, i64 1)
  %48 = xor i64 %_3349.3.i, %36
  %_3349.4.i = tail call i64 @llvm.fshl.i64(i64 %28, i64 %28, i64 1)
  %49 = xor i64 %40, %_3349.4.i
  %50 = xor i64 %45, %_18.i
  %51 = xor i64 %45, %_18.1.i
  %52 = xor i64 %45, %_18.2.i
  %53 = xor i64 %45, %_18.3.i
  %54 = xor i64 %45, %_18.4.i
  %55 = xor i64 %46, %_18.1120.i
  %56 = xor i64 %46, %_18.1.1.i
  %57 = xor i64 %46, %_18.2.1.i
  %58 = xor i64 %46, %_18.3.1.i
  %59 = xor i64 %46, %_18.4.1.i
  %60 = xor i64 %47, %_18.2121.i
  %61 = xor i64 %47, %_18.1.2.i
  %62 = xor i64 %47, %_18.2.2.i
  %63 = xor i64 %47, %_18.3.2.i
  %64 = xor i64 %47, %_18.4.2.i
  %65 = xor i64 %48, %_18.3122.i
  %66 = xor i64 %48, %_18.1.3.i
  %67 = xor i64 %48, %_18.2.3.i
  %68 = xor i64 %48, %_18.3.3.i
  %69 = xor i64 %48, %_18.4.3.i
  %70 = xor i64 %49, %_18.4123.i
  %71 = xor i64 %_18.1.4.i, %49
  %72 = xor i64 %_18.2.4.i, %49
  %73 = xor i64 %_18.3.4.i, %49
  %74 = xor i64 %_18.4.4.i, %49
  %75 = tail call i64 @llvm.fshl.i64(i64 %51, i64 %51, i64 36)
  %76 = tail call i64 @llvm.fshl.i64(i64 %52, i64 %52, i64 3)
  %77 = tail call i64 @llvm.fshl.i64(i64 %53, i64 %53, i64 41)
  %78 = tail call i64 @llvm.fshl.i64(i64 %54, i64 %54, i64 18)
  %79 = tail call i64 @llvm.fshl.i64(i64 %55, i64 %55, i64 1)
  %80 = tail call i64 @llvm.fshl.i64(i64 %56, i64 %56, i64 44)
  %81 = tail call i64 @llvm.fshl.i64(i64 %57, i64 %57, i64 10)
  %82 = tail call i64 @llvm.fshl.i64(i64 %58, i64 %58, i64 45)
  %83 = tail call i64 @llvm.fshl.i64(i64 %59, i64 %59, i64 2)
  %84 = tail call i64 @llvm.fshl.i64(i64 %60, i64 %60, i64 62)
  %85 = tail call i64 @llvm.fshl.i64(i64 %61, i64 %61, i64 6)
  %86 = tail call i64 @llvm.fshl.i64(i64 %62, i64 %62, i64 43)
  %87 = tail call i64 @llvm.fshl.i64(i64 %63, i64 %63, i64 15)
  %88 = tail call i64 @llvm.fshl.i64(i64 %64, i64 %64, i64 61)
  %89 = tail call i64 @llvm.fshl.i64(i64 %65, i64 %65, i64 28)
  %90 = tail call i64 @llvm.fshl.i64(i64 %66, i64 %66, i64 55)
  %91 = tail call i64 @llvm.fshl.i64(i64 %67, i64 %67, i64 25)
  %92 = tail call i64 @llvm.fshl.i64(i64 %68, i64 %68, i64 21)
  %93 = tail call i64 @llvm.fshl.i64(i64 %69, i64 %69, i64 56)
  %94 = tail call i64 @llvm.fshl.i64(i64 %70, i64 %70, i64 27)
  %95 = tail call i64 @llvm.fshl.i64(i64 %71, i64 %71, i64 20)
  %96 = tail call i64 @llvm.fshl.i64(i64 %72, i64 %72, i64 39)
  %97 = tail call i64 @llvm.fshl.i64(i64 %73, i64 %73, i64 8)
  %98 = tail call i64 @llvm.fshl.i64(i64 %74, i64 %74, i64 14)
  %_23.i12 = xor i64 %80, -1
  %_22.i = and i64 %86, %_23.i12
  %99 = xor i64 %50, %_22.i
  %_23.1.i13 = xor i64 %86, -1
  %_22.1.i = and i64 %92, %_23.1.i13
  %100 = xor i64 %_22.1.i, %80
  %_23.2.i14 = xor i64 %92, -1
  %_22.2.i = and i64 %98, %_23.2.i14
  %101 = xor i64 %_22.2.i, %86
  %_23.3.i15 = xor i64 %98, -1
  %_22.3.i = and i64 %50, %_23.3.i15
  %102 = xor i64 %_22.3.i, %92
  %_23.4.i16 = xor i64 %50, -1
  %_22.4.i = and i64 %80, %_23.4.i16
  %103 = xor i64 %_22.4.i, %98
  %_23.168.i = xor i64 %95, -1
  %_22.171.i = and i64 %76, %_23.168.i
  %104 = xor i64 %_22.171.i, %89
  %_23.1.1.i = xor i64 %76, -1
  %_22.1.1.i = and i64 %82, %_23.1.1.i
  %105 = xor i64 %95, %_22.1.1.i
  %_23.2.1.i = xor i64 %82, -1
  %_22.2.1.i = and i64 %88, %_23.2.1.i
  %106 = xor i64 %_22.2.1.i, %76
  %_23.3.1.i = xor i64 %88, -1
  %_22.3.1.i = and i64 %89, %_23.3.1.i
  %107 = xor i64 %_22.3.1.i, %82
  %_23.4.1.i = xor i64 %89, -1
  %_22.4.1.i = and i64 %95, %_23.4.1.i
  %108 = xor i64 %_22.4.1.i, %88
  %_23.276.i = xor i64 %85, -1
  %_22.279.i = and i64 %91, %_23.276.i
  %109 = xor i64 %_22.279.i, %79
  %_23.1.2.i = xor i64 %91, -1
  %_22.1.2.i = and i64 %97, %_23.1.2.i
  %110 = xor i64 %_22.1.2.i, %85
  %_23.2.2.i = xor i64 %97, -1
  %_22.2.2.i = and i64 %78, %_23.2.2.i
  %111 = xor i64 %_22.2.2.i, %91
  %_23.3.2.i = xor i64 %78, -1
  %_22.3.2.i = and i64 %79, %_23.3.2.i
  %112 = xor i64 %97, %_22.3.2.i
  %_23.4.2.i = xor i64 %79, -1
  %_22.4.2.i = and i64 %85, %_23.4.2.i
  %113 = xor i64 %_22.4.2.i, %78
  %_23.384.i = xor i64 %75, -1
  %_22.386.i = and i64 %81, %_23.384.i
  %114 = xor i64 %94, %_22.386.i
  %_23.1.3.i = xor i64 %81, -1
  %_22.1.3.i = and i64 %87, %_23.1.3.i
  %115 = xor i64 %_22.1.3.i, %75
  %_23.2.3.i = xor i64 %87, -1
  %_22.2.3.i = and i64 %93, %_23.2.3.i
  %116 = xor i64 %_22.2.3.i, %81
  %_23.3.3.i = xor i64 %93, -1
  %_22.3.3.i = and i64 %94, %_23.3.3.i
  %117 = xor i64 %_22.3.3.i, %87
  %_23.4.3.i = xor i64 %94, -1
  %_22.4.3.i = and i64 %75, %_23.4.3.i
  %118 = xor i64 %_22.4.3.i, %93
  %_23.490.i = xor i64 %90, -1
  %_22.493.i = and i64 %96, %_23.490.i
  %119 = xor i64 %_22.493.i, %84
  %_23.1.4.i = xor i64 %96, -1
  %_22.1.4.i = and i64 %77, %_23.1.4.i
  %120 = xor i64 %_22.1.4.i, %90
  %_23.2.4.i = xor i64 %77, -1
  %_22.2.4.i = and i64 %83, %_23.2.4.i
  %121 = xor i64 %96, %_22.2.4.i
  %_23.3.4.i = xor i64 %83, -1
  %_22.3.4.i = and i64 %84, %_23.3.4.i
  %122 = xor i64 %_22.3.4.i, %77
  %_23.4.4.i = xor i64 %84, -1
  %_22.4.4.i = and i64 %90, %_23.4.4.i
  %123 = xor i64 %_22.4.4.i, %83
  tail call void @llvm.experimental.noalias.scope.decl(metadata !8)
  %124 = add nuw nsw i64 %iter.sroa.0.024, 1
  %125 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.81d2408192f774ffc0f511fc69066f5d.0 to [24 x i64]*), i64 0, i64 %iter.sroa.0.024
  %_3.i17 = load i64, i64* %125, align 8, !noalias !8, !noundef !11
  %126 = xor i64 %_3.i17, %99
  %exitcond.not = icmp eq i64 %124, 24
  br i1 %exitcond.not, label %bb5, label %_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E.exit
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.experimental.noalias.scope.decl(metadata) #2

; Function Attrs: nounwind nonlazybind
define void @keccak(i64* noundef %input_pointer) unnamed_addr #3 {
start:
  tail call void @_ZN11rust_keccak16keccak_idiomatic6keccak17h5aa4472b1ac1c5dbE(i64* noundef %input_pointer) #4
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
!2 = !{!3}
!3 = distinct !{!3, !4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE: %a"}
!4 = distinct !{!4, !"_ZN11rust_keccak16keccak_idiomatic5theta17h1b65fc4534a207ddE"}
!5 = !{!6}
!6 = distinct !{!6, !7, !"_ZN11rust_keccak16keccak_idiomatic3chi17h43705a6eace343b2E: %a"}
!7 = distinct !{!7, !"_ZN11rust_keccak16keccak_idiomatic3chi17h43705a6eace343b2E"}
!8 = !{!9}
!9 = distinct !{!9, !10, !"_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E: %a"}
!10 = distinct !{!10, !"_ZN11rust_keccak16keccak_idiomatic4iota17h93435c968f686e07E"}
!11 = !{}
