(define (script-fu-move-layers-by-side inImage inDrawable inSpacing)
(let* (
	    (theI 0);iterator for our loop
	    (theCurrentLayer -1); the layer we are editing inside the loop
	    (thePrevLayerWidth 0)
	    (theLayers)
	    (theLayerNumber)
	    
      )
    (gimp-image-undo-group-start inImage)
    (set! theLayers (gimp-image-get-layers inImage))
    (set! theLayerNumber (- (car theLayers) 1))
    (set! theLayers (cadr theLayers))
    
    (while (< theI theLayerNumber)

    	    (set! theCurrentLayer (aref theLayers theI))
    	    ;(if (= theI 0)
    	        (gimp-layer-set-offsets theCurrentLayer
    	        (+ 10 thePrevLayerWidth)
    	        60)
    	        ;else
    	        ;()
    	    ;)
    	    (set! thePrevLayerWidth (+ (
    	    			    car (gimp-drawable-width theCurrentLayer))
    	    		            thePrevLayerWidth
    	    		            inSpacing
    	    		            ;TODO table-like behavour
    	    		            ;TODO only selected (linked) layers
    	    		            ) 
    	    )
	    (set! theI (+ theI 1))	    
    )
    (gimp-image-undo-group-end inImage)
    (gimp-displays-flush)
    thePrevLayerWidth
))
      
  (script-fu-register
    "script-fu-move-layers-by-side"                ;func name
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
  (script-fu-menu-register "script-fu-move-layers-by-side" "<Image>/Image")
