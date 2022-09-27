macro "msubstract" {
mean = getResult("Mean", nResults-1);
run("Select None");
currentPosition = nResults-1;
print("The mean is :" + mean + " and it is on the position " + currentPosition);
run("Subtract...", "value="+mean);
print(nResults);
}