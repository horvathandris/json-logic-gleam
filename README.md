# jsonlogic

[![Package Version](https://img.shields.io/hexpm/v/jsonlogic)](https://hex.pm/packages/jsonlogic)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/jsonlogic/)

A Gleam library for evaluating [JSON Logic](https://jsonlogic.com/) expressions.

```sh
gleam add jsonlogic@1
```
```gleam
import jsonlogic

pub fn main() {
  echo jsonlogic.apply(" { \"==\" : [1, 1] } ", to: dynamic.nil()) // Ok(True)
}
```

Further documentation can be found at <https://hexdocs.pm/jsonlogic>.

## Development

### Testing

The library is tested against the [JSON Logic Compatibility Tables](https://github.com/json-logic/compat-tables).
See [the test report](https://github.com/horvathandris/json-logic-gleam/blob/main/test/REPORT.md) for details.

```sh
gleam test  # Run the test suites
```
