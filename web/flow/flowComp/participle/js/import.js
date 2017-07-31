var rootPath = getRootPath();

document.write('<script src="'+rootPath+'app.js"></script>');
document.write('<script src="'+rootPath+'services/config.js"></script>');
document.write('<script src="'+rootPath+'services/utils.js"></script>');//其实可以考虑复用participle下的utils

document.write('<script src="'+rootPath+'controllers/compCtrl.js"></script>');
document.write('<script src="'+rootPath+'controllers/statCtrl.js"></script>');//数据统计组件特有的ctronller

document.write('<script src="'+rootPath+'directives/sourceSet.js"></script>');//其实可以考虑复用participle下的sourceSet
document.write('<script src="'+rootPath+'directives/hdfsSource.js"></script>');//其实可以考虑复用participle下的

document.write('<script src="'+rootPath+'directives/configSet.js"></script>');

document.write('<script src="'+rootPath+'directives/storeSet.js"></script>');
document.write('<script src="'+rootPath+'directives/hdfsStore.js"></script>');

document.close();

function getRootPath() {
      var scripts = document.getElementsByTagName("script"); 
	__FILE__ = scripts[scripts.length - 1].getAttribute("src");
	return __FILE__.substr( 0, __FILE__.lastIndexOf('/') + 1 );
}