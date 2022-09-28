macro "mfiresave" {
imagenRName = getArgument();
run("Fire");
saveAs("Tiff", imagenRName + "-R.tif");
saveAs("Jpeg", imagenRName + "-R.jpg");
}
