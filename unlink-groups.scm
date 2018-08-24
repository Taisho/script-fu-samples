(define (script-fu-unlink-groups inImage inDrawable)
(let* (
	;(script-fu-unlink-groups 1 2)
	;TODO next version must allow automatic position on the next line
	;if image is not enough big to store layers
	;TODO place icon in the toolbox for triggering script
	;TODO assign keyboard shortcut for the script
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (theLayerNumber)
	    (theLayers)
    
      )
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber (- (car theLayers) 1))
    (set! theLayers (cadr theLayers))
    
    (while (< theI theLayerNumber)
    	    (set! theCurrentLayer (aref theLayers theI))
    	 
    	 (if (= (car (gimp-item-get-linked theCurrentLayer)) 1)
    	    (gimp-item-set-linked theCurrentLayer FALSE)
    	  )
	    (set! theI (+ theI 1))	    
    )
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
))
      
  (script-fu-register
    "script-fu-unlink-groups"                      ;func name
    "Unlink all linked layers"                     ;menu label
    "Unlink all linked layers in the main stack"   ;description
    "Tichomit Mitkov"                              ;author
    "copyright 2013, Tichomit Mitkov"              ;copyright notice
    "November 4, 2013"                             ;date created
    ""                   			   ;image type that the script works on
    SF-IMAGE	   "Image" 	 0
    SF-DRAWABLE	   "Drawable"    0
  )
  (script-fu-menu-register "script-fu-unlink-groups" "<Image>/Layer")
