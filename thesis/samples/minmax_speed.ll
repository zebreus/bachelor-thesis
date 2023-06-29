; ModuleID = '<stdin>'
source_filename = "llvm-link"
target datalayout = "e-m:e-p270:32:32-p271:32:32-p272:64:64-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%"unwind::libunwind::_Unwind_Exception" = type { i64, void (i32, %"unwind::libunwind::_Unwind_Exception"*)*, [2 x i64] }
%"unwind::libunwind::_Unwind_Context" = type { [0 x i8] }

; Function Attrs: nofree nosync nounwind nonlazybind
define void @_ZN11rust_minmax6minmax6minmax17ha34c0f23e5d3bae7E(i32* nocapture noundef readonly %numbers, i32 noundef %numbers_length, i32* noalias nocapture noundef writeonly align 4 dereferenceable(4) %out_max, i32* noalias nocapture noundef writeonly align 4 dereferenceable(4) %out_min) unnamed_addr #0 personality i32 (i32, i32, i64, %"unwind::libunwind::_Unwind_Exception"*, %"unwind::libunwind::_Unwind_Context"*)* @rust_eh_personality {
start:
  %0 = icmp sgt i32 %numbers_length, 0
  br i1 %0, label %bb2.preheader, label %bb4

bb2.preheader:                                    ; preds = %start
  %wide.trip.count = zext i32 %numbers_length to i64
  %1 = add nsw i64 %wide.trip.count, -1
  %xtraiter = and i64 %wide.trip.count, 3
  %2 = icmp ult i64 %1, 3
  br i1 %2, label %bb4.loopexit.unr-lcssa, label %bb2.preheader.new

bb2.preheader.new:                                ; preds = %bb2.preheader
  %unroll_iter = and i64 %wide.trip.count, 4294967292
  br label %bb2

bb4.loopexit.unr-lcssa:                           ; preds = %bb2, %bb2.preheader
  %.lcssa32.ph = phi i32 [ undef, %bb2.preheader ], [ %16, %bb2 ]
  %.lcssa.ph = phi i32 [ undef, %bb2.preheader ], [ %17, %bb2 ]
  %indvars.iv.unr = phi i64 [ 0, %bb2.preheader ], [ %indvars.iv.next.3, %bb2 ]
  %local_max.026.unr = phi i32 [ -2147483648, %bb2.preheader ], [ %16, %bb2 ]
  %local_min.025.unr = phi i32 [ 2147483647, %bb2.preheader ], [ %17, %bb2 ]
  %lcmp.mod.not = icmp eq i64 %xtraiter, 0
  br i1 %lcmp.mod.not, label %bb4, label %bb2.epil

bb2.epil:                                         ; preds = %bb2.epil, %bb4.loopexit.unr-lcssa
  %indvars.iv.epil = phi i64 [ %indvars.iv.next.epil, %bb2.epil ], [ %indvars.iv.unr, %bb4.loopexit.unr-lcssa ]
  %local_max.026.epil = phi i32 [ %4, %bb2.epil ], [ %local_max.026.unr, %bb4.loopexit.unr-lcssa ]
  %local_min.025.epil = phi i32 [ %5, %bb2.epil ], [ %local_min.025.unr, %bb4.loopexit.unr-lcssa ]
  %epil.iter = phi i64 [ %epil.iter.next, %bb2.epil ], [ 0, %bb4.loopexit.unr-lcssa ]
  %indvars.iv.next.epil = add nuw nsw i64 %indvars.iv.epil, 1
  %3 = getelementptr inbounds i32, i32* %numbers, i64 %indvars.iv.epil
  %_14.epil = load i32, i32* %3, align 4, !noundef !2
  %4 = tail call i32 @llvm.smax.i32(i32 %_14.epil, i32 %local_max.026.epil)
  %5 = tail call i32 @llvm.smin.i32(i32 %_14.epil, i32 %local_min.025.epil)
  %epil.iter.next = add i64 %epil.iter, 1
  %epil.iter.cmp.not = icmp eq i64 %epil.iter.next, %xtraiter
  br i1 %epil.iter.cmp.not, label %bb4, label %bb2.epil, !llvm.loop !3

bb4:                                              ; preds = %bb2.epil, %bb4.loopexit.unr-lcssa, %start
  %local_min.0.lcssa = phi i32 [ 2147483647, %start ], [ %.lcssa.ph, %bb4.loopexit.unr-lcssa ], [ %5, %bb2.epil ]
  %local_max.0.lcssa = phi i32 [ -2147483648, %start ], [ %.lcssa32.ph, %bb4.loopexit.unr-lcssa ], [ %4, %bb2.epil ]
  store i32 %local_max.0.lcssa, i32* %out_max, align 4
  store i32 %local_min.0.lcssa, i32* %out_min, align 4
  ret void

bb2:                                              ; preds = %bb2, %bb2.preheader.new
  %indvars.iv = phi i64 [ 0, %bb2.preheader.new ], [ %indvars.iv.next.3, %bb2 ]
  %local_max.026 = phi i32 [ -2147483648, %bb2.preheader.new ], [ %16, %bb2 ]
  %local_min.025 = phi i32 [ 2147483647, %bb2.preheader.new ], [ %17, %bb2 ]
  %niter = phi i64 [ 0, %bb2.preheader.new ], [ %niter.next.3, %bb2 ]
  %indvars.iv.next = or i64 %indvars.iv, 1
  %6 = getelementptr inbounds i32, i32* %numbers, i64 %indvars.iv
  %_14 = load i32, i32* %6, align 4, !noundef !2
  %7 = tail call i32 @llvm.smax.i32(i32 %_14, i32 %local_max.026)
  %8 = tail call i32 @llvm.smin.i32(i32 %_14, i32 %local_min.025)
  %indvars.iv.next.1 = or i64 %indvars.iv, 2
  %9 = getelementptr inbounds i32, i32* %numbers, i64 %indvars.iv.next
  %_14.1 = load i32, i32* %9, align 4, !noundef !2
  %10 = tail call i32 @llvm.smax.i32(i32 %_14.1, i32 %7)
  %11 = tail call i32 @llvm.smin.i32(i32 %_14.1, i32 %8)
  %indvars.iv.next.2 = or i64 %indvars.iv, 3
  %12 = getelementptr inbounds i32, i32* %numbers, i64 %indvars.iv.next.1
  %_14.2 = load i32, i32* %12, align 4, !noundef !2
  %13 = tail call i32 @llvm.smax.i32(i32 %_14.2, i32 %10)
  %14 = tail call i32 @llvm.smin.i32(i32 %_14.2, i32 %11)
  %indvars.iv.next.3 = add nuw nsw i64 %indvars.iv, 4
  %15 = getelementptr inbounds i32, i32* %numbers, i64 %indvars.iv.next.2
  %_14.3 = load i32, i32* %15, align 4, !noundef !2
  %16 = tail call i32 @llvm.smax.i32(i32 %_14.3, i32 %13)
  %17 = tail call i32 @llvm.smin.i32(i32 %_14.3, i32 %14)
  %niter.next.3 = add i64 %niter, 4
  %niter.ncmp.3 = icmp eq i64 %niter.next.3, %unroll_iter
  br i1 %niter.ncmp.3, label %bb4.loopexit.unr-lcssa, label %bb2
}

; Function Attrs: nounwind nonlazybind
declare noundef i32 @rust_eh_personality(i32 noundef, i32 noundef, i64 noundef, %"unwind::libunwind::_Unwind_Exception"* noundef, %"unwind::libunwind::_Unwind_Context"* noundef) unnamed_addr #1

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smax.i32(i32, i32) #2

; Function Attrs: nocallback nofree nosync nounwind speculatable willreturn memory(none)
declare i32 @llvm.smin.i32(i32, i32) #2

; Function Attrs: nounwind nonlazybind
define void @min_max(i32* noundef %elements, i32 noundef %elements_length, i32* noalias noundef align 4 dereferenceable(4) %out_max, i32* noalias noundef align 4 dereferenceable(4) %out_min) unnamed_addr #1 {
start:
  tail call void @_ZN11rust_minmax6minmax6minmax17ha34c0f23e5d3bae7E(i32* noundef %elements, i32 noundef %elements_length, i32* noalias noundef nonnull align 4 dereferenceable(4) %out_max, i32* noalias noundef nonnull align 4 dereferenceable(4) %out_min) #3
  ret void
}

attributes #0 = { nofree nosync nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #1 = { nounwind nonlazybind "probe-stack"="__rust_probestack" "target-cpu"="generic" }
attributes #2 = { nocallback nofree nosync nounwind speculatable willreturn memory(none) }
attributes #3 = { nounwind }

!llvm.module.flags = !{!0, !1}

!0 = !{i32 8, !"PIC Level", i32 2}
!1 = !{i32 2, !"RtLibUseGOT", i32 1}
!2 = !{}
!3 = distinct !{!3, !4}
!4 = !{!"llvm.loop.unroll.disable"}
