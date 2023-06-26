use syn::spanned::Spanned;

const VERILOG_2001_RESERVED_NAMES: [&str; 102] = [
    "always",
    "ifnone",
    "rpmos",
    "and",
    "initial",
    "rtran",
    "assign",
    "inout",
    "rtranif0",
    "begin",
    "input",
    "rtranif1",
    "buf",
    "integer",
    "scalared",
    "bufif0",
    "join",
    "small",
    "bufif1",
    "large",
    "specify",
    "case",
    "macromodule",
    "specparam",
    "casex",
    "medium",
    "strong0",
    "casez",
    "module",
    "strong1",
    "cmos",
    "nand",
    "supply0",
    "deassign",
    "negedge",
    "supply1",
    "default",
    "nmos",
    "table",
    "defparam",
    "nor",
    "task",
    "disable",
    "not",
    "time",
    "edge",
    "notif0",
    "tran",
    "else",
    "notif1",
    "tranif0",
    "end",
    "or",
    "tranif1",
    "endcase",
    "output",
    "tri",
    "endmodule",
    "parameter",
    "tri0",
    "endfunction",
    "pmos",
    "tri1",
    "endprimitive",
    "posedge",
    "triand",
    "endspecify",
    "primitive",
    "trior",
    "endtable",
    "pull0",
    "trireg",
    "endtask",
    "pull1",
    "vectored",
    "event",
    "pullup",
    "wait",
    "for",
    "pulldown",
    "wand",
    "force",
    "rcmos",
    "weak0",
    "forever",
    "real",
    "weak1",
    "fork",
    "realtime",
    "while",
    "function",
    "reg",
    "wire",
    "highz0",
    "release",
    "wor",
    "highz1",
    "repeat",
    "xnor",
    "if",
    "rnmos",
    "xor",
];

pub fn assert_ident_is_a_valid_verilog_name(ident: &syn::Ident) -> Result<(), darling::Error> {
    let parameter_name = ident.to_string();
    if VERILOG_2001_RESERVED_NAMES.contains(&parameter_name.as_str()) {
        return Err(darling::Error::custom(format!(
            "The parameter name `{}` is a reserved Verilog 2001 keyword.",
            parameter_name
        ))
        .with_span(&ident.span()));
    }
    Ok(())
}

pub fn check_parameter(fn_arg: &syn::FnArg) -> Result<(String, syn::Type), darling::Error> {
    let syn::FnArg::Typed(typed) = fn_arg else {
        return Err(darling::Error::custom(
            "HLS main functions must not use self",
        )
        .with_span(&fn_arg.span()));
    };
    let syn::Pat::Ident(syn::PatIdent{ident,..}) = typed.pat.as_ref() else {
        return Err(darling::Error::custom("The HLS main function must only use ident parameters. Idk how this error can occur.").with_span(&typed.span()))
    };
    assert_ident_is_a_valid_verilog_name(&ident)?;
    let parameter_name = ident.to_string();
    let ty = typed.ty.as_ref().clone();
    Ok((parameter_name, ty))
}

#[cfg(test)]
mod tests {

    use super::*;

    #[test]
    fn accepts_valid_parameter() {
        // The test file should contain a lot of modules. At least three
        let parameter: syn::FnArg = syn::parse2(::quote::quote! {
            my_parameter: usize
        })
        .unwrap();

        check_parameter(&parameter).unwrap();
    }

    #[test]
    fn detects_verilog_keyword_in_parameter_name() {
        // The test file should contain a lot of modules. At least three
        let parameter: syn::FnArg = syn::parse2(::quote::quote! {
            input: usize
        })
        .unwrap();

        check_parameter(&parameter).unwrap_err();
    }

    #[test]
    fn detects_self_parameter() {
        // The test file should contain a lot of modules. At least three
        let parameter: syn::FnArg = syn::parse2(::quote::quote! {
            self
        })
        .unwrap();

        check_parameter(&parameter).unwrap_err();
    }
}
