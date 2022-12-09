/**
 * 
 */
$(document).ready(function(e){
	var reg=new RegExp("(,*?)\.(sh|exe|zip|alz)$");
	var maxSize=5242880;
	function checkExtension(fileName,fileSize){
		if(fileSize>maxSize){
			alert("5MB 이하의 파일만 업로드 할 수 있습니다.");
			return false;
		}
		if(reg.test(fileName)){
			alert("해당 파일의 확장자는 업로드 할 수 없습니다.")
			return false;
		}
		return true;
	}
	$('#file_btn').on("click", function(e){
		e.preventDefault();
		var formData=new FormData();
		var inputFile=$("input[name='uploadFile']");
		var files=inputFile[0].files;

		for(var i=0;i<files.length;i++){
			if(!checkExtension(files[i].name,files[i].size)){
				return false;
			}
			formData.append("uploadFile",files[i]);
		}
		$.ajax({
			url:"/uploadAjaxAction",
			processData:false,
			contentType:false,
			data:formData,
			type:"post",
			dataType:'Json',
			success:function(result){
				console.log(result);
				showUploadResult(result);
			}
		})
	})
	
	
	
	
})
function showUploadResult(Arr){
	function showComloadResult(Arr){
		if(!Arr||Arr.length==0){return;}
		var uploadUL=$("#uploadResult ul");
		var str= "";
		$(Arr).each(function(i,obj){
			if(obj.fileType){
				var fileCellPath=encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.fileName+"' data-type='"+obj.fileType+"'><div>"
				str+="<span>"+obj.filename+"</span>"
				str+="<button type='button' class='x' data-file=\'"+fileCellPath+"\' data-type=' '><i class='i'>X</i></button><br>"
				str+="<img src='display?filename="+fileCellPath+"'></div></li>"
			}else{
				var fileCellPath=encodeURIComponent(obj.uploadPath+"/"+obj.uuid+"_"+obj.filename)
				var fileLink=fileCellPath.replace(new RegExp(/\\/g),"/");
				str+="<li data-path='"+obj.uploadPath+"' data-uuid='"+obj.uuid+"' data-filename='"+obj.filename+"' data-type='"+obj.image+"'><div>"
				str+="<span>"+obj.filename+"</span>"
				str+="<button type='button' class='x' data-file=\'"+fileCellPath+"\' data-type='file'><i class='i'>X</i></button><br>"
				str+="<img src='../resources/image/paper-clip.png'></div></li>"
			}
		})
		uploadUL.append(str);
	}
	
}





















