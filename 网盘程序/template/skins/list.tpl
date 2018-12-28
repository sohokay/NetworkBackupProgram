<link href="/packs/assets/jstree/themes/default/style.min.css" rel="stylesheet" type="text/css" />
 <style>
.table th, .table td { 
text-align: center;
vertical-align: middle!important;
}
 </style>
<div class="page-content-wrapper">
                <!-- BEGIN CONTENT BODY -->
                <div class="page-content">
                    <!-- BEGIN PAGE HEAD-->
                
               

                    <!-- END PAGE HEAD-->
                    <!-- BEGIN PAGE BREADCRUMB -->
              
                    <!-- END PAGE BREADCRUMB -->
                    <!-- BEGIN PAGE BASE CONTENT -->
                    
      
                    <div class="row">
                    	                 <div class="col-md-6">
 	
 	
 	  <div class="portlet light bordered">
 	  	         <div class="portlet-title">
                                    <div class="caption">
                                    <i class="fa fa-clone fa-lg font-blue"></i>
                                        <span class="caption-subject font-blue-sharp bold uppercase">我的分类</span>
                                        <span class="caption-helper"> （你总共有  <?=$this->csdb->get_nums('myclass',array('uid'=>$user->id))?>  个分类） </span>
                                    </div>
	                               <div class="actions">
	                                  	<div class="btn-group">
	                                        <a class="btn blue btn-outline  btn-sm" href="<?=links('lists','edit')?>" > <i class="fa fa-plus"></i> 添加分类 </a>
	                                    </div>                     
	                                </div>
                                </div>
 	      						<div class="portlet-body">
                                        <div class="tab-content">
                                            <div class="tab-pane active" id="overview_1">
                                                    <table class="table table-striped table-hover table-bordered">
                                                        <thead>
                                                            <tr>
                                                                <th> 分类ID </th>
                                                                <th> 分类名称 </th>
                                                                <th> 操作 </th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
											<?php
											if(empty($myclass)) echo '<tr><td align="center" height="50" colspan="3">没有相关记录</td></tr>';
											foreach($myclass as $row){
												echo '<tr><td>'.$row->id.'</td><td style="text-align: left;"><a href="'.links('lists','vod',$row->id).'">├&nbsp;'.$row->name.'</a></td><td><a href="'.links('lists','edit',$row->id).'" class="btn btn-sm btn-default"><i class="fa fa-edit"></i> 修改 </a><a href="javascript:getajax(\''.links('lists','del',$row->id).'\',\'del\');"  class="btn btn-sm btn-default">  <i class="fa fa-remove"></i> 删除 </a></td></tr>';
												$arr = $this->csdb->get_select('myclass','*',array('fid'=>$row->id),'id ASC',100);
												foreach($arr as $row2){
													echo '<tr><td>'.$row2->id.'</td><td style="text-align: left;"><a href="'.links('lists','vod',$row2->id).'">&nbsp;&nbsp;&nbsp;&nbsp;├&nbsp;'.$row2->name.'</a></td><td><a href="'.links('lists','edit',$row2->id).'" class="btn btn-sm btn-default"><i class="fa fa-edit"></i> 修改 </a><a href="javascript:getajax(\''.links('lists','del',$row2->id).'\',\'del\');"  class="btn btn-sm btn-default">  <i class="fa fa-remove"></i> 删除 </a></td></tr>';
												}
											}
											?>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                                        </div>  
                                    </div>
                        </div>
 
                    	
                        <div class="col-md-6">
                            <div class="portlet light bordered">
                                <div class="portlet-title">
                                    <div class="caption">
                                    <i class="fa fa-search fa-lg font-blue"></i>
                                        <span class="caption-subject font-blue-sharp bold uppercase">分类预览</span>
                                     </div>
                                </div>
                                
                                <div class="portlet-body">
                                    <div id="tree_1" class="tree-demo">
                                    <ul>
                                        <li data-jstree='{ "opened" : true }'>我的分类
                                           	<?php
											foreach($myclass as $row){
												echo '<ul id="row_'.$row->id.'" ><li data-jstree=\'{ "opened" : true }\' ><a href="'.links('lists','vod',$row->id).'">'.$row->name.'</a><ul>';
												$arr = $this->csdb->get_select('myclass','*',array('fid'=>$row->id),'id ASC',100);
												foreach($arr as $row2){
													echo '<li data-jstree=\'{ "type" : "file"}\' > <a href="'.links('lists','vod',$row2->id).'">'.$row2->name.'</a></li>';
												}
												echo '</ul></li></ul>';
											}
											?>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
        </div>
        <script src="/packs/assets/jstree/jstree.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/app.min.js" type="text/javascript"></script>
        <script src="/packs/assets/js/ui-tree.min.js" type="text/javascript"></script>
    <script type="text/javascript">
    $('#a4').addClass('active');
    </script>