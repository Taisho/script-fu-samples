(define (script-fu-move-layers inImage inDrawable inSpacing)
(let* (
		;TODO get list of layers (of the image)
		;	gimp-item-get-children
	    ;(theMatrix)
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (theLayers)
	    (theLayerNumber)
	    
      );end of our local variables
    ;TODO get current image
    ;	gimp-image-getlayers
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber (car theLayers))
    (set! theLayers (cadr theLayers)); now we have layers only
    
    (while (< theI theLayerNumber)
    	    ;`car` on theLayers returns our current element
    	    ;TODO change offset of the layer
    	    (set! theCurrentLayer (aref theLayers theI))
    	    
    	    ;(gimp-drawable-offset (car theLayers)
    	    	    ;(aref (cadr (gimp-image-get-layers 1)) 1)
    	    	    ;for the error. Since the second argument is an array
    	    	    ;not a regular list
    	    ;	    		   FALSE
    	   ; 	    		   OFFSET-BACKGROUND
    	    	    		   ;TODO work out better offsets
    	    ;	    		   10 60
    	    ;)
    	    ;gimp-layer-translate
    	    ;gimp-layer-set-offsets
    	    (gimp-layer-translate theCurrentLayer
    	    	    		   10 60
    	    	    		   ;TODO place each next to the other
    	    )
	    (set! theI (+ theI 1))	    
    )
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
))
      
  (script-fu-register
    "script-fu-move-layers"                        ;func name
    "Move Layers"                                  ;menu label
    "Attempts to arrange layers in a table"        ;description
    "Tichomit Mitkov"                              ;author
    "copyright 2013, Tichomit Mitkov"              ;copyright notice
    "November 2, 2013"                             ;date created
    ""                     ;image type that the script works on
    SF-IMAGE	   "Image" 0
    SF-DRAWABLE	   "Drawable" 0
    SF-ADJUSTMENT  "Spacing"     '(50 1 1000 1 10 0 1)
                                                ;a spin-button
  )
  (script-fu-menu-register "script-fu-move-layers" "<Image>/Image/Move Layers")
