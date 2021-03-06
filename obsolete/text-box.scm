(define (script-fu-text-box inText inFont inFontSize inTextColor)
(let* (
		(theImageWidth 10)
		(theImageHeight 10)
		(theImage (car
				(gimp-image-new
				 theImageWidth
				 theImageHeight
				 RGB
				)
			  )
		)
		(theText)
		(theLayer (car
				(gimp-layer-new
				 theImage
				 theImageWidth
				 theImageHeight
				 RGB-IMAGE
				 "layer 1"
				 100
				 NORMAL
				)
			  )
		)
      );end of our local variables
      (gimp-image-add-layer theImage theLayer 0);add the layer to the image
      (gimp-context-set-background '(255 255 255))
      (gimp-context-set-foreground inTextColor)
      (gimp-drawable-fill theLayer BACKGROUND-FILL)
      (set! theText
      	      	    (car
      	      	    	 (gimp-text-fontname
      	      	    	  theImage theLayer
      	      	    	  0 0
      	      	    	  inText
      	      	    	  0
      	      	    	  TRUE
      	      	    	  inFontSize PIXELS
      	      	    	 "Sans")
      	      	    )
      )
     (set! theImageWidth (car (gimp-drawable-width theText)))
     (set! theImageHeight (car (gimp-drawable-height theText)))
     (gimp-image-resize theImage theImageWidth theImageHeight 0 0)
     (gimp-layer-resize theLayer theImageWidth theImageHeight 0 0)
     (gimp-display-new theImage);display results
))
      
  (script-fu-register
    "script-fu-text-box"                        ;func name
    "Text Box"                                  ;menu label
    "Creates a simple text box, sized to fit\
      around the user's choice of text,\
      font, font size, and color."              ;description
    "Michael Terry"                             ;author
    "copyright 1997, Michael Terry;\
      2009, the GIMP Documentation Team"        ;copyright notice
    "October 27, 1997"                          ;date created
    ""                     ;image type that the script works on
    SF-STRING      "Text"          "Text Box"   ;a string variable
    SF-FONT        "Font"          "Charter"    ;a font variable
    SF-ADJUSTMENT  "Font size"     '(50 1 1000 1 10 0 1)
                                                ;a spin-button
    SF-COLOR       "Color"         '(0 0 0)     ;color variable
  )
  (script-fu-menu-register "script-fu-text-box" "<Image>/File/Create/Text")
