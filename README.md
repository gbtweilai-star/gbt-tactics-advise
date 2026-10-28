# tactics_advise

**One capability bit from GBT V8, packaged standalone.** No. 153 of 341,
`longrun` domain (Long-run).

<p>
<img alt="python" src="https://img.shields.io/badge/python-3.9%2B-blue">
<img alt="license" src="https://img.shields.io/badge/license-MIT-green">
<img alt="deps" src="https://img.shields.io/badge/runtime%20dependencies-0-brightgreen">
</p>

> 察言观色层：识别沟通信号→给出表达分寸（只调怎么说，不改事实）

That description is copied verbatim from the registry. `tests/test_spec.py` pins it,
so documentation drift fails the build instead of shipping quietly.

## What this package actually is

It is the **contract** for one capability: its name, its parameters, the values it
accepts, and whether it can change state that cannot be restored. It is not the
implementation — that lives in the runtime this bit was extracted from.

So `run()` goes through a narrow `Backend` protocol, and the default backend is a
stub that **says so**:

```
status="validated"   backend="stub"   data={"executed": false}
```

Never `status="ok"`. A stub that reports success is worse than no stub, because the
caller stops looking for the real thing.

## Install

```bash
git clone https://github.com/gbtweilai-star/gbt-tactics-advise.git
cd gbt-tactics-advise
python -m pip install -e ".[dev]"
```

## Use

```bash
python -m gbt_tactics_advise info                  # capability card
python -m gbt_tactics_advise spec --json           # machine-readable contract
python -m gbt_tactics_advise check --payload '{}'
python -m gbt_tactics_advise run   --payload '{}'
```

Real `info` output from this machine:

```text
tactics_advise  (longrun)  v1.0.0
----------------------------------------
察言观色层：识别沟通信号→给出表达分寸（只调怎么说，不改事实）

gated      : False
external   : False
multi-op   : False
params     : (none)
```

Wire a real implementation:

```python
from gbt_tactics_advise import run

class MyBackend:
    name = "my-backend"
    def invoke(self, cap, payload):
        return {"cap": cap, "handled": sorted(payload)}

result = run({}, backend=MyBackend())
assert result.status == "ok"
```

## Parameters

| name | required | notes |
|---|---|---|
| — | no | the registry declares no required parameters |

Registry hint (`params_hint`): (empty)

Types are deliberately absent: the registry does not declare them, and an invented
type is worse than no type, because callers believe it.

## Boundaries

- Not gated: the registry marks this bit `safe: true`.
- No external service dependency declared.
- Single-action bit.
- No implementation ships here. Bring a backend; the protocol is one method.

## What this is not

Not a wrapper around a hosted API. Not a model. Not a promise that calling it does
anything on its own. It is the typed seam plus the validation, which is the part that
stays correct even when the implementation changes.

## Tests

```bash
python -m pytest
```

```text
20 passed, 3 skipped in 0.14s
```

## Provenance

| field | value |
|---|---|
| capability | `tactics_advise` |
| domain | `longrun` |
| handler | `tactics_advise` |
| safe | `True` (gated = `False`) |
| external | `False` |
| atlas page | [longrun/tactics_advise](https://github.com/gbtweilai-star/gbt-caps/blob/main/caps/longrun/tactics_advise.md) |
| full index | [https://github.com/gbtweilai-star/gbt-caps](https://github.com/gbtweilai-star/gbt-caps) |

The parent README says 348 capabilities; an AST pass over the registry enumerates
`341 + 0 unimplemented + 0 disabled = 341`. The extra 7 are historical duplicates.
Numbering here follows 341 and matches the `gbt-caps` index one-to-one.

## License

MIT.
