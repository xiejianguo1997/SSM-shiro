(function($) {
	'use strict';
	//备份jquery的ajax方法  
    var _ajax=$.ajax;  
    //重写jquery的ajax方法  
    $.ajax=function(opt){  
        //备份opt中error和success方法  
        var fn = {  
            error:function(XMLHttpRequest, textStatus, errorThrown){},  
            success:function(data, textStatus){}  
        };
        if(opt.error){  
            fn.error=opt.error;  
        }  
        if(opt.success){  
            fn.success=opt.success;  
        }  
        //扩展增强处理  
        var _opt = $.extend(opt,{  
            error:function(XMLHttpRequest, textStatus, errorThrown){ 
            	parent.layer.alert('网络错误,请稍候重试',{icon: 2});
                //错误方法增强处理  
                fn.error(XMLHttpRequest, textStatus, errorThrown);  
            },  
            success:function(data, textStatus){ 
            	//如果不是json对象,则转换为json对象
            	if(typeof(data)!="object"){
            		data = $.parseJSON(data);
            	} 
            	//如果是失败的情况,则提示错误消息
            	if(data.resultInfo && data.resultInfo.success == false){
            		parent.layer.alert(data.resultInfo.message,{icon: 2});
            		if(data.resultInfo.messageCode == 106){
            			window.location.href= '/driverConsumptionBack/logoutSkip.action';
            		}
            	}
                //成功回调方法增强处理  
                fn.success(data, textStatus);  
            }  
        });  
        return _ajax(_opt);  
    };  
    
    //form表单数据转成json对象
    $.fn.serializeJson=function(){  
        var serializeObj={};  
        var array=this.serializeArray();  
        $(array).each(function(){  
            if(serializeObj[this.name]){  
                if($.isArray(serializeObj[this.name])){  
                    serializeObj[this.name].push(this.value);  
                }else{  
                    serializeObj[this.name]=[serializeObj[this.name],this.value];  
                }  
            }else{  
                serializeObj[this.name]=this.value;   
            }  
        });  
        return serializeObj;  
    }; 
})(jQuery);


/**
 * 根据key获取解析到的字典数据
 * @param dicData 字典数据
 * @param dickey 字典中的key
 */
function analysisDicData(dicData,dickey){
	
	var result="数据未查到";//默认没有解析到数据
	//处理数据
	var tempData=dicData.replace('{', "").replace('}', "").replace(/ /g, "").split(",");

	var newDic=new Array();//最后存数据的字典
	
	//解析数据存放字典中
	for ( var key in tempData) {
		var smallArray=tempData[key].split("=");
		newDic[smallArray[0]]=smallArray[1];
	}
	
	//判断是否解析到数据
	if(newDic[dickey]){
		result=newDic[dickey];
	}
	
	return result; 
}
