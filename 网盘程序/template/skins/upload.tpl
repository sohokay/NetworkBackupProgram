<link rel="stylesheet" type="text/css" href="/packs/plupload/css/webuploader.css">
<style>
	#upload_box{width:90%;margin-top:20px;border: 1px dashed #999;box-sizing: border-box;}
    h5,p{margin: 10px 5px;}
	.btns{padding: 10px 20px;position: relative;}
	.bord{border : 1px solid #3bb4f2;border-radius: 5px;}
	#picker{width:100px;height:48px;}
	#ctlBtn{position: absolute;top:10px;right:20px;width: 86px;height:42px;cursor: pointer;line-height: 42px;font-size: 14px;border-radius: 3px;background-color: #e6e6e6;color: #444;text-align: center;background-color: #e6e6e6;}
	#thelist{margin: 10px 20px;padding: 5px;}
	.item{border-bottom: 1px dashed #999;}
	.progress-bar{height:10px;margin-bottom:6px;}
</style>
<div class="page-content-wrapper">
    <div class="page-content">
        <div class="row" >
            <div class="col-md-12">
                <div class="portlet light portlet-fit portlet-form bordered">
                    <div class="portlet-title">
                        <div class="caption">
                            <i class="fa fa-cloud-upload"></i>
                            <span class="caption-subject font-blue sbold uppercase">上传视频 &nbsp;</span>
                        </div>
                    </div>
                    <div class="portlet-body">
                        <div class="form-horizontal">
                            <div class="form-body" style="min-height: 700px;">

                 				<div class="form-group">
                                    <label class="control-label col-md-3">上传服务器
                                    	<span class="required" aria-required="true"></span>
                                    </label>
                                	<div class="col-md-6">
                              			<select id="fid" name="fid" class="bs-select form-control" title="默认服务器...">
	                                        <?php
	                                        foreach($server as $row){
	                                            $check = $row->id == $fid ? ' selected' : '';
                                                echo '<option value="'.$row->id.'"'.$check.'>'.$row->name.'</option>';
	                                        }
	                                        ?>
                                		</select>
                                	</div>
                            	</div>
                            	<div class="form-group">
                                  	<label class="control-label col-md-3">视频分类
                                        <span class="required" aria-required="true"> * </span>
                                    </label>
                                    <div class="col-md-6">
                                        <div class="md-radio-inline">
									<?php
                                        foreach($class as $row){
                                        $check = $row->id == $cid ? ' checked=""' : '';
                                        echo '
                                            <div class="md-radio">
                                                <input type="radio" id="'.$row->id.'" name="cid" class="md-radiobtn" value="'.$row->id.'"'.$check.'>
                                                <label for="'.$row->id.'">
                                                    <span></span>
                                                    <span class="check"></span>
                                                    <span class="box"></span> '.$row->name.'
                                                </label>
                                            </div>';
                                        }
                                    ?>
                                        </div>
                                    </div>
                                </div>
                 				<div class="form-group">
                                    <label class="control-label col-md-3">私人分类
                                    	<span class="required" aria-required="true"></span>
                                    </label>
                                	<div class="col-md-6">
                              			<select id="mycid" name="mycid" class="bs-select form-control" title="请选择私人分类...">
	                                        <?php
	                                        foreach($myclass as $row){
	                                            $check = $row->id == $mycid ? ' selected' : '';
                                                $arr = $this->csdb->get_select('myclass','*',array('fid'=>$row->id),'id ASC',100);
                                                echo '<option value="'.$row->id.'"'.$check.'>├&nbsp;'.$row->name.'</option>';
                                                foreach($arr as $row2){
                                                    $che2 = $row2->id == $mycid ? ' selected' : '';
                                                    echo '<option value="'.$row2->id.'"'.$che2.'>&nbsp;&nbsp;&nbsp;&nbsp;├&nbsp;'.$row2->name.'</option>';
                                                }
	                                        }
	                                        ?>
                                		</select>
                                	</div>
                            	</div>
								<div class="form-group" style="max-width: 980px;margin: 0 auto;">
									<div id="upload_box">
										<div id="uploader" class="wu-example">
										    <!--用来存放文件信息-->
										    <div class="btns">
										        <div id="picker">选择文件</div>
										        <div id="ctlBtn">开始上传</div>
										    </div>
										    <div id="thelist"></div>
										</div> 
									</div>
								</div>
                    		</div>
                        </div>
                	</div>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript" src="/packs/plupload/js/webuploader.js"></script>
<script type="text/javascript">
var uplink = '<?=links('upload')?>';
var cid = <?=$cid?>,mycid = <?=$mycid?>,fid = <?=$fid?>;
$(document).ready(function() {
	$('#a1').addClass('active');
	$('.md-radio').click(function() {
		cid = $(this).children('input').val();
		window.location.href = uplink+'?cid='+cid+'&fid='+fid+'&mycid='+mycid;
	});
	$("#mycid").change(function(){
		mycid = $(this).val();
		window.location.href = uplink+'?cid='+cid+'&fid='+fid+'&mycid='+mycid;
	});
	$("#fid").change(function(){
		fid = $(this).val();
		window.location.href = uplink+'?cid='+cid+'&fid='+fid+'&mycid='+mycid;
	});
	$('#picker').click(function() {
		if(cid == 0){
			layer.msg('请先选择视频分类',{icon:2});
			return false;
		}
	});
});
var upmsg = 0;
var uploader = WebUploader.create({
	swf: '/packs/plupload/js/Uploader.swf',
	server: '<?=$saveurl?>?key=<?=$key?>',
	pick: '#picker',
	chunked: true,    
	chunkSize : 2*1024*1024,
	fileVal: 'video',
	accept: {
		title: '视频文件上传',
		extensions: '<?php echo implode(',',array_filter(explode('|', Up_Ext)));?>',
		//mimeTypes: 'video/*,audio/*,application/*'
	},
	fileNumLimit: 1000,
	fileSizeLimit: 50000 * 1024 * 1024,
	fileSingleSizeLimit: 50000 * 1024 * 1024
});
uploader.on( 'fileQueued', function( file ) {
	$('#thelist').append( '<div id="' + file.id + '" class="item">' +
		'<h5 class="info">' + file.name + '</h5>' +
		'<p class="state" style="color:#f90">等待上传...</p>' +
	'</div>' );
	$('#thelist').addClass('bord');
});

$('#ctlBtn').click(function(event) {
	if(cid == 0){
		layer.msg('没有选择视频分类，无法上传~',{icon:2});
		return false;
	}
	uploader.upload();
	uploader.on( 'uploadProgress', function( file, percentage ) {
		var $li = $( '#'+file.id ),
			$percent = $li.find('.progress .progress-bar');
		if ( !$percent.length ) {
			$percent = $('<div class="progress progress-striped active">' +
			  '<div class="progress-bar" role="progressbar" style="width: 0%;background-color:#666;">' +
			  '</div>' +
			'</div>').appendTo( $li ).find('.progress-bar');
		}
		$li.find('p.state').html('<font color=blue>上传中...</font>');
		$percent.css( 'width', percentage * 100 + '%' );
	});
	uploader.on( 'uploadSuccess', function( file,json ) {
		if(json.code == 1){
			$( '#'+file.id ).find('p.state').html('<font color=#080>上传成功，已加入转码队列</font>');
			$.get('http://<?=Web_Zm_Url.Web_Path?>index.php/ting?id='+json.did);
		}else{
			$( '#'+file.id ).find('p.state').html('<font color=red>上传失败：'+json.msg+'</font>');
		}
	});
	uploader.on( 'uploadError', function( file ) {
		$( '#'+file.id ).find('p.state').html('<font color=red>上传出错</font>');
	});
	uploader.on( 'uploadComplete', function( file ) {
		$( '#'+file.id ).find('.progress').fadeOut();
	});
});
</script>