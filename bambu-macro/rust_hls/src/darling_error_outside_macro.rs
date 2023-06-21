use std::{
    fmt::{Display, Formatter},
    path::PathBuf,
};

use spanned_error_message::{Section, SpannedErrorMessage};
use std::error::Error;

#[derive(Debug)]
struct FormattedError {
    pub _message: String,
    pub formatted_message: String,
}

#[derive(Debug)]
pub struct DarlingErrorOutsideMacro {
    errors: Vec<FormattedError>,
}

impl DarlingErrorOutsideMacro {
    pub fn new(error: &darling::Error, file: &PathBuf) -> Self {
        let errors: Vec<_> = error
            .clone()
            .flatten()
            .into_iter()
            .map(|err| (err.span(), format!("{}", err)))
            .collect();
        let error_messages = errors
            .into_iter()
            .map(|(span, message)| {
                let section = Section::from_span_and_path(&span, &file).unwrap();
                let formatted_message = SpannedErrorMessage::new().title(&message).create(&section);
                FormattedError {
                    _message: message,
                    formatted_message,
                }
            })
            .collect();
        Self {
            errors: error_messages,
        }
    }
    pub fn from_syn_error(error: syn::Error, file: &PathBuf) -> Self {
        let errors: Vec<_> = error
            .into_iter()
            .map(|err| (err.span(), format!("{}", err)))
            .collect();
        let error_messages = errors
            .into_iter()
            .map(|(span, message)| {
                let section = Section::from_span_and_path(&span, &file).unwrap();
                let formatted_message = SpannedErrorMessage::new().title(&message).create(&section);
                FormattedError {
                    _message: message,
                    formatted_message,
                }
            })
            .collect();
        Self {
            errors: error_messages,
        }
    }
}

impl Display for DarlingErrorOutsideMacro {
    fn fmt(&self, f: &mut Formatter<'_>) -> std::fmt::Result {
        if self.errors.len() == 0 {
            writeln!(f, "Empty error")?;
        }
        for error in &self.errors {
            writeln!(f, "{}", error.formatted_message)?;
        }
        Ok(())
    }
}

impl Error for DarlingErrorOutsideMacro {}
