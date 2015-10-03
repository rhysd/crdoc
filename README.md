crdoc
=======
[![Build Status](https://travis-ci.org/rhysd/crdoc.svg)](https://travis-ci.org/rhysd/crdoc)

`crdoc` is a CLI tool to search and open documentation for [Crystal language](https://github.com/manastech/crystal).

## Installation

Please download a binary from [release page](https://github.com/rhysd/crdoc/releases) (OS X only) or build

```sh
$ cd /your/favorite/directory/
$ git clone https://github.com/rhysd/crdoc.git && cd crdoc
$ git submodule update
$ crystal build --release bin/crdoc.cr
$ cp crdoc /your/favorite/bin
```

## Usage

```
crdoc search [-f] KEYWORD...
crdoc api [-f] KEYWORD...
crdoc syntax_and_semantics [-f] KEYWORD...
crdoc list [-p|--path] [-a|--api] [-s|--syntax-and-semantics]
crdoc update
```

- `search` searches all documents with keyword(s) and show the result in browser.
- `api` searches API document with keyword(s) and show the result in browser.
- `syntax_and_semantics` searches 'syntax and semantics' document with keyword(s) and show the result in browser.
- `list` shows list of candidates.  When `--path` is specified, it shows full paths to HTML documents instead.
- `update` updates cached repository.

## Using with [Peco](https://github.com/peco/peco)/[Percol](https://github.com/mooz/percol)

TODO

## Contributing

1. Fork it ( https://github.com/rhysd/crdoc/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [@rhysd](https://github.com/rhysd) - creator, maintainer
