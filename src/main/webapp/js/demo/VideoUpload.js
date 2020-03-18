
	   
	var $list_branchSchoolAttachment = $('#thelist_branchSchoolAttachment'),
	    $btn_branchSchoolAttachment = $('#ctlBtn_branchSchoolAttachment'),
	    state_branchSchoolAttachment = 'pending',
	    uploader_branchSchoolAttachment;
    //初始化Web Uploader
    uploader_branchSchoolAttachment = WebUploader.create({

        // swf文件路径
        //swf: '${projectPath }/js/Uploader.swf',

        // 文件接收服务端。
        server: fileServerUrl + 'UploadServlet',

        // 选择文件的按钮。可选。
        // 内部根据当前运行是创建，可能是input元素，也可能是flash.
        pick: '#picker_branchSchoolAttachment',

        // 不压缩image, 默认如果是jpeg，文件上传前会压缩一把再上传！
        resize: false,
        //fileSingleSizeLimit :10000*1024
    });
 	// 当有文件被添加进队列的时候
    uploader_branchSchoolAttachment.on( 'fileQueued', function( file ) {
        $list_branchSchoolAttachment.append( '<div id="' + file.id + '" class="item">' +
            '<h4 class="info">' + file.name + '</h4>' +
            '<p class="state">等待上传...</p>' +
        '</div>' );
    });
 	// 文件上传过程中创建进度条实时显示。
    uploader_branchSchoolAttachment.on( 'uploadProgress', function( file, percentage ) {
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
    uploader_branchSchoolAttachment.on( 'uploadSuccess', function( file, response ) {
        if(response.state == 'SUCCESS'){
        	$( '#'+file.id ).find('p.state').text('已上传');
        	var str=response.url;
        	$list_branchSchoolAttachment.append('<input type="hidden" name="videoPath" value="'+response.url+'">');
            $list_branchSchoolAttachment.append('<input type="hidden" name="videoImg" value="'+str.split(".")[str.split(".").length-2]+'.png'+'">');
            $list_branchSchoolAttachment.append('<input type="hidden" name="videoTime" value="'+(parseInt((response.videoInfo.hours*3600))+parseInt((response.videoInfo.minutes*60))+parseInt((response.videoInfo.seconds)))+'">');
            $list_branchSchoolAttachment.append('<input type="hidden" name="types" value="0">');
        }else{
        	$( '#'+file.id ).find('p.state').text(response.state);
        }
    });

    uploader_branchSchoolAttachment.on( 'uploadError', function( file ) {
        $( '#'+file.id ).find('p.state').text('上传出错');
    });

    uploader_branchSchoolAttachment.on( 'uploadComplete', function( file ) {
        $( '#'+file.id ).find('.progress').fadeOut();
    });

    uploader_branchSchoolAttachment.on( 'all', function( type ) {
        if ( type === 'startUpload' ) {
            state_branchSchoolAttachment = 'uploading';
        } else if ( type === 'stopUpload' ) {
            state_branchSchoolAttachment = 'paused';
        } else if ( type === 'uploadFinished' ) {
            state_branchSchoolAttachment = 'done';
        }

        if ( state_branchSchoolAttachment === 'uploading' ) {
            $btn_branchSchoolAttachment.text('暂停上传');
        } else {
            $btn_branchSchoolAttachment.text('开始上传');
        }
    });

    $btn_branchSchoolAttachment.on( 'click', function() {
        if ( state_branchSchoolAttachment === 'uploading' ) {
            uploader_branchSchoolAttachment.stop();
        } else {
            uploader_branchSchoolAttachment.upload();
        }
    });