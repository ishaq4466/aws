Step1: Create an s3 bucket in aws and  host a static website after step 7(*_*)

Step2:upload all the png pics from the "imgAsset" folder to s3 bucket


Step3:Create two lambda fuction in aws which are triggered by the API gateway.

Step4:Upload the python script(lambaFunc) to the lambda fuction

Step5:Get the API address for the lambda fuctions and Paste it in the index.html page so as to trigger the lambda fuctions

Step6:also paste the URL addr from the s3 bucket for Images in the index.html file

Step7:Finally Upload the index.html and error.html to the s3 bucket.

Note:Make sure that all objects in the s3 bucket are made public.

 