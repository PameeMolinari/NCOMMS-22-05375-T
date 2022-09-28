macro "mThreshold" {
setAutoThreshold("Default dark");
//run("Threshold...");
setAutoThreshold("Otsu dark");
run("NaN Background");
}
