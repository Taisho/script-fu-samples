(define (script-fu-arrange-layers-table inImage inDrawable inSpacing)
(let* (
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (thePrevLayerWidth 0)
	    (theLayerNumber)
	    (theLayers)
	    (theLinkedLayers '())
    
      )
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber (- (car theLayers) 1))
    (set! theLayers (cadr theLayers))
    
    (while (< theI theLayerNumber)
    	    (set! theCurrentLayer (aref theLayers theI))
    	 ;TODO only selected (linked) layers
    	 ;NOTE chained layers are moving together,
    	 ;that's why I get funny results. They must be
    	 ;unchained before any movement and then
    	 ;rechained again
    	 ;TODO work with lists
    	 (if (= (car (gimp-item-get-linked theCurrentLayer)) 1)
    	   (begin
    	    (set! theLinkedLayers (cons theCurrentLayer theLinkedLayers));save the linked layer
    	    (gimp-item-set-linked theCurrentLayer FALSE)
    	    (gimp-layer-set-offsets theCurrentLayer
    	        (+ 10 thePrevLayerWidth) 60
    	    )
    	    (set! thePrevLayerWidth (+ (
    	    			    car (gimp-drawable-width theCurrentLayer))
    	    		            thePrevLayerWidth
    	    		            inSpacing
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
    (for-each apply-link theLinkedLayers) ;that for-each is quite convinient indeed
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
    thePrevLayerWidth
))
(define (apply-link inLayer)
	(gimp-item-set-linked inLayer TRUE)
)
      
  (script-fu-register
    "script-fu-arrange-layers-table"               ;func name
    "Layers in Table..."                           ;menu label
    "Attempts to arrange layers in a table"        ;description
    "Tichomit Mitkov"                              ;author
    "copyright 2013, Tichomit Mitkov"              ;copyright notice
    "November 2, 2013"                             ;date created
    ""                   			   ;image type that the script works on
    SF-IMAGE	   "Image" 0
    SF-DRAWABLE	   "Drawable" 0
    SF-ADJUSTMENT  "Spacing"     '(50 1 1000 1 10 0 1)
                                                ;a spin-button
  )
  (script-fu-menu-register "script-fu-arrange-layers-table" "<Image>/Layer")
