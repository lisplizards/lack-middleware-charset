;; Copyright (c) 2024 John Newton
;; SPDX-License-Identifier: Apache-2.0

(in-package #:lack/middleware/charset)

(defparameter *lack-middleware-charset*
  #'(lambda (app &key default)
      (declare (optimize (speed 0) (safety 3) (debug 3))
               (type function app))
      (check-type default list)
      (assert (not (null default))
              nil
              "charset default must not be NIL; either remove the middleware or specify an association list")
      (let ((defaults-hash (make-hash-table :test #'equalp)))
        (loop for (key . value) in default
              do (progn
                   (check-type key string)
                   (check-type value string)
                   (setf (gethash key defaults-hash)
                         value)))
        (setq default defaults-hash))
      #'(lambda (env)
          (declare (optimize (speed 3) (safety 0) (debug 0))
                   (type list env)
                   (type hash-table default))
          (let* ((response (funcall app env))
                 (content-type (getf (second response) :content-type)))
            (declare (type list response)
                     (type (or null simple-string) content-type))
            (when (and content-type (null (search "charset=" content-type)))
              (let ((charset (gethash content-type default)))
                (declare (type (or null string) charset))
                (when charset
                  (setf (getf (second response) :content-type)
                        (format nil "~A;charset=~A" content-type charset)))))
            response))))
