<div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                            <div class="row" >
                            <div class="col-md-12">
                                <!-- BEGIN VALIDATION STATES-->
                                <div class="portlet light portlet-fit portlet-form bordered">
                                    <div class="portlet-title">
                                        <div class="caption">
                                            <i class="fa fa-upload fa-lg font-red"></i>
                                            <span class="caption-subject font-red sbold uppercase">修改视频 &nbsp;</span>
                                        </div>
                                        <div class="actions">
                                            
                                  <div class="btn-group">
                                            <a class="btn red btn-outline  btn-sm" href="javascript:;" data-toggle="dropdown" data-hover="dropdown" data-close-others="true" aria-expanded="false"> 快捷操作
                                                <i class="fa fa-angle-down"></i>
                                            </a>
                                            <ul class="dropdown-menu pull-right">
                                                <li>
                                                    <a href="javascript:;" class="mt-clipboard" data-clipboard-action="copy" data-clipboard-target="#title">复制视频名称</a>
                                                </li>
                                                <li>
                                                    <a href="javascript:;" class="mt-clipboard" data-clipboard-action="copy" data-clipboard-target="#panvideoid">复制视频ID</a>
                                                </li>
                                                <li>
                                                    <a href="javascript:;" class="mt-clipboard" data-clipboard-action="copy" data-clipboard-target="#panshare">复制分享地址</a>
                                                </li>
                                                <li>
                                                    <a href="javascript:;" class="mt-clipboard" data-clipboard-action="copy" data-clipboard-target="#pantitlepic">复制预览图地址</a>
                                                </li>
                                            </ul>
                                        </div>
                                                                    
                                                                    
                                        </div>
                                    </div>
                                    <div class="portlet-body">
                                        <!-- BEGIN FORM-->
                                        <form action="<?=links('vod','save',$vod->id)?>" class="layui-form form-horizontal" method="post">
                                            <div class="form-body" style="padding-bottom: 0;">
                                                <div id="divFileProgressContainer"></div>
                                            </div>
 
                                            <div class="form-body">
 
                                <div class="form-group margin-bottom-30 margin-top-30">
                                                <div class="form-group">
                                         
                                                    <label class="control-label col-md-3">视频名称
                                                        <span class="required"> * </span>
                                                    </label>
                                                    <div class="col-md-6">
                                                        <input class="form-control" name="name" required  placeholder="请填写视频名称...（默认为上传文件名）" lay-verify="required" type="text" id="title" value="<?=$vod->name?>"/> 
                                                        </div>
                                                </div>
 <style type="text/css">.layui-form-radio{padding-right: 0px;}</style>
                                       <div class="form-group">
                                          <label class="control-label col-md-3">视频分类
                                                        <span class="required" aria-required="true"> * </span>
                                                    </label>
                                                    <div class="col-md-6">
                                                        <div class="md-radio-inline">
                                                        <?php
                                                        foreach($class as $row){
                                                            $check = $row->id == $vod->cid ? ' checked=""' : '';
                                                            echo '<div class="md-radio">
                                                                <input type="radio" id="'.$row->id.'" name="cid" class="md-radiobtn" title="'.$row->name.'" value="'.$row->id.'"'.$check.'>
                                                                <!--label for="'.$row->id.'">
                                                                    <span></span>
                                                                    <span class="check"></span>
                                                                    <span class="box"></span> '.$row->name.' </label-->
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
                                                    
                                              <select name="mycid" class="form-control">
                                                    <option value="0">├&nbsp;请选择私人分类...</option>
                                                        <?php
                                                        foreach($myclass as $row){
                                                            $check = $row->id == $vod->mycid ? ' selected' : '';
                                                            $arr = $this->csdb->get_select('myclass','*',array('fid'=>$row->id),'id ASC',100);
                                                            echo '<option value="'.$row->id.'"'.$check.'>├&nbsp;'.$row->name.'</option>';
                                                            foreach($arr as $row2){
                                                                $che2 = $row2->id == $vod->mycid ? ' selected' : '';
                                                                echo '<option value="'.$row2->id.'"'.$che2.'>&nbsp;&nbsp;├&nbsp;'.$row2->name.'</option>';
                                                            }
                                                        }
                                                        ?>
                                                </select>
                                                </div>
                                            </div>
    <div class="form-group">
         <label class="control-label col-md-3">视频ID
         <span class="required"> * </span>
         </label>
         <div class="col-md-6">
           <input  readonly="readonly" class="form-control" name="panvideoid" id="panvideoid" required  lay-required="" placeholder="" value="<?=$vod->vid?>" type="" />
         </div>
    </div>
    <div class="form-group">
         <label class="control-label col-md-3">预览图
         <span class="required"> * </span>
         </label>
         <div class="col-md-6">
           <input  readonly="readonly" class="form-control" name="pantitlepic" id="pantitlepic" required  lay-required="" placeholder="" value="<?=m3u8_link($vod->vid,$vod->addtime,'pic',1,$server)?>" type="" />
         </div>
    </div>
    <div class="form-group">
         <label class="control-label col-md-3">播放地址
         <span class="required"> * </span>
         </label>
         <div class="col-md-6">
           <input readonly="readonly" class="form-control" name="panshare" id="panshare" required  lay-required="" placeholder="" value="<?=links('play','index',$vod->vid)?>" type="" />
         </div>
    </div>
    <div class="form-group">
         <label class="control-label col-md-3">视频时长
         <span class="required"> * </span>
         </label>
         <div class="col-md-6">
           <input readonly="readonly" class="form-control" name="panvideotime" id="panvideotime" required   placeholder="" value="<?=formattime($vod->duration,1)?>" type="" />
         </div>
    </div>
    <div class="form-group">
         <label class="control-label col-md-3">视频大小
         <span class="required"> * </span>
         </label>
         <div class="col-md-6">
           <input  readonly="readonly" class="form-control" name="panvideosize" id="panvideosize" required   placeholder="" value="<?=formatsize($vod->size)?>" type="" />
         </div>
    </div>
                                            <div class="form-actions">
                                                <div class="row">
                                                    <div class="col-md-offset-3 col-md-9">
                                                        <button type="submit" lay-submit lay-filter="*" class="btn btn-lg green"><i class="fa fa-check"></i> 提交 </button>
                                                        <button type="reset" class="btn btn-lg grey-salsa btn-outline" ><i class="fa fa-refresh"></i> 重置</button>
                                                    </div>
                                                </div>
                                            </div>
                                    </div>

                                        </form>
                                </div>
                            </div>
                        </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
    $('#a3').addClass('active');
    </script>