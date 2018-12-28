<style>
 
    .mt-element-card .mt-card-item .mt-card-content .mt-card-social ul li a{font-size:14px;color:#678098;} 
    .video-time {
    position: absolute;
    left: 0;
    bottom: 0;
    height: 38px;
    line-height: 41px;
    overflow: hidden;
    width: 100%;
    padding: 0 5%;
    color: #fff;
    font-size: 13px;
    background: url(/packs/assets/img/shadow4.png) repeat-x 0 1px;
    z-index: 10;
}
    .mt-element-card .mt-card-item .mt-card-content .mt-card-social ul li a:hover{color: #5b9bd1;text-decoration: none;}
     .modal-body img{
        float:left;
        display:block;
        width:180px;
        height:100px;
        margin: 3px;
        }
    .clear{clear:both}
  .oneline{overflow: hidden;
    text-overflow: ellipsis;
    white-space: nowrap;
    width: 95%;}
    </style>
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                      <div class="row">
                        <div class="col-md-12">
                            <!-- Begin: life time stats -->
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-upload fa-lg font-red"></i>
                                            <span class="caption-subject font-red sbold uppercase">我的视频 &nbsp;</span>
 
                                              <span class="caption-helper"> （你总共上传了 <?=$this->csdb->get_nums('vod',array('uid'=>$user->id))?> 部视频） </span>
 
                                        </div>
                                        <div class="actions">
                                        	
                               <div class="btn-group">
                                            <a class="btn red btn-outline  btn-sm" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="false"> 浏览模式
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                            <ul class="dropdown-menu pull-right">
                                                <li>
                                                  <a href="<?=links('vod','index','txt',$cid)?>">详情模式</a>
                                                </li>
                                                <li class="divider"> </li>
                                                <li>
                                                    <a href="javascript:;"><i class="fa fa-check"></i>图文模式</a>
                                                </li>
                                                
                                            </ul>
                                        </div>                   
                                        </div>
                                    </div>
                    
                                <div class="portlet-body">
                                   <div class="tabbable-line">
                                        <ul class="nav nav-tabs">
                                            <li<?php if($cid == 0) echo ' class="active"';?>><a href="<?=links('vod')?>">全部视频</a></li>
                                            <?php 
                                            foreach($class as $row){
                                                $cls = $cid == $row->id ? 'active' : '';
                                                echo '<li class="'.$cls.'"><a href="'.links('vod','index',$op,$row->id).'">'.$row->name.'</a></li>';
                                            }
                                            ?>
	                                    </ul>
                                        <div class="tab-content">
                                        <div class="portlet-body dataTables_wrapper">
                                            <div class="mt-element-card mt-element-overlay">
                                            <?php
                                            if(empty($vod)) echo '<p style="text-align: center;height: 50px;">没有相关记录</p>';
                                            foreach($vod as $row){
                                                $cname = $myname = ' 未分类 ';
                                                if($row->cid > 0) $cname = getzd('class','name',$row->cid);
                                                if($row->mycid > 0) $myname = getzd('myclass','name',$row->mycid);
                                                $pic = $pic2 = '';
                                                for($i = 1;$i<=Jpg_Num;$i++){
                                                    $piclink = m3u8_link($row->vid,$row->addtime,'pic',$i);
                                                    $pic .= '<img alt="'.$row->name.'" src="'.$piclink.'">';
                                                    $pic2 .= $piclink.'<br>';
                                                }
                                                echo '
                                                <div class="col-lg-3 col-md-4 col-sm-6 col-xs-12">
                                                    <div class="mt-card-item">
                                                        <div class="mt-card-avatar mt-overlay-1">
                                                            <div class="video-time">
                                                              <span style="float:left;" id="size">'.formatsize($row->size).'</span>
                                                              <span style="float:right;" id="time">'.formattime($row->duration,1).'</span>
                                                            </div>
                                                            <img class="lazy" src="'.m3u8_link($row->vid,$row->addtime,'pic').'" alt="'.$row->name.'" style="height: 206px;width: 360px;">
                                                            <div class="mt-overlay">
                                                                <ul class="mt-info">
                                                                    <li>
                                                                        <a class="btn default btn-outline" href="'.links('play','index',$row->vid).'" target="_blank"><i class="fa fa-play"></i></a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                        <div class="mt-card-content">
                                                            <h3 class="mt-card-name oneline">'.$row->name.'</h3> 
                                                            <div class="mt-card-social">
                                                                <ul>
                                                                    <li>
                                                                        <a id="copyid'.$row->id.'" style="width:0px;height:0px;font-size:0px">'.$row->vid.'</a> 
                                                                        <a href="javascript:;" data-clipboard-action="copy" data-clipboard-target="#copyid'.$row->id.'" class="mt-clipboard"><i class="fa fa-copy"></i> 复制视频ID</a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="#long'.$row->id.'" data-toggle="modal" ><i class="fa fa-picture-o"></i> 视频截图</a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="javascript:;">
                                                                            <i class="fa fa-clock-o"></i>'.get_time($row->addtime).'</a>
                                                                    </li>
                                                                </ul>
                                                                 <ul>
                                                                    <li>
                                                                        <a href="javascript:;"><i class="fa fa-clone"></i>'.$myname.'</a>
                                                                    </li>
                                                                    <li>
                                                                        <a href="javascript:;"> <i class="fa fa-sort"></i> '.$cname.'</a>
                                                                    </li>
                                                                </ul>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>
                                                <div id="long'.$row->id.'" class="modal fade" tabindex="-1" data-width="600">
                                                    <div class="modal-dialog" style="margin:0px;padding:0px;">
                                                        <div class="modal-content">
                                                            <div class="modal-header">
                                                                <button type="button" class="close" data-dismiss="modal" aria-hidden="true"></button>
                                                                <h4 class="modal-title">来自 '.$row->name.' 预览图</h4>
                                                            </div>
                                                            <div class="modal-body" style="height:350px" >
                                                                '.$pic.' 
                                                            </div>
                                                            <div class="modal-body">
                                                              	<div class="well" id="copyshare'.$row->id.'" style="margin-bottom: 0px;">'.$pic2.'</div>
                                                            </div>
                                                            <div class="modal-footer">
                                                                <button type="button" href="javascript:;" data-clipboard-action="copy" data-clipboard-target="#copyshare'.$row->id.'"  class="mt-clipboard btn btn-success">一键复制</button>
                                                                <button type="button" data-dismiss="modal" class="btn btn-primary">关闭</button>
                                                            </div>
                                                        </div>
                                                    </div>
                                                </div>';
                                            }
                                            ?>
                                            <div class="row">
                                                <div class="col-md-offset-4 col-md-8">
                                                    <ul class="pagination"  style="float:right">
                                                        <?=$pages?>
                                                    </ul>
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
    </div>
    <script type="text/javascript">
    $('#a3').addClass('active');
    </script>
        