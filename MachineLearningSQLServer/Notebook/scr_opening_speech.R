#  Using Windows Speech API...

library("RDCOMClient")
voice1 <- COMCreate("SAPI.SpVoice")

speech <- "The R programming language is 
a popular data science language that excels in statistics.  
R does the work for you. It features data manipulation,
machine learning, and amazing visualizations.  
Lets get going!!!"

# $speaker.Speak($speakit, 1 )
voice1$Speak(speech,1)