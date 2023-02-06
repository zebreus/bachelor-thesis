; ModuleID = 'switch_rust.d9b97dd6-cgu.0'
source_filename = "switch_rust.d9b97dd6-cgu.0"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@switch.table.switch_rust = private unnamed_addr constant [4 x i32] [i32 0, i32 0, i32 0, i32 16777216], align 4
@switch.table.switch_rust.1 = private unnamed_addr constant [4 x i32] [i32 0, i32 0, i32 65536, i32 0], align 4
@switch.table.switch_rust.2 = private unnamed_addr constant [4 x i32] [i32 0, i32 256, i32 0, i32 0], align 4
@switch.table.switch_rust.3 = private unnamed_addr constant [4 x i32] [i32 1, i32 0, i32 0, i32 0], align 4

; Function Attrs: mustprogress nofree norecurse nosync nounwind nonlazybind optsize readnone willreturn
define i32 @switch_rust(i16 %counter) unnamed_addr #0 {
start:
  %0 = icmp ult i16 %counter, 4
  br i1 %0, label %switch.lookup, label %bb6

switch.lookup:                                    ; preds = %start
  %1 = sext i16 %counter to i64
  %switch.gep = getelementptr inbounds [4 x i32], [4 x i32]* @switch.table.switch_rust, i64 0, i64 %1
  %switch.load = load i32, i32* %switch.gep, align 4
  %2 = sext i16 %counter to i64
  %switch.gep1 = getelementptr inbounds [4 x i32], [4 x i32]* @switch.table.switch_rust.1, i64 0, i64 %2
  %switch.load2 = load i32, i32* %switch.gep1, align 4
  %3 = sext i16 %counter to i64
  %switch.gep3 = getelementptr inbounds [4 x i32], [4 x i32]* @switch.table.switch_rust.2, i64 0, i64 %3
  %switch.load4 = load i32, i32* %switch.gep3, align 4
  %4 = sext i16 %counter to i64
  %switch.gep5 = getelementptr inbounds [4 x i32], [4 x i32]* @switch.table.switch_rust.3, i64 0, i64 %4
  %switch.load6 = load i32, i32* %switch.gep5, align 4
  %5 = or i32 %switch.load2, %switch.load
  %6 = or i32 %5, %switch.load4
  %7 = or i32 %6, %switch.load6
  br label %bb6

bb6:                                              ; preds = %switch.lookup, %start
  %state.sroa.0.0.insert.insert = phi i32 [ %7, %switch.lookup ], [ 0, %start ]
  ret i32 %state.sroa.0.0.insert.insert
}

attributes #0 = { mustprogress nofree norecurse nosync nounwind nonlazybind optsize readnone willreturn "probe-stack"="__rust_probestack" "target-cpu"="generic" }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 7, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
