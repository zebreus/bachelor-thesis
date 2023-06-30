; ModuleID = '<stdin>'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"core::panic::location::Location<'_>" = type { { [0 x i8]*, i64 }, i32, i32 }

@alloc400 = hidden unnamed_addr constant <{ [65 x i8] }> <{ [65 x i8] c"A round_count greater than KECCAK_F_ROUND_COUNT is not supported!" }>, align 1
@alloc407 = hidden unnamed_addr constant <{ [85 x i8] }> <{ [85 x i8] c"/home/lennart/.cargo/registry/src/github.com-1ecc6299db9ec823/keccak-0.1.4/src/lib.rs" }>, align 1
@alloc395 = hidden unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [85 x i8] }>, <{ [85 x i8] }>* @alloc407, i32 0, i32 0, i32 0), [16 x i8] c"U\00\00\00\00\00\00\00\EB\00\00\00\09\00\00\00" }>, align 8
@alloc331 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8
@alloc397 = hidden unnamed_addr constant <{ i8*, [16 x i8] }> <{ i8* getelementptr inbounds (<{ [85 x i8] }>, <{ [85 x i8] }>* @alloc407, i32 0, i32 0, i32 0), [16 x i8] c"U\00\00\00\00\00\00\00\F0\00\00\00\19\00\00\00" }>, align 8
@anon.81d2408192f774ffc0f511fc69066f5d.0 = hidden unnamed_addr constant <{ [25 x i8] }> <{ [25 x i8] c"\00\01>\1C\1B$,\067\14\03\0A+\19')-\0F\15\08\12\02=8\0E" }>, align 1
@anon.81d2408192f774ffc0f511fc69066f5d.1 = hidden unnamed_addr constant <{ [192 x i8] }> <{ [192 x i8] c"\01\00\00\00\00\00\00\00\82\80\00\00\00\00\00\00\8A\80\00\00\00\00\00\80\00\80\00\80\00\00\00\80\8B\80\00\00\00\00\00\00\01\00\00\80\00\00\00\00\81\80\00\80\00\00\00\80\09\80\00\00\00\00\00\80\8A\00\00\00\00\00\00\00\88\00\00\00\00\00\00\00\09\80\00\80\00\00\00\00\0A\00\00\80\00\00\00\00\8B\80\00\80\00\00\00\00\8B\00\00\00\00\00\00\80\89\80\00\00\00\00\00\80\03\80\00\00\00\00\00\80\02\80\00\00\00\00\00\80\80\00\00\00\00\00\00\80\0A\80\00\00\00\00\00\00\0A\00\00\80\00\00\00\80\81\80\00\80\00\00\00\80\80\80\00\00\00\00\00\80\01\00\00\80\00\00\00\00\08\80\00\80\00\00\00\80" }>, align 8

; Function Attrs: minsize nounwind nonlazybind optsize
define void @_ZN6keccak8keccak_p17h14c2b04945b850ecE([25 x i64]* noalias noundef align 8 dereferenceable(200) %state, i64 noundef %round_count) unnamed_addr #0 {
start:
  %array = alloca [5 x i64], align 8
  %_3 = icmp ugt i64 %round_count, 24
  br i1 %_3, label %bb1, label %bb2

bb2:                                              ; preds = %start
  %_8 = sub nuw nsw i64 24, %round_count
  %0 = tail call fastcc { [0 x i64]*, i64 } @"_ZN4core5array85_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$5index17h3c4ec54dcecc78d7E"(i64 noundef %_8, i64 noundef 24) #6
  %_6.0 = extractvalue { [0 x i64]*, i64 } %0, 0
  %_6.1 = extractvalue { [0 x i64]*, i64 } %0, 1
  %ptr.i.i = getelementptr [0 x i64], [0 x i64]* %_6.0, i64 0, i64 0
  %1 = getelementptr inbounds [0 x i64], [0 x i64]* %_6.0, i64 0, i64 %_6.1
  %2 = icmp ne [0 x i64]* %_6.0, null
  tail call void @llvm.assume(i1 %2)
  %3 = bitcast [5 x i64]* %array to i8*
  %4 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 0
  %5 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 5
  %6 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 0
  %7 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 5
  %8 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 10
  %9 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 15
  %10 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 20
  %_43 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 1
  %11 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 1
  %12 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 6
  %13 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 11
  %14 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 16
  %15 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 21
  %_68 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 2
  %16 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 2
  %17 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 7
  %18 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 12
  %19 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 17
  %20 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 22
  %_93 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 3
  %21 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 3
  %22 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 8
  %23 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 13
  %24 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 18
  %25 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 23
  %_118 = getelementptr inbounds [5 x i64], [5 x i64]* %array, i64 0, i64 4
  %26 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 4
  %27 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 9
  %28 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 14
  %29 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 19
  %30 = getelementptr inbounds [25 x i64], [25 x i64]* %state, i64 0, i64 24
  br label %bb5

bb1:                                              ; preds = %start
  tail call void @_ZN4core9panicking5panic17h2a2cd64c1c1612ffE([0 x i8]* noalias noundef nonnull readonly align 1 bitcast (<{ [65 x i8] }>* @alloc400 to [0 x i8]*), i64 noundef 65, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc395 to %"core::panic::location::Location<'_>"*)) #7
  unreachable

bb5:                                              ; preds = %repeat_loop_next, %bb2
  %iter.sroa.4.0 = phi i64* [ %ptr.i.i, %bb2 ], [ %34, %repeat_loop_next ]
  %31 = icmp ne i64* %iter.sroa.4.0, null
  call void @llvm.assume(i1 %31)
  %_10.i = icmp eq i64* %iter.sroa.4.0, %1
  br i1 %_10.i, label %bb9, label %bb7

bb9:                                              ; preds = %bb5
  ret void

bb7:                                              ; preds = %bb5
  %rc = load i64, i64* %iter.sroa.4.0, align 8, !noundef !2
  call void @llvm.lifetime.start.p0i8(i64 40, i8* nonnull %3)
  br label %repeat_loop_header

repeat_loop_header:                               ; preds = %repeat_loop_body, %bb7
  %32 = phi i64* [ %4, %bb7 ], [ %33, %repeat_loop_body ]
  %.not = icmp eq i64* %32, %5
  br i1 %.not, label %repeat_loop_next, label %repeat_loop_body

repeat_loop_body:                                 ; preds = %repeat_loop_header
  store i64 0, i64* %32, align 8
  %33 = getelementptr inbounds i64, i64* %32, i64 1
  br label %repeat_loop_header

repeat_loop_next:                                 ; preds = %repeat_loop_header
  %34 = getelementptr inbounds i64, i64* %iter.sroa.4.0, i64 1
  %_20 = load i64, i64* %6, align 8, !noundef !2
  %35 = load i64, i64* %4, align 8, !alias.scope !3, !noundef !2
  %36 = xor i64 %35, %_20
  %_25 = load i64, i64* %7, align 8, !noundef !2
  %37 = xor i64 %_25, %36
  %_30 = load i64, i64* %8, align 8, !noundef !2
  %38 = xor i64 %_30, %37
  %_35 = load i64, i64* %9, align 8, !noundef !2
  %39 = xor i64 %_35, %38
  %_40 = load i64, i64* %10, align 8, !noundef !2
  %40 = xor i64 %_40, %39
  %_45 = load i64, i64* %11, align 8, !noundef !2
  %41 = load i64, i64* %_43, align 8, !alias.scope !6, !noundef !2
  %42 = xor i64 %41, %_45
  %_50 = load i64, i64* %12, align 8, !noundef !2
  %43 = xor i64 %_50, %42
  %_55 = load i64, i64* %13, align 8, !noundef !2
  %44 = xor i64 %_55, %43
  %_60 = load i64, i64* %14, align 8, !noundef !2
  %45 = xor i64 %_60, %44
  %_65 = load i64, i64* %15, align 8, !noundef !2
  %46 = xor i64 %_65, %45
  %_70 = load i64, i64* %16, align 8, !noundef !2
  %47 = load i64, i64* %_68, align 8, !alias.scope !9, !noundef !2
  %48 = xor i64 %47, %_70
  %_75 = load i64, i64* %17, align 8, !noundef !2
  %49 = xor i64 %_75, %48
  %_80 = load i64, i64* %18, align 8, !noundef !2
  %50 = xor i64 %_80, %49
  %_85 = load i64, i64* %19, align 8, !noundef !2
  %51 = xor i64 %_85, %50
  %_90 = load i64, i64* %20, align 8, !noundef !2
  %52 = xor i64 %_90, %51
  %_95 = load i64, i64* %21, align 8, !noundef !2
  %53 = load i64, i64* %_93, align 8, !alias.scope !12, !noundef !2
  %54 = xor i64 %53, %_95
  %_100 = load i64, i64* %22, align 8, !noundef !2
  %55 = xor i64 %_100, %54
  %_105 = load i64, i64* %23, align 8, !noundef !2
  %56 = xor i64 %_105, %55
  %_110 = load i64, i64* %24, align 8, !noundef !2
  %57 = xor i64 %_110, %56
  %_115 = load i64, i64* %25, align 8, !noundef !2
  %58 = xor i64 %_115, %57
  %_120 = load i64, i64* %26, align 8, !noundef !2
  %59 = load i64, i64* %_118, align 8, !alias.scope !15, !noundef !2
  %60 = xor i64 %59, %_120
  %_125 = load i64, i64* %27, align 8, !noundef !2
  %61 = xor i64 %_125, %60
  %_130 = load i64, i64* %28, align 8, !noundef !2
  %62 = xor i64 %_130, %61
  %_135 = load i64, i64* %29, align 8, !noundef !2
  %63 = xor i64 %_135, %62
  %_140 = load i64, i64* %30, align 8, !noundef !2
  %64 = xor i64 %_140, %63
  %65 = call i64 @llvm.fshl.i64(i64 %46, i64 %46, i64 1)
  %66 = xor i64 %64, %65
  %67 = xor i64 %66, %_20
  %68 = xor i64 %66, %_25
  %69 = xor i64 %66, %_30
  %70 = xor i64 %66, %_35
  %71 = xor i64 %66, %_40
  %72 = call i64 @llvm.fshl.i64(i64 %52, i64 %52, i64 1)
  %73 = xor i64 %72, %40
  %74 = xor i64 %73, %_45
  %75 = xor i64 %73, %_50
  %76 = xor i64 %73, %_55
  %77 = xor i64 %73, %_60
  %78 = xor i64 %73, %_65
  %79 = call i64 @llvm.fshl.i64(i64 %58, i64 %58, i64 1)
  %80 = xor i64 %79, %46
  %81 = xor i64 %80, %_70
  %82 = xor i64 %80, %_75
  %83 = xor i64 %80, %_80
  %84 = xor i64 %80, %_85
  %85 = xor i64 %80, %_90
  %86 = call i64 @llvm.fshl.i64(i64 %64, i64 %64, i64 1)
  %87 = xor i64 %86, %52
  %88 = xor i64 %87, %_95
  %89 = xor i64 %87, %_100
  %90 = xor i64 %87, %_105
  %91 = xor i64 %87, %_110
  %92 = xor i64 %87, %_115
  %93 = call i64 @llvm.fshl.i64(i64 %40, i64 %40, i64 1)
  %94 = xor i64 %58, %93
  %95 = xor i64 %_120, %94
  %96 = xor i64 %_125, %94
  %97 = xor i64 %_130, %94
  %98 = xor i64 %_135, %94
  %99 = xor i64 %_140, %94
  %100 = call i64 @llvm.fshl.i64(i64 %74, i64 %74, i64 1)
  %101 = call i64 @llvm.fshl.i64(i64 %69, i64 %69, i64 3)
  %102 = call i64 @llvm.fshl.i64(i64 %82, i64 %82, i64 6)
  %103 = call i64 @llvm.fshl.i64(i64 %76, i64 %76, i64 10)
  %104 = call i64 @llvm.fshl.i64(i64 %84, i64 %84, i64 15)
  %105 = call i64 @llvm.fshl.i64(i64 %91, i64 %91, i64 21)
  %106 = call i64 @llvm.fshl.i64(i64 %88, i64 %88, i64 28)
  %107 = call i64 @llvm.fshl.i64(i64 %68, i64 %68, i64 36)
  %108 = call i64 @llvm.fshl.i64(i64 %77, i64 %77, i64 45)
  %109 = call i64 @llvm.fshl.i64(i64 %89, i64 %89, i64 55)
  %110 = call i64 @llvm.fshl.i64(i64 %78, i64 %78, i64 2)
  %111 = call i64 @llvm.fshl.i64(i64 %99, i64 %99, i64 14)
  %112 = call i64 @llvm.fshl.i64(i64 %95, i64 %95, i64 27)
  %113 = call i64 @llvm.fshl.i64(i64 %70, i64 %70, i64 41)
  %114 = call i64 @llvm.fshl.i64(i64 %92, i64 %92, i64 56)
  %115 = call i64 @llvm.fshl.i64(i64 %98, i64 %98, i64 8)
  %116 = call i64 @llvm.fshl.i64(i64 %90, i64 %90, i64 25)
  %117 = call i64 @llvm.fshl.i64(i64 %83, i64 %83, i64 43)
  %118 = call i64 @llvm.fshl.i64(i64 %81, i64 %81, i64 62)
  %119 = call i64 @llvm.fshl.i64(i64 %71, i64 %71, i64 18)
  %120 = call i64 @llvm.fshl.i64(i64 %97, i64 %97, i64 39)
  %121 = call i64 @llvm.fshl.i64(i64 %85, i64 %85, i64 61)
  %122 = call i64 @llvm.fshl.i64(i64 %96, i64 %96, i64 20)
  %123 = call i64 @llvm.fshl.i64(i64 %75, i64 %75, i64 44)
  %124 = xor i64 %123, -1
  %125 = and i64 %117, %124
  %126 = xor i64 %67, %125
  %127 = xor i64 %117, -1
  %128 = and i64 %105, %127
  %129 = xor i64 %128, %123
  store i64 %129, i64* %11, align 8
  %130 = xor i64 %105, -1
  %131 = and i64 %111, %130
  %132 = xor i64 %131, %117
  store i64 %132, i64* %16, align 8
  %133 = xor i64 %111, -1
  %134 = and i64 %67, %133
  %135 = xor i64 %105, %134
  store i64 %135, i64* %21, align 8
  %136 = xor i64 %67, -1
  %137 = and i64 %123, %136
  %138 = xor i64 %137, %111
  store i64 %138, i64* %26, align 8
  %139 = xor i64 %122, -1
  %140 = and i64 %101, %139
  %141 = xor i64 %140, %106
  store i64 %141, i64* %7, align 8
  %142 = xor i64 %101, -1
  %143 = and i64 %108, %142
  %144 = xor i64 %143, %122
  store i64 %144, i64* %12, align 8
  %145 = xor i64 %108, -1
  %146 = and i64 %121, %145
  %147 = xor i64 %101, %146
  store i64 %147, i64* %17, align 8
  %148 = xor i64 %121, -1
  %149 = and i64 %106, %148
  %150 = xor i64 %149, %108
  store i64 %150, i64* %22, align 8
  %151 = xor i64 %106, -1
  %152 = and i64 %122, %151
  %153 = xor i64 %152, %121
  store i64 %153, i64* %27, align 8
  %154 = xor i64 %102, -1
  %155 = and i64 %116, %154
  %156 = xor i64 %155, %100
  store i64 %156, i64* %8, align 8
  %157 = xor i64 %116, -1
  %158 = and i64 %115, %157
  %159 = xor i64 %158, %102
  store i64 %159, i64* %13, align 8
  %160 = xor i64 %115, -1
  %161 = and i64 %119, %160
  %162 = xor i64 %161, %116
  store i64 %162, i64* %18, align 8
  %163 = xor i64 %119, -1
  %164 = and i64 %100, %163
  %165 = xor i64 %164, %115
  store i64 %165, i64* %23, align 8
  %166 = xor i64 %100, -1
  %167 = and i64 %102, %166
  %168 = xor i64 %119, %167
  store i64 %168, i64* %28, align 8
  %169 = xor i64 %107, -1
  %170 = and i64 %103, %169
  %171 = xor i64 %170, %112
  store i64 %171, i64* %9, align 8
  %172 = xor i64 %103, -1
  %173 = and i64 %104, %172
  %174 = xor i64 %107, %173
  store i64 %174, i64* %14, align 8
  %175 = xor i64 %104, -1
  %176 = and i64 %114, %175
  %177 = xor i64 %176, %103
  store i64 %177, i64* %19, align 8
  %178 = xor i64 %114, -1
  %179 = and i64 %112, %178
  %180 = xor i64 %179, %104
  store i64 %180, i64* %24, align 8
  %181 = xor i64 %112, -1
  %182 = and i64 %107, %181
  %183 = xor i64 %182, %114
  store i64 %183, i64* %29, align 8
  %184 = xor i64 %109, -1
  %185 = and i64 %120, %184
  %186 = xor i64 %185, %118
  store i64 %186, i64* %10, align 8
  %187 = xor i64 %120, -1
  %188 = and i64 %113, %187
  %189 = xor i64 %188, %109
  store i64 %189, i64* %15, align 8
  %190 = xor i64 %113, -1
  %191 = and i64 %110, %190
  %192 = xor i64 %191, %120
  store i64 %192, i64* %20, align 8
  %193 = xor i64 %110, -1
  %194 = and i64 %118, %193
  %195 = xor i64 %113, %194
  store i64 %195, i64* %25, align 8
  %196 = xor i64 %118, -1
  %197 = and i64 %109, %196
  %198 = xor i64 %197, %110
  store i64 %198, i64* %30, align 8
  %199 = xor i64 %126, %rc
  store i64 %199, i64* %6, align 8, !alias.scope !18
  call void @llvm.lifetime.end.p0i8(i64 40, i8* nonnull %3)
  br label %bb5
}

; Function Attrs: inlinehint minsize nounwind nonlazybind optsize
define hidden fastcc { [0 x i64]*, i64 } @"_ZN4core5array85_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u3b$$u20$N$u5d$$GT$5index17h3c4ec54dcecc78d7E"(i64 noundef %index.0, i64 noundef %index.1) unnamed_addr #1 {
start:
  %_3.i.i = icmp ult i64 %index.1, %index.0
  br i1 %_3.i.i, label %bb1.i.i, label %"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h4d86e1f67b03df9aE.exit"

bb1.i.i:                                          ; preds = %start
  tail call void @_ZN4core5slice5index22slice_index_order_fail17h21be7899c602c21aE(i64 noundef %index.0, i64 noundef %index.1, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24) bitcast (<{ i8*, [16 x i8] }>* @alloc397 to %"core::panic::location::Location<'_>"*)) #7
  unreachable

"_ZN4core5slice5index74_$LT$impl$u20$core..ops..index..Index$LT$I$GT$$u20$for$u20$$u5b$T$u5d$$GT$5index17h4d86e1f67b03df9aE.exit": ; preds = %start
  %0 = getelementptr inbounds i64, i64* bitcast (<{ [192 x i8] }>* @alloc331 to i64*), i64 %index.0
  %len.i.i = sub i64 %index.1, %index.0
  %1 = bitcast i64* %0 to [0 x i64]*
  %2 = insertvalue { [0 x i64]*, i64 } undef, [0 x i64]* %1, 0
  %3 = insertvalue { [0 x i64]*, i64 } %2, i64 %len.i.i, 1
  ret { [0 x i64]*, i64 } %3
}

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite)
declare void @llvm.assume(i1 noundef) #2

; Function Attrs: cold minsize noinline noreturn nounwind nonlazybind optsize
declare void @_ZN4core9panicking5panic17h2a2cd64c1c1612ffE([0 x i8]* noalias noundef nonnull readonly align 1, i64 noundef, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #3

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.start.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i64 @llvm.fshl.i64(i64, i64, i64) #5

; Function Attrs: nocallback nofree nosync nounwind willreturn memory(argmem: readwrite)
declare void @llvm.lifetime.end.p0i8(i64 immarg, i8* nocapture) #4

; Function Attrs: cold minsize noinline noreturn nounwind nonlazybind optsize
declare void @_ZN4core5slice5index22slice_index_order_fail17h21be7899c602c21aE(i64 noundef, i64 noundef, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24)) unnamed_addr #3

; Function Attrs: minsize nounwind nonlazybind optsize
define void @_ZN6keccak5f160017hff8c436371c4a92dE([25 x i64]* noalias noundef align 8 dereferenceable(200) %state) unnamed_addr #0 {
start:
  tail call void @_ZN6keccak8keccak_p17h14c2b04945b850ecE([25 x i64]* noalias noundef nonnull align 8 dereferenceable(200) %state, i64 noundef 24) #6
  ret void
}

; Function Attrs: minsize nounwind nonlazybind optsize
define void @keccak_crate(i64* noundef %input) unnamed_addr #0 {
start:
  %0 = bitcast i64* %input to [25 x i64]*
  %1 = icmp ne i64* %input, null
  tail call void @llvm.assume(i1 %1)
  tail call void @_ZN6keccak5f160017hff8c436371c4a92dE([25 x i64]* noalias noundef nonnull align 8 dereferenceable(200) %0) #6
  ret void
}

; Function Attrs: minsize nounwind nonlazybind optsize
define void @keccak(i64* noundef %input_pointer) unnamed_addr #0 {
start:
  tail call void @keccak_crate(i64* noundef %input_pointer) #6
  ret void
}

attributes #0 = { minsize nounwind nonlazybind optsize "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #1 = { inlinehint minsize nounwind nonlazybind optsize "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind willreturn memory(inaccessiblemem: readwrite) }
attributes #3 = { cold minsize noinline noreturn nounwind nonlazybind optsize "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #4 = { nocallback nofree nosync nounwind willreturn memory(argmem: readwrite) }
attributes #5 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #6 = { nounwind }
attributes #7 = { noreturn nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
!3 = !{!4}
!4 = distinct !{!4, !5, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!5 = distinct !{!5, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
!6 = !{!7}
!7 = distinct !{!7, !8, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!8 = distinct !{!8, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
!9 = !{!10}
!10 = distinct !{!10, !11, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!11 = distinct !{!11, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
!12 = !{!13}
!13 = distinct !{!13, !14, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!14 = distinct !{!14, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
!15 = !{!16}
!16 = distinct !{!16, !17, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!17 = distinct !{!17, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
!18 = !{!19}
!19 = distinct !{!19, !20, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE: %self"}
!20 = distinct !{!20, !"_ZN52_$LT$u64$u20$as$u20$core..ops..bit..BitXorAssign$GT$13bitxor_assign17h91592bede9d717adE"}
