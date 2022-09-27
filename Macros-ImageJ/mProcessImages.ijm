macro "mProcessImages" {
arguments = getArgument();
args = split(arguments,"|");
id = args[0];
workingDir = args[1];
macroDir = args[2];
name = getTitle;
baseNameEnd=indexOf(name, ".nd2");
baseName=substring(name, 0, baseNameEnd);
tiffDir = workingDir + "\\" + "Tiff";   
File.makeDirectory(tiffDir);
tiffName = tiffDir+ "\\" + baseName;
saveAs("tif",tiffName);
imageRDir = workingDir + "\\" + "R_Images";
File.makeDirectory(imageRDir);
imageRName = imageRDir+ "\\" + baseName;
roiDir = workingDir + "\\" + "ROISets";   
File.makeDirectory(roiDir);
roisetName = roiDir+ "\\" + baseName;
resultsDir = workingDir + "\\" + "Results_csv";
File.makeDirectory(resultsDir);
resultsName = resultsDir+ "\\" + baseName;
arguments = tiffDir + "|" + macroDir;
runMacro(macroDir + "\\" + "mProcessCurrentImg.ijm", arguments);
run("Image Expression Parser");
waitForUser("Please select A and B Images to Parse. Click OK when done");
keep_going = true;
x = 0;
while(keep_going){
     windowR = "Image "+x;
     if(isOpen(windowR)){
        keep_going = false;
        selectWindow(windowR);       
     }
     if(x == 100){
       keep_going = false;
       print("ERROR in image: "+name);
     }
     x++;     
}
run("Clear Results");
runMacro(macroDir + "\\" + "mfiresave.ijm" , imageRName);
runMacro(macroDir + "\\" + "mtotalfield.ijm");
runMacro(macroDir + "\\" + "mROIcells.ijm" , roisetName);
runMacro(macroDir + "\\" + "msaveResults.ijm" , resultsName);
}