; ModuleID = 'src/switch_big_cpp.cpp'
source_filename = "src/switch_big_cpp.cpp"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@switch.table.switch_big_cpp = private unnamed_addr constant [4 x i64] [i64 0, i64 131072, i64 0, i64 0], align 8
@switch.table.switch_big_cpp.1 = private unnamed_addr constant [4 x i64] [i64 0, i64 0, i64 17179869184, i64 0], align 8
@switch.table.switch_big_cpp.2 = private unnamed_addr constant [4 x i64] [i64 0, i64 0, i64 0, i64 2251799813685248], align 8
@switch.table.switch_big_cpp.3 = private unnamed_addr constant [4 x i64] [i64 1, i64 0, i64 0, i64 0], align 8

; Function Attrs: norecurse nounwind readnone sspstrong uwtable
define i64 @switch_big_cpp(i32 %0) local_unnamed_addr #0 {
  %2 = icmp ult i32 %0, 4
  br i1 %2, label %3, label %16

3:                                                ; preds = %1
  %4 = sext i32 %0 to i64
  %5 = getelementptr inbounds [4 x i64], [4 x i64]* @switch.table.switch_big_cpp, i64 0, i64 %4
  %6 = load i64, i64* %5, align 8
  %7 = sext i32 %0 to i64
  %8 = getelementptr inbounds [4 x i64], [4 x i64]* @switch.table.switch_big_cpp.1, i64 0, i64 %7
  %9 = load i64, i64* %8, align 8
  %10 = sext i32 %0 to i64
  %11 = getelementptr inbounds [4 x i64], [4 x i64]* @switch.table.switch_big_cpp.2, i64 0, i64 %10
  %12 = load i64, i64* %11, align 8
  %13 = sext i32 %0 to i64
  %14 = getelementptr inbounds [4 x i64], [4 x i64]* @switch.table.switch_big_cpp.3, i64 0, i64 %13
  %15 = load i64, i64* %14, align 8
  br label %16

16:                                               ; preds = %3, %1
  %17 = phi i64 [ 0, %1 ], [ %6, %3 ]
  %18 = phi i64 [ 0, %1 ], [ %9, %3 ]
  %19 = phi i64 [ 0, %1 ], [ %12, %3 ]
  %20 = phi i64 [ 0, %1 ], [ %15, %3 ]
  %21 = or i64 %18, %17
  %22 = or i64 %21, %19
  %23 = or i64 %22, %20
  ret i64 %23
}

attributes #0 = { norecurse nounwind readnone sspstrong uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "frame-pointer"="none" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="true" "stack-protector-buffer-size"="4" "target-cpu"="x86-64" "target-features"="+cx8,+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.module.flags = !{!0, !1}
!llvm.ident = !{!2}

!0 = !{i32 1, !"wchar_size", i32 4}
!1 = !{i32 7, !"PIC Level", i32 2}
!2 = !{!"clang version 11.1.0"}
