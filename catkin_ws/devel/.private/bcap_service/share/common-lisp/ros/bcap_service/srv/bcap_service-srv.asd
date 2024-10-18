
(cl:in-package :asdf)

(defsystem "bcap_service-srv"
  :depends-on (:roslisp-msg-protocol :roslisp-utils :bcap_service-msg
)
  :components ((:file "_package")
    (:file "bcap" :depends-on ("_package_bcap"))
    (:file "_package_bcap" :depends-on ("_package"))
  ))