; Dummy panic implementation
%"core::panic::location::Location<'_>" = type { { [0 x i8]*, i64 }, i32, i32 }

; core::panicking::panic
; Function Attrs: cold noinline noreturn nounwind nonlazybind optsize
define void @_ZN4core9panicking5panic17h2a2cd64c1c1612ffE([0 x i8]* noalias noundef nonnull readonly align 1 %0, i64 noundef  %1, %"core::panic::location::Location<'_>"* noalias noundef readonly align 8 dereferenceable(24) %2) unnamed_addr #4 {
start:
  unreachable
}

; core::panicking::panic_bounds_check
; Function Attrs: cold noinline noreturn nounwind nonlazybind optsize
define void @_ZN4core9panicking18panic_bounds_check17ha723b51b27c76082E(i64 %0, i64 %1, %"core::panic::location::Location<'_>"* align 8 %2) unnamed_addr #5 {
start:
  unreachable
}