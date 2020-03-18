    var $list = $('#thelist'),
	    $btn = $('#ctlBtn'),
	    state = 'pending',
	    uploader;
    //初始化Web Uploader
    uploader = WebUploader.create({

        // swf文件路径
        //swf: '${projectPath }/js/Uploader.swf',

        // 文件接收服务端。
        server: fileServerUrl + 'UploadServlet',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker',

        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false,
        fileSingleSizeLimit :10000*1024
    });
 	// 当有文件被添加进队列的时候
    uploader.on( 'fileQueued', function( file ) {
        $list.append( '<div id="' + file.id + '" class="item">' +
            '<h4 class="info">'+ $("#attchmentType").find("option:selected").text() +"："+ file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
        '</div>' );
    });
 	// 文件上传过程中创建进度条实时显示。
    uploader.on( 'uploadProgress', function( file, percentage ) {
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
    uploader.on( 'uploadSuccess', function( file, response ) {
        if(response.state == 'SUCCESS'){
        	$( '#'+file.id ).find('p.state').text('已上传');
        	$list.append('<input type="hidden" name="filePaths" value="'+response.url+'">');
            $list.append('<input type="hidden" name="fileNames" value="'+response.originalName+'">');
            $list.append('<input type="hidden" name="types" value="'+$("#attchmentType").val()+'">');
        }else{
        	$( '#'+file.id ).find('p.state').text(response.state);
        }
    });

    uploader.on( 'uploadError', function( file ) {
        $( '#'+file.id ).find('p.state').text('上传出错');
    });

    uploader.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').fadeOut();
    });

    uploader.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state = 'done';
        }

        if ( state === 'uploading' ) {
            $btn.text('暂停上传');
        } else {
            $btn.text('开始上传');
        }
    });

    $btn.on( 'click', function() {
        if ( state === 'uploading' ) {
            uploader.stop();
        } else {
            uploader.upload();
        }
    });