pub struct Toaster {
    pub message_pointer: *const u32,
}

impl Toaster {
    pub fn new(message_pointer: *const u32) -> Toaster {
        Toaster { message_pointer }
    }
    pub unsafe fn process_message(&self) -> &'static [u32] {
        unsafe fn sub_process_message(message_pointer: *const u32) -> &'static [u32] {
            let message = std::slice::from_raw_parts(message_pointer, 16);
            return message;
        }
        let message = sub_process_message(self.message_pointer);
        return message;
    }
}

#[inline]
pub unsafe fn process_message(message_pointer: *const u32) -> &'static [u32] {
    #[inline]
    unsafe fn sub_process_message(message_pointer: *const u32) -> &'static [u32] {
        let message = std::slice::from_raw_parts(message_pointer, 16);
        return message;
    }
    let message = sub_process_message(message_pointer);
    return message;
}
