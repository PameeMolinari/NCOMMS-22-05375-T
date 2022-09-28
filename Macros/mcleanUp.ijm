macro "mcleanUp" {
selectWindow("Results"); 
run("Close");
selectWindow("Log");
run("Close" );
selectWindow("ROI Manager");
run("Close");
}
