;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:lack/middleware/charset/tests)

(defun app-0 (env)
  (declare (ignore env))
  `(200
    (:content-type "application/json; charset=utf-8"
     :content-length 17)
    ("{\"hello\":\"world\"}")))

(defun app-1 (env)
  (declare (ignore env))
  `(200
    (:content-type "application/json"
     :content-length 17)
    ("{\"hello\":\"world\"}")))

(deftest charset-defaults-test ()
  (testing
   "Does nothing when the content-type already has a charset"
   (let* ((app (funcall lack/middleware/charset:*lack-middleware-charset*
                        #'app-0
                        :default '(("application/json" . "utf-16"))))
          (response (funcall app ())))
     (ok (equal (getf (second response) :content-type)
                "application/json; charset=utf-8"))))

  (testing
   "Appends a charset based on the configured default"
   (let* ((app (funcall lack/middleware/charset:*lack-middleware-charset*
                        #'app-1
                        :default '(("application/json" . "utf-8"))))
          (response (funcall app ())))
     (ok (equal (getf (second response) :content-type)
                "application/json;charset=utf-8")))))

