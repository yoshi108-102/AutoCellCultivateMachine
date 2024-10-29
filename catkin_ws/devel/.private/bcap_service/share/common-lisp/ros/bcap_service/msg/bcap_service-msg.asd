
(cl:in-package :asdf)

(defsystem "bcap_service-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "variant" :depends-on ("_package_variant"))
    (:file "_package_variant" :depends-on ("_package"))
  ))