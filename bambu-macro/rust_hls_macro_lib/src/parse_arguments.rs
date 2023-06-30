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
    #[darling(multiple)]
    /// You can add an additional [LLVM optimizer](https://llvm.org/docs/CommandGuide/opt.html) pass after linking the llvm bitcode.
    ///
    /// If this option is not set, opt will not be called.
    ///
    /// The arguments passed to this flag will be appended to the opt call.
    ///
    /// To get more info about the available passes, run `opt --help`
    pub llvm_opt_flag: Vec<String>,
    #[darling(default)]
    /// Include the generated LLVM IR in the output directory
    pub include_llvm_ir: Option<bool>,
    #[darling(default)]
    /// Include the logs of bambu in the output directory
    pub include_logs: Option<bool>,
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
            || !self.llvm_opt_flag.is_empty()
            || self.include_llvm_ir.is_some()
            || self.include_logs.is_some()
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
    pub fn llvm_opt_flags(&self) -> Option<String> {
        if self.llvm_opt_flag.is_empty() {
            return None;
        }

        let result = self
            .llvm_opt_flag
            .iter()
            .fold(String::new(), |mut flags, flag| {
                flags.push(' ');
                flags.push_str(flag);
                flags
            });

        Some(result)
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
        assert_eq!(args.llvm_opt_flags(), None);
    }

    #[test]
    fn llvm_opt_flags_seem_to_work() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag", llvm_opt_flag = "--llvm-opt-flag", rust_flag = "--flag-b", bambu_flag = "--bambu-flag-b --bambu-flag-c",
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.rust_flags(), " --flag --flag-b");
        assert_eq!(args.llvm_opt_flags().unwrap(), " --llvm-opt-flag");
    }

    #[test]
    fn unset_flags_return_none() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag"
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.include_llvm_ir, None);
    }
    #[test]
    fn set_flags_return_option_true() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag", include_llvm_ir
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.include_llvm_ir, Some(true));
    }
    #[test]
    fn set_false_flags_return_option_false() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag", include_llvm_ir = false
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.include_llvm_ir, Some(false));
    }
    #[test]
    fn set_true_flags_return_option_false() {
        // The test file should contain a lot of modules. At least three
        let args = ::quote::quote! {
            rust_flag = "--flag", include_llvm_ir = true
        };

        let args = parse_hls_macro_args(args).unwrap();
        assert_eq!(args.include_llvm_ir, Some(true));
    }
}
