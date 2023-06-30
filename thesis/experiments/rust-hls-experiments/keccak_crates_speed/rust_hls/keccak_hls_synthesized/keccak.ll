; ModuleID = '<stdin>'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::panic::location::Location<'_>" = type { { [0 x i8]*, i64 }, i32, i32 }

@alloc400 = hidden unnamed_addr constant <{ [65 x i8] }> <{ [65 x i8] c"A round_count greater than KECCAK_F_ROUND_COUNT is not supported!" }>, align 1
@alloc407 = hidden unnamed_addr constant <{ [85 x i8] }> <{ [85 x i8] c"/home/lennart/.cargo/registry/src/github.com-1ecc6299db9ec823/keccak-0.1.4/src/lib.rs" }>, align 1
@alloc395 = hidden unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [85 x i8] }>, <{ [85 x i8] }>* @alloc407, i32 0, i32 0, i32 0), [16 x i8] c"U\00\00\00\00\00\00\00\EB\00\00\00\09\00\00\00" }>, align 8
@alloc331 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8
@anon.81d2408192f774ffc0f511fc69066f5d.0 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #0

; Function Attrs: cold noinline noreturn nounwind nonlazybind
declare void @_ZN4core9panicking5panic17h2a2cd64c1c1612ffE([0 x i8]* noalias noundef nonnull readonly align 1, i64 noundef, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #1

; Function Attrs: nounwind nonlazybind
define hidden fastcc void @_ZN6keccak8keccak_p17h14c2b04945b850ecE([25 x i64]* noalias noundef align 8 dereferenceable(200) %state, i64 noundef %round_count) unnamed_addr #2 {
start:
  %_3 = icmp ugt i64 %round_count, 24
  br i1 %_3, label %bb1, label %"_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17hc31564b6d6ef0b16E.exit"

"_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17hc31564b6d6ef0b16E.exit": ; preds = %start
  %_8 = sub nuw nsw i64 24, %round_count
  %0 = getelementptr inbounds i64, i64* bitcast (<{ [192 x i8] }>* @alloc331 to i64*), i64 %_8
  %_10.i131 = icmp eq i64* %0, bitcast (i8* getelementptr inbounds (<{ [192 x i8] }>, <{ [192 x i8] }>* @alloc331, i64 1, i32 0, i64 0) to i64*)
  br i1 %_10.i131, label %bb8, label %bb6.lr.ph

bb6.lr.ph:                                        ; preds = %"_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17hc31564b6d6ef0b16E.exit"
  %1 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 0
  %2 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 5
  %3 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 10
  %4 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 15
  %5 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 20
  %6 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 1
  %7 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 6
  %8 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 11
  %9 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 16
  %10 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 21
  %11 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 2
  %12 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 7
  %13 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 12
  %14 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 17
  %15 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 22
  %16 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 3
  %17 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 8
  %18 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 13
  %19 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 18
  %20 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 23
  %21 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 4
  %22 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 9
  %23 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 14
  %24 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 19
  %25 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 24
  %.promoted = load i64, i64* %1, align 8
  %.promoted133 = load i64, i64* %2, align 8
  %.promoted135 = load i64, i64* %3, align 8
  %.promoted137 = load i64, i64* %4, align 8
  %.promoted139 = load i64, i64* %5, align 8
  %.promoted141 = load i64, i64* %6, align 8
  %.promoted143 = load i64, i64* %7, align 8
  %.promoted145 = load i64, i64* %8, align 8
  %.promoted147 = load i64, i64* %9, align 8
  %.promoted149 = load i64, i64* %10, align 8
  %.promoted151 = load i64, i64* %11, align 8
  %.promoted153 = load i64, i64* %12, align 8
  %.promoted155 = load i64, i64* %13, align 8
  %.promoted157 = load i64, i64* %14, align 8
  %.promoted159 = load i64, i64* %15, align 8
  %.promoted161 = load i64, i64* %16, align 8
  %.promoted163 = load i64, i64* %17, align 8
  %.promoted165 = load i64, i64* %18, align 8
  %.promoted167 = load i64, i64* %19, align 8
  %.promoted169 = load i64, i64* %20, align 8
  %.promoted171 = load i64, i64* %21, align 8
  %.promoted173 = load i64, i64* %22, align 8
  %.promoted175 = load i64, i64* %23, align 8
  %.promoted177 = load i64, i64* %24, align 8
  %.promoted179 = load i64, i64* %25, align 8
  br label %bb6

bb1:                                              ; preds = %start
  tail call void @_ZN4core9panicking5panic17h2a2cd64c1c1612ffE([0 x i8]* noalias noundef nonnull readonly align 1 bitcast (<{ [65 x i8] }>* @alloc400 to [0 x i8]*), i64 noundef 65, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc395 to %"core::panic::location::Location<'_>"*)) #4
  unreachable

bb4.bb8_crit_edge:                                ; preds = %bb6
  store i64 %206, i64* %1, align 8
  store i64 %148, i64* %2, align 8
  store i64 %163, i64* %3, align 8
  store i64 %178, i64* %4, align 8
  store i64 %193, i64* %5, align 8
  store i64 %136, i64* %6, align 8
  store i64 %151, i64* %7, align 8
  store i64 %166, i64* %8, align 8
  store i64 %181, i64* %9, align 8
  store i64 %196, i64* %10, align 8
  store i64 %139, i64* %11, align 8
  store i64 %154, i64* %12, align 8
  store i64 %169, i64* %13, align 8
  store i64 %184, i64* %14, align 8
  store i64 %199, i64* %15, align 8
  store i64 %142, i64* %16, align 8
  store i64 %157, i64* %17, align 8
  store i64 %172, i64* %18, align 8
  store i64 %187, i64* %19, align 8
  store i64 %202, i64* %20, align 8
  store i64 %145, i64* %21, align 8
  store i64 %160, i64* %22, align 8
  store i64 %175, i64* %23, align 8
  store i64 %190, i64* %24, align 8
  store i64 %205, i64* %25, align 8
  br label %bb8

bb8:                                              ; preds = %bb4.bb8_crit_edge, %"_ZN106_$LT$core..ops..range..Range$LT$usize$GT$$u20$as$u20$core..slice..index..SliceIndex$LT$$u5b$T$u5d$$GT$$GT$5index17hc31564b6d6ef0b16E.exit"
  ret void

bb6:                                              ; preds = %bb6, %bb6.lr.ph
  %26 = phi i64 [ %.promoted179, %bb6.lr.ph ], [ %205, %bb6 ]
  %27 = phi i64 [ %.promoted177, %bb6.lr.ph ], [ %190, %bb6 ]
  %28 = phi i64 [ %.promoted175, %bb6.lr.ph ], [ %175, %bb6 ]
  %29 = phi i64 [ %.promoted173, %bb6.lr.ph ], [ %160, %bb6 ]
  %30 = phi i64 [ %.promoted171, %bb6.lr.ph ], [ %145, %bb6 ]
  %31 = phi i64 [ %.promoted169, %bb6.lr.ph ], [ %202, %bb6 ]
  %32 = phi i64 [ %.promoted167, %bb6.lr.ph ], [ %187, %bb6 ]
  %33 = phi i64 [ %.promoted165, %bb6.lr.ph ], [ %172, %bb6 ]
  %34 = phi i64 [ %.promoted163, %bb6.lr.ph ], [ %157, %bb6 ]
  %35 = phi i64 [ %.promoted161, %bb6.lr.ph ], [ %142, %bb6 ]
  %36 = phi i64 [ %.promoted159, %bb6.lr.ph ], [ %199, %bb6 ]
  %37 = phi i64 [ %.promoted157, %bb6.lr.ph ], [ %184, %bb6 ]
  %38 = phi i64 [ %.promoted155, %bb6.lr.ph ], [ %169, %bb6 ]
  %39 = phi i64 [ %.promoted153, %bb6.lr.ph ], [ %154, %bb6 ]
  %40 = phi i64 [ %.promoted151, %bb6.lr.ph ], [ %139, %bb6 ]
  %41 = phi i64 [ %.promoted149, %bb6.lr.ph ], [ %196, %bb6 ]
  %42 = phi i64 [ %.promoted147, %bb6.lr.ph ], [ %181, %bb6 ]
  %43 = phi i64 [ %.promoted145, %bb6.lr.ph ], [ %166, %bb6 ]
  %44 = phi i64 [ %.promoted143, %bb6.lr.ph ], [ %151, %bb6 ]
  %45 = phi i64 [ %.promoted141, %bb6.lr.ph ], [ %136, %bb6 ]
  %46 = phi i64 [ %.promoted139, %bb6.lr.ph ], [ %193, %bb6 ]
  %47 = phi i64 [ %.promoted137, %bb6.lr.ph ], [ %178, %bb6 ]
  %48 = phi i64 [ %.promoted135, %bb6.lr.ph ], [ %163, %bb6 ]
  %49 = phi i64 [ %.promoted133, %bb6.lr.ph ], [ %148, %bb6 ]
  %50 = phi i64 [ %.promoted, %bb6.lr.ph ], [ %206, %bb6 ]
  %iter.sroa.4.0132 = phi i64* [ %0, %bb6.lr.ph ], [ %51, %bb6 ]
  %rc = load i64, i64* %iter.sroa.4.0132, align 8, !noundef !2
  %51 = getelementptr inbounds i64, i64* %iter.sroa.4.0132, i64 1
  %52 = xor i64 %49, %50
  %53 = xor i64 %48, %52
  %54 = xor i64 %47, %53
  %55 = xor i64 %46, %54
  %56 = xor i64 %44, %45
  %57 = xor i64 %43, %56
  %58 = xor i64 %42, %57
  %59 = xor i64 %41, %58
  %60 = xor i64 %39, %40
  %61 = xor i64 %38, %60
  %62 = xor i64 %37, %61
  %63 = xor i64 %36, %62
  %64 = xor i64 %34, %35
  %65 = xor i64 %33, %64
  %66 = xor i64 %32, %65
  %67 = xor i64 %31, %66
  %68 = xor i64 %29, %30
  %69 = xor i64 %28, %68
  %70 = xor i64 %27, %69
  %71 = xor i64 %26, %70
  %72 = tail call i64 @llvm.fshl.i64(i64 %59, i64 %59, i64 1)
  %73 = xor i64 %71, %72
  %74 = xor i64 %73, %50
  %75 = xor i64 %73, %49
  %76 = xor i64 %73, %48
  %77 = xor i64 %73, %47
  %78 = xor i64 %73, %46
  %79 = tail call i64 @llvm.fshl.i64(i64 %63, i64 %63, i64 1)
  %80 = xor i64 %79, %55
  %81 = xor i64 %80, %45
  %82 = xor i64 %80, %44
  %83 = xor i64 %80, %43
  %84 = xor i64 %80, %42
  %85 = xor i64 %80, %41
  %86 = tail call i64 @llvm.fshl.i64(i64 %67, i64 %67, i64 1)
  %87 = xor i64 %86, %59
  %88 = xor i64 %87, %40
  %89 = xor i64 %87, %39
  %90 = xor i64 %87, %38
  %91 = xor i64 %87, %37
  %92 = xor i64 %87, %36
  %93 = tail call i64 @llvm.fshl.i64(i64 %71, i64 %71, i64 1)
  %94 = xor i64 %93, %63
  %95 = xor i64 %94, %35
  %96 = xor i64 %94, %34
  %97 = xor i64 %94, %33
  %98 = xor i64 %94, %32
  %99 = xor i64 %94, %31
  %100 = tail call i64 @llvm.fshl.i64(i64 %55, i64 %55, i64 1)
  %101 = xor i64 %67, %100
  %102 = xor i64 %30, %101
  %103 = xor i64 %29, %101
  %104 = xor i64 %28, %101
  %105 = xor i64 %27, %101
  %106 = xor i64 %26, %101
  %107 = tail call i64 @llvm.fshl.i64(i64 %81, i64 %81, i64 1)
  %108 = tail call i64 @llvm.fshl.i64(i64 %76, i64 %76, i64 3)
  %109 = tail call i64 @llvm.fshl.i64(i64 %89, i64 %89, i64 6)
  %110 = tail call i64 @llvm.fshl.i64(i64 %83, i64 %83, i64 10)
  %111 = tail call i64 @llvm.fshl.i64(i64 %91, i64 %91, i64 15)
  %112 = tail call i64 @llvm.fshl.i64(i64 %98, i64 %98, i64 21)
  %113 = tail call i64 @llvm.fshl.i64(i64 %95, i64 %95, i64 28)
  %114 = tail call i64 @llvm.fshl.i64(i64 %75, i64 %75, i64 36)
  %115 = tail call i64 @llvm.fshl.i64(i64 %84, i64 %84, i64 45)
  %116 = tail call i64 @llvm.fshl.i64(i64 %96, i64 %96, i64 55)
  %117 = tail call i64 @llvm.fshl.i64(i64 %85, i64 %85, i64 2)
  %118 = tail call i64 @llvm.fshl.i64(i64 %106, i64 %106, i64 14)
  %119 = tail call i64 @llvm.fshl.i64(i64 %102, i64 %102, i64 27)
  %120 = tail call i64 @llvm.fshl.i64(i64 %77, i64 %77, i64 41)
  %121 = tail call i64 @llvm.fshl.i64(i64 %99, i64 %99, i64 56)
  %122 = tail call i64 @llvm.fshl.i64(i64 %105, i64 %105, i64 8)
  %123 = tail call i64 @llvm.fshl.i64(i64 %97, i64 %97, i64 25)
  %124 = tail call i64 @llvm.fshl.i64(i64 %90, i64 %90, i64 43)
  %125 = tail call i64 @llvm.fshl.i64(i64 %88, i64 %88, i64 62)
  %126 = tail call i64 @llvm.fshl.i64(i64 %78, i64 %78, i64 18)
  %127 = tail call i64 @llvm.fshl.i64(i64 %104, i64 %104, i64 39)
  %128 = tail call i64 @llvm.fshl.i64(i64 %92, i64 %92, i64 61)
  %129 = tail call i64 @llvm.fshl.i64(i64 %103, i64 %103, i64 20)
  %130 = tail call i64 @llvm.fshl.i64(i64 %82, i64 %82, i64 44)
  %131 = xor i64 %130, -1
  %132 = and i64 %124, %131
  %133 = xor i64 %74, %132
  %134 = xor i64 %124, -1
  %135 = and i64 %112, %134
  %136 = xor i64 %135, %130
  %137 = xor i64 %112, -1
  %138 = and i64 %118, %137
  %139 = xor i64 %138, %124
  %140 = xor i64 %118, -1
  %141 = and i64 %74, %140
  %142 = xor i64 %112, %141
  %143 = xor i64 %74, -1
  %144 = and i64 %130, %143
  %145 = xor i64 %144, %118
  %146 = xor i64 %129, -1
  %147 = and i64 %108, %146
  %148 = xor i64 %147, %113
  %149 = xor i64 %108, -1
  %150 = and i64 %115, %149
  %151 = xor i64 %150, %129
  %152 = xor i64 %115, -1
  %153 = and i64 %128, %152
  %154 = xor i64 %108, %153
  %155 = xor i64 %128, -1
  %156 = and i64 %113, %155
  %157 = xor i64 %156, %115
  %158 = xor i64 %113, -1
  %159 = and i64 %129, %158
  %160 = xor i64 %159, %128
  %161 = xor i64 %109, -1
  %162 = and i64 %123, %161
  %163 = xor i64 %162, %107
  %164 = xor i64 %123, -1
  %165 = and i64 %122, %164
  %166 = xor i64 %165, %109
  %167 = xor i64 %122, -1
  %168 = and i64 %126, %167
  %169 = xor i64 %168, %123
  %170 = xor i64 %126, -1
  %171 = and i64 %107, %170
  %172 = xor i64 %171, %122
  %173 = xor i64 %107, -1
  %174 = and i64 %109, %173
  %175 = xor i64 %126, %174
  %176 = xor i64 %114, -1
  %177 = and i64 %110, %176
  %178 = xor i64 %177, %119
  %179 = xor i64 %110, -1
  %180 = and i64 %111, %179
  %181 = xor i64 %114, %180
  %182 = xor i64 %111, -1
  %183 = and i64 %121, %182
  %184 = xor i64 %183, %110
  %185 = xor i64 %121, -1
  %186 = and i64 %119, %185
  %187 = xor i64 %186, %111
  %188 = xor i64 %119, -1
  %189 = and i64 %114, %188
  %190 = xor i64 %189, %121
  %191 = xor i64 %116, -1
  %192 = and i64 %127, %191
  %193 = xor i64 %192, %125
  %194 = xor i64 %127, -1
  %195 = and i64 %120, %194
  %196 = xor i64 %195, %116
  %197 = xor i64 %120, -1
  %198 = and i64 %117, %197
  %199 = xor i64 %198, %127
  %200 = xor i64 %117, -1
  %201 = and i64 %125, %200
  %202 = xor i64 %120, %201
  %203 = xor i64 %125, -1
  %204 = and i64 %116, %203
  %205 = xor i64 %204, %117
  %206 = xor i64 %133, %rc
  %_10.i = icmp eq i64* %51, bitcast (i8* getelementptr inbounds (<{ [192 x i8] }>, <{ [192 x i8] }>* @alloc331, i64 1, i32 0, i64 0) to i64*)
  br i1 %_10.i, label %bb4.bb8_crit_edge, label %bb6
}

; Function Attrs: nounwind nonlazybind
define void @_ZN6keccak5f160017hff8c436371c4a92dE([25 x i64]* noalias noundef align 8 dereferenceable(200) %state) unnamed_addr #2 {
start:
  tail call fastcc void @_ZN6keccak8keccak_p17h14c2b04945b850ecE([25 x i64]* noalias noundef nonnull align 8 dereferenceable(200) %state, i64 noundef 24) #5
  ret void
}

; Function Attrs: nounwind nonlazybind
define void @keccak_crate(i64* noundef %input) unnamed_addr #2 {
start:
  %0 = bitcast i64* %input to [25 x i64]*
  %1 = icmp ne i64* %input, null
  tail call void @llvm.assume(i1 %1)
  tail call void @_ZN6keccak5f160017hff8c436371c4a92dE([25 x i64]* noalias noundef nonnull align 8 dereferenceable(200) %0) #5
  ret void
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #3

; Function Attrs: nounwind nonlazybind
define void @keccak(i64* noundef %input_pointer) unnamed_addr #2 {
start:
  tail call void @keccak_crate(i64* noundef %input_pointer) #5
  ret void
}

attributes #0 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #1 = { cold noinline noreturn nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #2 = { nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #3 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #4 = { noreturn nounwind }
attributes #5 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
