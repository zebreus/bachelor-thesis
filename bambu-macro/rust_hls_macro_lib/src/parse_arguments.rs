use darling::ast::NestedMeta;
use darling::{Error, FromMeta};
use proc_macro2::TokenStream;

#[derive(Debug, FromMeta, Default, Clone, PartialEq, Eq, Hash)]
pub struct HlsArguments {
    #[darling(default)]
    /// Dont use the default bambu flags
    ///
    /// By default they will be added before the flags specified as `bambu_flag`
    pub skip_default_bambu_flags: Option<bool>,
    #[darling(multiple)]
    /// Add this flag when calling the bambu (the HLS compiler)
    ///
    /// Can be used multiple times
    pub bambu_flag: Vec<String>,
    #[darling(default)]
    /// Dont use the default rust flags
    ///
    /// By default they will be added before the flags specified as `rust_flag`
    pub skip_default_rust_flags: Option<bool>,
    #[darling(multiple)]
    /// Add this flag when calling the rust (the HLS compiler)
    ///
    /// Can be used multiple times
    pub rust_flag: Vec<String>,
}

impl HlsArguments {
    /// Overlay the current arguments with other arguments
    ///
    /// Other arguments will take precedence
    ///
    /// For now this returns other, if other has any set value
    pub fn overlay(&self, other: &Self) -> Self {
        if other.is_set() {
            return other.clone();
        } else {
            return self.clone();
        }
    }
    pub fn is_set(&self) -> bool {
        self.skip_default_bambu_flags.is_some()
            || self.skip_default_rust_flags.is_some()
            || !self.bambu_flag.is_empty()
            || !self.rust_flag.is_empty()
    }
    pub fn rust_flags(&self) -> String {
        self.rust_flag
            .iter()
            .fold(String::new(), |mut flags, flag| {
                flags.push(' ');
                flags.push_str(flag);
                flags
            })
    }
    pub fn bambu_flags(&self) -> String {
        self.bambu_flag
            .iter()
            .fold(String::new(), |mut flags, flag| {
                flags.push(' ');
                flags.push_str(flag);
                flags
            })
    }
}

/// Parse the macro arguments.
///
/// the input is a tokenstream of whats inside the brackets of the macro call.
/// i.e.: `rust_flags = "smth", hls_flags = "smth"`
pub fn parse_hls_macro_args(args: TokenStream) -> Result<HlsArguments, darling::Error> {
    let attr_args = match NestedMeta::parse_meta_list(args) {
        Ok(v) => v,
        Err(e) => {
            return Err(Error::from(e));
        }
    };

    let arguments = match HlsArguments::from_list(&attr_args) {
        Ok(v) => v,
        Err(e) => {
            return Err(e);
        }
    };

    return Ok(arguments);
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn flags_seem_to_work() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag", bambu_flag = "--bambu-flag", rust_flag = "--flag-b", bambu_flag = "--bambu-flag-b --bambu-flag-c",
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.rust_flags(), " --flag --flag-b");
        assert_eq!(
            args.bambu_flags(),
            " --bambu-flag --bambu-flag-b --bambu-flag-c"
        );
    }
}
