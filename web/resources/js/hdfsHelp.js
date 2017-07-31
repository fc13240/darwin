/*!
      
 */
var HdfsHelp = function(params){

    function upload(){
        //$("uploadBtn").click(function(){

        //});

        var zTree = $.fn.zTree.getZTreeObj("treeDemo2");
        var nodes = zTree.getSelectedNodes();
        console.log(nodes);
        if(nodes.length==0){
            alert("请选择上传的目录！");
            return;
        }

        var K = params.K;

        var uploadbutton = K.uploadbutton({
            button : K('#uploadButton')[0],
            fieldName : 'imgFile',
            url : '/resources/kindeditor-4.1.10/jsp/upload_json.jsp?dir=file&dscDir='+nodes.hdfsPath,
            afterUpload : function(data) {
                console.log(data);
                if (data.error === 0) {
                    var url = K.formatUrl(data.url, 'absolute');
                    K('#url').val(url);
                    alert("上传成功!");
                } else {
                    alert(data.message);
                }
            },
            afterError : function(str) {
                alert('自定义错误信息: ' + str);
            }
        });
        uploadbutton.fileBox.change(function(e) {
            uploadbutton.submit();
        });
    }

    function newFile(){
        
    }

    return {
        upload:upload,
        newFile:newFile
    }
}