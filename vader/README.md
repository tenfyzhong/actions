# vader
Test vim plugin with [vader](https://github.com/junegunn/vader.vim)

# Usage
```yaml
name: vader

permissions:
  actions: read

on: 
  workflow_call:
    inputs:
      plugins:
        required: false
        type: string
        default: ""
      test-pattern:
        required: false
        type: string
        default: "**/*.vader"

jobs:
  test:
    name: Test (${{ matrix.editor }})
    runs-on: ubuntu-latest
    strategy:
      matrix:
        editor: ['vim', 'nvim']
    steps:
      - uses: actions/checkout@v4
      - uses: rhysd/action-setup-vim@v1
        with:
          neovim: ${{ matrix.editor == 'nvim' }}
      - uses: tenfyzhong/actions/vader@main
        with:
          editor: ${{ matrix.editor }}
          plugins: ${{ inputs.plugins }}
          test-pattern: ${{ inputs.test-pattern }}

```

## inputs
### test-pattern
A glob which points to you vader test files.

Default: `**/*.vader`

required: false

### editor
The editor to run vader, vim or nvim.

Default: `vim`

required: false

### plugins
A colon-separated list of plugins to install. 

Default: ''

required: false
