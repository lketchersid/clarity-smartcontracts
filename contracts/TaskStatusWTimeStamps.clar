;; Simple clarity smart contract
;; Workflow task and sub task status
;; functionality - allow the setting of four task statuses. Check for status integrity
;; future versions can:
;; - have a better task state machine
;; - potentially use something like Friedger's escrow to accept STX when a task is set to in process
;; - define task state change start and stop times (i.e. task duration)

;; define any constants


;; define local storage

;; these are the basic task and subtask possible status states
;; ideally these should be mutually exclusive. will put a test for that in a private function
;; by default a task is not used until it is either moved to notstarted, inprocess, complete or cancelled 
(define-data-var notused bool true)
(define-data-var notstarted bool false)
(define-data-var inprocess bool false)
(define-data-var complete bool false)
(define-data-var cancelled bool false)
(define-data-var taskstarttime uint u0)
(define-data-var currentblockheight uint block-height)

;; define read-only functions
(define-read-only (get-task-status)
  {notused: (var-get notused), notstarted: (var-get notstarted), inprocess: (var-get inprocess), complete: (var-get complete), cancelled: (var-get cancelled)}
)


;; define private functions
;; this will check the integrity of the task settings and error out
(define-private (if-task-complete-cannot-be-used-err)
	(unwrap-panic
		(if (var-get complete)
			(err 1)
			(ok true)
		)
	)
)


;; define public functions
;;
;; these functions allow the setting of the different task statuses
(define-public (start-task)
	(begin
		(if-task-complete-cannot-be-used-err)
		(var-set inprocess true)
		(var-set notused false)
		(var-set taskstarttime (get-block-info? time (var-get currentblockheight)))
	(ok taskstarttime))
)

(define-public (task-used)
	(begin
		(if-task-complete-cannot-be-used-err)
		(var-set notused false)
		(var-set notstarted true)
	(ok true))
)

(define-public (task-complete)
	(begin
		(if-task-complete-cannot-be-used-err)
		(var-set notstarted false)
		(var-set inprocess false)
		(var-set complete true)
	(ok true))
)

(define-public (cancel-task)
	(begin
		(if-task-complete-cannot-be-used-err)
		(var-set inprocess false)
		(var-set notused false)
		(var-set notstarted false)
	(ok true))
)
