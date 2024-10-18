
(cl:in-package :asdf)

(defsystem "denso_cobotta_driver-msg"
  :depends-on (:roslisp-msg-protocol :roslisp-utils )
  :components ((:file "_package")
    (:file "RobotState" :depends-on ("_package_RobotState"))
    (:file "_package_RobotState" :depends-on ("_package"))
    (:file "SafeState" :depends-on ("_package_SafeState"))
    (:file "_package_SafeState" :depends-on ("_package"))
  ))