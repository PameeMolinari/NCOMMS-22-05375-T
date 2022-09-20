macro "mProcesarImagenes" {
argumentos = getArgument();
args = split(argumentos,"|");
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
imagenRDir = workingDir + "\\" + "R_Images";
File.makeDirectory(imagenRDir);
imagenRName = imagenRDir+ "\\" + baseName;
roiDir = workingDir + "\\" + "ROISets";   
File.makeDirectory(roiDir);
roisetName = roiDir+ "\\" + baseName;
resultsDir = workingDir + "\\" + "Results_csv";
File.makeDirectory(resultsDir);
resultsName = resultsDir+ "\\" + baseName;
argumentos = tiffDir + "|" + macroDir;
runMacro(macroDir + "\\" + "mprocesarImgActual.ijm", argumentos);
run("Image Expression Parser");
waitForUser("Please select A and B Images to Parse. Click OK when done");
keep_going = true;
x = 0;
while(keep_going){
     ventanaR = "Image "+x;
     if(isOpen(ventanaR)){
        keep_going = false;
        selectWindow(ventanaR);       
     }
     if(x == 100){
       keep_going = false;
       print("ERROR en imagen: "+name);
     }
     x++;     
}
run("Clear Results");
runMacro(macroDir + "\\" + "mfiresave.ijm" , imagenRName);
runMacro(macroDir + "\\" + "mtotalfield.ijm");
runMacro(macroDir + "\\" + "mROIcells.ijm" , roisetName);
runMacro(macroDir + "\\" + "msaveResults.ijm" , resultsName);
}