(define (script-fu-move-to-group inImage inDrawable)
(let* (
	;(script-fu-move-to-group 1 2)
	;TODO next version must allow automatic position on the next line
	;if image is not enough big to store layers
	;TODO place icon in the toolbox for triggering script
	;TODO assign keyboard shortcut for the script
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (thePrevLayerWidth 0)
	    (theLayerNumber)
	    (theLayers)
	    (theLinkedLayers '())
	    (theBaseTop '())
	    (theBaseLeft '())
    
      )
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber (- (car theLayers) 1))
    (set! theLayers (cadr theLayers))
    
    (while (< theI theLayerNumber)
    	    (set! theCurrentLayer (aref theLayers theI))
    	 
    	 (if (= (car (gimp-item-get-linked theCurrentLayer)) 1)
    	   (begin
    	    ;get top and left offset of the first layer
    	    (unless (number? theBaseLeft)
    	    	    (set! theBaseLeft (car (gimp-drawable-offsets theCurrentLayer)))
    	    	    (set! theBaseTop (cadr (gimp-drawable-offsets theCurrentLayer)))
    	    )
    	    (set! theLinkedLayers (cons theCurrentLayer theLinkedLayers));save the linked layers
    	    (gimp-item-set-linked theCurrentLayer FALSE)
    	    ;(gimp-layer-set-offsets theCurrentLayer
    	    ;    (+ theBaseLeft thePrevLayerWidth) theBaseTop
    	    ;)
    	    ;(set! thePrevLayerWidth (+ (
    	    ;			    car (gimp-drawable-width theCurrentLayer))
    	    ;		            thePrevLayerWidth
    	    ;		            inSpacing
    	    ; 		            ) 
    	    ;)
    	    (when (= 1 (car (gimp-item-is-group inDrawable)))
    	        (gimp-image-reorder-item
    	            inImage
    	            theCurrentLayer
    	            inDrawable
    	            theI
    	        )
    	    )
    	    (display thePrevLayerWidth)
    	    (display "  ")
    	    (newline)
    	   )
    	  )
	    (set! theI (+ theI 1))	    
    )
    ;restore linked layers
    (for-each apply-link theLinkedLayers) ;that for-each is quite convenient indeed
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
    thePrevLayerWidth
))
(define (apply-link inLayer)
	(gimp-item-set-linked inLayer TRUE)
)
      
  (script-fu-register
    "script-fu-move-to-group"                      ;func name
    "Move layers inside group..."                  ;menu label
    "Move linked layers into the selected group layer" ;description
    "Tichomit Mitkov"                              ;author
    "copyright 2013, Tichomit Mitkov"              ;copyright notice
    "November 2, 2013"                             ;date created
    ""                   			   ;image type that the script works on
    SF-IMAGE	   "Image" 	 0
    SF-DRAWABLE	   "Drawable"    0
  )
  (script-fu-menu-register "script-fu-move-to-group" "<Image>/Layer")
