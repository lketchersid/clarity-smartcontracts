;; Simple clarity smart contract
;; Workflow task and sub task status
;; functionality - allow the setting of four task statuses. Check for status integrity
;; future versions can:
;; - have a better task state machine
;; - potentially use something like Friedger's escrow to accept STX when a task is set to in process
;; - define task state change start and stop times (i.e. task duration)

;; define any constants


;; define local storage
(define-data-var notused bool true)
(define-data-var idle bool false)
(define-data-var inprocess bool false)
(define-data-var complete bool false)
(define-data-var cancelled bool false)

;; define read-only functions
(define-read-only (get-task-status)
  {balance: (var-get balance), buyerOk: (var-get buyerOk), sellerOk: (var-get sellerOk)}
)


;; define private functions



;; define public functions

