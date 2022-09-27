macro "mProcessCurrentImg" {
arguments = getArgument();
args = split(arguments,"|");
tiffDir = args[0];
macroDir = args[1];
title = getTitle();
print("Processing " + title);
run("Split Channels");
window1 = "C1-"+ title;
print(window1);
if (isOpen(window1)) {
	print(window1);
	selectWindow(window1);
	runMacro(macroDir + "\\" + "mHilo_32bit.ijm");
	print("Hiloready");
	runMacro(macroDir + "\\" + "mROI.ijm", macroDir);
	runMacro(macroDir + "\\" + "mThreshold.ijm");
}
window2 = "C2-"+title;
if (isOpen(window2)) {
	selectWindow(window2);
	run("Close");
}
window3 = "C3-"+title;
if (isOpen(window3)) {
	selectWindow(window3);
	runMacro(macroDir + "\\" + "mHilo_32bit.ijm");
	roiManager("Select", 0);
	roiManager("Measure");
	runMacro(macroDir + "\\" + "msubstract.ijm");
	runMacro(macroDir + "\\" + "mThreshold.ijm"); 
}
}