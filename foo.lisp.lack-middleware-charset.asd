;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(defsystem "foo.lisp.lack-middleware-charset"
  :version "1.0.0"
  :author "John Newton"
  :license "Apache-2.0"
  :homepage "https://github.com/lisplizards/lack-middleware-charset"
  :bug-tracker "https://github.com/lisplizards/lack-middleware-charset/issues"
  :source-control (:git "https://github.com/lisplizards/lack-middleware-charset.git")
  :depends-on ()
  :components ((:module "src"
                :components
                ((:file "middleware" :depends-on ("package"))
                 (:file "package"))))
  :description "Lack middleware to add a default charset a parameter to the response Content-Type header"
  :in-order-to ((test-op (test-op "foo.lisp.lack-middleware-charset/tests"))))

(defsystem "foo.lisp.lack-middleware-charset/tests"
  :author "John Newton"
  :license "Apache-2.0"
  :depends-on ("foo.lisp.lack-middleware-charset"
               "rove")
  :components ((:module "tests"
                :components
                ((:file "middleware" :depends-on ("package"))
                 (:file "package"))))
  :description "Test system for foo.lisp.lack-middleware-charset"
  :perform (test-op (op c) (symbol-call :rove :run c)))
