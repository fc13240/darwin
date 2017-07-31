var rootPath = getRootPath();

document.write('<script src="'+rootPath+'modal.js"></script>');
document.write('<script src="'+rootPath+'hdfsPath.js"></script>');
document.write('<script src="'+rootPath+'selectChoice.js"></script>');
document.write('<script src="'+rootPath+'tableSet.js"></script>');
document.write('<script src="'+rootPath+'twotableSet.js"></script>');
document.write('<script src="'+rootPath+'ui-bootstrap-tpls-0.13.0.js"></script>');
document.write('<script src="'+rootPath+'colSeparator.js"></script>');
document.write('<script src="'+rootPath+'datacleanSeparator.js"></script>');
document.write('<script src="'+rootPath+'storeSeparator.js"></script>');
document.write('<script src="'+rootPath+'cleanmodal.js"></script>');




document.close();

function getRootPath() {
      var scripts = document.getElementsByTagName("script"); 
	__FILE__ = scripts[scripts.length - 1].getAttribute("src");
	return __FILE__.substr( 0, __FILE__.lastIndexOf('/') + 1 );
}