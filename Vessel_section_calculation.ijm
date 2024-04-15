//CHANGE FILE NAME
t="write_file_name";
t1=t+"_0"
rename(t1);
run("Channels Tool...");
run("Brightness/Contrast...");
waitForUser("Action required", "Select a slice in which the valve is visible");
Stack.getPosition(ch, sl1, fr);	
selectWindow(t1);
run("Duplicate...","duplicate slices=" +sl1);
run("RGB Color");
waitForUser("Action required", "You will be asked to Rotate.");
run("Rotate... ");
selectWindow(t1);
waitForUser("Action required", "Select duplicate the hyperstack");
run("Duplicate...")
run("Rotate... ");
rename(t);

//reslice from top
run("Reslice [/]...", "output=0.14 start=Top avoid");
run("Z Project...", "stop=600 projection=[Max Intensity]");
run("RGB Color");

//adjust angle on max pro
waitForUser("Action required", "You will be asked to Rotate.");
run("Rotate... ");

//Use same angle as Max Project
selectWindow("Reslice of " +t);
run("Rotate... ");
run("Reslice [/]...", "output=0.14 start=Left avoid");
run("Orthogonal Views");
waitForUser("Action required", "Click to confirm the position of interest");
Stack.getPosition(ch, sl, fr);
selectWindow("Reslice of Reslice of " +t);
resetMinAndMax(); 
Stack.getPosition(ch, sl, fr);	
a=sl-2
b=sl+2
run("Duplicate...", "duplicate slices=a-b");
run("Z Project...", "projection=[Max Intensity]");
run("Remove Overlay");

//save the image on with the quantification will be run
s=t+" slice"
rename(s);
path= getDir("path/to/folder");
waitForUser("Action required", "Select folder");
saveAs("Tiff", path+s);
s=t+" slice"
selectWindow(s+".tif");
run("Duplicate...", "duplicate channels=2");
run("Threshold...")
waitForUser("Action required", "Click to confirm the thresholding");
run("Convert to Mask");
setTool("Pencil Tool");
waitForUser("Action required", "Close the holes");
run("Fill Holes");
setTool("wand");
waitForUser("Action required", "SELECT AREA")
//select the area of the valve
run("Measure");
String.copyResults();
m=t+"masked"
rename(m);
saveAs("Tiff", path+m);
waitForUser("Action required", "Close all images")
close("*");
