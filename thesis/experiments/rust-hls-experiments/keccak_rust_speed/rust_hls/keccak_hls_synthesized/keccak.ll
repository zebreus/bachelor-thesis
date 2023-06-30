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

; Function Attrs: nounwind nonlazybind
define void @_ZN11rust_keccak6keccak6keccak17h5798c7dfdadb5aa6E(i64* noundef %a) unnamed_addr #2 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* bitcast (i32 (...)* @rust_eh_personality to i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)*) {
start:
  %0 = getelementptr inbounds i64, i64* %a, i64 5
  %1 = getelementptr inbounds i64, i64* %a, i64 10
  %2 = getelementptr inbounds i64, i64* %a, i64 15
  %3 = getelementptr inbounds i64, i64* %a, i64 20
  %4 = getelementptr inbounds i64, i64* %a, i64 1
  %5 = getelementptr inbounds i64, i64* %a, i64 6
  %6 = getelementptr inbounds i64, i64* %a, i64 11
  %7 = getelementptr inbounds i64, i64* %a, i64 16
  %8 = getelementptr inbounds i64, i64* %a, i64 21
  %9 = getelementptr inbounds i64, i64* %a, i64 2
  %10 = getelementptr inbounds i64, i64* %a, i64 7
  %11 = getelementptr inbounds i64, i64* %a, i64 12
  %12 = getelementptr inbounds i64, i64* %a, i64 17
  %13 = getelementptr inbounds i64, i64* %a, i64 22
  %14 = getelementptr inbounds i64, i64* %a, i64 3
  %15 = getelementptr inbounds i64, i64* %a, i64 8
  %16 = getelementptr inbounds i64, i64* %a, i64 13
  %17 = getelementptr inbounds i64, i64* %a, i64 18
  %18 = getelementptr inbounds i64, i64* %a, i64 23
  %19 = getelementptr inbounds i64, i64* %a, i64 4
  %20 = getelementptr inbounds i64, i64* %a, i64 9
  %21 = getelementptr inbounds i64, i64* %a, i64 14
  %22 = getelementptr inbounds i64, i64* %a, i64 19
  %23 = getelementptr inbounds i64, i64* %a, i64 24
  %_18.i.pre = load i64, i64* %a, align 8
  %_18.1.i.pre = load i64, i64* %0, align 8
  %_18.2.i.pre = load i64, i64* %1, align 8
  %_18.3.i.pre = load i64, i64* %2, align 8
  %_18.4.i.pre = load i64, i64* %3, align 8
  %_18.1122.i.pre = load i64, i64* %4, align 8
  %_18.1.1.i.pre = load i64, i64* %5, align 8
  %_18.2.1.i.pre = load i64, i64* %6, align 8
  %_18.3.1.i.pre = load i64, i64* %7, align 8
  %_18.4.1.i.pre = load i64, i64* %8, align 8
  %_18.2123.i.pre = load i64, i64* %9, align 8
  %_18.1.2.i.pre = load i64, i64* %10, align 8
  %_18.2.2.i.pre = load i64, i64* %11, align 8
  %_18.3.2.i.pre = load i64, i64* %12, align 8
  %_18.4.2.i.pre = load i64, i64* %13, align 8
  %_18.3124.i.pre = load i64, i64* %14, align 8
  %_18.1.3.i.pre = load i64, i64* %15, align 8
  %_18.2.3.i.pre = load i64, i64* %16, align 8
  %_18.3.3.i.pre = load i64, i64* %17, align 8
  %_18.4.3.i.pre = load i64, i64* %18, align 8
  %_18.4125.i.pre = load i64, i64* %19, align 8
  %_18.1.4.i.pre = load i64, i64* %20, align 8
  %_18.2.4.i.pre = load i64, i64* %21, align 8
  %_18.3.4.i.pre = load i64, i64* %22, align 8
  %_18.4.4.i.pre = load i64, i64* %23, align 8
  br label %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit

bb4:                                              ; preds = %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit
  store i64 %99, i64* %4, align 8
  store i64 %100, i64* %9, align 8
  store i64 %101, i64* %14, align 8
  store i64 %102, i64* %19, align 8
  store i64 %103, i64* %0, align 8
  store i64 %104, i64* %5, align 8
  store i64 %105, i64* %10, align 8
  store i64 %106, i64* %15, align 8
  store i64 %107, i64* %20, align 8
  store i64 %108, i64* %1, align 8
  store i64 %109, i64* %6, align 8
  store i64 %110, i64* %11, align 8
  store i64 %111, i64* %16, align 8
  store i64 %112, i64* %21, align 8
  store i64 %113, i64* %2, align 8
  store i64 %114, i64* %7, align 8
  store i64 %115, i64* %12, align 8
  store i64 %116, i64* %17, align 8
  store i64 %117, i64* %22, align 8
  store i64 %118, i64* %3, align 8
  store i64 %119, i64* %8, align 8
  store i64 %120, i64* %13, align 8
  store i64 %121, i64* %18, align 8
  store i64 %122, i64* %23, align 8
  store i64 %125, i64* %a, align 8
  ret void

_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit: ; preds = %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit, %start
  %_18.4.4.i = phi i64 [ %_18.4.4.i.pre, %start ], [ %122, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3.4.i = phi i64 [ %_18.3.4.i.pre, %start ], [ %117, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2.4.i = phi i64 [ %_18.2.4.i.pre, %start ], [ %112, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1.4.i = phi i64 [ %_18.1.4.i.pre, %start ], [ %107, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.4125.i = phi i64 [ %_18.4125.i.pre, %start ], [ %102, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.4.3.i = phi i64 [ %_18.4.3.i.pre, %start ], [ %121, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3.3.i = phi i64 [ %_18.3.3.i.pre, %start ], [ %116, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2.3.i = phi i64 [ %_18.2.3.i.pre, %start ], [ %111, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1.3.i = phi i64 [ %_18.1.3.i.pre, %start ], [ %106, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3124.i = phi i64 [ %_18.3124.i.pre, %start ], [ %101, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.4.2.i = phi i64 [ %_18.4.2.i.pre, %start ], [ %120, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3.2.i = phi i64 [ %_18.3.2.i.pre, %start ], [ %115, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2.2.i = phi i64 [ %_18.2.2.i.pre, %start ], [ %110, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1.2.i = phi i64 [ %_18.1.2.i.pre, %start ], [ %105, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2123.i = phi i64 [ %_18.2123.i.pre, %start ], [ %100, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.4.1.i = phi i64 [ %_18.4.1.i.pre, %start ], [ %119, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3.1.i = phi i64 [ %_18.3.1.i.pre, %start ], [ %114, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2.1.i = phi i64 [ %_18.2.1.i.pre, %start ], [ %109, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1.1.i = phi i64 [ %_18.1.1.i.pre, %start ], [ %104, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1122.i = phi i64 [ %_18.1122.i.pre, %start ], [ %99, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.4.i = phi i64 [ %_18.4.i.pre, %start ], [ %118, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.3.i = phi i64 [ %_18.3.i.pre, %start ], [ %113, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.2.i = phi i64 [ %_18.2.i.pre, %start ], [ %108, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.1.i = phi i64 [ %_18.1.i.pre, %start ], [ %103, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %_18.i = phi i64 [ %_18.i.pre, %start ], [ %125, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %iter.sroa.0.019 = phi i64 [ 0, %start ], [ %123, %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit ]
  %24 = xor i64 %_18.1.i, %_18.i
  %25 = xor i64 %24, %_18.2.i
  %26 = xor i64 %25, %_18.3.i
  %27 = xor i64 %26, %_18.4.i
  %28 = xor i64 %_18.1.1.i, %_18.1122.i
  %29 = xor i64 %28, %_18.2.1.i
  %30 = xor i64 %29, %_18.3.1.i
  %31 = xor i64 %30, %_18.4.1.i
  %32 = xor i64 %_18.1.2.i, %_18.2123.i
  %33 = xor i64 %32, %_18.2.2.i
  %34 = xor i64 %33, %_18.3.2.i
  %35 = xor i64 %34, %_18.4.2.i
  %36 = xor i64 %_18.1.3.i, %_18.3124.i
  %37 = xor i64 %36, %_18.2.3.i
  %38 = xor i64 %37, %_18.3.3.i
  %39 = xor i64 %38, %_18.4.3.i
  %40 = xor i64 %_18.1.4.i, %_18.4125.i
  %41 = xor i64 %40, %_18.2.4.i
  %42 = xor i64 %41, %_18.3.4.i
  %43 = xor i64 %42, %_18.4.4.i
  %_3251.i = tail call i64 @llvm.fshl.i64(i64 %31, i64 %31, i64 1)
  %44 = xor i64 %43, %_3251.i
  %_3251.1.i = tail call i64 @llvm.fshl.i64(i64 %35, i64 %35, i64 1)
  %45 = xor i64 %_3251.1.i, %27
  %_3251.2.i = tail call i64 @llvm.fshl.i64(i64 %39, i64 %39, i64 1)
  %46 = xor i64 %_3251.2.i, %31
  %_3251.3.i = tail call i64 @llvm.fshl.i64(i64 %43, i64 %43, i64 1)
  %47 = xor i64 %_3251.3.i, %35
  %_3251.4.i = tail call i64 @llvm.fshl.i64(i64 %27, i64 %27, i64 1)
  %48 = xor i64 %39, %_3251.4.i
  %49 = xor i64 %44, %_18.i
  %50 = xor i64 %44, %_18.1.i
  %51 = xor i64 %44, %_18.2.i
  %52 = xor i64 %44, %_18.3.i
  %53 = xor i64 %44, %_18.4.i
  %54 = xor i64 %45, %_18.1122.i
  %55 = xor i64 %45, %_18.1.1.i
  %56 = xor i64 %45, %_18.2.1.i
  %57 = xor i64 %45, %_18.3.1.i
  %58 = xor i64 %45, %_18.4.1.i
  %59 = xor i64 %46, %_18.2123.i
  %60 = xor i64 %46, %_18.1.2.i
  %61 = xor i64 %46, %_18.2.2.i
  %62 = xor i64 %46, %_18.3.2.i
  %63 = xor i64 %46, %_18.4.2.i
  %64 = xor i64 %47, %_18.3124.i
  %65 = xor i64 %47, %_18.1.3.i
  %66 = xor i64 %47, %_18.2.3.i
  %67 = xor i64 %47, %_18.3.3.i
  %68 = xor i64 %47, %_18.4.3.i
  %69 = xor i64 %48, %_18.4125.i
  %70 = xor i64 %_18.1.4.i, %48
  %71 = xor i64 %_18.2.4.i, %48
  %72 = xor i64 %_18.3.4.i, %48
  %73 = xor i64 %_18.4.4.i, %48
  %74 = tail call i64 @llvm.fshl.i64(i64 %50, i64 %50, i64 36)
  %75 = tail call i64 @llvm.fshl.i64(i64 %51, i64 %51, i64 3)
  %76 = tail call i64 @llvm.fshl.i64(i64 %52, i64 %52, i64 41)
  %77 = tail call i64 @llvm.fshl.i64(i64 %53, i64 %53, i64 18)
  %78 = tail call i64 @llvm.fshl.i64(i64 %54, i64 %54, i64 1)
  %79 = tail call i64 @llvm.fshl.i64(i64 %55, i64 %55, i64 44)
  %80 = tail call i64 @llvm.fshl.i64(i64 %56, i64 %56, i64 10)
  %81 = tail call i64 @llvm.fshl.i64(i64 %57, i64 %57, i64 45)
  %82 = tail call i64 @llvm.fshl.i64(i64 %58, i64 %58, i64 2)
  %83 = tail call i64 @llvm.fshl.i64(i64 %59, i64 %59, i64 62)
  %84 = tail call i64 @llvm.fshl.i64(i64 %60, i64 %60, i64 6)
  %85 = tail call i64 @llvm.fshl.i64(i64 %61, i64 %61, i64 43)
  %86 = tail call i64 @llvm.fshl.i64(i64 %62, i64 %62, i64 15)
  %87 = tail call i64 @llvm.fshl.i64(i64 %63, i64 %63, i64 61)
  %88 = tail call i64 @llvm.fshl.i64(i64 %64, i64 %64, i64 28)
  %89 = tail call i64 @llvm.fshl.i64(i64 %65, i64 %65, i64 55)
  %90 = tail call i64 @llvm.fshl.i64(i64 %66, i64 %66, i64 25)
  %91 = tail call i64 @llvm.fshl.i64(i64 %67, i64 %67, i64 21)
  %92 = tail call i64 @llvm.fshl.i64(i64 %68, i64 %68, i64 56)
  %93 = tail call i64 @llvm.fshl.i64(i64 %69, i64 %69, i64 27)
  %94 = tail call i64 @llvm.fshl.i64(i64 %70, i64 %70, i64 20)
  %95 = tail call i64 @llvm.fshl.i64(i64 %71, i64 %71, i64 39)
  %96 = tail call i64 @llvm.fshl.i64(i64 %72, i64 %72, i64 8)
  %97 = tail call i64 @llvm.fshl.i64(i64 %73, i64 %73, i64 14)
  %_22.i = xor i64 %79, -1
  %_21.i = and i64 %85, %_22.i
  %98 = xor i64 %49, %_21.i
  %_22.1.i = xor i64 %85, -1
  %_21.1.i = and i64 %91, %_22.1.i
  %99 = xor i64 %_21.1.i, %79
  %_22.2.i = xor i64 %91, -1
  %_21.2.i = and i64 %97, %_22.2.i
  %100 = xor i64 %_21.2.i, %85
  %_22.3.i = xor i64 %97, -1
  %_21.3.i = and i64 %49, %_22.3.i
  %101 = xor i64 %_21.3.i, %91
  %_22.4.i = xor i64 %49, -1
  %_21.4.i = and i64 %79, %_22.4.i
  %102 = xor i64 %_21.4.i, %97
  %_22.173.i = xor i64 %94, -1
  %_21.176.i = and i64 %75, %_22.173.i
  %103 = xor i64 %_21.176.i, %88
  %_22.1.1.i = xor i64 %75, -1
  %_21.1.1.i = and i64 %81, %_22.1.1.i
  %104 = xor i64 %94, %_21.1.1.i
  %_22.2.1.i = xor i64 %81, -1
  %_21.2.1.i = and i64 %87, %_22.2.1.i
  %105 = xor i64 %_21.2.1.i, %75
  %_22.3.1.i = xor i64 %87, -1
  %_21.3.1.i = and i64 %88, %_22.3.1.i
  %106 = xor i64 %_21.3.1.i, %81
  %_22.4.1.i = xor i64 %88, -1
  %_21.4.1.i = and i64 %94, %_22.4.1.i
  %107 = xor i64 %_21.4.1.i, %87
  %_22.281.i = xor i64 %84, -1
  %_21.284.i = and i64 %90, %_22.281.i
  %108 = xor i64 %_21.284.i, %78
  %_22.1.2.i = xor i64 %90, -1
  %_21.1.2.i = and i64 %96, %_22.1.2.i
  %109 = xor i64 %_21.1.2.i, %84
  %_22.2.2.i = xor i64 %96, -1
  %_21.2.2.i = and i64 %77, %_22.2.2.i
  %110 = xor i64 %_21.2.2.i, %90
  %_22.3.2.i = xor i64 %77, -1
  %_21.3.2.i = and i64 %78, %_22.3.2.i
  %111 = xor i64 %96, %_21.3.2.i
  %_22.4.2.i = xor i64 %78, -1
  %_21.4.2.i = and i64 %84, %_22.4.2.i
  %112 = xor i64 %_21.4.2.i, %77
  %_22.389.i = xor i64 %74, -1
  %_21.391.i = and i64 %80, %_22.389.i
  %113 = xor i64 %93, %_21.391.i
  %_22.1.3.i = xor i64 %80, -1
  %_21.1.3.i = and i64 %86, %_22.1.3.i
  %114 = xor i64 %_21.1.3.i, %74
  %_22.2.3.i = xor i64 %86, -1
  %_21.2.3.i = and i64 %92, %_22.2.3.i
  %115 = xor i64 %_21.2.3.i, %80
  %_22.3.3.i = xor i64 %92, -1
  %_21.3.3.i = and i64 %93, %_22.3.3.i
  %116 = xor i64 %_21.3.3.i, %86
  %_22.4.3.i = xor i64 %93, -1
  %_21.4.3.i = and i64 %74, %_22.4.3.i
  %117 = xor i64 %_21.4.3.i, %92
  %_22.495.i = xor i64 %89, -1
  %_21.498.i = and i64 %95, %_22.495.i
  %118 = xor i64 %_21.498.i, %83
  %_22.1.4.i = xor i64 %95, -1
  %_21.1.4.i = and i64 %76, %_22.1.4.i
  %119 = xor i64 %_21.1.4.i, %89
  %_22.2.4.i = xor i64 %76, -1
  %_21.2.4.i = and i64 %82, %_22.2.4.i
  %120 = xor i64 %95, %_21.2.4.i
  %_22.3.4.i = xor i64 %82, -1
  %_21.3.4.i = and i64 %83, %_22.3.4.i
  %121 = xor i64 %_21.3.4.i, %76
  %_22.4.4.i = xor i64 %83, -1
  %_21.4.4.i = and i64 %89, %_22.4.4.i
  %122 = xor i64 %_21.4.4.i, %82
  %123 = add nuw nsw i64 %iter.sroa.0.019, 1
  %124 = getelementptr inbounds [24 x i64], [24 x i64]* bitcast (<{ [192 x i8] }>* @anon.ae87fea7d3f4a48b2c4e407fb0e59ffa.0 to [24 x i64]*), i64 0, i64 %iter.sroa.0.019
  %_3.i12 = load i64, i64* %124, align 8, !noundef !2
  %125 = xor i64 %_3.i12, %98
  %exitcond.not = icmp eq i64 %123, 24
  br i1 %exitcond.not, label %bb4, label %_ZN11rust_keccak6keccak4iota17hb795299ece32111cE.exit
}

; Function Attrs: nounwind nonlazybind
define void @keccak(i64* noundef %input_pointer) unnamed_addr #2 {
start:
  tail call void @_ZN11rust_keccak6keccak6keccak17h5798c7dfdadb5aa6E(i64* noundef %input_pointer) #3
  ret void
}

attributes #0 = { nonlazybind "target-cpu"="generic" }
attributes #1 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #2 = { nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
