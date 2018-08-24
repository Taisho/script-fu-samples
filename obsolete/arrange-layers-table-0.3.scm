(define (script-fu-arrange-layers-table
	inImage inDrawable inColumnSpacing inRowSpacing inFitLayer inFitImage)
(let* (
		;(script-fu-arrange-layers-table 1 2 50 30 TRUE FALSE)
	;TODO next version must allow automatic position on the next line
	;if image is not enough big to store layers
	;TODO place icon in the toolbox for triggering script
	;TODO assign keyboard shortcut for the script
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (theRowWidth 0)
	    (theLayerNumber)
	    (theLayers)
	    (theLinkedLayers '())
	    (theBaseTop '())
	    (theBaseLeft '())
    
      )
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber  (car theLayers) )
    (set! theLayers (cadr theLayers))
    
    (while (< theI theLayerNumber)
    	    (set! theCurrentLayer (aref theLayers theI))
    	 
    	 (if (= (car (gimp-item-get-linked theCurrentLayer)) 1)
    	   (begin
    	    ;TODO get width of the active layer
    	    ;TODO if flag is set AND rowWidth > layerWidth; set theBaseTop one layer down
    	    
    	    ;get top and left offset of the first layer
    	    (unless (number? theBaseLeft)
    	    	    (set! theBaseLeft (car (gimp-drawable-offsets theCurrentLayer)))
    	    	    (set! theBaseTop (cadr (gimp-drawable-offsets theCurrentLayer)))
    	    )
    	    (set! theLinkedLayers (cons theCurrentLayer theLinkedLayers));save the linked layers
    	    (gimp-item-set-linked theCurrentLayer FALSE)
    	    
    	    (gimp-layer-set-offsets theCurrentLayer
    	        (+ theBaseLeft theRowWidth) theBaseTop
    	    )
    	    ;(display "base top ")
    	    ;(display theBaseTop)
    	    ;(newline)
    	    (set! theRowWidth (+ (
    	    			    car (gimp-drawable-width theCurrentLayer))
    	    		            theRowWidth
    	    		            inColumnSpacing
    	    		            ) 
    	    )
    	    (cond ((equal? TRUE inFitImage)
    	    	    (display "fit image ")
    	    	    (when (> theRowWidth (car (gimp-image-width inImage)))
    	    	    	    (set! theBaseTop (+ inRowSpacing
    	    	    	    		 (car (gimp-drawable-height theCurrentLayer))
    	    	    	    		 theBaseTop
    	    	    	    ))
    	    	    	    (set! theRowWidth 0)
    	    	    ))
    	    	  ((equal? TRUE inFitLayer)
    	    	    (display "fit layer ")
    	    	    (when (> theRowWidth (car (gimp-drawable-width inDrawable)))
    	    	    	    (display "set! baseTop ")
    	    	    	    (display theBaseTop)
    	    	    	    (set! theBaseTop (+ inRowSpacing
    	    	    	    		 (car (gimp-drawable-height theCurrentLayer))
    	    	    	    		 theBaseTop
    	    	    	    ))
    	    	    	    (set! theRowWidth 0)
    	    	    	    (display " goes ")
    	    	    	    (display theBaseTop)
    	    	    )(newline))
    	    )
    	   )
    	  )
    	 
	    (set! theI (+ theI 1))	    
    )
    ;restore linked layers
    (for-each apply-link theLinkedLayers) ;that for-each is quite convenient indeed
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
    theRowWidth
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
    SF-ADJUSTMENT  "Column Spacing"           	 '(50 1 1000 1 10 0 1)
    SF-ADJUSTMENT  "Row Spacing"           	 '(30 1 1000 1 10 0 1)
    SF-TOGGLE	   "Fit inside active layer"   			TRUE
    SF-TOGGLE	   "Fit inside image (overrides above option)"	FALSE
                                                
  )
  (script-fu-menu-register "script-fu-arrange-layers-table" "<Image>/Layer")
