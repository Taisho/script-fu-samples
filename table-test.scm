(define (script-fu-table-test)
 (let* (
   ;Assuming layers are of equal sizes
 	 (x '())
 	)
 	 ;(set! x (list 1 2))
 	 ;(set! x (list x 3))
 	 ;(list-ref x 0)
 	(set! x (cons 1 '()))
	(set! x (cons 2 x))
	(set! x (cons 3 x))
	(set! x (cons 4 x))
	(set! x (cons 5 x))
	(cadr x)
 )
)

(script-fu-register
    "script-fu-table-test"              	   ;func name
    "List Test (Console Only)"                     ;menu label
    "Attempts to arrange layers in a table"        ;description
    "Tichomit Mitkov"                              ;author
    "copyright 2013, Tichomit Mitkov"              ;copyright notice
    "November 2, 2013"                             ;date created
    ""                   			   ;image type
)
