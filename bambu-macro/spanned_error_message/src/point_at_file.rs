use crate::{Section, SpannedErrorMessage};

pub fn point_at_file(section: &Section, options: &SpannedErrorMessage) -> Option<String> {
    let Section {
        start, document, ..
    } = section;
    let line = start.line;

    let line_number_string = line.to_string();

    let path = match options.include_filename {
        crate::IncludeFilename::Always => document.path.clone().unwrap_or("<unknown>".into()),
        crate::IncludeFilename::Never => return None,
        crate::IncludeFilename::OnlyIfTheFilenameIsARealFile => document.path.clone()?,
    }
    .to_string_lossy()
    .to_string();

    let result = format!(
        " {}--> {}:{}:{}",
        " ".repeat(line_number_string.len()),
        path,
        start.line,
        start.column
    );

    return Some(result);
}
