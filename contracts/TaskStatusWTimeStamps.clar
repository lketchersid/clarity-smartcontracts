;; Simple clarity smart contract
;; Workflow task and sub task status WITH TIME STAMPS from STX blockchain
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
(define-data-var taskcompletetime uint u0)
(define-data-var taskcanceltime uint u0)
(define-data-var currentblockheight uint u0)
(define-data-var taskduration uint u0)

;; define read-only functions
(define-read-only (get-task-status)
  {notused: (var-get notused), notstarted: (var-get notstarted), inprocess: (var-get inprocess), complete: (var-get complete), cancelled: (var-get cancelled)}
)


;; define private functions
;; this will check the integrity of the task settings and error out
;; if the task is already completed or cancelled panic
(define-private (if-task-complete-or-cancelled-cannot-be-used-err)
	(unwrap-panic
		(if (or (var-get complete) (var-get cancelled))
			(err 1)
			(ok true)
		)
	)
)



;; huge thanks to @hozzjss for assist this time function
(define-private (get-current-block-time) 
  (default-to u0 (get-block-info? time block-height)))


;; define public functions
;;
;; this function should allow a check on the task time duration, whether complete, cancelled or in-process
;; if the task is completed or cancelled, provides the previously calculated task duration
;; if the task is in process, it calculates using current time and the task start time
;; if the task has not started it should return u0 
(define-public (get-task-duration)
	(begin
		(if (if-task-complete-or-cancelled-cannot-be-used-err)
			(var-get taskduration)
			(- (get-current-block-time) (var-get taskstarttime))
		)
		(ok (var-get taskduration))
	)
)

;; these functions allow the setting of the different task statuses

(define-public (start-task)
	(begin
		(if-task-complete-or-cancelled-cannot-be-used-err)
		(var-set inprocess true)
		(var-set notused false)
		(var-set taskstarttime (get-current-block-time))
		(ok (var-get taskstarttime))
	)
)

(define-public (task-used)
	(begin
		(if-task-complete-or-cancelled-cannot-be-used-err)
		(var-set notused false)
		(var-set notstarted true)
		(ok true))
)

(define-public (task-complete)
	(begin
		(if-task-complete-or-cancelled-cannot-be-used-err)
		(var-set notstarted false)
		(var-set inprocess false)
		(var-set complete true)
		(var-set taskcompletetime (get-current-block-time))
		(var-set taskduration (- (var-get taskcompletetime) (var-get taskstarttime)))
		(ok (var-get taskcompletetime))
	)
)

(define-public (cancel-task)
	(begin
		(if-task-complete-or-cancelled-cannot-be-used-err)
		(var-set inprocess false)
		(var-set notused false)
		(var-set notstarted false)
		(var-set taskcanceltime (get-current-block-time))
		(var-set taskduration (- (var-get taskcanceltime) (var-get taskstarttime)))
		(ok (var-get taskcanceltime))
	)
)




