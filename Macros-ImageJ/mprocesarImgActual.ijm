macro "mprocesarImgActual" {
argumentos = getArgument();
args = split(argumentos,"|");
tiffDir = args[0];
macroDir = args[1];
title = getTitle();
print("procesando " + title);
run("Split Channels");
ventana1 = "C1-"+ title;
print(ventana1);
if (isOpen(ventana1)) {
	print(ventana1);
	selectWindow(ventana1);
	runMacro(macroDir + "\\" + "mHilo_32bit.ijm");
	print("Hiloready");
	runMacro(macroDir + "\\" + "mROI.ijm", macroDir);
	runMacro(macroDir + "\\" + "mThreshold.ijm");
}
ventana2 = "C2-"+title;
if (isOpen(ventana2)) {
	selectWindow(ventana2);
	run("Close");
}
ventana3 = "C3-"+title;
if (isOpen(ventana3)) {
	selectWindow(ventana3);
	runMacro(macroDir + "\\" + "mHilo_32bit.ijm");
	roiManager("Select", 0);
	roiManager("Measure");
	runMacro(macroDir + "\\" + "msubstract.ijm");
	runMacro(macroDir + "\\" + "mThreshold.ijm"); 
}
}