workingDir = getDirectory("Select working directory");
macroDir = workingDir + "\Macros";
nd2Dir = workingDir + "\ND2_images";
nd2List = getFileList(nd2Dir);
for (i=0; i<nd2List.length; i++) {
     if (endsWith(nd2List[i], ".nd2")){
         print(i + ": " + nd2Dir+"\\"+nd2List[i]);
         arguments = "" + i +"|"+ workingDir +"|"+ macroDir;
         open(nd2Dir+"\\"+nd2List[i]);
         waitForUser("About to process image: "+(i+1));
         print(arguments);
         runMacro(macroDir + "\\" + "mProcessImages.ijm", arguments);
         run("Close All"); 
         runMacro(macroDir + "\\" + "mcleanUp.ijm");
     }
}

