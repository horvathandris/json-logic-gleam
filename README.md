# jsonlogic

[![Package Version](https://img.shields.io/hexpm/v/jsonlogic)](https://hex.pm/packages/jsonlogic)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/jsonlogic/)

```sh
gleam add jsonlogic@1
```
```gleam
import jsonlogic

pub fn main() {
  echo jsonlogic.apply(" { \"==\" : [1, 1] } ") // Ok(True)
}
```

Further documentation can be found at <https://hexdocs.pm/jsonlogic>.

## Development

```sh
gleam run   # Run the project
gleam test  # Run the tests
```
