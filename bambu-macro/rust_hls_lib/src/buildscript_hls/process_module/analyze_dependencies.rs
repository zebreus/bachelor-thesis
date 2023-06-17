use std::collections::HashSet;

use super::super::find_modules::MacroModule;
use thiserror::Error;

#[derive(Error, Debug, PartialEq, Eq, Clone)]
pub enum AnalyzeDependenciesError {
    #[error(transparent)]
    StripPrefixError(#[from] std::path::StripPrefixError),
    #[error("Cannot reference crate root in hls module. Tried to reference: {path}")]
    CannotReferenceCrateRoot { path: String },
    #[error(
        "Cannot use super to reference a module outside the hls module. Tried to reference: {path}"
    )]
    CannotSuperOutsideHlsModule { path: String },
}

mod dependency_finder;
mod super_checker;
mod usetree_to_path;
pub use dependency_finder::*;
pub use super_checker::*;
pub use usetree_to_path::*;
// TODO: Implement a visitor that check that super does not leave the module

/// Analyze which dependencies are used in a module
///
/// Returns the dependencies that are used in the module
pub fn analyze_dependencies(
    module: &MacroModule,
    available_dependencies: &HashSet<String>,
) -> Result<HashSet<String>, AnalyzeDependenciesError> {
    let content = &module.module_content;
    let mut super_checker = SuperChecker::new();
    syn::visit::visit_file(&mut super_checker, content);
    super_checker.get_result()?;
    let mut dependency_finder = DependencyFinder::new(available_dependencies);
    syn::visit::visit_file(&mut dependency_finder, content);
    dependency_finder.get_result()
}
