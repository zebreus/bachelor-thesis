use crate::SpannedErrorMessage;

pub fn title(options: &SpannedErrorMessage) -> Option<String> {
    let Some(title_message ) = &options.title_message else {return None};
    let title_prefix = &options.title_prefix;

    let result = format!("{}: {}", title_prefix, title_message);

    return Some(result);
}
