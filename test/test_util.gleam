import filepath
import simplifile

pub fn do_find_root(path: String) -> Result(String, simplifile.FileError) {
  let manifest = filepath.join(path, "gleam.toml")
  case simplifile.is_file(manifest) {
    Ok(True) -> Ok(path)
    Ok(False) -> do_find_root(filepath.join(path, ".."))
    Error(reason) -> Error(reason)
  }
}
