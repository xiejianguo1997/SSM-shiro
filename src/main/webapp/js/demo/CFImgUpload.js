    var $list_imgUrl = $('#thelist_imgUrl'),
	    $btn_imgUrl = $('#ctlBtn_imgUrl'),
	    state_imgUrl = 'pending',
	    uploader_imgUrl;
    //初始化Web Uploader
    uploader_imgUrl = WebUploader.create({

        // swf文件路径
        //swf: '${projectPath }/js/Uploader.swf',

        // 文件接收服务端。
        server: fileServerUrl + 'UploadServlet',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: {id:'#picker_imgUrl',multiple: false},

        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false,
        // 配置压缩的图片的选项。如果此选项为false, 则图片在上传前不进行压缩。
        compress :false,
        accept:{
            title: 'Images',
            extensions: 'gif,jpg,jpeg,bmp,png',
            mimeTypes: 'image/*'
        },
        fileSingleSizeLimit :10000*1024
    });
 	// 当有文件被添加进队列的时候
    uploader_imgUrl.on( 'fileQueued', function( file ) {
        $list_imgUrl.append( '<div id="' + file.id + '" class="item">' +
            '<h4 class="info">' + file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
        '</div>' );
    });
 	// 文件上传过程中创建进度条实时显示。
    uploader_imgUrl.on( 'uploadProgress', function( file, percentage ) {
        var $li = $( '#'+file.id ),
            $percent = $li.find('.progress .progress-bar');

        // 避免重复创建
        if ( !$percent.length ) {
            $percent = $('<div class="progress progress-striped active">' +
            			'<div class="progress-bar" role="progressbar" style="width: 0%"><span></span></div>' +
            			'</div>').appendTo( $li ).find('.progress-bar');
        }

        $li.find('p.state').text('上传中');

        $percent.css( 'width', percentage * 100 + '%' );
        $percent.find('span').text( (percentage * 100).toFixed(2) + '%' );
    });
 	//文件成功、失败处理
    uploader_imgUrl.on( 'uploadSuccess', function( file, response ) {
        if(response.state == 'SUCCESS'){
        	$( '#'+file.id ).find('p.state').text('已上传');
        	$("#imgUrl").val(response.url);
			$("#img_imgUrl").attr("src",fileServerUrl + response.url).show();
        }else{
        	$( '#'+file.id ).find('p.state').text(response.state);
        }
    });

    uploader_imgUrl.on( 'uploadError', function( file ) {
        $( '#'+file.id ).find('p.state').text('上传出错');
    });

    uploader_imgUrl.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').fadeOut();
    });

    uploader_imgUrl.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state_imgUrl = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state_imgUrl = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state_imgUrl = 'done';
        }

        if ( state_imgUrl === 'uploading' ) {
            $btn_imgUrl.text('暂停上传');
        } else {
            $btn_imgUrl.text('开始上传');
        }
    });

    $btn_imgUrl.on( 'click', function() {
        if ( state_imgUrl === 'uploading' ) {
            uploader_imgUrl.stop();
        } else {
            uploader_imgUrl.upload();
        }
    });