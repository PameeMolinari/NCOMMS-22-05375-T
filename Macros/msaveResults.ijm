macro "msaveResults" {
resultsName = getArgument();	
if (nResults==0){
 exit("Results table is empty");
}
path = resultsName +"-Results.csv";
saveAs("Measurements", path);
}