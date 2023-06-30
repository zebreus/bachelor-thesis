mod keccak;
mod keccak_crate;
// mod keccak_fully_expanded;
// pub use keccak_fully_expanded::keccak_fully_expanded;
mod keccak_idiomatic;

pub use keccak::keccak;
pub use keccak_crate::keccak_crate;
pub use keccak_idiomatic::keccak as keccak_idiomatic;
