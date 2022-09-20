macro "mROI" {
macroDir = getArgument();
setTool("oval");
keep_going = true;
while (keep_going) {
	run("Clear Results");
    waitForUser("Please select oval point for 1 Region Of Interest. Click OK when done");
    run("Measure");
	Dialog.create("Instructions");
	Dialog.addCheckbox("Keep going?", true);	
	Dialog.show();
	keep_going = Dialog.getCheckbox;
}	
roiManager("Add");
run("Select None");
runMacro(macroDir + "\\" + "msubstract.ijm");
}