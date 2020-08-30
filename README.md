# Image-Processing

   Hello everyone!

   My name is Xuchen and these are my image processing programs.

   All programs are written in Matlab.

   Some descriptions are in followed.

   I hope these programs can help you.

   Best wishes.





**Descriptions**

***Grayscale_image_processing.m***

    Figure 1: get the grayscale image.
   
    Figute 2: change the value of grayscale about the image. 


***specific_filer.m***

    8 specific filers for image processing

***FT processing.m***

    get the FT result of a picture
    
***Color_Image_Processing and Canny_Edge_Detect***    
   
   **Input and Output**
   
   Input:mypc.jpg
     
     <dimensions of 800*600>
     <resolution are 96 dpi>
     <bit depth is 24>
     
     
    
  
   Output: 
          
	  Figure1       <Normalized Gray Histogram >	  
	  Figure2       <HSL image> Color Image Processing
          Figure22      <6 pictures about Canny processing> Edge Detecting

***Key processing steps about Color_Image_Processing and Canny_Edge_Detect***

Color Image Processing:
	 
	 Step1: Seperate Red Green and Blue of original picture
	 Step2: calculation about i,s,h,θ(hue, saturation,lightness)
 	 Step3： Change value andCombine to a new HSL image.
   
Canny Edge Detecting:

	Step1: Gaussian filter processing
	Step2: Partial derivative computing
	Step3: Gradient magnitude computing(Critical Section)
	Step4: Double threshold algorithm and connects edges
   
