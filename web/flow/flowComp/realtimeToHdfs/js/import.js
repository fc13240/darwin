var rootPath = getRootPath();

document.write('<script src="'+rootPath+'app.js"></script>');
document.write('<script src="'+rootPath+'filters/filters.js"></script>');
document.write('<script src="'+rootPath+'services/config.js"></script>');
document.write('<script src="'+rootPath+'services/utils.js"></script>');

document.write('<script src="'+rootPath+'controllers/compCtrl.js"></script>');
document.write('<script src="'+rootPath+'controllers/configFieldCtrl.js"></script>');


document.write('<script src="'+rootPath+'directives/sourceSet.js"></script>');

document.write('<script src="'+rootPath+'directives/storeSet.js"></script>');
/*document.write('<script src="'+rootPath+'directives/hdfsSource.js"></script>');*/
document.write('<script src="'+rootPath+'directives/kafkaSource.js"></script>');

document.write('<script src="'+rootPath+'directives/searchStore.js"></script>');
document.write('<script src="'+rootPath+'directives/configSet.js"></script>');




document.close();

function getRootPath() {
      var scripts = document.getElementsByTagName("script"); 
	__FILE__ = scripts[scripts.length - 1].getAttribute("src");
	return __FILE__.substr( 0, __FILE__.lastIndexOf('/') + 1 );
}