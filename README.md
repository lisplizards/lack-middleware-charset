# lack-middleware-charset

> Add a charset parameter to Content-Type response headers

## Usage

Wrap app:

```lisp
(funcall lack/middleware/charset:*lack-middleware-charset*
         *app*
         :default '(("text/html" . "utf-8")
                    ("application/json" . "utf-8")))
```

Lack Builder:

```lisp
(lack:builder
 (:charset :default '(("text/html" . "utf-8")))
 *web*)
```

## Development

Run tests:

```lisp
(asdf:test-system :foo.lisp.lack-middleware-charset)
```

## Installation

Not in Quicklisp, so clone to "local-projects/".

## Author

* John Newton (<a href="mailto:jnewton@lisplizards.dev">jnewton@lisplizards.dev</a>)

## Copyright

Copyright (c) 2024 John Newton

## License

Apache-2.0
