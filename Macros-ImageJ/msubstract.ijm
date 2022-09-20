macro "msubstract" {
mean = getResult("Mean", nResults-1);
run("Select None");
posicionActual = nResults-1;
print("La media es :" + mean + "y esta en la posicion "+posicionActual);
run("Subtract...", "value="+mean);
print(nResults);
}