
            <div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                      <div class="row">
                        <div class="col-md-12">
                            <!-- Begin: life time stats -->
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-clone fa-lg font-blue"></i>
                                            <span class="caption-subject font-blue sbold uppercase">（<?=$list->name?>）分类下的视频 &nbsp;</span>
                                              <span class="caption-helper"> （该分类下共计 <?=$nums?> 部视频） </span>
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <div class="tabbable-line">
                                            <div class="tab-content">
                                                <div class="tab-pane active" id="overview_1">
                                                    <table class="table table-striped table-hover table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th> 视频名称 </th>
                                                                <th> 类别 </th>
                                                                <th> 分类 </th>
                                                                <th> 状态</th>
                                                                <th> 发布时间 </th>
                                                                <th> 视频ID </th>
                                                                <th> 操作 </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                        <?php
                                                        if(empty($vod)) echo '<tr><td align="center" height="50" colspan="7">没有相关记录</td></tr>';
                                                        foreach($vod as $row){
                                                            $cname = $myname = ' -- ';
                                                            if($row->cid > 0) $cname = getzd('class','name',$row->cid);
                                                            if($row->mycid > 0) $myname = getzd('myclass','name',$row->mycid);
                                                            if($row->zt == 1){
                                                                $color = 'color:#080;';
                                                                $zt = '<i class="fa fa-spinner"></i>转码中';
                                                            }elseif($row->zt == 2){
                                                                $color = '';
                                                                $zt = '<i class="fa fa-check-square-o"></i>已转码';
                                                            }elseif($row->zt == 3){
                                                                $color = 'color:red;';
                                                                $zt = '<i class="fa fa-window-close-o">转码失败</i>';
                                                            }else{
                                                                $color = 'color:#f90;';
                                                                $zt = '<i class="fa fa-retweet"></i>待转码';
                                                            }
                                                            $pic = $pic2 = '';
                                                            for($i = 1;$i<=Jpg_Num;$i++){
                                                                $piclink = m3u8_link($row->vid,$row->addtime,'pic',$i);
                                                                $pic .= '<img alt="'.$row->name.'" src="'.$piclink.'">';
                                                                $pic2 .= $piclink.'<br>';
                                                            }
                                                            echo '
                                                            <tr>
                                                                <td style="text-align: left;"><a href="'.links('play','index',$row->vid).'" target="_blank">'.$row->name.'</a> <span class="label label-info">'.formatsize($row->size).'</span></td>
                                                                <td>'.$cname.'</td>
                                                                <td>'.$myname.'</td>
                                                                <td class="text-primary" style="'.$color.'">'.$zt.'</td>
                                                                <td>'.get_time($row->addtime).'</td>
                                                                <td><span id="copyid'.$row->id.'"> '.$row->vid.' </span>&nbsp;&nbsp;<a href="javascript:;" data-clipboard-action="copy" data-clipboard-target="#copyid'.$row->id.'" class="mt-clipboard btn btn-sm btn-default"><i class="icon-note"></i>点击复制</a></td>
                                                                <td><a href="#long'.$row->id.'" data-toggle="modal"  class="btn btn-sm btn-default"> <i class="fa fa-file-picture-o"></i> 预览图 </a><a  href="'.links('play','index',$row->vid).'"  target="_blank" class="btn btn-sm btn-default">  <i class="fa fa-search"></i> 预览 </a><a href="'.links('vod','edit',$row->id).'" class="btn btn-sm btn-default"><i class="fa fa-edit"></i> 编辑 </a></td>
                                                            </tr>

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
                                                            </div>';
                                                        }
                                                        ?>
                                                        </tbody>
                                                    </table>
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
    $('#a4').addClass('active');
    </script>